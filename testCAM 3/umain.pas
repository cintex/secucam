unit umain;

{*******************************************************************************
TODO:
  -Bild in graustufen umkonvertieren.

  -CompareSquare umändern. Mittelwert von Farben berechnen. Bei zu grosser
   abweichung -> Differenz. Bsp: MoyRef = 34 MoyCmp = 39 -> MoyRef + 5 bei
   kleinem Unterschied. MoyRef = 40 MoyCmp = 68 -> Differenz. Vergleiche
   jeden 2ten (oder Nten) Pixel.

  -Dialog zum einstellen der Auflösung.

  -Funktionen in eine separate Unit setzen.

*******************************************************************************}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ExtCtrls, StdCtrls, {*-1*} VFrames, Spin, Gauges, Menus;

type //-2
  TRGB32 = packed record
    B, G, R, A: Byte;
  end;
  TRGB32Array = packed array[0..MaxInt div SizeOf(TRGB32)-1] of TRGB32;
  PRGB32Array = ^TRGB32Array;

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
    mmMainMenu: TMainMenu;
    mmiFile: TMenuItem;
    mmiTst: TMenuItem;
    N1: TMenuItem;
    mmiQuit: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure lbCamListClick(Sender: TObject);
    procedure btnCapClick(Sender: TObject);
    procedure tmCapTimer(Sender: TObject);
    procedure btnStopClick(Sender: TObject);
    procedure mmiQuitClick(Sender: TObject);
    procedure mmiTstClick(Sender: TObject);
    procedure btnCompClick(Sender: TObject);
  private
    CurrentCam: TVideoImage;
    CamActive : boolean;
  public
    function CompareSquare (pCanvasRef, pCanvasComp: TImage): boolean;
  end;

var
  frmMain: TfrmMain;
  Cams : TStringList;

implementation

  {*
    # Function CompareSquare
    # Input: Canvas von Referenz Bild sowie Vergleichs Bild.
    # Output: True wenn Änderung, False wenn keine Änderung.
    ############################################################################
  *}
  function TfrmMain.CompareSquare (pCanvasRef, pCanvasComp: TImage): boolean;
  var X, Y            : integer;
      DivR, DivG, DivB: integer;
      PicLineRef      : PRGB32Array;
      PicLineCmp      : PRGB32Array;

      ColRef, ColComp : integer;
  begin
    DivR:= 0;
    DivG:= 0;
    DivB:= 0;

    ColRef:= 0;
    ColComp:= 0;
    Result:= false;
    //pCanvasRef:= TImage.Create (nil);
    //pCanvasComp:= TImage.Create (nil);
    pCanvasRef.Picture.Bitmap.PixelFormat:= pf24bit;
    pCanvasComp.Picture.Bitmap.PixelFormat:= pf24bit;
    for X:= 0 to pCanvasRef.Height - 1 do begin
      PicLineRef:= pCanvasRef.Picture.Bitmap.ScanLine[X];
      PicLineCmp:= pCanvasComp.Picture.Bitmap.ScanLine[X];
      for Y:= 0 to pCanvasRef.Width - 1 do begin
        //if PicLineRef[Y].R XOR PicLineCmp[Y].R <> 0 then inc (DivR);
        //if PicLineRef[Y].G XOR PicLineCmp[Y].G <> 0 then inc (DivG);
        //if PicLineRef[Y].B XOR PicLineCmp[Y].B <> 0 then inc (DivB);

        ColRef:= ColR + PicLineRef[Y].R;

      end;
    end;
    if (DivR <> 0) OR (DivG <> 0) OR (DivB <> 0) then Result:= true
  end;

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
  showmessage (inttostr (lbCamList.Items.Count));
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
  imgCamCurrent.Canvas.Pen.Color:= clWhite;
  imgCamCurrent.Canvas.Rectangle(0,0,320,240);
  imgCamCurrent.Canvas.TextOut (10,10,'IDLE [Current Frame]');
  tmCap.Enabled:= false;
end;

procedure TfrmMain.mmiQuitClick(Sender: TObject);
begin
  close;
end;

procedure TfrmMain.mmiTstClick(Sender: TObject);
begin
  imgCamMain.Picture.LoadFromFile ('testscreen2.bmp');
  imgCamCurrent.Picture.LoadFromFile ('testscreen2.bmp');
  imgCamReference.Picture.LoadFromFile ('testscreen1.bmp');
end;

procedure TfrmMain.btnCompClick(Sender: TObject);
var CurrRefSq            : TImage;
    CurrCompSq           : TImage;
    CNTSqX, CNTSqY, I, J : integer;
    X, Y                 : integer;
    PicLineRef           : PRGB32Array;
    PicLineCmp           : PRGB32Array;
begin
    CurrRefSq:= TImage.Create(nil);
    CurrCompSq:= TImage.Create(nil);
    CurrRefSq.Width:= 32;
    CurrRefSq.Height:= 24;
    CurrCompSq.Width:= 32;
    CurrCompSq.Height:= 24;

  CNTSqX:= 0;
  CNTSqY:= 0;
  X:= 0;
  imgCamDifference.Picture:= imgCamCurrent.Picture;
  for I:= 1 to 10 do begin
    //Showmessage ('Loop1');
    for J:= 1 to 10 do begin
    //Showmessage ('X->'+IntToStr (CNTSqX)+' Y->'+IntToStr (CNTSqY));
      CurrRefSq.Canvas.CopyRect (Rect (0, 0, 32,24),
                                 imgCamCurrent.Canvas,
                                 Rect (CNTSqX, CNTSqY, CNTSqX+32,CNTSqY+24));
      CurrCompSq.Canvas.CopyRect (Rect (0, 0, 32,24),
                                  imgCamReference.Canvas,
                                  Rect (CNTSqX, CNTSqY, CNTSqX+32,CNTSqY+24));


      //imgCamDifference.Picture:= CurrRefSq.Picture;
      if CompareSquare (CurrRefSq, CurrCompSq) = true then begin
        //imgCamDifference.Canvas.Rectangle(CNTSqX,CNTSqY,CNTSqX+5,CNTSqY+5);
        imgCamDifference.Canvas.Pen.Color:= clLime;
        imgCamDifference.Canvas.MoveTo(CNTSqX,CNTSqY);
        imgCamDifference.Canvas.LineTo(CNTSqX+32,CNTSqY+24);
        imgCamDifference.Canvas.MoveTo(CNTSqX+32,CNTSqY);
        imgCamDifference.Canvas.LineTo(CNTSqX,CNTSqY+24);
        //X:= X + 1;
        //showmessage ('Diff')
      end;
      //Showmessage ('I''m here');
      CNTSqX:= CNTSqX + 32;
      //CurrRefSq.Canvas.Rectangle(0,0,32,24);
    end;
    CNTSqX:= 0;
    CNTSqY:= CNTSqY + 24;
  end;

  //gauDifference.Progress:= X;
  {CurrRefSq.Canvas.CopyRect (Rect (0,0,32,24),imgCamCurrent.Canvas,Rect (224,96,256,120));
  CurrCompSq.Canvas.CopyRect (Rect (0,0,32,24),imgCamReference.Canvas,Rect (224,96,256,120));
  imgCamDifference.Picture:= CurrRefSq.Picture;
  if CompareSquare (CurrRefSq, CurrCompSq) = true then Showmessage ('Difference');}

end;

end.

{* # Quellen:
   # *1: http://www.delphipraxis.net/70813-webcam-mit-directshow.html
   # *2: http://edn.embarcadero.com/article/29173
   #############################################################################
*}
