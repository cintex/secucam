unit ucam_v2;

interface

uses
  SysUtils, Classes, ExtCtrls, Windows, VFrames, ucamcomparator;

type
  TCam = class (TImage)
  private
    CamTimer: TTimer;
    Cam     : TVideoImage;
    CamImg  : TImage;

    // *** PROPERTY VARS *******************************************************
    FDectIntervall : integer;
    FRunning       : boolean;
    FPaused        : boolean;
    FMotDect       : boolean;
    FAttCam        : string;

    // *** SETTERS *************************************************************
    procedure SetAttCam        (const pAttCam: string);
    procedure SetMotDect       (const pMotDect: boolean);
    procedure SetDectIntervall (const pDectIntervall: integer);

    // *** FUNKTIONEN & PROZEDUREN ** Private **********************************
    procedure OnCamTimer (Sender: TObject);
  public
    constructor Create (AOwner: TComponent); override;
    destructor  Destroy; override;

    // *** PROPERTIES **********************************************************
    property IsRunning       : boolean read FRunning;
    property AttachedCam     : string read FAttCam write SetAttCam;
    property IsPaused        : boolean read FPaused;
    property MotionDetection : boolean read FMotDect write SetMotDect;
    property FrameRate       : integer read FDectIntervall write SetDectIntervall;

    // *** FUNKTIONEN & PROZEDUREN ** Public ***********************************
    function VideoStart: boolean;
    function VideoPause: boolean;
    function VideoStop: boolean;
  end;

implementation

  constructor TCam.Create (AOwner: TComponent);
  begin
    inherited;
    //*** Kamera Bild **********************************************************
    Width:= 320;
    Height:= 240;
    Canvas.Rectangle (0, 0, 320, 240);
    Canvas.TextOut (10,210,'Kein Bild');

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

  end;

  destructor TCam.Destroy;
  begin
    //CamTimer.Free;
    FreeAndNil (CamTimer);
    FreeAndNil (Cam);
    FreeAndNil (CamImg);
    inherited;
  end;

  procedure TCam.OnCamTimer (Sender: TObject);
  begin
    Picture.Bitmap:= CamImg.Picture.Bitmap;
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
  end;

  function TCam.VideoStart: boolean;
  begin
    if FPaused then begin
      Cam.VideoResume;
      FPaused:= false;
      Result:= true;
    end
    else if not FRunning then begin
      Cam.VideoStart (FAttCam);
      FPaused:= false;
      FRunning:= true;
      CamTimer.Enabled:= true;
      Result:= true;
    end
    else Result:= false;
  end;

  function TCam.VideoPause: boolean;
  begin
    if FRunning AND not FPaused then begin
      Cam.VideoPause;
      FPaused:= true;
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
      Result:= true;
    end
    else Result:= false;
  end;
end.
