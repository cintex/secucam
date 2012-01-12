object frmMain: TfrmMain
  Left = 198
  Top = 110
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'SecuCAM TEST 3 [FINAL]'
  ClientHeight = 568
  ClientWidth = 894
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = mmMainMenu
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object imgCamMain: TImage
    Left = 240
    Top = 8
    Width = 320
    Height = 240
  end
  object imgCamCurrent: TImage
    Left = 568
    Top = 8
    Width = 320
    Height = 240
  end
  object imgCamReference: TImage
    Left = 240
    Top = 256
    Width = 320
    Height = 240
  end
  object imgCamDifference: TImage
    Left = 568
    Top = 256
    Width = 320
    Height = 240
  end
  object gauDifference: TGauge
    Left = 488
    Top = 520
    Width = 145
    Height = 22
    ForeColor = clLime
    Progress = 0
  end
  object Label1: TLabel
    Left = 408
    Top = 504
    Width = 19
    Height = 13
    Caption = 'Grid'
  end
  object Difference: TLabel
    Left = 488
    Top = 504
    Width = 49
    Height = 13
    Caption = 'Difference'
  end
  object shCap: TShape
    Left = 640
    Top = 520
    Width = 25
    Height = 25
    Shape = stCircle
  end
  object Label2: TLabel
    Left = 640
    Top = 504
    Width = 37
    Height = 13
    Caption = 'Capture'
  end
  object shComp: TShape
    Left = 688
    Top = 520
    Width = 25
    Height = 25
    Shape = stCircle
  end
  object Label3: TLabel
    Left = 688
    Top = 504
    Width = 42
    Height = 13
    Caption = 'Compare'
  end
  object lbCamList: TListBox
    Left = 0
    Top = 0
    Width = 233
    Height = 545
    ItemHeight = 13
    TabOrder = 0
    OnClick = lbCamListClick
  end
  object sbStatus: TStatusBar
    Left = 0
    Top = 549
    Width = 894
    Height = 19
    Panels = <
      item
        Text = 'ACTIVE CAM: NONE'
        Width = 50
      end>
  end
  object btnCap: TButton
    Left = 240
    Top = 504
    Width = 75
    Height = 41
    Caption = 'Capture'
    TabOrder = 2
    OnClick = btnCapClick
  end
  object btnStop: TButton
    Left = 320
    Top = 504
    Width = 75
    Height = 41
    Caption = 'Stop'
    TabOrder = 3
    OnClick = btnStopClick
  end
  object speGrid: TSpinEdit
    Left = 408
    Top = 520
    Width = 73
    Height = 22
    EditorEnabled = False
    Increment = 4
    MaxValue = 256
    MinValue = 0
    TabOrder = 4
    Value = 32
  end
  object btnGetCurr: TButton
    Left = 744
    Top = 504
    Width = 75
    Height = 17
    Caption = 'Get Current'
    TabOrder = 5
  end
  object btnGetRef: TButton
    Left = 744
    Top = 528
    Width = 75
    Height = 17
    Caption = 'Get Ref.'
    TabOrder = 6
  end
  object btnComp: TButton
    Left = 824
    Top = 504
    Width = 65
    Height = 41
    Caption = 'Compare'
    TabOrder = 7
    OnClick = btnCompClick
  end
  object tmCap: TTimer
    Enabled = False
    OnTimer = tmCapTimer
    Left = 848
    Top = 16
  end
  object mmMainMenu: TMainMenu
    Left = 808
    Top = 16
    object mmiFile: TMenuItem
      Caption = 'File'
      object mmiTst: TMenuItem
        Caption = 'Load Test Screen'
        OnClick = mmiTstClick
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object mmiQuit: TMenuItem
        Caption = 'Quit'
        OnClick = mmiQuitClick
      end
    end
  end
end
