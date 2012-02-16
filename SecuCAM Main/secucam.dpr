program secucam;

uses
  Forms,
  umain in 'umain.pas' {frmMain},
  usplash in 'usplash.pas' {frmSplash},
  uabout in 'uabout.pas' {frmAbout},
  ucamcomparator in 'ucamcomparator.pas',
  uaddcam in 'uaddcam.pas' {frmAddCam},
  ucamdb in 'ucamdb.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'SecuCAM CST';
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmSplash, frmSplash);
  Application.CreateForm(TfrmAbout, frmAbout);
  Application.CreateForm(TfrmAddCam, frmAddCam);
  Application.Run;
end.
