{*******************************************************************************
     *  SecuCAM CST // umain.pas *
     *****************************

  Entwickelt von : WARNIMONT POL
                   T3IF @ Lycée du Nord
                   2011 - 2012

  Beschreibung : Haupt Unit des Programms.

*******************************************************************************}

unit umain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ToolWin, Menus, ExtCtrls, VFrames, ImgList,
  ucamcomparator, uaddcam, CoolTrayIcon, ucam_v2;

type
  TfrmMain = class(TForm)
    mmMainMenu: TMainMenu;
    mmiFile: TMenuItem;
    mmiSettings: TMenuItem;
    mmiHelp: TMenuItem;
    mmiAbout: TMenuItem;
    mmiExit: TMenuItem;
    tbMain: TToolBar;
    tbtnGo: TToolButton;
    ToolButton3: TToolButton;
    tbtnPlay: TToolButton;
    tbtnPause: TToolButton;
    sbStatus: TStatusBar;
    lbCamList: TListBox;
    pgMain: TPageControl;
    tbsMain: TTabSheet;
    tbsExtended: TTabSheet;
    tmGeneral: TTimer;
    imgIcoLst: TImageList;
    tbtnStop: TToolButton;
    ToolButton7: TToolButton;
    tbtnAddCam: TToolButton;
    tbtnSettings: TToolButton;
    N1: TMenuItem;
    mmiMinimize: TMenuItem;
    mmiOptions: TMenuItem;
    mmiAddCam: TMenuItem;
    tbtnRunTest: TToolButton;
    ToolButton11: TToolButton;
    imgFiller1: TImage;
    Shape5: TShape;
    Shape6: TShape;
    imgFiller2: TImage;
    imgFiller3: TImage;
    imgFiller4: TImage;
    Label1: TLabel;
    Bevel1: TBevel;
    TabSheet1: TTabSheet;
    Label2: TLabel;
    Bevel2: TBevel;
    Label3: TLabel;
    Label4: TLabel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    tricoSecu: TCoolTrayIcon;
    pmMain: TPopupMenu;
    mmiMinimizeToTray: TMenuItem;
    N2: TMenuItem;
    mmiClose: TMenuItem;
    mmiStealthMode: TMenuItem;
    imgIcoTray: TImageList;
    pmCams: TPopupMenu;
    tbtnHalt: TToolButton;
    procedure FormShow(Sender: TObject);
    procedure tmGeneralTimer(Sender: TObject);
    procedure mmiExitClick(Sender: TObject);
    procedure mmiAboutClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure tbtnRunTestClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure mmiAddCamClick(Sender: TObject);
    procedure mmiMinimizeToTrayClick(Sender: TObject);
    procedure tbtnGoClick(Sender: TObject);
    procedure tbtnHaltClick(Sender: TObject);
  private
    { Private declarations }
  public
    MyCams: array[0..31] of TCamComparator;
    //Cam1: TCamComparator;
  end;

var
  frmMain: TfrmMain;

implementation

uses
  usplash, uabout;

{$R *.dfm}

procedure TfrmMain.FormShow(Sender: TObject);
begin
  //frmSplash.ShowModal;
end;

procedure TfrmMain.tmGeneralTimer(Sender: TObject);
begin
  sbStatus.Panels[0].Text:= TimeToStr (Now);
end;

procedure TfrmMain.mmiExitClick(Sender: TObject);
begin
  close;
end;

procedure TfrmMain.mmiAboutClick(Sender: TObject);
begin
  frmAbout.ShowModal;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  Doublebuffered:= true;
  tricoSecu.IconIndex:= 2;
end;

procedure TfrmMain.tbtnRunTestClick(Sender: TObject);
var Cam: TCam;
    Cam2: TCam;
    Cam3: TCam;
    Cam4: TCam;
begin
  // Test prozeduren hier
  Cam:= TCam.Create (tbsMain);
  Cam.AttachedCam:= 'USB Video Device';
  Cam.Top:= 8;
  Cam.Left:= 8;
  Cam.Visible:= true;
  Cam.MotionDetection:= false;
  //Cam.CamComparator.DoHighlight:= true;
  //Cam.CamComparator.Sensitivity:= 10;
  //Cam.FrameRate:= 500;
  Cam.VideoStart;

  Cam2:= TCam.Create (tbsMain);
  Cam2.Top:= 8;
  Cam2.Left:= 360;

  Cam3:= TCam.Create (tbsMain);
  Cam3.AttachedCam:= 'Logitech QuickCam Express';
  Cam3.Top:= 264;
  Cam3.Left:= 8;
  Cam3.Visible:= true;
  Cam3.MotionDetection:= true;
  Cam3.CamComparator.DoHighlight:= true;
  Cam3.CamComparator.Sensitivity:= 10;
  Cam3.VideoStart;

  Cam4:= TCam.Create (tbsMain);
  Cam4.Top:= 264;
  Cam4.Left:= 360;
end;

procedure TfrmMain.FormDestroy(Sender: TObject);
var I: integer;
begin
  //
end;

procedure TfrmMain.mmiAddCamClick(Sender: TObject);
begin
  if frmAddCam.ShowModal = mrOk then begin
    //
  end;
end;

procedure TfrmMain.mmiMinimizeToTrayClick(Sender: TObject);
begin
  if frmMain.Visible = true then begin
    mmiMinimizeToTray.Caption:= 'Maximize';
    frmMain.Visible:= false;
  end
  else begin
    mmiMinimizeToTray.Caption:= 'Minimize to tray';
    frmMain.Visible:= true;
  end;
end;

procedure TfrmMain.tbtnGoClick(Sender: TObject);
begin
  tricoSecu.IconIndex:= 0;
  tricoSecu.ShowBalloonHint('Information', 'Kamera Überwachung ist jetzt aktiv!',
                            bitInfo,10);
end;

procedure TfrmMain.tbtnHaltClick(Sender: TObject);
begin
  tricoSecu.IconIndex:= 2;
  tricoSecu.ShowBalloonHint('Information', 'Kamera Überwachung gestoppt!',
                            bitWarning,10);
end;

end.
