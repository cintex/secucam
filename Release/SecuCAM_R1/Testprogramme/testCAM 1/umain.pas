unit umain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TRGB32 = packed record
    B, G, R, A: Byte;
  end;
  TRGB32Array = packed array[0..MaxInt div SizeOf(TRGB32)-1] of TRGB32; 
  PRGB32Array = ^TRGB32Array;

type
  TForm1 = class(TForm)
    plCAM: TPanel;
    btnStream: TButton;
    tmAutom: TTimer;
    imgActual: TImage;
    imgReference: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    imgXOR: TImage;
    Label4: TLabel;
    btnCapture: TButton;
    btnRefernce: TButton;
    btnCompare: TButton;
    btnAuto: TButton;
    lblStatus: TLabel;
    grpStreamStats: TGroupBox;
    grpActualStats: TGroupBox;
    grpRefStats: TGroupBox;
    grpDetectionStats: TGroupBox;
    Label5: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    lblStreamRed: TLabel;
    lblStreamGreen: TLabel;
    lblStreamBlue: TLabel;
    lblStreamAlpha: TLabel;
    lblStreamMean: TLabel;
    Label16: TLabel;
    lblActualRed: TLabel;
    lblActualGreen: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    lblActualBlue: TLabel;
    lblActualAlpha: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    lblActualMean: TLabel;
    Label26: TLabel;
    lblRefRed: TLabel;
    lblRefGreen: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    lblRefBlue: TLabel;
    lblRefAlpha: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    lblRefMean: TLabel;
    Label36: TLabel;
    lblXORRed: TLabel;
    lblXORGreen: TLabel;
    Label39: TLabel;
    Label40: TLabel;
    lblXORBlue: TLabel;
    lblXORAlpha: TLabel;
    Label43: TLabel;
    Label44: TLabel;
    lblXORMean: TLabel;
    plDetection: TPanel;
    Button1: TButton;
    ledCap: TShape;
    ledComp: TShape;
    ledWarn: TShape;
    procedure btnStreamClick(Sender: TObject);
    procedure btnCaptureClick(Sender: TObject);
    procedure btnRefernceClick(Sender: TObject);
    procedure btnCompareClick(Sender: TObject);
    procedure btnAutoClick(Sender: TObject);
    procedure tmAutomTimer(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

const
  WM_CAP_DRIVER_CONNECT = WM_USER + 10;
  WM_CAP_EDIT_COPY = WM_USER + 30;
  WM_CAP_SET_PREVIEW = WM_USER + 50;
  WM_CAP_SET_OVERLAY = WM_USER + 51;
  WM_CAP_SET_PREVIEWRATE = WM_USER + 52;

var
  Form1: TForm1;

implementation

function capCreateCaptureWindow(lpszWindowName: LPCSTR;
  dwStyle: DWORD;
  x, y,
  nWidth,
  nHeight: integer;
  hwndParent: HWND;
  nID: integer): HWND; stdcall;
  external 'AVICAP32.DLL' name 'capCreateCaptureWindowA';

function CapFromStream (Frame: TBitmap; Handle : hWnd): boolean;
var Area           : TRect;
    AWidth, AHeight: Integer;
begin
  try
    GetWindowRect(Handle, Area);
    AWidth := Area.Right - Area.Left;
    AHeight := Area.Bottom - Area.Top;
    Frame.Width := AWidth;
    Frame.Height := AHeight;
    BitBlt(Frame.Canvas.Handle, 0, 0, AWidth, AHeight, GetWindowDC(Handle), 0, 0, SRCCOPY);
  finally
    ReleaseDC(Handle, GetWindowDC(Handle));
  end;
end;

{$R *.dfm}

procedure TForm1.btnStreamClick(Sender: TObject);
var handle:THandle;
begin
  handle := capCreateCaptureWindow('Video',ws_child+ws_visible, 0,
  0, 320, 240, plCAM.Handle, 1);
  SendMessage(handle, WM_CAP_DRIVER_CONNECT, 0, 0);
  SendMessage(handle, WM_CAP_SET_PREVIEWRATE, 30, 0);
  sendMessage(handle, WM_CAP_SET_OVERLAY, 1, 0);
  SendMessage(handle, wm_cap_set_preview, 1, 0);
end;

procedure TForm1.btnCaptureClick(Sender: TObject);
var AFrame: TBitmap;
begin
  AFrame:= TBitmap.Create;
  CapFromStream (AFrame, plCAM.Handle);
  imgActual.Picture.Bitmap:= AFrame;
  AFrame.Free;
end;

procedure TForm1.btnRefernceClick(Sender: TObject);
var AFrame: TBitmap;
begin
  AFrame:= TBitmap.Create;
  CapFromStream (AFrame, plCAM.Handle);
  imgReference.Picture.Bitmap:= AFrame;
  AFrame.Free;
end;

procedure TForm1.btnCompareClick(Sender: TObject);
var 
  x,y  : Integer;
  Line : PRGB32Array;
  Line2: PRGB32Array;
  Line3: PRGB32Array;
begin
  with imgActual.Picture.Bitmap do
  begin
    PixelFormat := pf32bit;
    imgReference.Picture.Bitmap.PixelFormat:= pf32bit;
    imgXOR.Picture.Bitmap.PixelFormat:= pf32bit;

    Width := imgActual.Width;
    Height := imgActual.Height;
    imgReference.Picture.Bitmap.Width:= imgActual.Width;
    imgReference.Picture.Bitmap.Height:= imgActual.Height;
    imgXOR.Picture.Bitmap.Width:= imgActual.Width;
    imgXOR.Picture.Bitmap.Height:= imgActual.Height;

    for y := 0 to Height - 1 do
    begin
      Line := Scanline[y];
      Line2:= imgReference.Picture.Bitmap.ScanLine[y];
      Line3:= imgXOR.Picture.Bitmap.ScanLine[y];

      for x := 0 to Width - 1 do
      begin
        Line3[x].B:= Line[x].B XOR Line2[x].B;
        Line3[x].G:= Line[x].G XOR Line2[x].G;
        Line3[x].R:= Line[x].R XOR Line2[x].R;
        Line3[x].A:= Line[x].A XOR Line2[x].A;
      end;
    end;
  end;
  imgActual.Invalidate;
  imgXOR.Invalidate;
  imgReference.Invalidate;

end;

procedure TForm1.btnAutoClick(Sender: TObject);
begin
  tmAutom.Enabled:= true;
end;

procedure TForm1.tmAutomTimer(Sender: TObject);
begin
  if lblStatus.Caption = 'CAP' then begin
    btnCaptureClick (sender);
    lblStatus.Caption:= 'COMP';
    ledCap.Brush.Color:= clGreen;
    ledComp.Brush.Color:= clLime;
  end
  else begin
    btnRefernceClick (sender);
    btnCompareClick (sender);
    lblStatus.Caption:= 'CAP';
    ledCap.Brush.Color:= clLime;
    ledComp.Brush.Color:= clGreen;
  end;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  plDetection.Caption:= 'DETECTION';
  plDetection.Color:= clRed;
  ledWarn.Brush.Color:= clRed;
end;

end.
