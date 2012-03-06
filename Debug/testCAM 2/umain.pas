unit umain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DSPack, DSUtil, DirectShow9, StdCtrls;

type
  TfrmMain = class(TForm)
    VideoWindow1: TVideoWindow;
    ListBox1: TListBox;
    VideoSourceFilter: TFilter;
    CaptureGraph: TFilterGraph;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;
  VideoDevice: TSysDevEnum;
  VideoMediaTypes: TEnumMediaType;

implementation

{$R *.dfm}

procedure TfrmMain.FormCreate(Sender: TObject);
var i: integer;
begin
 VideoDevice := TSysDevEnum.Create(CLSID_VideoInputDeviceCategory);
 for i := 0 to VideoDevice.CountFilters - 1 do
   ListBox1.Items.Add(VideoDevice.Filters[i].FriendlyName);

 VideoMediaTypes := TEnumMediaType.Create;
end;

procedure TfrmMain.FormDestroy(Sender: TObject);
begin
  VideoDevice.Free;
 VideoMediaTypes.Free;
end;

end.
