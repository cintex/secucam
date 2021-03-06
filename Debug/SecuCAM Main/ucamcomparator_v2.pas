{*******************************************************************************
     *  SecuCAM CST // ucamcomparator_v2.pas *
     *****************************************

  Entwickelt von : WARNIMONT POL
                   T3IF @ Lyc�e du Nord
                   2011 - 2012

  Beschreibung : Unit beinhaltet alle Funktionen um ein Kamerabild auf eine
                 Bewegung zu �berpr�fen.

*******************************************************************************}

unit ucamcomparator_v2;

interface

uses
  SysUtils, ExtCtrls, Graphics, Math, Types, Dialogs;

type
  TRGB = packed record
    B, G, R: Byte;
  end;
  TRGBPXArr = packed array[0..MaxInt div SizeOf(TRGB)-1] of TRGB;
  RGBPXArr  = ^TRGBPXArr;

type
  TCamComparator = class
  private
    // *** Not visible on tbsMain **********************************************
    ImgReferenceFull : TBitmap;
    ImgCompareFull   : TBitmap;
    ImgReferenceSq   : TBitmap;
    ImgCompareSq     : TBitmap;

    // *** General *************************************************************
    SizeX : integer;
    SizeY : integer;
    SqPX  : integer;

    // *** PROPERTY VARS *******************************************************
    FSensitivity : integer;
    FResolution  : integer;
    FDoHighlight : boolean;
    FShowGrid    : boolean;
    FGridColor   : TColor;
    FHCol        : TColor;
    FBusy        : boolean;

    // *** SETTERS *************************************************************
    procedure SetSensitivity (const pSensitivity: integer);
    procedure SetResolution  (const pResolution: integer);
    procedure SetDoHighlight (const pDoHighlight: boolean);
    procedure SetShowGrid    (const pShowGrid: boolean);
    procedure SetGridColor   (const pGridColor: TColor);
    procedure SetHCol        (const pHCol: TColor);

    // *** FUNKTIONEN & PROZEDUREN ** Private **********************************
    function CompareSquare (pCmpSquare, pRefSquare: TBitmap): boolean;
  public
    constructor Create;
    destructor  Destroy;

    // *** PROPERTIES **********************************************************
    property Sensitivity    : integer read FSensitivity write SetSensitivity;
    property Resolution     : integer read FResolution write SetResolution;
    property DoHighlight    : boolean read FDoHighlight write SetDoHighlight;
    property ShowGrid       : boolean read FShowGrid write SetShowGrid;
    property GridColor      : TColor read FGridColor write SetGridColor;
    property HighlightColor : TColor read FHCol write SetHCol;
    property Busy           : boolean read FBusy;

    // *** FUNKTIONEN & PROZEDUREN ** Public ***********************************
    procedure CheckDifference (var pCmpImg: TImage; pRefImg: TImage; var pDiff: integer);
  end;

