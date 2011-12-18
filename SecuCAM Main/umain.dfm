object frmMain: TfrmMain
  Left = 192
  Top = 107
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'SecuCAM 0.1 ALPHA'
  ClientHeight = 600
  ClientWidth = 881
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = mmMainMenu
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object ToolBar1: TToolBar
    Left = 0
    Top = 0
    Width = 881
    Height = 29
    Caption = 'ToolBar1'
    TabOrder = 0
    object ToolButton1: TToolButton
      Left = 0
      Top = 2
      Caption = 'ToolButton1'
      ImageIndex = 0
    end
    object ToolButton2: TToolButton
      Left = 23
      Top = 2
      Caption = 'ToolButton2'
      ImageIndex = 1
    end
    object ToolButton3: TToolButton
      Left = 46
      Top = 2
      Width = 8
      Caption = 'ToolButton3'
      ImageIndex = 2
      Style = tbsSeparator
    end
    object ToolButton4: TToolButton
      Left = 54
      Top = 2
      Caption = 'ToolButton4'
      ImageIndex = 2
    end
    object ToolButton5: TToolButton
      Left = 77
      Top = 2
      Caption = 'ToolButton5'
      ImageIndex = 3
    end
  end
  object sbStatus: TStatusBar
    Left = 0
    Top = 581
    Width = 881
    Height = 19
    Panels = <
      item
        Text = '??:??:??'
        Width = 50
      end
      item
        Text = 'Keine Detektion'
        Width = 50
      end>
  end
  object lbCamList: TListBox
    Left = 0
    Top = 29
    Width = 201
    Height = 552
    Align = alLeft
    Enabled = False
    ItemHeight = 13
    Items.Strings = (
      'Keine Kamera verf'#252'gbar')
    TabOrder = 2
  end
  object pgMain: TPageControl
    Left = 201
    Top = 29
    Width = 680
    Height = 552
    ActivePage = tbsMain
    Align = alClient
    TabOrder = 3
    object tbsMain: TTabSheet
      Caption = '&Hauptfenster'
      object pbCamW1: TPaintBox
        Left = 8
        Top = 8
        Width = 320
        Height = 240
        OnPaint = pbCamW1Paint
      end
      object pbCamW2: TPaintBox
        Left = 344
        Top = 8
        Width = 320
        Height = 240
        OnPaint = pbCamW2Paint
      end
      object pbCamW3: TPaintBox
        Left = 8
        Top = 264
        Width = 320
        Height = 240
        OnPaint = pbCamW3Paint
      end
      object pbCamW4: TPaintBox
        Left = 344
        Top = 264
        Width = 320
        Height = 240
        OnPaint = pbCamW4Paint
      end
    end
    object tbsExtended: TTabSheet
      Caption = '&Erweitert'
      ImageIndex = 1
    end
  end
  object mmMainMenu: TMainMenu
    Left = 848
    Top = 56
    object mmiFile: TMenuItem
      Caption = '&Datei'
      object mmiExit: TMenuItem
        Caption = '&Schliessen'
        OnClick = mmiExitClick
      end
    end
    object mmiSettings: TMenuItem
      Caption = '&Einstellungen'
    end
    object mmiHelp: TMenuItem
      Caption = '&Hilfe'
      object mmiAbout: TMenuItem
        Caption = #220'&ber dieses Programm...'
        OnClick = mmiAboutClick
      end
    end
  end
  object tmGeneral: TTimer
    OnTimer = tmGeneralTimer
    Left = 837
    Top = 69
  end
end
