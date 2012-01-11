unit umain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ToolWin, Menus, ExtCtrls;

type
  TfrmMain = class(TForm)
    mmMainMenu: TMainMenu;
    mmiFile: TMenuItem;
    mmiSettings: TMenuItem;
    mmiHelp: TMenuItem;
    mmiAbout: TMenuItem;
    mmiExit: TMenuItem;
    ToolBar1: TToolBar;
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
    pbCamW1: TPaintBox;
    pbCamW2: TPaintBox;
    pbCamW3: TPaintBox;
    pbCamW4: TPaintBox;
    tmGeneral: TTimer;
    procedure pbCamW1Paint(Sender: TObject);
    procedure pbCamW2Paint(Sender: TObject);
    procedure pbCamW3Paint(Sender: TObject);
    procedure pbCamW4Paint(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure tmGeneralTimer(Sender: TObject);
    procedure mmiExitClick(Sender: TObject);
    procedure mmiAboutClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

uses
  usplash, uabout;

{$R *.dfm}

procedure TfrmMain.pbCamW1Paint(Sender: TObject);
begin
  pbCamW1.Canvas.Rectangle (1,1,320,240);
  pbCamW1.Canvas.TextOut(10,10,'Keine Kamera definiert!');
end;

procedure TfrmMain.pbCamW2Paint(Sender: TObject);
begin
  pbCamW2.Canvas.Rectangle (1,1,320,240);
  pbCamW2.Canvas.TextOut(10,10,'Keine Kamera definiert!');
end;

procedure TfrmMain.pbCamW3Paint(Sender: TObject);
begin
  pbCamW3.Canvas.Rectangle (1,1,320,240);
  pbCamW3.Canvas.TextOut(10,10,'Keine Kamera definiert!');
end;

procedure TfrmMain.pbCamW4Paint(Sender: TObject);
begin
  pbCamW4.Canvas.Rectangle (1,1,320,240);
  pbCamW4.Canvas.TextOut(10,10,'Keine Kamera definiert!');
end;

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

end.
