{*******************************************************************************
  In dieser Unit befinden sich alle Funktionen um die Bilder der Kamera zu
  vergleichen.

  Functions:
   -CompareSquare

********************************************************************************}
unit ucamcomparator;

interface

uses
  SysUtils, ExtCtrls, Graphics;

type
  TRGBa = packed record
    B, G, R, A: Byte;
  end;
  TRGBaPXArr = packed array[0..MaxInt div SizeOf(TRGBa)-1] of TRGBa;
  RGBaPXArr  = ^TRGBaPXArr;

type
  TCamComparator = class
  private
    ImgRefFull  : TImage;
    ImgCmpFull  : TImage;
    ImgRefPart  : TImage;
    ImgCmpPart  : TImage;

    FSensitivity: integer;
    procedure SetSensitivity(const pSensitivity: integer);
  public
    constructor Create;
    destructor  Destroy;

    property Sensitivity: integer read FSensitivity write SetSensitivity;

    procedure GetPicture (var pCamImage: TBitmap);
    procedure CheckDifference ();
    function  CompareSquare (pSqRef, pSqCmp: TImage): boolean;
  end;

implementation

  constructor TCamComparator.Create;
  begin
    ImgRefFull:= TImage.Create (nil);
    ImgRefFull.Picture.Bitmap.PixelFormat:= pf24bit;
    ImgRefFull.Picture.Bitmap.Width:= 320;
    ImgRefFull.Picture.Bitmap.Height:= 240;

    ImgCmpFull:= TImage.Create (nil);
    ImgCmpFull.Picture.Bitmap.PixelFormat:= pf24bit;
    ImgCmpFull.Picture.Bitmap.Width:= 320;
    ImgCmpFull.Picture.Bitmap.Height:= 240;
    ImgRefFull.Canvas.TextOut(10,10,'KEIN BILD!');

    ImgRefPart:= TImage.Create (nil);
    ImgCmpPart:= TImage.Create (nil);
  end;

  destructor TCamComparator.Destroy;
  begin
    ImgRefFull.Destroy;
    ImgCmpFull.Destroy;
    ImgRefPart.Destroy;
    ImgCmpPart.Destroy;
  end;

  procedure TCamComparator.GetPicture(var pCamImage: TBitmap);
  begin
    pCamImage:= ImgRefFull.Picture.Bitmap;
    pCamImage.Canvas.TextOut(10,10,FormatDateTime('yyyy-mm-dd hh:nn:ss', now));
  end;

  procedure TCamComparator.CheckDifference ();
  begin
  end;

  function TCamComparator.CompareSquare (pSqRef, pSqCmp: TImage): boolean;
  var X, Y                    : integer;
      DiffRr, DiffGr, DiffBr  : integer;
      DiffRc, DiffGc, DiffBc  : integer;
      ScanLineRef, ScanLineCmp: RGBaPXArr;
  begin
    DiffRr:= 0;
    DiffGr:= 0;
    DiffBr:= 0;
    DiffRc:= 0;
    DiffGc:= 0;
    DiffBc:= 0;
    Result:= false;

    for X:= 0 to pSqRef.Picture.Bitmap.Height -1 do begin
      ScanLineRef:= pSqRef.Picture.Bitmap.ScanLine [X];
      ScanLineCmp:= pSqCmp.Picture.Bitmap.ScanLine [X];
      for Y:= 0 to pSqRef.Picture.Bitmap.Width -1 do begin
        DiffRr:= DiffRr + ScanLineRef [Y].R;
        DiffGr:= DiffGr + ScanLineRef [Y].G;
        DiffBr:= DiffBr + ScanLineRef [Y].B;
        DiffRc:= DiffRc + ScanLineRef [Y].R;
        DiffGc:= DiffGc + ScanLineRef [Y].G;
        DiffBc:= DiffBc + ScanLineRef [Y].B;
      end;
    end;

    DiffRr:= round (DiffRr / 768);
    DiffGr:= round (DiffGr / 768);
    DiffBr:= round (DiffBr / 768);
    DiffRc:= round (DiffRc / 768);
    DiffGc:= round (DiffGc / 768);
    DiffBc:= round (DiffBc / 768);

    if (abs (DiffRr - DiffRc) > FSensitivity) OR
       (abs (DiffGr - DiffGc) > FSensitivity) OR
       (abs (DiffBr - DiffBc) > FSensitivity) then Result:= true;
  end;

  procedure TCamComparator.SetSensitivity(const pSensitivity: integer);
  begin
    FSensitivity := pSensitivity;
  end;

end.
