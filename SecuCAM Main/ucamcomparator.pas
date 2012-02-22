{*******************************************************************************
  In dieser Unit befinden sich alle Funktionen um die Bilder der Kamera zu
  vergleichen.

  Functions:
   -CompareSquare

********************************************************************************}
unit ucamcomparator;

interface

uses
  SysUtils, ExtCtrls, Graphics, Classes, Math;

type
  TRGB = packed record
    B, G, R: Byte;
  end;
  TRGBPXArr = packed array[0..MaxInt div SizeOf(TRGB)-1] of TRGB;
  RGBPXArr  = ^TRGBPXArr;

type
  TCamComparator = class
  private
    ImgRefFull  : TImage;
    ImgCmpFull  : TImage;
    ImgRefPart  : TImage;
    ImgCmpPart  : TImage;

    FSensitivity    : integer;
    FDoHighlight    : boolean;
    FGridSize       : integer;
    FGridColor      : TColor;
    FHighlightColor : TColor;
    FBusy           : boolean;

    procedure SetSensitivity    (const pSensitivity: integer);
    procedure SetDoHighlight    (const pDoHighlight: boolean);
    procedure SetGridSize       (const pGridSize: integer);
    procedure SetGridColor      (const pGridColor: TColor);
    procedure SetHighlightColor (const pHighlightColor: TColor);

    function CompareSquare (pSqRef, pSqCmp: TImage): boolean;
  public
    constructor Create;
    destructor  Destroy; override;

    property Sensitivity    : integer read FSensitivity write SetSensitivity;
    property GridSize       : integer read FGridSize write SetGridSize;
    property DoHighlight    : boolean read FDoHighlight write SetDoHighlight;
    property GridColor      : TColor read FGridColor write SetGridColor;
    property HighlightColor : TColor read FHighlightColor write SetHighlightColor;
    property Busy           : boolean read FBusy;

    procedure GetPicture (var pCamImage: TImage);
    procedure CheckDifference (pImgCmp, pImgRef: TImage;
                               pDifference: integer);
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
    ImgCmpFull.Canvas.TextOut(10,215,'Keine Kamera aktiv!');

    ImgRefPart:= TImage.Create (nil);
    ImgRefPart.Picture.Bitmap.PixelFormat:= pf24bit;

    ImgCmpPart:= TImage.Create (nil);
    ImgCmpPart.Picture.Bitmap.PixelFormat:= pf24bit;

    FSensitivity:= 3;
    FGridSize:= 16;
    FDoHighlight:= false;
    FGridColor:= clLime;
    FHighlightColor:= clLime;
    FBusy:= false;
  end;

  destructor TCamComparator.Destroy;
  begin
    ImgRefFull.Destroy;
    ImgCmpFull.Destroy;
    ImgRefPart.Destroy;
    ImgCmpPart.Destroy;
    inherited Destroy;
  end;

  procedure TCamComparator.GetPicture(var pCamImage: TImage);
  var I: integer;
  begin
    if not FBusy = true then begin
      pCamImage.Picture:= ImgCmpFull.Picture;
      if FDoHighlight = true then begin
        pCamImage.Canvas.Pen.Color:= FGridColor;
        for I:= 1 to FGridSize do begin
          pCamImage.Canvas.Polyline ([Point (round (I * (320 / FGridSize)), 0),
                                      Point (round (I * (320 / FGridSize)), 240)]);
          pCamImage.Canvas.Polyline ([Point (0, round (I * (240 / FGridSize))),
                                      Point (320, round (I * (240 / FGridSize)))]);
        end;
      end;
      pCamImage.Canvas.TextOut(10,10,FormatDateTime('yyyy-mm-dd hh:nn:ss', now));
    end
  end;

  procedure TCamComparator.CheckDifference (pImgCmp, pImgRef: TImage;
                                            pDifference: integer);
  var I, J          : integer;
      CNTSqX, CNTSqY: integer;
      Difference    : integer;
      RatioX, RatioY: integer;
  begin
    CNTSqX:= 0;
    CNTSqY:= 0;
    Difference:= 0;
    RatioX:= FGridSize;
    RatioY:= round (FGridSize / 4) * 3;
    ImgRefPart.Picture.Bitmap.Width:= RatioX;
    ImgRefPart.Picture.Bitmap.Height:= RatioY;
    ImgCmpPart.Picture.Bitmap.Width:= RatioX;
    ImgCmpPart.Picture.Bitmap.Height:= RatioY;
    ImgCmpFull.Picture.Bitmap:= pImgCmp.Picture.Bitmap;
    if FDoHighlight = true then ImgCmpFull.Canvas.Pen.Color:= FHighlightColor;
    FBusy:= true;
    for I:= 1 to round (320 / RatioX) do begin
      for J:= 1 to round (240 / RatioY) do begin
        ImgCmpPart.Canvas.CopyRect (Rect (0,0,RatioX, RatioX),
                                    pImgCmp.Canvas,
                                    Rect (CNTSqX, CNTSqY, CNTSqX + RatioX, CNTSqY + RatioY));
        ImgRefPart.Canvas.CopyRect (Rect (0,0,RatioX, RatioY),
                                    pImgRef.Canvas,
                                    Rect (CNTSqX, CNTSqY, CNTSqX + RatioX, CNTSqY + RatioY));
        if CompareSquare (ImgRefPart, ImgCmpPart) = true then begin
          inc (Difference);
          if FDoHighlight = true then begin
            ImgCmpFull.Canvas.Polyline ([Point (CNTSqX, CNTSqY),
                                         Point (CNTSqX + RatioX, CNTSqY + RatioY)]);
            ImgCmpFull.Canvas.Polyline ([Point (CNTSqX + RatioX, CNTSqY),
                                         Point (CNTSqX, CNTSqY + RatioY)]);
          end;
        end;
        CNTSqX:= CNTSqX + RatioX;
      end;
      CNTSqX:= 0;
      CNTSqY:= CNTSqY + RatioY;
    end;
    pDifference:= round (Difference / power (round (320 / RatioX), 2)) * 100;
    FBusy:= false;
  end;

  function TCamComparator.CompareSquare (pSqRef, pSqCmp: TImage): boolean;
  var X, Y                    : integer;
      DiffRr, DiffGr, DiffBr  : integer;
      DiffRc, DiffGc, DiffBc  : integer;
      ScanLineRef, ScanLineCmp: RGBPXArr;
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
        DiffRc:= DiffRc + ScanLineCmp [Y].R;
        DiffGc:= DiffGc + ScanLineCmp [Y].G;
        DiffBc:= DiffBc + ScanLineCmp [Y].B;
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

  procedure TCamComparator.SetDoHighlight(const pDoHighlight: boolean);
  begin
    FDoHighlight:= pDoHighlight;
  end;

  procedure TCamComparator.SetGridSize(const pGridSize: integer);
  begin
    FGridSize := pGridSize;
  end;

  procedure TCamComparator.SetGridColor(const pGridColor: TColor);
  begin
    FGridColor := pGridColor;
  end;

  procedure TCamComparator.SetHighlightColor(const pHighlightColor: TColor);
  begin
    FHighlightColor := pHighlightColor;
  end;

end.
