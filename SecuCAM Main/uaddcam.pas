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
  Dialogs, StdCtrls, ComCtrls, ExtCtrls, VFrames;

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
    ckbCamActive: TCheckBox;
    dlgColor: TColorDialog;
    ckbHighlightOn: TCheckBox;
    btnGridColor: TButton;
    btnHighlightColor: TButton;
    imgPreview: TImage;
    Label6: TLabel;
    Label7: TLabel;
    shGridColor: TShape;
    shHighlightColor: TShape;
    procedure lbAvailableCamsClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnGridColorClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure btnHighlightColorClick(Sender: TObject);
  private
    TempCam: TVideoImage;
  public
    { Public declarations }
  end;

var
  frmAddCam: TfrmAddCam;

implementation

{$R *.dfm}

procedure TfrmAddCam.lbAvailableCamsClick(Sender: TObject);
begin
  if lbAvailableCams.ItemIndex <> -1 then begin
    TempCam.VideoStop;
    gbCamProps.Visible:= true;
    lblCamName.Caption:= lbAvailableCams.Items[lbAvailableCams.ItemIndex];
    TempCam.VideoStart (lblCamName.Caption);
  end else gbCamProps.Visible:= false;
end;

procedure TfrmAddCam.FormCreate(Sender: TObject);
begin
  imgPreview.Canvas.Rectangle (0,0,imgPreview.ClientWidth,imgPreview.ClientHeight);
  imgPreview.Canvas.TextOut (5,imgPreview.ClientHeight - 15,'Kein Bild!');
end;

procedure TfrmAddCam.btnGridColorClick(Sender: TObject);
begin
  if dlgColor.Execute then begin
    shGridColor.Brush.Color:= dlgColor.Color;
  end;
end;

procedure TfrmAddCam.FormShow(Sender: TObject);
var TmpStrLst: TStringList;
    I        : integer;
begin
  lbAvailableCams.Clear;
  TmpStrLst:= TStringList.Create;
  TempCam:= TVideoImage.Create;
  TempCam.SetDisplayCanvas (imgPreview.Canvas);
  TempCam.GetListOfDevices (TmpStrLst);
  for I:= 0 to TmpStrLst.Count - 1 do
    lbAvailableCams.Items.Add (TmpStrLst[I]);
end;

procedure TfrmAddCam.FormHide(Sender: TObject);
begin
  TempCam.VideoStop;
  TempCam.Destroy;
end;

procedure TfrmAddCam.btnHighlightColorClick(Sender: TObject);
begin
  if dlgColor.Execute then begin
    shHighlightColor.Brush.Color:= dlgColor.Color;
  end;
end;

end.
