{*******************************************************************************
     *  SecuCAM CST // usplash.pas *
     *******************************

  Entwickelt von : WARNIMONT POL
                   T3IF @ Lycée du Nord
                   2011 - 2012

  Beschreibung : Splash Screen.

*******************************************************************************}

unit usplash;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, ComCtrls;

type
  TfrmSplash = class(TForm)
    pbInit: TProgressBar;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    memInit: TMemo;
    Label3: TLabel;
    tmClose: TTimer;
    lblCntDown: TLabel;
    procedure tmCloseTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSplash: TfrmSplash;

implementation

{$R *.dfm}

procedure TfrmSplash.tmCloseTimer(Sender: TObject);
var CurrentVal: integer;
begin
  CurrentVal:= StrToInt(lblCntDown.Caption);
  if CurrentVal <> 0 then begin
    CurrentVal:= CurrentVal - 1;
    lblCntDown.Caption:= IntToStr (CurrentVal);
  end
  else begin
    tmClose.Enabled:= false;
    frmSplash.Close;
  end;
end;

procedure TfrmSplash.FormShow(Sender: TObject);
begin
  frmSplash.Left:= (Screen.Width div 2) - (frmSplash.Width div 2);
  frmSplash.Top:= (Screen.Height div 2) - (frmSplash.Height div 2);
end;

end.
