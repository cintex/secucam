unit umain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ToolWin, Menus, ExtCtrls, VFrames, ImgList,
  ucamcomparator;

type
  TfrmMain = class(TForm)
    mmMainMenu: TMainMenu;
    mmiFile: TMenuItem;
    mmiSettings: TMenuItem;
    mmiHelp: TMenuItem;
    mmiAbout: TMenuItem;
    mmiExit: TMenuItem;
    tbMain: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    sbStatus: TStatusBar;
    lbCamList: TListBox;
    pgMain: TPageControl;
    tbsMain: TTabSheet;
    tbsExtended: TTabSheet;
    tmGeneral: TTimer;
    imgIcoLst: TImageList;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
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
    procedure FormShow(Sender: TObject);
    procedure tmGeneralTimer(Sender: TObject);
    procedure mmiExitClick(Sender: TObject);
    procedure mmiAboutClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure tbtnRunTestClick(Sender: TObject);
  private
    { Private declarations }
  public
    Cam1: TCamComparator;
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
begin
  Cam1:= TCamComparator.Create;
  imgCamW1.Canvas.Rectangle (0,0,320,240);
  imgCamW1.Canvas.TextOut(10,10,'Keine Kamera definiert!');
  imgCamW2.Canvas.Rectangle (0,0,320,240);
  imgCamW2.Canvas.TextOut(10,10,'Keine Kamera definiert!');
  imgCamW3.Canvas.Rectangle (0,0,320,240);
  imgCamW3.Canvas.TextOut(10,10,'Keine Kamera definiert!');
  imgCamW4.Canvas.Rectangle (0,0,320,240);
  imgCamW4.Canvas.TextOut(10,10,'Keine Kamera definiert!');
end;

procedure TfrmMain.tbtnRunTestClick(Sender: TObject);
begin
  Cam1.Sensitivity:= 3;
  Cam1.GridSize:= 16;
  Cam1.DoHighlight:= false;
  Cam1.GridColor:= clLime;
  Cam1.HighlightColor:= clRed;
  Cam1.GetPicture (imgCamW1);
  CamW1prog.Position:= 55;
  shCamW1det.Brush.Color:= clRed;
end;

end.
