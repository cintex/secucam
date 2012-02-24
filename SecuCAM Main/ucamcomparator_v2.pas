{*******************************************************************************
     *  SecuCAM CST // ucamcomparator_v2.pas *
     *****************************************

  Entwickelt von : WARNIMONT POL
                   T3IF @ Lycée du Nord
                   2011 - 2012

  Beschreibung : Unit beinhaltet alle Funktionen um ein Kamerabild auf eine
                 Bewegung zu überprüfen.

*******************************************************************************}

unit ucamcomparator_v2;

interface

uses
  SysUtils, ExtCtrls, Graphics, Math;

type
  TRGB = packed record
    B, G, R: Byte;
  end;
  TRGBPXArr = packed array[0..MaxInt div SizeOf(TRGB)-1] of TRGB;
  RGBPXArr  = ^TRGBPXArr;

type
  TCamComparator = class
  private
    // *** PROPERTY VARS *******************************************************
    FSensitivity : integer;
    FResolution  : integer;
    FDoHighlight : boolean;
    FGridColor   : TColor;
    FHCol        : TColor;
    FBusy        : boolean;

    // *** SETTERS *************************************************************
    procedure SetSensitivity (const pSensitivity: integer);
    procedure SetResolution  (const pResolution: integer);
    procedure SetDoHighlight (const pDoHighlight: boolean);
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
    property GridColor      : TColor read FGridColor write SetGridColor;
    property HighlightColor : TColor read FHCol write SetHCol;
    property Busy           : boolean read FBusy;

    // *** FUNKTIONEN & PROZEDUREN ** Public ***********************************
    procedure CheckDifference (pCmpImg, pRefImg: TBitmap; var pDiff: integer);
    function  ReturnPicture: TBitmap;
  end;

implementation

end.
