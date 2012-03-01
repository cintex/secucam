{*******************************************************************************
     *  SecuCAM CST // ueditcam.pas *
     ********************************

  Entwickelt von : WARNIMONT POL
                   T3IF @ Lycée du Nord
                   2011 - 2012

  Beschreibung : Form um Kameraeinstellungen zu ändern.

*******************************************************************************}

unit ueditcam;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Spin, ComCtrls, FileCtrl;

type
  TfrmEditCam = class(TForm)
    Label1: TLabel;
    Bevel1: TBevel;
    Label2: TLabel;
    btnAccept: TButton;
    btnCancel: TButton;
    lblCamName: TLabel;
    Label3: TLabel;
    edtAlias: TEdit;
    gbCamSettings: TGroupBox;
    Label8: TLabel;
    Label9: TLabel;
    shGridColor: TShape;
    shHighlightColor: TShape;
    lblDiff: TLabel;
    lblTol: TLabel;
    ckbMotDect: TCheckBox;
    ckbGrid: TCheckBox;
    ckbHighlight: TCheckBox;
    trbDiff: TTrackBar;
    trbToll: TTrackBar;
    speRes: TSpinEdit;
    speInt: TSpinEdit;
    btnGridColor: TButton;
    btnHighlightColor: TButton;
    dlgColor: TColorDialog;
    procedure btnHighlightColorClick(Sender: TObject);
    procedure btnGridColorClick(Sender: TObject);
    procedure trbDiffChange(Sender: TObject);
    procedure trbTollChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmEditCam: TfrmEditCam;

implementation

{$R *.dfm}

procedure TfrmEditCam.btnHighlightColorClick(Sender: TObject);
begin
  dlgColor.Color:= shHighlightColor.Brush.Color;
  if dlgColor.Execute then begin
    shHighlightColor.Brush.Color:= dlgColor.Color;
  end;
end;

procedure TfrmEditCam.btnGridColorClick(Sender: TObject);
begin
  dlgColor.Color:= shGridColor.Brush.Color;
  if dlgColor.Execute then begin
    shGridColor.Brush.Color:= dlgColor.Color;
  end;
end;

procedure TfrmEditCam.trbDiffChange(Sender: TObject);
begin
  lblDiff.Caption:= 'Reagiere bei ' + IntToStr (trbDiff.Position) + '% unterschied.';
end;

procedure TfrmEditCam.trbTollChange(Sender: TObject);
begin
  lblTol.Caption:= 'Toleranz: ' + IntToStr (round ((trbToll.Position / 40)*100)) + '%';
end;

end.
