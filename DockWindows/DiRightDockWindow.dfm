object RightDockWindow: TRightDockWindow
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1080
  ClientHeight = 508
  ClientWidth = 655
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Visible = True
  PixelsPerInch = 96
  TextHeight = 13
  object InfoLabel: TLabel
    Left = 8
    Top = 8
    Width = 131
    Height = 19
    Caption = #1042#1099#1074#1086#1076' '#1075#1088#1072#1092#1080#1082#1080
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object PaintBox: TPaintBox
    Left = 8
    Top = 64
    Width = 639
    Height = 436
  end
  object StartButton: TButton
    Left = 8
    Top = 33
    Width = 75
    Height = 25
    Caption = 'Start'
    TabOrder = 0
    OnClick = OnStartButtonClick
  end
  object StopButton: TButton
    Left = 89
    Top = 33
    Width = 75
    Height = 25
    Caption = 'Stop'
    TabOrder = 1
    OnClick = OnStopButtonClick
  end
  object ClearButton: TButton
    Left = 170
    Top = 33
    Width = 75
    Height = 25
    Caption = 'Clear'
    TabOrder = 2
    OnClick = OnClearButtonClick
  end
end
