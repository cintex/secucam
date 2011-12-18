unit umain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ExtCtrls, StdCtrls, VFrames, Spin, Gauges;

type
  TfrmMain = class(TForm)
    lbCamList: TListBox;
    imgCamMain: TImage;
    imgCamCurrent: TImage;
    sbStatus: TStatusBar;
    imgCamReference: TImage;
    imgCamDifference: TImage;
    btnCap: TButton;
    btnStop: TButton;
    tmCap: TTimer;
    speGrid: TSpinEdit;
    gauDifference: TGauge;
    Label1: TLabel;
    Difference: TLabel;
    shCap: TShape;
    Label2: TLabel;
    shComp: TShape;
    Label3: TLabel;
    btnGetCurr: TButton;
    btnGetRef: TButton;
    btnComp: TButton;
    procedure FormCreate(Sender: TObject);
    procedure lbCamListClick(Sender: TObject);
    procedure btnCapClick(Sender: TObject);
    procedure tmCapTimer(Sender: TObject);
    procedure btnStopClick(Sender: TObject);
  private
    CurrentCam: TVideoImage;
    CamActive : boolean;
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;
  Cams : TStringList;

implementation

{$R *.dfm}

procedure TfrmMain.FormCreate(Sender: TObject);
var I: integer;
begin
  doublebuffered:= true;
  Cams:= TStringList.Create;
  imgCamMain.Canvas.TextOut (10, 10, 'NO CAM SELECTED');
  imgCamCurrent.Canvas.TextOut (10, 10, 'IDLE [Current Frame]');
  imgCamReference.Canvas.TextOut (10, 10, 'IDLE [Reference Frame]');
  imgCamDifference.Canvas.TextOut (10, 10, 'IDLE [Difference]');
  CurrentCam:= TVideoImage.Create;
  CurrentCam.SetDisplayCanvas (imgCamMain.Canvas);
  CurrentCam.GetListOfDevices (Cams);
  for I:= 0 to Cams.Count - 1 do begin
    lbCamList.Items.Add(Cams.Strings[I])
  end;
end;

procedure TfrmMain.lbCamListClick(Sender: TObject);
begin
  CurrentCam.VideoStop;
  CurrentCam.VideoStart (lbCamList.Items[lbCamList.itemindex]);
  sbStatus.Panels[0].Text:= 'ACTIVE CAM: ' + lbCamList.Items[lbCamList.itemindex];
end;

procedure TfrmMain.btnCapClick(Sender: TObject);
begin
  tmCap.Enabled:= true;
end;

procedure TfrmMain.tmCapTimer(Sender: TObject);
var I: integer;
    Interval: integer;
begin
  if shCap.Brush.Color = clWhite then shCap.Brush.Color:= clLime
                                 else shCap.Brush.Color:= clWhite;
  imgCamCurrent.Picture:= imgCamMain.Picture;
  imgCamCurrent.Canvas.Pen.Color:= clLime;
  imgCamCurrent.Canvas.Pen.Width:= 1;
  Interval:= tmCap.Interval;
  I:= 1;
  while I <> 320 do begin
    if I mod speGrid.Value = 0 then begin
      imgCamCurrent.Canvas.MoveTo(I,0);
      imgCamCurrent.Canvas.LineTo(I,240);
    end;
    inc (I);
  end;
  I:= 1;
  while I <> 240 do begin
    if I mod (speGrid.Value - 8) = 0 then begin
      imgCamCurrent.Canvas.MoveTo(0,I);
      imgCamCurrent.Canvas.LineTo(320,I);
    end;
    inc (I);
  end;
  imgCamCurrent.Canvas.TextOut (5,5,'GetFrame FPS: ' + FloatToStr(Round (1000 / Interval)));
  imgCamMain.Canvas.TextOut (5,5,'Actual FPS: ' + FloatToStr (Round (CurrentCam.FramesPerSecond)));
  if Round (CurrentCam.FramesPerSecond) <> 0 then tmCap.Interval:= Round (1000 / CurrentCam.FramesPerSecond);
end;

procedure TfrmMain.btnStopClick(Sender: TObject);
begin
  //TEST DIFF
  imgCamCurrent.Canvas.Pen.Color:= clWhite;
  imgCamCurrent.Canvas.Rectangle(0,0,320,240);
  imgCamCurrent.Canvas.TextOut (10,10,'IDLE [Current Frame]');
  tmCap.Enabled:= false;
end;

end.
