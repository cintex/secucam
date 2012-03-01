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
  ucamcomparator, uaddcam, CoolTrayIcon, ucamdb, ueditcam, IdBaseComponent,
  IdComponent, IdTCPConnection, IdTCPClient, IdFTP, FileCtrl, Buttons, Spin,
  IdMessageClient, IdSMTP, IdMessage;

type
  TfrmMain = class(TForm)
    mmMainMenu: TMainMenu;
    mmiFile: TMenuItem;
    mmiSettings: TMenuItem;
    mmiHelp: TMenuItem;
    mmiAbout: TMenuItem;
    mmiExit: TMenuItem;
    tbMain: TToolBar;
    sbStatus: TStatusBar;
    lbCamList: TListBox;
    pgMain: TPageControl;
    tbsMain: TTabSheet;
    tbsExtended: TTabSheet;
    tmGeneral: TTimer;
    imgIcoLst: TImageList;
    ToolButton7: TToolButton;
    tbtnAddCam: TToolButton;
    tbtnSettings: TToolButton;
    N1: TMenuItem;
    mmiMinimize: TMenuItem;
    mmiOptions: TMenuItem;
    mmiAddCam: TMenuItem;
    imgFiller1: TImage;
    Shape5: TShape;
    Shape6: TShape;
    imgFiller2: TImage;
    imgFiller3: TImage;
    imgFiller4: TImage;
    Label1: TLabel;
    Bevel1: TBevel;
    tbsIntro: TTabSheet;
    Label2: TLabel;
    Bevel2: TBevel;
    Label3: TLabel;
    Label4: TLabel;
    btnNewCam: TButton;
    btnSettings: TButton;
    Label5: TLabel;
    Label6: TLabel;
    tricoSecu: TCoolTrayIcon;
    pmMain: TPopupMenu;
    pmiMinimizeToTray: TMenuItem;
    N2: TMenuItem;
    pmiClose: TMenuItem;
    imgIcoTray: TImageList;
    pmCams: TPopupMenu;
    pmiCamSettings: TMenuItem;
    pmiVideoStart: TMenuItem;
    pmiVideoPause: TMenuItem;
    pmiVideoStop: TMenuItem;
    N3: TMenuItem;
    pmiDelete: TMenuItem;
    pmiMotionDect: TMenuItem;
    N4: TMenuItem;
    gbMainSettings: TGroupBox;
    gbFTPSettings: TGroupBox;
    btnConfirm: TButton;
    gbMailSettings: TGroupBox;
    cmbDrives: TDriveComboBox;
    Label8: TLabel;
    lbDirs: TDirectoryListBox;
    Label9: TLabel;
    edtFTPAddr: TEdit;
    Label10: TLabel;
    speFTPPort: TSpinEdit;
    Label11: TLabel;
    edtRemoteDir: TEdit;
    edtFTPUser: TEdit;
    Label12: TLabel;
    Label13: TLabel;
    edtFTPPass: TEdit;
    btnTestCon: TButton;
    Label14: TLabel;
    edtMailRec: TEdit;
    Label15: TLabel;
    edtMailSnd: TEdit;
    edtMailServer: TEdit;
    Label16: TLabel;
    speMailPort: TSpinEdit;
    Label17: TLabel;
    edtMailAccount: TEdit;
    edtMailPassword: TEdit;
    Label18: TLabel;
    Button7: TButton;
    IdFTP1: TIdFTP;
    IdSMTP1: TIdSMTP;
    IdMessage1: TIdMessage;
    ckbFTP: TCheckBox;
    ckbEmail: TCheckBox;
    tbtnStop: TToolButton;
    tbtnPause: TToolButton;
    tbtnPlay: TToolButton;
    procedure tmGeneralTimer(Sender: TObject);
    procedure mmiAboutClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure mmiAddCamClick(Sender: TObject);
    procedure pmiMinimizeToTrayClick(Sender: TObject);
    procedure tbtnGoClick(Sender: TObject);
    procedure tbtnHaltClick(Sender: TObject);
    procedure pmCamsPopup(Sender: TObject);
    procedure pmiVideoStartClick(Sender: TObject);
    procedure pmiVideoStopClick(Sender: TObject);
    procedure pmiVideoPauseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure mmiOptionsClick(Sender: TObject);
    procedure pmiCamSettingsClick(Sender: TObject);
    procedure pmiMotionDectClick(Sender: TObject);
    procedure pmiDeleteClick(Sender: TObject);
    procedure lbCamListClick(Sender: TObject);
    procedure btnTestConClick(Sender: TObject);
    procedure IdFTP1Connected(Sender: TObject);
    procedure tbsExtendedHide(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure btnConfirmClick(Sender: TObject);
    procedure cmbDrivesChange(Sender: TObject);
    procedure tbtnSettingsClick(Sender: TObject);
    procedure btnNewCamClick(Sender: TObject);
    procedure btnSettingsClick(Sender: TObject);
    procedure pmiCloseClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure mmiExitClick(Sender: TObject);
    procedure mmiMinimizeClick(Sender: TObject);
  private
    CamDataBase: TCamDB;
  public
  end;

var
  frmMain: TfrmMain;

implementation

uses
  usplash, uabout;

{$R *.dfm}

procedure TfrmMain.tmGeneralTimer(Sender: TObject);
var I  : integer;
    Txt: TStringList;
begin
  sbStatus.Panels[0].Text:= TimeToStr (Now);
  if (CamDataBase.CamCount <> 0) AND (lbCamList.Items.Count <> 0) then begin
    if ckbEmail.Checked = true then begin
      for I:= 0 to lbCamList.Items.Count -1 do begin
        Txt:= TStringList.Create;
        Txt.Add('Achtung Alarm ausgelöst!');
        if CamDataBase.IsAlerted (lbCamList.Items[I]) = true then begin
          Txt.Add('Kamera: ' + lbCamList.Items[I]);
          IdMessage1.Body.Assign(Txt);
          IdMessage1.Subject:= 'SecuCAM CST';
          IdSMTP1.Connect();
          try
            IdSMTP1.Send (IdMessage1);
          finally
          IdSMTP1.Disconnect;
          end;
        end;
        Txt.Free;
      end;
    end;
  end;
end;

procedure TfrmMain.mmiAboutClick(Sender: TObject);
begin
  frmAbout.ShowModal;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  Doublebuffered:= true;
  tricoSecu.IconIndex:= 2;
  CamDataBase:= TCamDB.Create (tbsMain);
  //if fileexists ('secucam.db') then CamDataBase.LoadDB;
end;

procedure TfrmMain.mmiAddCamClick(Sender: TObject);
var TmpSettings: TCamSettings;
begin
  if frmAddCam.ShowModal = mrOk then begin
    if lbCamList.Items[0] = 'Keine Kamera verfügbar' then begin
      lbCamList.Clear;
      lbCamList.Enabled:= true;
    end;
    with TmpSettings do begin
      CamName:= frmAddCam.lblCamName.Caption;
      if frmAddCam.edtAlias.Text = '' then Alias:= CamName
                                      else Alias:= frmAddCam.edtAlias.Text;
      Activated:= true;
      AlarmLevel:= frmAddCam.trbDiff.Position;
      FrameRate:= frmAddCam.speInt.Value;
      Sensitivity:= frmAddCam.trbTol.Position;
      Resolution:= frmAddCam.speRes.Value;
      DoHighlight:= frmAddCam.ckbHighlightOn.Checked;
      ShowGrid:= frmAddCam.ckbGridOn.Checked;
      GridColor:= frmAddCam.shGridColor.Brush.Color;
      HighlightColor:= frmAddCam.shHighlightColor.Brush.Color;
      Parent:= tbsMain;
      MotionDetection:= frmAddCam.ckbMotActive.Checked;
      if CamDataBase.CamCount < 4 then Visible:= true
                                  else Visible:= false;
      if CamDataBase.AddCam (TmpSettings) = true then begin
        lbCamList.Items.Add (Alias)
      end
      else MessageDlg ('Kann Kamera nicht hinzufügen!', mtError, [mbOk], 0);
    end;
  end;
end;

procedure TfrmMain.pmiMinimizeToTrayClick(Sender: TObject);
begin
  if frmMain.Visible = true then begin
    pmiMinimizeToTray.Caption:= 'Maximieren';
    frmMain.Visible:= false;
  end
  else begin
    pmiMinimizeToTray.Caption:= 'Zur Taskleiste minimieren';
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

procedure TfrmMain.pmCamsPopup(Sender: TObject);
var TmpSettings: TCamSettings;
    Alias: string;
begin
  //
end;

procedure TfrmMain.pmiVideoStartClick(Sender: TObject);
begin
  if CamDataBase.StartCam (lbCamList.Items[lbCamList.ItemIndex]) = false then
    MessageDlg ('Kamera konnte nicht gestartet werden!',
                mtError,
                [mbOk],
                0);
end;

procedure TfrmMain.pmiVideoStopClick(Sender: TObject);
begin
  if CamDataBase.StopCam (lbCamList.Items[lbCamList.ItemIndex]) = false then
    MessageDlg ('Kamera konnte nicht gestoppt werden!',
                mtError,
                [mbOk],
                0);
end;

procedure TfrmMain.pmiVideoPauseClick(Sender: TObject);
begin
  if CamDataBase.PauseCam (lbCamList.Items[lbCamList.ItemIndex]) = false then
    MessageDlg ('Kamera konnte nicht pausiert werden!',
                mtError,
                [mbOk],
                0);
end;

procedure TfrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  CamDataBase.Destroy;
end;

procedure TfrmMain.mmiOptionsClick(Sender: TObject);
begin
  tbsExtended.Show;
end;

procedure TfrmMain.pmiCamSettingsClick(Sender: TObject);
var TmpSettings: TCamSettings;
    Alias      : string;
begin
  Alias:= lbCamList.Items[lbCamList.ItemIndex];
  if CamDataBase.GetCam (Alias, TmpSettings) = true then begin
    with TmpSettings do begin
      frmEditCam.lblCamName.Caption:= CamName;
      frmEditCam.edtAlias.Text:= Alias;
      frmEditCam.ckbMotDect.Checked:= MotionDetection;
      frmEditCam.ckbGrid.Checked:= ShowGrid;
      frmEditCam.ckbHighlight.Checked:= DoHighlight;
      frmEditCam.speRes.Value:= Resolution;
      frmEditCam.speInt.Value:= FrameRate;
      frmEditCam.trbDiff.Position:= AlarmLevel;
      frmEditCam.trbToll.Position:= Sensitivity;
      frmEditCam.shGridColor.Brush.Color:= GridColor;
      frmEditCam.shHighlightColor.Brush.Color:= HighlightColor;
    end;
    if frmEditCam.ShowModal = mrOk then begin
      if CamDataBase.IsCamRunning (Alias) = true then CamDataBase.StopCam (Alias);
      with TmpSettings do begin
        Alias:= frmEditCam.edtAlias.Text;
        MotionDetection:= frmEditCam.ckbMotDect.Checked;
        Showgrid:= frmEditCam.ckbGrid.Checked;
        DoHighlight:= frmEditCam.ckbHighlight.Checked;
        Resolution:= frmEditCam.speRes.Value;
        FrameRate:= frmEditCam.speInt.Value;
        AlarmLevel:= frmEditCam.trbDiff.Position;
        Sensitivity:= frmEditCam.trbToll.Position;
        GridColor:= frmEditCam.shGridColor.Brush.Color;
        HighlightColor:= frmEditCam.shHighlightColor.Brush.Color;
      end;
      if CamDataBase.IsCamRunning (Alias) = true then CamDataBase.StopCam (Alias);
      CamDataBase.EditCam (Alias, TmpSettings);
      CamDataBase.StartCam (Alias);
    end;
  end
  else MessageDlg ('Es ist ein Fehler aufgetreten!',
                   mtError,
                   [mbOk],
                   0);
end;

procedure TfrmMain.pmiMotionDectClick(Sender: TObject);
var TmpSettings: TCamSettings;
begin
  CamDataBase.GetCam (lbCamList.Items[lbCamList.ItemIndex], TmpSettings);
  if TmpSettings.MotionDetection = false then
    CamDataBase.MotionDetection (lbCamList.Items[lbCamList.ItemIndex], true)
  else
    CamDataBase.MotionDetection (lbCamList.Items[lbCamList.ItemIndex], false);
end;

procedure TfrmMain.pmiDeleteClick(Sender: TObject);
var TmpSettings: TCamSettings;
begin
  if MessageDlg ('Möchten Sie wirklich die Kamera ' + lbCamList.Items[lbCamList.ItemIndex] +
                 ' löschen?',
                 mtConfirmation,
                 [mbYes,mbNo],
                 0) = mrYes then begin
    CamDataBase.DelCam (lbCamList.Items[lbCamList.ItemIndex]);
    lbCamList.Items.Delete (lbCamList.ItemIndex);
    CamDataBase.RearrangeCams;
    if lbCamList.Items.Count = 0 then begin
      lbCamList.Items.Add ('Keine Kamera verfügbar');
      lbCamList.Enabled:= false;
    end;
  end;
end;

procedure TfrmMain.lbCamListClick(Sender: TObject);
var Alias      : string;
    //TmpSettings: TCamSettings;
begin
  pmiVideoStart.Enabled:= false;
  pmiVideoPause.Enabled:= false;
  pmiVideoStop.Enabled:= false;
  pmiCamSettings.Enabled:= false;
  pmiMotionDect.Enabled:= false;
  pmiDelete.Enabled:= false;
  tbtnPlay.Enabled:= false;
  tbtnPause.Enabled:= false;
  tbtnStop.Enabled:= false;
  if lbCamList.ItemIndex <> -1 then begin
    tbtnPlay.Enabled:= true;
    tbtnPause.Enabled:= true;
    tbtnStop.Enabled:= true;
    pmiDelete.Enabled:= true;
    pmiCamSettings.Enabled:= true;
    pmiMotionDect.Enabled:= true;
    Alias:= lbCamList.Items[lbCamList.ItemIndex];
    if CamDataBase.IsCamRunning (Alias) = false then begin
      pmiVideoStart.Enabled:= true;
    end
    else begin
      pmiVideoStop.Enabled:= true;
      pmiVideoPause.Enabled:= true;
    end;
  end;
end;

procedure TfrmMain.btnTestConClick(Sender: TObject);
begin
  {FTPTest:= true;
  IdFTP1.Host:= edtFTPAddr.Text;
  IdFTP1.Port:= speFTPPort.Value;
  IdFTP1.Username:= edtFTPUser.Text;
  IdFTP1.Password:= edtFTPPass.Text;
  IdFTP1.Connect();}
end;

procedure TfrmMain.IdFTP1Connected(Sender: TObject);
begin
  {if FTPTest = true then begin
    MessageDlg ('Test erfolgreich!', mtInformation, [mbOk],0);
    FTPTest:= false;
  end;}
end;

procedure TfrmMain.tbsExtendedHide(Sender: TObject);
begin
  if IdFTP1.Connected = true then IdFTP1.Disconnect;
end;

procedure TfrmMain.Button7Click(Sender: TObject);
var Txt: TStringlist;
begin
  Txt:= TStringList.Create;
  Txt.Add('THIS IS A TEST MESSAGE!');
  IdSMTP1.AuthenticationType:= atLogin;
  IdSMTP1.Username:= edtMailAccount.Text;
  IdSMTP1.Password:= edtMailPassword.Text;
  IdSMTP1.Host:= edtMailServer.Text;
  IdSMTP1.Port:= speMailPort.Value;
  IdSMTP1.Connect();
  IdMessage1.Body.Assign(Txt);
  IdMessage1.From.Text:= edtMailSnd.Text;
  IdMessage1.Recipients.EMailAddresses:= edtMailRec.Text;
  IdMessage1.Subject:= 'SecuCAM Test Message';
  try
    IdSMTP1.Send (IdMessage1);
  finally
    IdSMTP1.Disconnect;
    Txt.Free;
  end;
end;

procedure TfrmMain.btnConfirmClick(Sender: TObject);
var Err        : boolean;
    I          : integer;
    TmpSettings: TCamSettings;
begin
  Err:= false;
  if ckbEmail.Checked then begin
    if (edtMailAccount.Text = '') OR
       (edtMailPassword.Text = '') OR
       (edtMailServer.Text = '') OR
       (edtMailSnd.Text = '') OR
       (edtMailRec.Text = '') then begin
      MessageDlg ('Bitte füllen Sie alle Felder aus',
                  mtWarning,
                  [mbOk],
                  0);
      Err:= true;
    end
    else begin
      IdSMTP1.AuthenticationType:= atLogin;
      IdSMTP1.Username:= edtMailAccount.Text;
      IdSMTP1.Password:= edtMailPassword.Text;
      IdSMTP1.Host:= edtMailServer.Text;
      IdSMTP1.Port:= speMailPort.Value;
      IdMessage1.From.Text:= edtMailSnd.Text;
      IdMessage1.Recipients.EMailAddresses:= edtMailRec.Text;
      MessageDlg ('Bitte füllen Sie alle Felder aus',
                  mtInformation,
                  [mbOk],
                  0);
    end;
  end;
  if (Err = false) AND (lbCamList.Items.Count <> 0) then begin
    for I:= 0 to lbCamList.Items.Count -1 do begin
      CamDataBase.GetCam (lbCamList.Items[I], TmpSettings);
      TmpSettings.Path:= lbDirs.Directory;
      CamDataBase.EditCam (lbCamList.Items[I], TmpSettings);
    end;
  end;
end;

procedure TfrmMain.cmbDrivesChange(Sender: TObject);
begin
  lbDirs.Drive:= cmbDrives.Drive;
end;

procedure TfrmMain.tbtnSettingsClick(Sender: TObject);
begin
  tbsExtended.Show;
end;

procedure TfrmMain.btnNewCamClick(Sender: TObject);
begin
  tbtnAddCam.Click;
  btnSettings.Enabled:= true;
end;

procedure TfrmMain.btnSettingsClick(Sender: TObject);
begin
  tbsMain.Show;
  tbsIntro.Hide;
  tbsIntro.Visible:= false;
  tbsIntro.Enabled:= false;
end;

procedure TfrmMain.pmiCloseClick(Sender: TObject);
var I: integer;
begin
  close;  
end;

procedure TfrmMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var I: integer;
begin
  if MessageDlg ('Program wirklich beenden?',
                 mtConfirmation,
                 [mbYes,mbNo],
                 0) = mrYes then begin
    {if lbCamList.Items[0] <> 'Keine Kamera verfügbar' then begin
      for I:= 0 to lbCamList.Count -1 do
        CamDataBase.StopCam (lbCamList.Items[I]);
      CamDataBase.SaveDB;
    end;}
    CanClose:= true;
  end
  else CanClose:= false;
end;

procedure TfrmMain.mmiExitClick(Sender: TObject);
begin
  close;
end;

procedure TfrmMain.mmiMinimizeClick(Sender: TObject);
begin
  pmiMinimizeToTray.Click;
end;

end.
