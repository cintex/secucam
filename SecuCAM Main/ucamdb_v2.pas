unit ucamdb_v2;

interface

uses
  SysUtils, Classes, Graphics, Controls, Contnrs, ucam_v2;

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
  end;

  TCamDB = class
  private
    CamDB : TObjectList;
  public
    constructor Create;
    destructor  Destroy;

    function AddCam (pSettings: TCamSettings): boolean;
  end;

implementation

  constructor TCamDB.Create;
  begin
    CamDB:= TObjectList.Create (true);
  end;

  destructor TCamDB.Destroy;
  begin
  end;

  function TCamDB.AddCam (pSettings: TCamSettings): boolean;
  begin
  end;

end.
