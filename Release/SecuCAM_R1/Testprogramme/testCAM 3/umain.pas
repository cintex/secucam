unit umain;

{*******************************************************************************
TODO:
  -Bild in graustufen umkonvertieren.

  -CompareSquare um�ndern. Mittelwert von Farben berechnen. Bei zu grosser
   abweichung -> Differenz. Bsp: MoyRef = 34 MoyCmp = 39 -> MoyRef + 5 bei
   kleinem Unterschied. MoyRef = 40 MoyCmp = 68 -> Differenz. Vergleiche
   jeden 2ten (oder Nten) Pixel.

  -Dialog zum einstellen der Aufl�sung.

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
    procedure FormShow(Sender: TObject);
    procedure btnGetCurrClick(Sender: TObject);
  private
    CurrentCam: TVideoImage;
    CamActive : boolean;
    ImgSp     : TImage;
  public
    function CompareSquare (pCanvasRef, pCanvasComp: TImage): boolean;
  end;

var
  frmMain: TfrmMain;
  Cams : TStringList;

implementation

uses
  ustatus;

  {*
    # Function CompareSquare
    # Input: Canvas von Referenz Bild sowie Vergleichs Bild.
    # Output: True wenn �nderung, False wenn keine �nderung.
    ############################################################################
  *}
  function TfrmMain.CompareSquare (pCanvasRef, pCanvasComp: TImage): boolean;
  var X, Y               : integer;
      DivRr, DivGr, DivBr: integer;
      DivRc, DivGc, DivBc: integer;
      PicLineRef         : PRGB32Array;
      PicLineCmp         : PRGB32Array;

      ColRef, ColComp : integer;
  begin
    DivRr:= 0; DivRc:= 0;
    DivGr:= 0; DivGc:= 0;
    DivBr:= 0; DivBc:= 0;

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

        DivRr:= DivRr + PicLineRef[Y].R;
        DivRc:= DivRc + PicLineCmp[Y].R;
        DivGr:= DivGr + PicLineRef[Y].G;
        DivGc:= DivGc + PicLineCmp[Y].G;
        DivBr:= DivBr + PicLineRef[Y].B;
        DivBc:= DivBc + PicLineCmp[Y].B;
      end;
    end;

    DivRr:= DivRr div 80;
    DivRc:= DivRc div 80;
    DivGr:= DivGr div 80;
    DivGc:= DivGc div 80;
    DivBr:= DivBr div 80;
    DivBc:= DivBc div 80;

    {*Showmessage ('**RED** || '+
                 'Ref=>'+IntToStr (DivRr)+' '+
                 'Cmp=>'+IntToStr (DivRc)+ ' '+
                 'Diff=>'+IntToStr (abs(DivRr - DivRc)));
    Showmessage ('**GREEN** || '+
                 'Ref=>'+IntToStr (DivGr)+' '+
                 'Cmp=>'+IntToStr (DivGc)+ ' '+
                 'Diff=>'+IntToStr (abs(DivGr - DivGc)));
    Showmessage ('**BLUE** || '+
                 'Ref=>'+IntToStr (DivBr)+' '+
                 'Cmp=>'+IntToStr (DivBc)+ ' '+
                 'Diff=>'+IntToStr (abs(DivBr - DivBc))); *}
    if (abs (DivRr - DivRc) > 5) OR
       (abs (DivGr - DivGc) > 5) OR
       (abs (DivBr - DivBc) > 5) then Result:= true;
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
  ImgSp:= TImage.Create(nil);
  ImgSp.Width:= 320;
  ImgSp.Height:= 240;
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
  if (shCap.Brush.Color = clWhite) AND (gauDifference.PercentDone < 3) then begin
    imgSp.Picture:= imgCamMain.Picture;
    shComp.Brush.Color:= clWhite;
    imgCamCurrent.Picture:= imgCamMain.Picture;
    shCap.Brush.Color:= clLime
  end
  else begin
    imgCamReference.Picture:= imgCamMain.Picture;
    btnGetCurrClick (sender);
    shComp.Brush.Color:= clBlue;
    shCap.Brush.Color:= clWhite;
  end;
  //imgCamCurrent.Picture:= imgCamMain.Picture;
  imgCamCurrent.Canvas.Pen.Color:= clLime;
  imgCamCurrent.Canvas.Pen.Width:= 1;
  Interval:= tmCap.Interval;
  I:= 1;
  {while I <> 320 do begin
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
  imgCamMain.Canvas.TextOut (5,5,'Actual FPS: ' + FloatToStr (Round (CurrentCam.FramesPerSecond)));}
  //if Round (CurrentCam.FramesPerSecond) <> 0 then tmCap.Interval:= Round (1000 / CurrentCam.FramesPerSecond);
end;

procedure TfrmMain.btnStopClick(Sender: TObject);
begin
  imgCamCurrent.Canvas.Pen.Color:= clWhite;
  imgCamCurrent.Canvas.Rectangle(0,0,320,240);
  imgCamCurrent.Canvas.TextOut (10,10,'IDLE [Current Frame]');
  tmCap.Enabled:= false;
  gauDifference.Progress:= 0;
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
    CurrRefSq.Width:= 16;
    CurrRefSq.Height:= 12;
    CurrCompSq.Width:= 16;
    CurrCompSq.Height:= 12;

  CNTSqX:= 0;
  CNTSqY:= 0;
  X:= 0;
  //imgSp.Picture:= imgCamCurrent.Picture;
  imgCamDifference.Picture:= imgSp.Picture;

  //*** ONLY FOR DEBUGGING ***

  {*CurrRefSq.Canvas.CopyRect (Rect (0, 0, 32, 24),
                             imgCamCurrent.Canvas,
                             Rect (64, 48, 96, 72));
  CurrCompSq.Canvas.CopyRect (Rect (0, 0, 32, 24),
                              imgCamReference.Canvas,
                              Rect (64, 48, 96, 72));

  if CompareSquare (CurrRefSq, CurrCompSq) = true then Showmessage ('DIFF');*}

  //**************************

  for I:= 1 to 20 do begin
    //Showmessage ('Loop1');
    for J:= 1 to 20 do begin
    //Showmessage ('X->'+IntToStr (CNTSqX)+' Y->'+IntToStr (CNTSqY));
      CurrRefSq.Canvas.CopyRect (Rect (0, 0, 16, 12),
                                 imgSp.Canvas,
                                 Rect (CNTSqX, CNTSqY, CNTSqX+16,CNTSqY+12));
      CurrCompSq.Canvas.CopyRect (Rect (0, 0, 16, 12),
                                  imgCamReference.Canvas,
                                  Rect (CNTSqX, CNTSqY, CNTSqX+16,CNTSqY+12));


      //imgCamDifference.Picture:= CurrRefSq.Picture;
      if CompareSquare (CurrRefSq, CurrCompSq) = true then begin
        //imgCamDifference.Canvas.Rectangle(CNTSqX,CNTSqY,CNTSqX+5,CNTSqY+5);
        imgCamDifference.Canvas.Pen.Color:= clLime;
        imgCamDifference.Canvas.MoveTo(CNTSqX,CNTSqY);
        imgCamDifference.Canvas.LineTo(CNTSqX+16,CNTSqY+12);
        imgCamDifference.Canvas.MoveTo(CNTSqX+16,CNTSqY);
        imgCamDifference.Canvas.LineTo(CNTSqX,CNTSqY+12);
        X:= X + 1;
      end;
      CNTSqX:= CNTSqX + 16;
      //CurrRefSq.Canvas.Rectangle(0,0,32,24);
    end;
    CNTSqX:= 0;
    CNTSqY:= CNTSqY + 12;
  end;
  //Showmessage (IntToStr (X));
  gauDifference.Progress:= X;
  //gauDifference.Progress:= X;
  {CurrRefSq.Canvas.CopyRect (Rect (0,0,32,24),imgCamCurrent.Canvas,Rect (224,96,256,120));
  CurrCompSq.Canvas.CopyRect (Rect (0,0,32,24),imgCamReference.Canvas,Rect (224,96,256,120));
  imgCamDifference.Picture:= CurrRefSq.Picture;
  if CompareSquare (CurrRefSq, CurrCompSq) = true then Showmessage ('Difference');}

end;
//===================== FORM SHOW ==============================================
procedure TfrmMain.FormShow(Sender: TObject);
begin
  frmStatus.Show;
  frmStatus.memStatus.Lines.Add('Program initialized.')
end;
//==============================================================================
procedure TfrmMain.btnGetCurrClick(Sender: TObject);
var I,J: integer;
    SizeX, SizeY: integer;
    CurrRefSq, CurrCmpSq: TImage;
begin
  CurrRefSq:= TImage.Create (nil);
  CurrCmpSq:= TImage.Create (nil);
  SizeX:= round (320 / speGrid.Value);
  SizeY:= round (240 / speGrid.Value);
  CurrRefSq.Width:= SizeX;
  CurrRefSq.Height:= SizeY;
  CurrCmpSq.Width:= SizeX;
  CurrCmpSq.Height:= SizeY;
  imgCamDifference.Canvas.Pen.Color:= clLime;
  //Showmessage ('SizeX:'+IntToStr(SizeX)+' SizeY:'+IntToStr(SizeY));
  imgCamDifference.Picture:= imgCamReference.Picture;
  for I:= 1 to speGrid.Value do begin
    imgCamDifference.Canvas.Polyline ([Point (0,I*SizeY),
                                    Point (320,I*SizeY)]);
    imgCamDifference.Canvas.Polyline ([Point (I*SizeX, 0),
                                    Point (I*SizeX, 240)]);
  end;
  for I:= 1 to 32 do begin
    for J:= 1 to 32 do begin
      CurrRefSq.Canvas.CopyRect (Rect (0,0,SizeX,SizeY),
                                 imgCamCurrent.Canvas,
                                 Rect ((J-1)*SizeX, (I-1)*SizeY, J*SizeX, I*SizeY));
      CurrCmpSq.Canvas.CopyRect (Rect (0,0,SizeX,SizeY),
                                 imgCamReference.Canvas,
                                 Rect ((J-1)*SizeX, (I-1)*SizeY, J*SizeX, I*SizeY));
      if CompareSquare (CurrRefSq, CurrCmpSq) = true then begin
        imgCamDifference.Canvas.Pen.Color:= clLime;
        imgCamDifference.Canvas.Polyline ([Point ((J-1)*SizeX,(I-1)*SizeY),
                                        Point ((J)*SizeX,(I)*SizeY)]);
      end;
    end;
  end;
end;

end.

{* # Quellen:
   # *1: http://www.delphipraxis.net/70813-webcam-mit-directshow.html
   # *2: http://edn.embarcadero.com/article/29173
   #############################################################################
*}
