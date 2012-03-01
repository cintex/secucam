object frmEditCam: TfrmEditCam
  Left = 537
  Top = 231
  BorderStyle = bsDialog
  Caption = 'Kameraeinstellungen'
  ClientHeight = 465
  ClientWidth = 346
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 178
    Height = 24
    Caption = 'Kameraeinstellungen'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clHighlight
    Font.Height = -21
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Bevel1: TBevel
    Left = 8
    Top = 32
    Width = 673
    Height = 9
    Shape = bsTopLine
  end
  object Label2: TLabel
    Left = 8
    Top = 40
    Width = 103
    Height = 13
    Caption = 'Ausgew'#228'hlte Kamera:'
  end
  object lblCamName: TLabel
    Left = 32
    Top = 56
    Width = 31
    Height = 20
    Caption = '???'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMenuHighlight
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 8
    Top = 88
    Width = 25
    Height = 13
    Caption = 'Alias:'
  end
  object btnAccept: TButton
    Left = 8
    Top = 432
    Width = 75
    Height = 25
    Caption = '&'#220'bernehmen'
    ModalResult = 1
    TabOrder = 0
  end
  object btnCancel: TButton
    Left = 88
    Top = 432
    Width = 75
    Height = 25
    Caption = '&Abbrechen'
    ModalResult = 2
    TabOrder = 1
  end
  object edtAlias: TEdit
    Left = 32
    Top = 104
    Width = 121
    Height = 21
    TabOrder = 2
    Text = '???'
  end
  object gbCamSettings: TGroupBox
    Left = 8
    Top = 136
    Width = 329
    Height = 289
    Caption = 'Kameraeinstellungen'
    TabOrder = 3
    object Label8: TLabel
      Left = 256
      Top = 32
      Width = 47
      Height = 13
      Caption = 'Aufl'#246'sung'
    end
    object Label9: TLabel
      Left = 256
      Top = 59
      Width = 59
      Height = 13
      Caption = 'Intervall (ms)'
    end
    object shGridColor: TShape
      Left = 104
      Top = 248
      Width = 9
      Height = 25
    end
    object shHighlightColor: TShape
      Left = 208
      Top = 248
      Width = 9
      Height = 25
    end
    object lblDiff: TLabel
      Left = 8
      Top = 112
      Width = 138
      Height = 13
      Caption = 'Reagiere bei 1% unterschied.'
    end
    object lblTol: TLabel
      Left = 8
      Top = 176
      Width = 61
      Height = 13
      Caption = 'Toleranz: 1%'
    end
    object ckbMotDect: TCheckBox
      Left = 8
      Top = 30
      Width = 113
      Height = 17
      Caption = 'Bewegungsmelder'
      TabOrder = 0
    end
    object ckbGrid: TCheckBox
      Left = 8
      Top = 57
      Width = 97
      Height = 17
      Caption = 'Grid anzeigen'
      TabOrder = 1
    end
    object ckbHighlight: TCheckBox
      Left = 8
      Top = 84
      Width = 97
      Height = 17
      Caption = 'Bewegungen an'
      TabOrder = 2
    end
    object trbDiff: TTrackBar
      Left = 8
      Top = 136
      Width = 313
      Height = 33
      Max = 100
      Frequency = 5
      TabOrder = 3
      OnChange = trbDiffChange
    end
    object trbToll: TTrackBar
      Left = 8
      Top = 192
      Width = 313
      Height = 33
      Max = 40
      TabOrder = 4
      OnChange = trbTollChange
    end
    object speRes: TSpinEdit
      Left = 128
      Top = 27
      Width = 121
      Height = 22
      MaxValue = 0
      MinValue = 0
      TabOrder = 5
      Value = 0
    end
    object speInt: TSpinEdit
      Left = 128
      Top = 54
      Width = 121
      Height = 22
      MaxValue = 0
      MinValue = 0
      TabOrder = 6
      Value = 0
    end
    object btnGridColor: TButton
      Left = 16
      Top = 248
      Width = 81
      Height = 25
      Caption = '&Grid Farbe'
      TabOrder = 7
      OnClick = btnGridColorClick
    end
    object btnHighlightColor: TButton
      Left = 120
      Top = 248
      Width = 81
      Height = 25
      Caption = '&Highlight Farbe'
      TabOrder = 8
      OnClick = btnHighlightColorClick
    end
  end
  object dlgColor: TColorDialog
    Left = 312
    Top = 48
  end
end
