program secucam;

uses
  Forms,
  umain in 'umain.pas' {frmMain},
  usplash in 'usplash.pas' {frmSplash},
  uabout in 'uabout.pas' {frmAbout};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmSplash, frmSplash);
  Application.CreateForm(TfrmAbout, frmAbout);
  Application.Run;
end.
