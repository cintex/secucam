object frmMain: TfrmMain
  Left = 192
  Top = 107
  Width = 489
  Height = 342
  Caption = 'SecuCAM TEST 2'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object VideoWindow1: TVideoWindow
    Left = 152
    Top = 8
    Width = 320
    Height = 240
    VMROptions.Mode = vmrWindowed
    Color = clBlack
  end
  object ListBox1: TListBox
    Left = 0
    Top = 0
    Width = 137
    Height = 313
    ItemHeight = 13
    TabOrder = 1
  end
  object VideoSourceFilter: TFilter
    BaseFilter.data = {00000000}
    Left = 440
    Top = 16
  end
  object CaptureGraph: TFilterGraph
    GraphEdit = False
    Left = 432
    Top = 24
  end
end
