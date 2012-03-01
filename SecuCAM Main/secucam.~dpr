program secucam;

uses
  Forms,
  umain in 'umain.pas' {frmMain},
  usplash in 'usplash.pas' {frmSplash},
  uabout in 'uabout.pas' {frmAbout},
  ucamcomparator in 'ucamcomparator.pas',
  uaddcam in 'uaddcam.pas' {frmAddCam},
  ucamdb in 'ucamdb.pas',
  ucam in 'ucam.pas',
  ucam_v2 in 'ucam_v2.pas',
  ucamcomparator_v2 in 'ucamcomparator_v2.pas',
  ueditcam in 'ueditcam.pas' {frmEditCam},
  ucamdb_v2 in 'ucamdb_v2.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'SecuCAM CST';
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmSplash, frmSplash);
  Application.CreateForm(TfrmAbout, frmAbout);
  Application.CreateForm(TfrmAddCam, frmAddCam);
  Application.CreateForm(TfrmEditCam, frmEditCam);
  Application.Run;
end.
