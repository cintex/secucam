{*******************************************************************************
     *  SecuCAM CST // ucam_v2.pas *
     *******************************

  Entwickelt von : WARNIMONT POL
                   T3IF @ Lyc�e du Nord
                   2011 - 2012

  Beschreibung : Unit enth�llt die Klasse TCam.

*******************************************************************************}

unit ucam_v2;

interface

uses
  SysUtils, Classes, ComCtrls, StdCtrls, ExtCtrls, Windows, VFrames, Graphics,
  Controls, Dialogs, DateUtils, ucamcomparator_v2;

type
  TCam = class
  private
    // *** Not visible on tbsMain **********************************************
    CamTimer : TTimer;
    Timeout  : TTimer;
    Cam      : TVideoImage;
    CamImg   : TImage;
    CamImgCmp  : TImage;
    CamImgRef  : TImage;

    // *** Visible on tbsMain **************************************************
    ShapeDect : TShape;
    ShapeAct  : TShape;
    DiffProg  : TProgressBar;
    CamImage  : TImage;

    // *** General *************************************************************
    TakeRefPic : boolean;
    Diff       : integer;
    Time10     : integer;
    TOut       : integer;
    TmpDiff    : integer;
    LockTm     : boolean;
    ID         : integer;

    // *** PROPERTY VARS *******************************************************
    FDectIntervall : integer;
    FRunning       : boolean;
    FPaused        : boolean;
    FMotDect       : boolean;
    FAttCam        : string;
    FParent        : TWinControl;
    FLeft          : integer;
    FTop           : integer;
    FVisible       : boolean;
    FAlarmLevel    : integer;
    FAlias         : string;
    FBusy          : boolean;
    FOwner         : TComponent;
    FAlert         : boolean;
    FPath          : string;

    // *** SETTERS *************************************************************
    procedure SetAttCam        (const pAttCam: string);
    procedure SetMotDect       (const pMotDect: boolean);
    procedure SetDectIntervall (const pDectIntervall: integer);
    procedure SetParent        (const pParent: TWinControl);
    procedure SetLeft          (const pLeft: integer);
    procedure SetTop           (const pTop: integer);
    procedure SetVisible       (const pVisible: boolean);
    procedure SetAlarmLevel    (const pAlarmLevel: integer);
    procedure SetAlias         (const pAlias: string);
    procedure SetPath          (const pPath: string);

    // *** FUNKTIONEN & PROZEDUREN ** Private **********************************
    procedure OnCamTimer (Sender: TObject);
    procedure OnTimeout (Sender: TObject);
  public
    CamComparator: TCamComparator;

    constructor Create (Parent: TWinControl; AOwner: TComponent; pID: integer);
    destructor  Destroy;

    // *** PROPERTIES **********************************************************
    property IsRunning       : boolean read FRunning;
    property AttachedCam     : string read FAttCam write SetAttCam;
    property IsPaused        : boolean read FPaused;
    property MotionDetection : boolean read FMotDect write SetMotDect;
    property FrameRate       : integer read FDectIntervall write SetDectIntervall;
    property Parent          : TWinControl read FParent write SetParent;
    property Left            : integer read FLeft write SetLeft;
    property Top             : integer read FTop write SetTop;
    property Visible         : boolean read FVisible write SetVisible;
    property AlarmLevel      : integer read FAlarmLevel write SetAlarmLevel;
    property Alias           : string read FAlias write SetAlias;
    property AOwner          : TComponent read FOwner;
    property Alert           : boolean read FAlert;
    property Path            : string read FPath write SetPath;

    // *** FUNKTIONEN & PROZEDUREN ** Public ***********************************
    function VideoStart: boolean;
    function VideoPause: boolean;
    function VideoStop: boolean;
  end;

