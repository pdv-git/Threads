object FileListMdiWindow: TFileListMdiWindow
  Left = 0
  Top = 0
  Caption = #1055#1086#1076#1088#1086#1073#1085#1086#1089#1090#1080' '#1082#1072#1090#1072#1083#1086#1075#1072
  ClientHeight = 461
  ClientWidth = 662
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Visible = True
  WindowState = wsMaximized
  OnClose = OnFormClose
  OnResize = OnFormResize
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter: TSplitter
    Left = 321
    Top = 0
    Height = 461
    ExplicitLeft = 336
    ExplicitTop = 200
    ExplicitHeight = 100
  end
  object PanelLeft: TPanel
    Left = 0
    Top = 0
    Width = 321
    Height = 461
    Align = alLeft
    BorderStyle = bsSingle
    TabOrder = 0
    OnResize = OnPanelLeftResize
  end
  object PanelRight: TPanel
    Left = 324
    Top = 0
    Width = 338
    Height = 461
    Align = alClient
    BorderStyle = bsSingle
    TabOrder = 1
    OnResize = OnPanelRightResize
    ExplicitLeft = 330
    ExplicitWidth = 332
  end
end
