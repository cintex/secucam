unit umain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ToolWin, Menus, ExtCtrls, VFrames, ImgList,
  ucamcomparator, uaddcam, CoolTrayIcon;

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
    tbtnHalt: TToolButton;
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
    imgCamW1: TImage;
    shCamW1det: TShape;
    Shape2: TShape;
    Shape3: TShape;
    Shape4: TShape;
    Shape5: TShape;
    Shape6: TShape;
    Shape7: TShape;
    Shape8: TShape;
    Shape9: TShape;
    Shape10: TShape;
    CamW1prog: TProgressBar;
    ProgressBar2: TProgressBar;
    ProgressBar3: TProgressBar;
    ProgressBar4: TProgressBar;
    imgCamW2: TImage;
    imgCamW3: TImage;
    imgCamW4: TImage;
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
    procedure FormShow(Sender: TObject);
    procedure tmGeneralTimer(Sender: TObject);
    procedure mmiExitClick(Sender: TObject);
    procedure mmiAboutClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure tbtnRunTestClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure mmiAddCamClick(Sender: TObject);
    procedure mmiMinimizeToTrayClick(Sender: TObject);
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
  frmSplash.ShowModal;
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
var I     : integer;
    TmpPic: TImage;
begin
  TmpPic:= TImage.Create (nil);
  for I:= 0 to 3 do begin
    MyCams[I]:= TCamComparator.Create;
    MyCams[I].Sensitivity:= 15;
    MyCams[I].GridSize:= 32;
    MyCams[I].DoHighlight:= false;
  end;
  MyCams[0].GetPicture (imgCamW1);
  MyCams[1].GetPicture (imgCamW2);
  MyCams[2].GetPicture (imgCamW3);
  MyCams[3].GetPicture (imgCamW4);
  TmpPic.Destroy;
end;

procedure TfrmMain.tbtnRunTestClick(Sender: TObject);
begin
  // Test prozeduren hier
  shCamW1det.Brush.Color:= clRed;
  sbStatus.Panels[1].Text:= 'Detektion an Kamera 1';
end;

procedure TfrmMain.FormDestroy(Sender: TObject);
var I: integer;
begin
  for I:= 0 to 3 do begin
    MyCams[I].Destroy;
  end;
end;

procedure TfrmMain.mmiAddCamClick(Sender: TObject);
begin
  frmAddCam.ShowModal;
end;

procedure TfrmMain.mmiMinimizeToTrayClick(Sender: TObject);
begin
  if frmMain.Visible = true then begin
    
  end
end;

end.