implementation

  constructor TCamComparator.Create;
  begin
    FSensitivity:= 10;
    SetResolution (16);
    FDoHighlight:= false;
    FShowGrid:= false;
    FGridColor:= clWhite;
    FHCol:= clWhite;
    FBusy:= false;

    ImgReferenceFull:= TBitmap.Create;
    ImgReferenceFull.Width:= 320;
    ImgReferenceFull.Height:= 240;
    ImgReferenceFull.PixelFormat:= pf24bit;

    ImgReferenceSq:= TBitmap.Create;
    ImgReferenceSq.Width:= SizeX;
    ImgReferenceSq.Height:= SizeY;
    ImgReferenceSq.PixelFormat:= pf24bit;

    ImgCompareFull:= TBitmap.Create;
    ImgCompareFull.Width:= 320;
    ImgCompareFull.Height:= 240;
    ImgCompareFull.PixelFormat:= pf24bit;

    ImgCompareSq:= TBitmap.Create;
    ImgCompareSq.Width:= SizeX;
    ImgCompareSq.Height:= SizeY;
    ImgCompareSq.PixelFormat:= pf24bit;
  end;

  destructor TCamComparator.Destroy;
  begin
    FreeAndNil (ImgReferenceFull);
    FreeAndNil (ImgReferenceSq);
    FreeAndNil (ImgCompareFull);
    FreeAndNil (ImgCompareSq);
  end;

  procedure TCamComparator.SetSensitivity (const pSensitivity: integer);
  begin
    FSensitivity:= pSensitivity;
  end;

  procedure TCamComparator.SetResolution (const pResolution: integer);
  begin
    FResolution:= pResolution;
    SizeX:= round (320 / FResolution);
    SizeY:= round (240 / FResolution);
    SqPX:= SizeX * SizeY;
  end;

  procedure TCamComparator.SetDoHighlight (const pDoHighlight: boolean);
  begin
    FDoHighlight:= pDoHighlight;
  end;

  procedure TCamComparator.SetShowGrid (const pShowGrid: boolean);
  begin
    FShowGrid:= pShowGrid;
  end;

  procedure TCamComparator.SetGridColor (const pGridColor: TColor);
  begin
    FGridColor:= pGridColor;
  end;

  procedure TCamComparator.SetHCol (const pHCol: TColor);
  begin
    FHCol:= pHCol;
  end;

  function TCamComparator.CompareSquare (pCmpSquare, pRefSquare: TBitmap): boolean;
  var X, Y                   : integer;
      DiffRr, DiffGr, DiffBr : integer;
      DiffRc, DiffGc, DiffBc : integer;
      ScanLineRef            : RGBPXArr;
      ScanLineCmp            : RGBPXArr;
  begin
    DiffRr:= 0; DiffGr:= 0; DiffBr:= 0;
    DiffRc:= 0; DiffGc:= 0; DiffBc:= 0;
    Result:= false;

    pCmpSquare.PixelFormat:= pf24bit;
    pRefSquare.PixelFormat:= pf24bit;

    for X:= 0 to pRefSquare.Height - 1 do begin
      ScanLineRef:= pRefSquare.ScanLine [X];
      ScanLineCmp:= pCmpSquare.ScanLine [X];
      for Y:= 0 to pRefSquare.Width - 1 do begin
        DiffRr:= DiffRr + ScanLineRef[Y].R;
        DiffGr:= DiffGr + ScanLineRef[Y].G;
        DiffBr:= DiffBr + ScanLineRef[Y].B;
        DiffRc:= DiffRc + ScanLineCmp[Y].R;
        DiffGc:= DiffGc + ScanLineCmp[Y].G;
        DiffBc:= DiffBc + ScanLineCmp[Y].B;
      end;
    end;

    DiffRr:= DiffRr div SqPX;
    DiffGr:= DiffGr div SqPX;
    DiffBr:= DiffBr div SqPX;
    DiffRc:= DiffRc div SqPX;
    DiffGc:= DiffGc div SqPX;
    DiffBc:= DiffBc div SqPX;

    if (abs (DiffRr - DiffRc) > FSensitivity) OR
       (abs (DiffGr - DiffGc) > FSensitivity) OR
       (abs (DiffBr - DiffBc) > FSensitivity) then Result:= true;
  end;

  procedure TCamComparator.CheckDifference (var pCmpImg: TImage; pRefImg: TImage; var pDiff: integer);
  var X, Y  : integer;
      Diff  : integer;
      DiffR : real;
  begin
    FBusy:= true;
    Diff:= 0;
    pCmpImg.Canvas.Pen.Color:= FHCol;
    for Y:= 1 to FResolution do begin
      for X:= 1 to FResolution do begin
        ImgCompareSq.Canvas.CopyRect (Rect (0, 0, SizeX, SizeY),
                                      pCmpImg.Canvas,
                                      Rect ((X-1)*SizeX, (Y-1)*SizeY, X*SizeX, Y*SizeY));
        ImgReferenceSq.Canvas.CopyRect(Rect (0, 0, SizeX, SizeY),
                                       pRefImg.Canvas,
                                       Rect ((X-1)*SizeX, (Y-1)*SizeY, X*SizeX, Y*SizeY));
        if CompareSquare (ImgCompareSq, ImgReferenceSq) = true then begin
          inc (Diff);
          if FDoHighlight = true then begin
            pCmpImg.Canvas.Polyline ([Point ((X-1)*SizeX, (Y-1)*SizeY),
                                      Point (X*SizeX, Y*SizeY)]);
          end;
        end;
      end;
    end;
    //pCmpImg.Canvas.TextOut(10,10,'DEBUG INFO');
    //pCmpImg.Canvas.TextOut (10,30,'Squares: ' + IntToStr (Diff));
    DiffR:= Diff / 256;
    DiffR:= DiffR * 100;
    pDiff:= round (DiffR);
    //pCmpImg.Canvas.TextOut (10,50,'DiffPercent: ' + IntToStr (pDiff));
    if FShowGrid = true then begin
      pCmpImg.Canvas.Pen.Color:= FGridColor;
      for X:= 1 to SizeX do begin
        pCmpImg.Canvas.Polyline ([Point (0, X*SizeY),
                                  Point (320, X*SizeY)]);
        pCmpImg.Canvas.Polyline ([Point (X*SizeX, 0),
                                  Point (X*SizeX, 240)]);
      end;
    end;
    FBusy:= false;
  end;
end.
