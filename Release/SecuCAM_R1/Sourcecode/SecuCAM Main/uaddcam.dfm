object frmAddCam: TfrmAddCam
  Left = 903
  Top = 200
  BorderStyle = bsDialog
  Caption = 'Kamera hinzu'#252'gen'
  ClientHeight = 480
  ClientWidth = 489
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCloseQuery = FormCloseQuery
  OnHide = FormHide
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 216
    Height = 24
    Caption = 'Neue Kamera hinzuf'#252'gen'
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
    Width = 481
    Height = 9
    Shape = bsTopLine
  end
  object pgAddCam: TPageControl
    Left = 0
    Top = 40
    Width = 489
    Height = 401
    ActivePage = tbsUSBCam
    TabOrder = 0
    object tbsUSBCam: TTabSheet
      Caption = 'USB Kamera'
      object Label2: TLabel
        Left = 8
        Top = 8
        Width = 124
        Height = 13
        Caption = 'Verf'#252'gbare USB Kameras:'
      end
      object Label3: TLabel
        Left = 200
        Top = 8
        Width = 103
        Height = 13
        Caption = 'Ausgew'#228'hlte Kamera:'
      end
      object Label4: TLabel
        Left = 200
        Top = 56
        Width = 25
        Height = 13
        Caption = 'Alias:'
      end
      object lblCamName: TLabel
        Left = 224
        Top = 24
        Width = 46
        Height = 20
        Caption = 'Keine'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMenuHighlight
        Font.Height = -16
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label7: TLabel
        Left = 240
        Top = 200
        Width = 114
        Height = 13
        Caption = 'Bitte Kamera ausw'#228'hlen'
      end
      object lbAvailableCams: TListBox
        Left = 8
        Top = 24
        Width = 169
        Height = 337
        ItemHeight = 13
        TabOrder = 0
        OnClick = lbAvailableCamsClick
      end
      object edtAlias: TEdit
        Left = 224
        Top = 72
        Width = 225
        Height = 21
        TabOrder = 1
      end
      object gbCamProps: TGroupBox
        Left = 192
        Top = 104
        Width = 281
        Height = 257
        Caption = 'Kamera Einstellungen'
        TabOrder = 2
        Visible = False
        object shGridColor: TShape
          Left = 104
          Top = 216
          Width = 9
          Height = 25
        end
        object shHighlightColor: TShape
          Left = 208
          Top = 216
          Width = 9
          Height = 25
        end
        object Label5: TLabel
          Left = 184
          Top = 29
          Width = 47
          Height = 13
          Caption = 'Aufl'#246'sung'
        end
        object Label8: TLabel
          Left = 184
          Top = 56
          Width = 59
          Height = 13
          Caption = 'Intervall (ms)'
        end
        object lblDiff: TLabel
          Left = 16
          Top = 104
          Width = 138
          Height = 13
          Caption = 'Reagiere bei 1% unterschied.'
        end
        object lblTol: TLabel
          Left = 16
          Top = 160
          Width = 61
          Height = 13
          Caption = 'Toleranz: 1%'
        end
        object ckbGridOn: TCheckBox
          Left = 16
          Top = 54
          Width = 97
          Height = 17
          Caption = 'Grid anzeigen'
          TabOrder = 0
        end
        object ckbMotActive: TCheckBox
          Left = 16
          Top = 27
          Width = 113
          Height = 17
          Caption = 'Bewegungsmelder'
          TabOrder = 1
        end
        object ckbHighlightOn: TCheckBox
          Left = 16
          Top = 80
          Width = 105
          Height = 17
          Caption = 'Bewegungen an'
          TabOrder = 2
        end
        object btnGridColor: TButton
          Left = 16
          Top = 216
          Width = 81
          Height = 25
          Caption = '&Grid Farbe'
          TabOrder = 3
          OnClick = btnGridColorClick
        end
        object btnHighlightColor: TButton
          Left = 120
          Top = 216
          Width = 81
          Height = 25
          Caption = '&Highlight Farbe'
          TabOrder = 4
          OnClick = btnHighlightColorClick
        end
        object speRes: TSpinEdit
          Left = 128
          Top = 24
          Width = 49
          Height = 22
          Increment = 2
          MaxValue = 64
          MinValue = 4
          TabOrder = 5
          Value = 4
        end
        object speInt: TSpinEdit
          Left = 128
          Top = 51
          Width = 49
          Height = 22
          Increment = 10
          MaxValue = 10000
          MinValue = 500
          TabOrder = 6
          Value = 1000
        end
        object trbDiff: TTrackBar
          Left = 16
          Top = 120
          Width = 257
          Height = 33
          Max = 100
          Min = 1
          Frequency = 5
          Position = 1
          TabOrder = 7
          OnChange = trbDiffChange
        end
        object trbTol: TTrackBar
          Left = 16
          Top = 176
          Width = 257
          Height = 33
          Max = 40
          TabOrder = 8
          OnChange = trbTolChange
        end
      end
    end
    object tbsIPCam: TTabSheet
      Caption = 'IP Kamera'
      Enabled = False
      ImageIndex = 1
    end
  end
  object btnAdd: TButton
    Left = 8
    Top = 448
    Width = 89
    Height = 25
    Caption = '&Hinzuf'#252'gen'
    ModalResult = 1
    TabOrder = 1
  end
  object btnCancel: TButton
    Left = 104
    Top = 448
    Width = 89
    Height = 25
    Caption = '&Abbrechen'
    ModalResult = 2
    TabOrder = 2
    OnClick = btnCancelClick
  end
  object dlgColor: TColorDialog
    Left = 400
    Top = 8
  end
end
