object Form1: TForm1
  Left = 200
  Top = 137
  Width = 865
  Height = 615
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object imgActual: TImage
    Left = 336
    Top = 24
    Width = 320
    Height = 240
  end
  object imgReference: TImage
    Left = 8
    Top = 296
    Width = 320
    Height = 240
  end
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 72
    Height = 13
    Caption = 'Camera Stream'
  end
  object Label2: TLabel
    Left = 336
    Top = 8
    Width = 73
    Height = 13
    BiDiMode = bdRightToLeftReadingOnly
    Caption = 'Aktueller Frame'
    ParentBiDiMode = False
  end
  object Label3: TLabel
    Left = 8
    Top = 280
    Width = 63
    Height = 13
    Caption = 'Referenz Bild'
  end
  object imgXOR: TImage
    Left = 336
    Top = 296
    Width = 320
    Height = 240
  end
  object Label4: TLabel
    Left = 336
    Top = 280
    Width = 93
    Height = 13
    Caption = 'Ver'#228'nderung (XOR)'
  end
  object lblStatus: TLabel
    Left = 544
    Top = 552
    Width = 25
    Height = 13
    Caption = 'CAP'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object plCAM: TPanel
    Left = 8
    Top = 24
    Width = 320
    Height = 240
    Caption = 'CAM WINDOW'
    TabOrder = 0
  end
  object btnStream: TButton
    Left = 8
    Top = 544
    Width = 75
    Height = 25
    Caption = 'STREAM'
    TabOrder = 1
    OnClick = btnStreamClick
  end
  object btnCapture: TButton
    Left = 96
    Top = 544
    Width = 75
    Height = 25
    Caption = 'Get Frame'
    TabOrder = 2
    OnClick = btnCaptureClick
  end
  object btnRefernce: TButton
    Left = 176
    Top = 544
    Width = 75
    Height = 25
    Caption = 'Get Reference'
    TabOrder = 3
    OnClick = btnRefernceClick
  end
  object btnCompare: TButton
    Left = 256
    Top = 544
    Width = 75
    Height = 25
    Caption = 'Compare'
    TabOrder = 4
    OnClick = btnCompareClick
  end
  object btnAuto: TButton
    Left = 584
    Top = 544
    Width = 75
    Height = 25
    Caption = 'Automatic'
    TabOrder = 5
    OnClick = btnAutoClick
  end
  object TPanel
    Left = 672
    Top = 0
    Width = 177
    Height = 577
    TabOrder = 6
    object grpStreamStats: TGroupBox
      Left = 8
      Top = 8
      Width = 161
      Height = 113
      Caption = 'Stream Stats'
      TabOrder = 0
      object Label5: TLabel
        Left = 8
        Top = 24
        Width = 23
        Height = 13
        Caption = 'Red:'
      end
      object Label7: TLabel
        Left = 8
        Top = 40
        Width = 29
        Height = 13
        Caption = 'Green'
      end
      object Label8: TLabel
        Left = 8
        Top = 56
        Width = 21
        Height = 13
        Caption = 'Blue'
      end
      object Label9: TLabel
        Left = 8
        Top = 72
        Width = 27
        Height = 13
        Caption = 'Alpha'
      end
      object Label10: TLabel
        Left = 8
        Top = 88
        Width = 57
        Height = 13
        Caption = 'Mean Value'
      end
      object lblStreamRed: TLabel
        Left = 88
        Top = 24
        Width = 8
        Height = 13
        Caption = '0'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblStreamGreen: TLabel
        Left = 88
        Top = 40
        Width = 8
        Height = 13
        Caption = '0'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGreen
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblStreamBlue: TLabel
        Left = 88
        Top = 56
        Width = 8
        Height = 13
        Caption = '0'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblStreamAlpha: TLabel
        Left = 88
        Top = 72
        Width = 8
        Height = 13
        Caption = '0'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblStreamMean: TLabel
        Left = 88
        Top = 88
        Width = 8
        Height = 13
        Caption = '0'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
    object grpActualStats: TGroupBox
      Left = 8
      Top = 128
      Width = 161
      Height = 113
      Caption = 'Actual Frame Stats'
      TabOrder = 1
      object Label16: TLabel
        Left = 8
        Top = 24
        Width = 23
        Height = 13
        Caption = 'Red:'
      end
      object lblActualRed: TLabel
        Left = 88
        Top = 24
        Width = 8
        Height = 13
        Caption = '0'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblActualGreen: TLabel
        Left = 88
        Top = 40
        Width = 8
        Height = 13
        Caption = '0'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGreen
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label19: TLabel
        Left = 8
        Top = 40
        Width = 29
        Height = 13
        Caption = 'Green'
      end
      object Label20: TLabel
        Left = 8
        Top = 56
        Width = 21
        Height = 13
        Caption = 'Blue'
      end
      object lblActualBlue: TLabel
        Left = 88
        Top = 56
        Width = 8
        Height = 13
        Caption = '0'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblActualAlpha: TLabel
        Left = 88
        Top = 72
        Width = 8
        Height = 13
        Caption = '0'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label23: TLabel
        Left = 8
        Top = 72
        Width = 27
        Height = 13
        Caption = 'Alpha'
      end
      object Label24: TLabel
        Left = 8
        Top = 88
        Width = 57
        Height = 13
        Caption = 'Mean Value'
      end
      object lblActualMean: TLabel
        Left = 88
        Top = 88
        Width = 8
        Height = 13
        Caption = '0'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
    object grpRefStats: TGroupBox
      Left = 8
      Top = 248
      Width = 161
      Height = 113
      Caption = 'Reference Frame Stats'
      TabOrder = 2
      object Label26: TLabel
        Left = 8
        Top = 24
        Width = 23
        Height = 13
        Caption = 'Red:'
      end
      object lblRefRed: TLabel
        Left = 88
        Top = 24
        Width = 8
        Height = 13
        Caption = '0'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblRefGreen: TLabel
        Left = 88
        Top = 40
        Width = 8
        Height = 13
        Caption = '0'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGreen
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label29: TLabel
        Left = 8
        Top = 40
        Width = 29
        Height = 13
        Caption = 'Green'
      end
      object Label30: TLabel
        Left = 8
        Top = 56
        Width = 21
        Height = 13
        Caption = 'Blue'
      end
      object lblRefBlue: TLabel
        Left = 88
        Top = 56
        Width = 8
        Height = 13
        Caption = '0'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblRefAlpha: TLabel
        Left = 88
        Top = 72
        Width = 8
        Height = 13
        Caption = '0'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label33: TLabel
        Left = 8
        Top = 72
        Width = 27
        Height = 13
        Caption = 'Alpha'
      end
      object Label34: TLabel
        Left = 8
        Top = 88
        Width = 57
        Height = 13
        Caption = 'Mean Value'
      end
      object lblRefMean: TLabel
        Left = 88
        Top = 88
        Width = 8
        Height = 13
        Caption = '0'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
    object grpDetectionStats: TGroupBox
      Left = 8
      Top = 368
      Width = 161
      Height = 201
      Caption = 'Detection Stats'
      Color = clBtnFace
      ParentColor = False
      TabOrder = 3
      object Label36: TLabel
        Left = 8
        Top = 24
        Width = 23
        Height = 13
        Caption = 'Red:'
      end
      object lblXORRed: TLabel
        Left = 88
        Top = 24
        Width = 8
        Height = 13
        Caption = '0'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblXORGreen: TLabel
        Left = 88
        Top = 40
        Width = 8
        Height = 13
        Caption = '0'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGreen
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label39: TLabel
        Left = 8
        Top = 40
        Width = 29
        Height = 13
        Caption = 'Green'
      end
      object Label40: TLabel
        Left = 8
        Top = 56
        Width = 21
        Height = 13
        Caption = 'Blue'
      end
      object lblXORBlue: TLabel
        Left = 88
        Top = 56
        Width = 8
        Height = 13
        Caption = '0'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblXORAlpha: TLabel
        Left = 88
        Top = 72
        Width = 8
        Height = 13
        Caption = '0'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label43: TLabel
        Left = 8
        Top = 72
        Width = 27
        Height = 13
        Caption = 'Alpha'
      end
      object Label44: TLabel
        Left = 8
        Top = 88
        Width = 57
        Height = 13
        Caption = 'Mean Value'
      end
      object lblXORMean: TLabel
        Left = 88
        Top = 88
        Width = 8
        Height = 13
        Caption = '0'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object ledCap: TShape
        Left = 8
        Top = 112
        Width = 25
        Height = 25
        Brush.Color = clGreen
        Shape = stCircle
      end
      object ledComp: TShape
        Left = 40
        Top = 112
        Width = 25
        Height = 25
        Brush.Color = clGreen
        Shape = stCircle
      end
      object ledWarn: TShape
        Left = 128
        Top = 112
        Width = 25
        Height = 25
        Brush.Color = clBlack
        Shape = stCircle
      end
      object plDetection: TPanel
        Left = 8
        Top = 144
        Width = 145
        Height = 49
        Caption = 'NO DETECTION'
        Color = clGreen
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'Stencil'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
    end
  end
  object Button1: TButton
    Left = 392
    Top = 544
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 7
    OnClick = Button1Click
  end
  object tmAutom: TTimer
    Enabled = False
    Interval = 2000
    OnTimer = tmAutomTimer
    Left = 608
    Top = 40
  end
end