implementation

  constructor TCam.Create (Parent: TWinControl; AOwner: TComponent; pID: integer);
  begin
    //*** General **************************************************************
    FParent:= Parent;
    FOwner:= AOwner;
    FVisible:= false;
    CamComparator:= TCamComparator.Create;
    CamComparator.Sensitivity:= 10;
    CamComparator.Resolution:= 16;
    TakeRefPic:= true;
    Diff:= 0;
    TOut:= 0;
    TmpDiff:= 0;
    FBusy:= false;
    LockTm:= false;
    ID:= pID;
    FAlert:= false;
    FPath:= 'Capture';

    //*** Kamera Bild **********************************************************
    CamImage:= TImage.Create (FOwner);
    CamImage.Name:= 'imgCam' + IntToStr (ID);
    CamImage.Parent:= FParent;
    CamImage.Width:= 320;
    CamImage.Height:= 240;
    CamImage.Canvas.Rectangle (0, 0, 320, 240);
    CamImage.Canvas.TextOut (10,210,'Kein Bild');
    CamImage.Visible:= false;

    //*** Timer Optionen *******************************************************
    FDectIntervall:= 500;
    FRunning:= false;
    FPaused:= false;
    CamTimer:= TTimer.Create (FOwner);
    CamTimer.Name:= 'tmCam' + IntToStr (ID);
    CamTimer.Interval:= FDectIntervall;
    CamTimer.OnTimer:= OnCamTimer;
    CamTimer.Enabled:= FRunning;

    Timeout:= TTimer.Create (FOwner);
    Timeout.Name:= 'tmTimeout' + IntToStr (ID);
    Timeout.Interval:= 1000;
    Timeout.OnTimer:= OnTimeout;
    Timeout.Enabled:= false;

    //*** Video Optionen *******************************************************
    Cam:= TVideoImage.Create;
    CamImg:= TImage.Create (FOwner);
    CamImg.Name:= 'imgINTCam' + IntToStr (ID);
    CamImg.Width:= 320;
    CamImg.Height:= 240;
    CamImgCmp:= TImage.Create (FOwner);
    CamImgCmp.Name:= 'imgINTCmp' + IntToStr (ID);
    CamImgCmp.Width:= 320;
    CamImgCmp.Height:= 240;
    CamImgRef:= TImage.Create (FOwner);
    CamImgRef.Name:= 'imgINTRef' + IntToStr (ID);
    CamImgRef.Width:= 320;
    CamImgRef.Height:= 240;
    Cam.SetDisplayCanvas (CamImg.Canvas);

    //*** Activity Shapes ******************************************************
    ShapeAct:= TShape.Create (FOwner);
    ShapeAct.Name:= 'shAct' + IntToStr (ID);
    ShapeAct.Parent:= FParent;
    ShapeAct.Width:= 17;
    ShapeAct.Height:= 17;
    ShapeAct.Shape:= stCircle;
    ShapeAct.Brush.Color:= clRed;
    ShapeAct.Visible:= false;

    ShapeDect:= TShape.Create (FOwner);
    ShapeDect.Name:= 'shDect' + IntToStr (ID);
    ShapeDect.Parent:= FParent;
    ShapeDect.Width:= 17;
    ShapeDect.Height:= 17;
    ShapeDect.Shape:= stCircle;
    ShapeDect.Visible:= false;

    DiffProg:= TProgressBar.Create (FOwner);
    DiffProg.Name:= 'prgDiff' + IntToStr (ID);
    DiffProg.Parent:= FParent;
    DiffProg.Orientation:= pbVertical;
    DiffProg.Width:= 15;
    DiffProg.Height:= 184;
    DiffProg.Visible:= false;
  end;

  destructor TCam.Destroy;
  begin
    if FRunning = true then VideoStop;
    SetVisible (false);
    SetParent (nil);
    CamComparator.Free;
    Cam.Free;
    CamImage.Free;
    CamTimer.Free;
    TimeOut.Free;
    CamImg.Free;
    CamImgCmp.Free;
    CamImgRef.Free;
    ShapeAct.Free;
    ShapeDect.Free;
    DiffProg.Free;
    inherited;
  end;

  procedure TCam.OnCamTimer (Sender: TObject);
  var I: integer;
  begin
    FBusy:= true;

    if not LockTm then begin

    if FMotDect = true then begin
      DiffProg.Position:= Diff;
      if not CamComparator.Busy then begin
      if TakeRefPic = true then begin
        CamImgRef.Picture.Bitmap:= CamImg.Picture.Bitmap;
        TakeRefPic:= false;
      end
      else begin
        CamImgCmp.Picture.Bitmap:= CamImg.Picture.Bitmap;
        CamComparator.CheckDifference (CamImgCmp, CamImgRef, Diff);
        if (Diff > FAlarmLevel) AND (TOut <= 10) then begin
          //UserCode BEGIN
          FAlert:= true;
          CamImg.Picture.SaveToFile (FPath + '\' +FormatDateTime ('yyyy-mm-dd_hh-nn-ss',now)+'_'+FAlias+'_CAPTURE.bmp');
          //UserCode END
          ShapeDect.Brush.Color:= clRed;
          //CamImgCmp.Canvas.TextOut (10,70,'TOut: ' + IntToStr (TOut));
          if (Diff >= (TmpDiff - 2)) AND (Diff <= (TmpDiff + 2)) then inc (TOut)
                                                                 else TOut:= 0;
          TmpDiff:= Diff;
        end
        else begin
          FAlert:= false;
          ShapeDect.Brush.Color:= clGreen;
          TakeRefPic:= true;
          TOut:= 0;
          I:= 0;
        end;
        TmpDiff:= Diff;
        CamImage.Picture.Bitmap:= CamImgCmp.Picture.Bitmap;
      end;
      end;
    end
    else begin
      CamImage.Picture.Bitmap:= CamImg.Picture.Bitmap;
    end;

    end;
    FBusy:= false;
  end;

  procedure TCam.OnTimeout (Sender: TObject);
  begin
    if Time10 = 3 then begin
      FMotDect:= true;
      Timeout.Enabled:= false;
    end
    else begin
      CamImage.Canvas.TextOut (10,30,'ReadyTimer: '+IntToStr (Time10));
      inc (Time10);
    end
  end;

  procedure TCam.SetAttCam (const pAttCam: string);
  begin
    FAttCam:= pAttCam;
    Cam.VideoStart (FAttCam);
  end;

  procedure TCam.SetMotDect (const pMotDect: boolean);
  begin
    if pMotDect = true then begin
      Time10:= 0;
      Timeout.Enabled:= true;
    end
    else begin
      ShapeDect.Brush.Color:= clWhite;
      FMotDect:= pMotDect;
    end;
  end;

  procedure TCam.SetDectIntervall (const pDectIntervall: integer);
  begin
    FDectIntervall:= pDectIntervall;
    CamTimer.Interval:= FDectIntervall;
  end;

  procedure TCam.SetParent (const pParent: TWinControl);
  begin
    FParent:= pParent;
    CamImage.Parent:= FParent;
    ShapeAct.Parent:= FParent;
    ShapeDect.Parent:= FParent;
    DiffProg.Parent:= FParent;
  end;

  procedure TCam.SetLeft (const pLeft: integer);
  begin
    FLeft:= pLeft;
    CamImage.Left:= FLeft;
    ShapeAct.Left:= CamImage.Left + CamImage.Width + 5;
    ShapeDect.Left:= CamImage.Left + CamImage.Width + 5;
    DiffProg.Left:= CamImage.Left + CamImage.Width + 7;
  end;

  procedure TCam.SetTop (const pTop: integer);
  begin
    FTop:= pTop;
    CamImage.Top:= FTop;
    ShapeAct.Top:= CamImage.Top + 25;
    ShapeDect.Top:= CamImage.Top;
    DiffProg.Top:= CamImage.Top + 55;
  end;

  procedure TCam.SetVisible (const pVisible: boolean);
  begin
    FVisible:= pVisible;
    CamImage.Visible:= FVisible;
    ShapeAct.Visible:= FVisible;
    ShapeDect.Visible:= FVisible;
    DiffProg.Visible:= FVisible;
  end;

  procedure TCam.SetAlarmLevel (const pAlarmLevel: integer);
  begin
    FAlarmLevel:= pAlarmLevel;
  end;

  procedure TCam.SetAlias (const pAlias: string);
  begin
    FAlias:= pAlias;
  end;

  procedure TCam.SetPath (const pPath: string);
  begin
    FPath:= pPath;
  end;

  function TCam.VideoStart: boolean;
  begin
    LockTm:= true;
    while FBusy = true do begin
    end;
    if FPaused then begin
      CamTimer.Enabled:= true;
      Cam.VideoResume;
      FPaused:= false;
      ShapeAct.Brush.Color:= clLime;
      Result:= true;
    end
    else if not FRunning then begin
      CamTimer.Enabled:= true;
      Cam.VideoStart (FAttCam);
      FPaused:= false;
      FRunning:= true;
      CamTimer.Enabled:= true;
      ShapeAct.Brush.Color:= clLime;
      Result:= true;
    end
    else Result:= false;

    LockTm:= false;
  end;

  function TCam.VideoPause: boolean;
  begin
    LockTm:= true;
    while FBusy = true do begin
    end;
    if FRunning AND not FPaused then begin
      CamTimer.Enabled:= false;
      Cam.VideoPause;
      FPaused:= true;
      ShapeAct.Brush.Color:= clYellow;
      Result:= true;
    end
    else Result:= false;
    LockTm:= false;
  end;

  function TCam.VideoStop: boolean;
  begin
    LockTm:= true;
    while FBusy = true do begin
    end;
    if FRunning then begin
      FMotDect:= false;
      CamTimer.Enabled:= false;
      CamImage.Canvas.Rectangle(0,0,320,240);
      CamImage.Canvas.TextOut(10,10,'Kamera gestoppt.');
      Cam.VideoStop;
      FPaused:= false;
      FRunning:= false;
      ShapeAct.Brush.Color:= clRed;
      Result:= true;
    end
    else Result:= false;
    LockTm:= false;
  end;
end.
