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
  Controls, ucamcomparator;

type
  TCam = class
  private
    // *** Not visible on tbsMain **********************************************
    CamTimer : TTimer;
    Cam      : TVideoImage;
    CamImg   : TImage;
    ImgRef   : TBitmap;
    ImgCmp   : TBitmap;

    // *** Visible on tbsMain **************************************************
    ShapeDect : TShape;
    ShapeAct  : TShape;
    DiffProg  : TProgressBar;
    CamImage  : TImage;

    // *** General *************************************************************
    TakeRefPic : boolean;

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

    // *** SETTERS *************************************************************
    procedure SetAttCam        (const pAttCam: string);
    procedure SetMotDect       (const pMotDect: boolean);
    procedure SetDectIntervall (const pDectIntervall: integer);
    procedure SetParent        (const pParent: TWinControl);
    procedure SetLeft          (const pLeft: integer);
    procedure SetTop           (const pTop: integer);
    procedure SetVisible       (const pVisible: boolean);

    // *** FUNKTIONEN & PROZEDUREN ** Private **********************************
    procedure OnCamTimer (Sender: TObject);
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
    CamComparator.Sensitivity:= 3;
    CamComparator.GridSize:= 16;
    ImgRef:= TBitmap.Create;
    ImgRef.Width:= 320;
    ImgRef.Height:= 240;
    ImgCmp:= TBitmap.Create;
    ImgCmp.Width:= 320;
    ImgCmp.Height:= 240;
    TakeRefPic:= true;

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

    //*** Video Optionen *******************************************************
    Cam:= TVideoImage.Create;
    CamImg:= TImage.Create (nil);
    CamImg.Width:= 320;
    CamImg.Height:= 240;
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

  procedure TCam.OnCamTimer (Sender: TObject);
  var Diff: integer;
  begin
    if FMotDect = true then begin
      if TakeRefPic = true then begin
        ImgRef:= CamImg.Picture.Bitmap;
        TakeRefPic:= false;
      end
      else begin
        ImgCmp:= CamImg.Picture.Bitmap;
        CamComparator.CheckDifference (ImgCmp, ImgRef, Diff);
        CamComparator.GetPicture (CamImage);
        TakeRefPic:= true;
      end;
    end
    else begin
      CamImage.Picture.Bitmap:= CamImg.Picture.Bitmap;
    end;
  end;

  procedure TCam.SetAttCam (const pAttCam: string);
  begin
    FAttCam:= pAttCam;
  end;

  procedure TCam.SetMotDect (const pMotDect: boolean);
  begin
    FMotDect:= pMotDect;
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
