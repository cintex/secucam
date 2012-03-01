{*******************************************************************************
     *  SecuCAM CST // uaddcam.pas *
     *******************************

  Entwickelt von : WARNIMONT POL
                   T3IF @ Lycée du Nord
                   2011 - 2012

  Beschreibung : Unit für die Form, um eine Kamera hinzuzufügen.

*******************************************************************************}

unit uaddcam;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls, VFrames, Spin;

type
  TfrmAddCam = class(TForm)
    Label1: TLabel;
    Bevel1: TBevel;
    pgAddCam: TPageControl;
    tbsUSBCam: TTabSheet;
    tbsIPCam: TTabSheet;
    btnAdd: TButton;
    btnCancel: TButton;
    lbAvailableCams: TListBox;
    Label2: TLabel;
    Label3: TLabel;
    edtAlias: TEdit;
    Label4: TLabel;
    lblCamName: TLabel;
    gbCamProps: TGroupBox;
    ckbGridOn: TCheckBox;
    ckbMotActive: TCheckBox;
    dlgColor: TColorDialog;
    ckbHighlightOn: TCheckBox;
    btnGridColor: TButton;
    btnHighlightColor: TButton;
    Label7: TLabel;
    shGridColor: TShape;
    shHighlightColor: TShape;
    speRes: TSpinEdit;
    Label5: TLabel;
    Label8: TLabel;
    speInt: TSpinEdit;
    trbDiff: TTrackBar;
    trbTol: TTrackBar;
    lblDiff: TLabel;
    lblTol: TLabel;
    procedure lbAvailableCamsClick(Sender: TObject);
    procedure btnGridColorClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure btnHighlightColorClick(Sender: TObject);
    procedure trbDiffChange(Sender: TObject);
    procedure trbTolChange(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btnCancelClick(Sender: TObject);
  private
    TempCam : TVideoImage;
    Err     : boolean;

    procedure ClearFields;
  public
    { Public declarations }
  end;

var
  frmAddCam: TfrmAddCam;

implementation

{$R *.dfm}

procedure TfrmAddCam.ClearFields;
begin
  //lbAvailableCams.ItemIndex:= -1;
  lblCamName.Caption:= 'Keine';
  edtAlias.Text:= '';
  ckbMotActive.Checked:= false;
  ckbGridOn.Checked:= false;
  ckbHighlightOn.Checked:= false;
  speRes.Value:= 4;
  speInt.Value:= 100;
  trbDiff.Position:= 1;
  trbTol.Position:= 1;
  shGridColor.Brush.Color:= clWhite;
  shHighlightColor.Brush.Color:= clWhite;
end;

procedure TfrmAddCam.lbAvailableCamsClick(Sender: TObject);
begin
  if lbAvailableCams.ItemIndex <> -1 then begin
    ClearFields;
    //TempCam.VideoStop;
    gbCamProps.Visible:= true;
    lblCamName.Caption:= lbAvailableCams.Items[lbAvailableCams.ItemIndex];
    //TempCam.VideoStart (lblCamName.Caption);
  end else gbCamProps.Visible:= false;
end;

procedure TfrmAddCam.btnGridColorClick(Sender: TObject);
begin
  dlgColor.Color:= shGridColor.Brush.Color;
  if dlgColor.Execute then begin
    shGridColor.Brush.Color:= dlgColor.Color;
  end;
end;

procedure TfrmAddCam.FormShow(Sender: TObject);
var TmpStrLst: TStringList;
    I        : integer;
begin
  ClearFields;
  gbCamProps.Visible:= false;
  lbAvailableCams.Clear;
  TmpStrLst:= TStringList.Create;
  TempCam:= TVideoImage.Create;
  //TempCam.SetDisplayCanvas (imgPreview.Canvas);
  TempCam.GetListOfDevices (TmpStrLst);
  for I:= 0 to TmpStrLst.Count - 1 do
    lbAvailableCams.Items.Add (TmpStrLst[I]);
  edtAlias.Text:= '';
end;

procedure TfrmAddCam.FormHide(Sender: TObject);
begin
  TempCam.VideoStop;
  TempCam.Destroy;
end;

procedure TfrmAddCam.btnHighlightColorClick(Sender: TObject);
begin
  dlgColor.Color:= shHighlightColor.Brush.Color;
  if dlgColor.Execute then begin
    shHighlightColor.Brush.Color:= dlgColor.Color;
  end;
end;

procedure TfrmAddCam.trbDiffChange(Sender: TObject);
begin
  lblDiff.Caption:= 'Reagiere bei ' + IntToStr (trbDiff.Position) + '% unterschied.';
end;

procedure TfrmAddCam.trbTolChange(Sender: TObject);
var PercTol: real;
begin
  lblTol.Caption:= 'Toleranz: ' + IntToStr (round ((trbTol.Position / 40)*100)) + '%';
end;

procedure TfrmAddCam.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if (lbAvailableCams.ItemIndex = -1) AND (ModalResult = mrOk) then begin
    CanClose:= true;
    case MessageDlg ('Sie haben keine Kamera ausgewählt! Möchten Sie wirklich '+
                     'fortfahren?',
                     mtWarning,
                     [mbYes,mbNo],
                     0) of
      mrYes : ModalResult:= mrCancel;
      mrNo  : CanClose:= false;
    end;
  end;
end;

procedure TfrmAddCam.btnCancelClick(Sender: TObject);
begin
  Err:= false;
end;

end.
