program testcam3;

uses
  Forms,
  umain in 'umain.pas' {frmMain},
  ustatus in 'ustatus.pas' {frmStatus};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmStatus, frmStatus);
  Application.Run;
end.
