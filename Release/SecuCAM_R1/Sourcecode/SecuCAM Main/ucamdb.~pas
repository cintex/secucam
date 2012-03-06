{*******************************************************************************
     *  SecuCAM CST // ucamdb.pas *
     ******************************

  Entwickelt von : WARNIMONT POL
                   T3IF @ Lycée du Nord
                   2011 - 2012

  Beschreibung : Kamera Datenbank.

*******************************************************************************}

unit ucamdb;

interface

uses
  SysUtils, Classes, Graphics, Controls, ucam_v2;

const
  MaxCams    = 31;
  DBFileName = 'secucam.db';

type
  TCamSettings = record
    CamName         : string[255];
    Alias           : string[255];
    MotionDetection : boolean;
    Visible         : boolean;
    AlarmLevel      : integer;
    FrameRate       : integer;
    Sensitivity     : integer;
    Resolution      : integer;
    DoHighlight     : boolean;
    ShowGrid        : boolean;
    GridColor       : TColor;
    HighlightColor  : TColor;
    Parent          : TWinControl;
    Activated       : boolean;
    Path            : string[255];
  end;

type
  TCamDB = class
  private
    // *** General *************************************************************
    CamArray  : array[0..MaxCams] of TCam;
    PosCnt    : integer;

    // *** PROPERTY VARS *******************************************************
    FCamCount : integer;
    FOwner    : TComponent;

    // *** FUNKTIONEN & PROZEDUREN ** Private **********************************
    function ReturnCamIndex (pAlias: string): integer;
    procedure AddCamObj (pCam: TCam);
  public
    constructor Create (AOwner: TComponent);
    destructor  Destroy;

    // *** PROPERTIES **********************************************************
    property CamCount : integer read FCamCount;

    // *** FUNKTIONEN & PROZEDUREN ** Public ***********************************
    function AddCam (pSettings: TCamSettings): boolean;
    function EditCam (pAlias: string; pSettings: TCamSettings): boolean;
    function GetCam (pAlias: string; var pSettings: TCamSettings): boolean;
    function DelCam (pAlias: string): boolean;
    function StartCam (pAlias: string): boolean;
    function StopCam (pAlias: string): boolean;
    function PauseCam (pAlias: string): boolean;
    function MotionDetection (pAlias: string; pMotDect: boolean): boolean;
    function IsCamRunning (pAlias: string): boolean;
    function IsCamPaused (pAlias: string): boolean;
    function IsAlerted (pAlias: string): boolean;
    procedure RearrangeCams;
    function SaveDB: boolean;
    function LoadDB: boolean;
  end;

