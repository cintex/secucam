object frmAddCam: TfrmAddCam
  Left = 305
  Top = 169
  BorderStyle = bsDialog
  Caption = 'Kamera hinzu'#252'gen'
  ClientHeight = 491
  ClientWidth = 434
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
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
    Width = 425
    Height = 9
    Shape = bsTopLine
  end
  object pgAddCam: TPageControl
    Left = 0
    Top = 40
    Width = 433
    Height = 417
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
        Height = 353
        ItemHeight = 13
        TabOrder = 0
        OnClick = lbAvailableCamsClick
      end
      object edtAlias: TEdit
        Left = 224
        Top = 72
        Width = 193
        Height = 21
        TabOrder = 1
      end
      object gbCamProps: TGroupBox
        Left = 192
        Top = 104
        Width = 225
        Height = 273
        Caption = 'Kamera Einstellungen'
        TabOrder = 2
        Visible = False
        object imgPreview: TImage
          Left = 16
          Top = 152
          Width = 193
          Height = 113
          Stretch = True
        end
        object Label6: TLabel
          Left = 16
          Top = 136
          Width = 38
          Height = 13
          Caption = 'Preview'
        end
        object shGridColor: TShape
          Left = 96
          Top = 104
          Width = 9
          Height = 25
        end
        object shHighlightColor: TShape
          Left = 200
          Top = 104
          Width = 9
          Height = 25
        end
        object ckbGridOn: TCheckBox
          Left = 16
          Top = 48
          Width = 97
          Height = 17
          Caption = 'Grid anzeigen'
          TabOrder = 0
        end
        object ckbCamActive: TCheckBox
          Left = 16
          Top = 24
          Width = 97
          Height = 17
          Caption = 'Kamera aktiv'
          TabOrder = 1
        end
        object ckbHighlightOn: TCheckBox
          Left = 16
          Top = 72
          Width = 129
          Height = 17
          Caption = 'Bewegungen anzeigen'
          TabOrder = 2
        end
        object btnGridColor: TButton
          Left = 16
          Top = 104
          Width = 73
          Height = 25
          Caption = '&Grid Farbe'
          TabOrder = 3
          OnClick = btnGridColorClick
        end
        object btnHighlightColor: TButton
          Left = 112
          Top = 104
          Width = 81
          Height = 25
          Caption = '&Highlight Farbe'
          TabOrder = 4
          OnClick = btnHighlightColorClick
        end
      end
    end
    object tbsIPCam: TTabSheet
      Caption = 'IP Kamera'
      ImageIndex = 1
    end
  end
  object btnAdd: TButton
    Left = 0
    Top = 464
    Width = 89
    Height = 25
    Caption = '&Hinzuf'#252'gen'
    ModalResult = 1
    TabOrder = 1
  end
  object btnCancel: TButton
    Left = 344
    Top = 464
    Width = 89
    Height = 25
    Caption = '&Abbrechen'
    ModalResult = 2
    TabOrder = 2
  end
  object dlgColor: TColorDialog
    Left = 400
    Top = 8
  end
end
