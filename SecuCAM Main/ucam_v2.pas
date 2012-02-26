{*******************************************************************************
     *  SecuCAM CST // ucam_v2.pas *
     *******************************

  Entwickelt von : WARNIMONT POL
                   T3IF @ Lycée du Nord
                   2011 - 2012

  Beschreibung : Unit enthällt die Klasse TCam.

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
    CamImg2  : TImage;
    ImgRef   : TBitmap;
    ImgCmp   : TBitmap;

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

    // *** SETTERS *************************************************************
    procedure SetAttCam        (const pAttCam: string);
    procedure SetMotDect       (const pMotDect: boolean);
    procedure SetDectIntervall (const pDectIntervall: integer);
    procedure SetParent        (const pParent: TWinControl);
    procedure SetLeft          (const pLeft: integer);
    procedure SetTop           (const pTop: integer);
    procedure SetVisible       (const pVisible: boolean);
    procedure SetAlarmLevel    (const pAlarmLevel: integer);

    // *** FUNKTIONEN & PROZEDUREN ** Private **********************************
    procedure OnCamTimer (Sender: TObject);
    procedure OnTimeout (Sender: TObject);
  public
    CamComparator: TCamComparator;

    constructor Create (Parent: TWinControl);
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

    // *** FUNKTIONEN & PROZEDUREN ** Public ***********************************
    function VideoStart: boolean;
    function VideoPause: boolean;
    function VideoStop: boolean;
  end;

implementation

  constructor TCam.Create (Parent: TWinControl);
  begin
    //*** General **************************************************************
    FParent:= Parent;
    FVisible:= false;
    CamComparator:= TCamComparator.Create;
    CamComparator.Sensitivity:= 10;
    CamComparator.Resolution:= 16;
    ImgRef:= TBitmap.Create;
    ImgRef.Width:= 320;
    ImgRef.Height:= 240;
    ImgCmp:= TBitmap.Create;
    ImgCmp.Width:= 320;
    ImgCmp.Height:= 240;
    TakeRefPic:= true;
    Diff:= 0;
    TOut:= 0;
    TmpDiff:= 0;

    //*** Kamera Bild **********************************************************
    CamImage:= TImage.Create (nil);
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
    CamTimer:= TTimer.Create (nil);
    CamTimer.Interval:= FDectIntervall;
    CamTimer.OnTimer:= OnCamTimer;
    CamTimer.Enabled:= FRunning;

    Timeout:= TTimer.Create (nil);
    Timeout.Interval:= 1000;
    Timeout.OnTimer:= OnTimeout;
    Timeout.Enabled:= false;

    //*** Video Optionen *******************************************************
    Cam:= TVideoImage.Create;
    CamImg:= TImage.Create (nil);
    CamImg.Width:= 320;
    CamImg.Height:= 240;
    CamImg2:= TImage.Create (nil);
    CamImg2.Width:= 320;
    CamImg2.Height:= 240;
    Cam.SetDisplayCanvas (CamImg.Canvas);

    //*** Activity Shapes ******************************************************
    ShapeDect:= TShape.Create (nil);
    ShapeDect.Width:= 17;
    ShapeDect.Height:= 17;
    ShapeDect.Parent:= FParent;
    ShapeDect.Shape:= stCircle;
    ShapeDect.Visible:= false;

    ShapeAct:= TShape.Create (nil);
    ShapeAct.Width:= 17;
    ShapeAct.Height:= 17;
    ShapeAct.Parent:= FParent;
    ShapeAct.Shape:= stCircle;
    ShapeAct.Brush.Color:= clRed;
    ShapeAct.Visible:= false;

    DiffProg:= TProgressBar.Create (nil);
    DiffProg.Orientation:= pbVertical;
    DiffProg.Width:= 15;
    DiffProg.Height:= 184;
    DiffProg.Parent:= FParent;
    DiffProg.Visible:= false;
  end;

  destructor TCam.Destroy;
  begin
    //CamTimer.Free;
    FreeAndNil (CamTimer);
    FreeAndNil (Cam);
    FreeAndNil (CamImg);
    FreeAndNil (CamComparator);
    FreeAndNil (ImgRef);
    FreeAndNil (ImgCmp);
    inherited;
  end;

  {
      TODO: Warte 10 Sekunden bis Kamera = Ready.
  }
  procedure TCam.OnCamTimer (Sender: TObject);
  var I: integer;
  begin
    //TOut:= 0;
    DiffProg.Position:= Diff;
    if FMotDect = true then begin
      if TakeRefPic = true then begin
        //Ref:= CamImg.Picture.Bitmap;
        CamImg2.Picture.Bitmap:= CamImg.Picture.Bitmap;
        //CamImage.Picture.Bitmap:= CamImg2.Picture.Bitmap;
        //ImgRef.LoadFromFile ('testscreen1.bmp');
        //Showmessage ('here');
        TakeRefPic:= false;
      end
      else begin
        ImgCmp:= CamImg.Picture.Bitmap;
        //ImgCmp.SaveToFile('tsts1.bmp');
        //Ref.SaveToFile('tsts2.bmp');
        CamComparator.CheckDifference (ImgCmp, CamImg2.Picture.Bitmap, Diff);
        //showmessage (IntToStr (Diff));
        //Showmessage ('möp');
        //showmessage (IntToStr (TOut));
        if (Diff > FAlarmLevel) AND (TOut <= 10) then begin
          //UserCode

          ShapeDect.Brush.Color:= clRed;
          //ImgCmp.Canvas.TextOut (10,50,'TOut: ' + IntToStr (TOut));
          //showmessage ('D-'+IntToStr(Diff)+' T-'+IntToStr(TmpDiff));
          if (Diff >= (TmpDiff - 2)) AND (Diff <= (TmpDiff + 2)) then inc (TOut)
                                                                 else TOut:= 0;
          TmpDiff:= Diff;
        end
        else begin
          ShapeDect.Brush.Color:= clGreen;
          TakeRefPic:= true;
          TOut:= 0;
          I:= 0;
        end;
        TmpDiff:= Diff;
        CamImage.Picture.Bitmap:= ImgCmp;
      end;
    end
    else begin
      CamImage.Picture.Bitmap:= CamImg.Picture.Bitmap;
    end;
  end;

  procedure TCam.OnTimeout (Sender: TObject);
  begin
    if Time10 = 3 then begin
      FMotDect:= true;
      Timeout.Enabled:= false;
    end
    else begin
      CamImage.Canvas.TextOut (10,30,IntToStr (Time10));
      inc (Time10);
    end
  end;

  procedure TCam.SetAttCam (const pAttCam: string);
  begin
    FAttCam:= pAttCam;
  end;

  procedure TCam.SetMotDect (const pMotDect: boolean);
  begin
    if pMotDect = true then begin
      Time10:= 0;
      Timeout.Enabled:= true;
    end
    else FMotDect:= pMotDect;
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

  function TCam.VideoStart: boolean;
  begin
    if FPaused then begin
      Cam.VideoResume;
      FPaused:= false;
      ShapeAct.Brush.Color:= clLime;
      Result:= true;
    end
    else if not FRunning then begin
      Cam.VideoStart (FAttCam);
      FPaused:= false;
      FRunning:= true;
      CamTimer.Enabled:= true;
      ShapeAct.Brush.Color:= clLime;
      Result:= true;
    end
    else Result:= false;
  end;

  function TCam.VideoPause: boolean;
  begin
    if FRunning AND not FPaused then begin
      Cam.VideoPause;
      FPaused:= true;
      ShapeAct.Brush.Color:= clYellow;
      Result:= true;
    end
    else Result:= false;
  end;

  function TCam.VideoStop: boolean;
  begin
    if FRunning then begin
      Cam.VideoStop;
      FPaused:= false;
      FRunning:= false;
      ShapeAct.Brush.Color:= clRed;
      Result:= true;
    end
    else Result:= false;
  end;
end.