implementation

  constructor TCamDB.Create (AOwner: TComponent);
  begin
    FCamCount:= 0;
    PosCnt:= 1;
    FOwner:= AOwner;
  end;

  destructor TCamDB.Destroy;
  begin
  end;

  function TCamDB.ReturnCamIndex (pAlias: string): integer;
  var I: integer;
  begin
    I:= 0;
    while (CamArray[I].Alias <> pAlias) AND (I <= FCamCount) do inc (I);
    if I > FCamCount then Result:= -1
                     else Result:= I;
  end;

  procedure TCamDB.RearrangeCams;
  var I          : integer;
      TmpSettings: TCamSettings;
  begin
    PosCnt:= 1;
    for I:= 0 to FCamCount -1 do begin
      with CamArray[I] do begin
        case PosCnt of
          1:  begin
                Left:= 8;
                Top:= 8;
              end;
          2:  begin
                Left:= 360;
                Top:= 8;
              end;
          3:  begin
                Left:= 8;
                Top:= 264;
              end;
          4:  begin
                Left:= 360;
                Top:= 264;
              end;
        end;
        if PosCnt < 4 then inc (PosCnt)
                      else PosCnt:= 1;
      end;
    end;
  end;

  procedure TCamDB.AddCamObj (pCam: TCam);
  begin
    CamArray[FCamCount]:= pCam;
    inc (FCamCount);
  end;

  function TCamDB.AddCam (pSettings: TCamSettings): boolean;
  begin
    try
      CamArray[FCamCount]:= TCam.Create (pSettings.Parent, FOwner, FCamCount);
      with CamArray[FCamCount] do begin
        Alias:= pSettings.Alias;
        AttachedCam:= pSettings.CamName;
        case PosCnt of
          1:  begin
                Left:= 8;
                Top:= 8;
              end;
          2:  begin
                Left:= 360;
                Top:= 8;
              end;
          3:  begin
                Left:= 8;
                Top:= 264;
              end;
          4:  begin
                Left:= 360;
                Top:= 264;
              end;
        end;
        if PosCnt < 4 then inc (PosCnt)
                      else PosCnt:= 1;
        Visible:= pSettings.Visible;
        FrameRate:= pSettings.FrameRate;
        AlarmLevel:= pSettings.AlarmLevel;
        CamComparator.Sensitivity:= pSettings.Sensitivity;
        CamComparator.Resolution:= pSettings.Resolution;
        CamComparator.HighlightColor:= pSettings.HighlightColor;
        CamComparator.GridColor:= pSettings.GridColor;
        CamComparator.DoHighlight:= pSettings.DoHighlight;
        CamComparator.ShowGrid:= pSettings.ShowGrid;
        Path:= pSettings.Path;
        if pSettings.Activated = true then VideoStart;
        //VideoStart;
        MotionDetection:= pSettings.MotionDetection;
        inc (FCamCount);
      end;
      Result:= true;
    except
      Result:= false;
    end;
  end;

  function TCamDB.EditCam (pAlias: string; pSettings: TCamSettings): boolean;
  var IndC: integer;
  begin
    IndC:= ReturnCamIndex (pAlias);
    //CamArray[IndC].MotionDetection:= false;
    //CamArray[IndC].VideoStop;
    if IndC <> -1 then begin
      with CamArray[IndC] do begin
        Alias:= pSettings.Alias;
        FrameRate:= pSettings.FrameRate;
        AlarmLevel:= pSettings.AlarmLevel;
        CamComparator.Sensitivity:= pSettings.Sensitivity;
        CamComparator.Resolution:= pSettings.Resolution;
        CamComparator.HighlightColor:= pSettings.HighlightColor;
        CamComparator.GridColor:= pSettings.GridColor;
        CamComparator.DoHighlight:= pSettings.DoHighlight;
        CamComparator.ShowGrid:= pSettings.ShowGrid;
        Path:= pSettings.Path;
        MotionDetection:= pSettings.MotionDetection;
      end;
      Result:= true;
    end
    else Result:= false;
  end;

  function TCamDB.GetCam (pAlias: string; var pSettings: TCamSettings): boolean;
  var IndC: integer;
  begin
    IndC:= ReturnCamIndex (pAlias);
    if IndC <> -1 then begin
      with CamArray[IndC] do begin
        pSettings.CamName:= AttachedCam;
        pSettings.Alias:= Alias;
        pSettings.MotionDetection:= MotionDetection;
        pSettings.Visible:= Visible;
        pSettings.AlarmLevel:= AlarmLevel;
        pSettings.FrameRate:= FrameRate;
        pSettings.Sensitivity:= CamComparator.Sensitivity;
        pSettings.Resolution:= CamComparator.Resolution;
        pSettings.DoHighlight:= CamComparator.DoHighlight;
        pSettings.ShowGrid:= CamComparator.ShowGrid;
        pSettings.GridColor:= CamComparator.GridColor;
        pSettings.HighlightColor:= CamComparator.HighlightColor;
        pSettings.Parent:= Parent;
        pSettings.Path:= Path
      end;
      Result:= true;
    end
    else Result:= false;
  end;

  function TCamDB.DelCam (pAlias: string): boolean;
  var IndC: integer;
      I   : integer;
  begin
    IndC:= ReturnCamIndex (pAlias);
    if IndC <> -1 then begin
      CamArray[IndC].Destroy;
      for I:= (IndC + 1) to FCamCount do begin
        CamArray[I-1]:= CamArray[I];
      end;
      dec (FCamCount);
    end
    else Result:= false;
  end;

  function TCamDB.StartCam (pAlias: string): boolean;
  var IndC: integer;
  begin
    IndC:= ReturnCamIndex (pAlias);
    if IndC <> -1 then begin
      if CamArray[IndC].VideoStart = true then Result:= true
                                          else Result:= false;
    end
    else Result:= false;
  end;

  function TCamDB.StopCam (pAlias: string): boolean;
  var IndC: integer;
  begin
    IndC:= ReturnCamIndex (pAlias);
    if IndC <> -1 then begin
      if CamArray[IndC].VideoStop = true then Result:= true
                                         else Result:= false;
    end
    else Result:= false;
  end;

  function TCamDB.PauseCam (pAlias: string): boolean;
  var IndC: integer;
  begin
    IndC:= ReturnCamIndex (pAlias);
    if IndC <> -1 then begin
      if CamArray[IndC].VideoPause = true then Result:= true
                                          else Result:= false;
    end
    else Result:= false;
  end;

  function TCamDB.MotionDetection (pAlias: string; pMotDect: boolean): boolean;
  var IndC: integer;
  begin
    IndC:= ReturnCamIndex (pAlias);
    if IndC <> -1 then begin
      CamArray[IndC].MotionDetection:= pMotDect;
      Result:= true;
    end
    else Result:= false;
  end;

  function TCamDB.IsCamRunning (pAlias: string): boolean;
  var IndC: integer;
  begin
    IndC:= ReturnCamIndex (pAlias);
    if IndC <> -1 then begin
      if CamArray[IndC].IsRunning = true then Result:= true
                                         else Result:= false;
    end
    else Result:= false;
  end;

  function TCamDB.IsCamPaused (pAlias: string): boolean;
  var IndC: integer;
  begin
    IndC:= ReturnCamIndex (pAlias);
    if IndC <> -1 then begin
      if CamArray[IndC].IsPaused = true then Result:= true
                                        else Result:= false;
    end
    else Result:= false;
  end;

  function TCamDB.IsAlerted (pAlias: string): boolean;
  var IndC: integer;
  begin
    IndC:= ReturnCamIndex (pAlias);
    if IndC <> -1 then begin
      Result:= CamArray[IndC].Alert;
    end
  end;

  function TCamDB.SaveDB: boolean;
  var F           : file of TCamSettings;
      I           : integer;
      TmpSettings : TCamSettings;
  begin
    Assign (F, DBFileName);
    Rewrite (F);
    for I:= 0 to FCamCount -1 do begin
      GetCam (CamArray[I].Alias, TmpSettings);
      write (F, TmpSettings);
    end;
    close (F);
  end;

  function TCamDB.LoadDB: boolean;
  var F           : file of TCamSettings;
      TmpSettings : TCamSettings;
  begin
    FCamCount:= 0;
    Assign (F, DBFileName);
    Reset (F);
    while not eof (F) do begin
      read (F, TmpSettings);
      AddCam (TmpSettings);
    end;
    close (F);
  end;

end.
