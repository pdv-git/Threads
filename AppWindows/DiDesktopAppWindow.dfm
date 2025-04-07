object DesktopAppWindow: TDesktopAppWindow
  Left = 0
  Top = 0
  Caption = 'Desktop'
  ClientHeight = 542
  ClientWidth = 784
  Color = clAppWorkSpace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIForm
  Menu = MainMenu
  OldCreateOrder = False
  Position = poDefault
  WindowState = wsMaximized
  OnShow = OnFormShow
  PixelsPerInch = 96
  TextHeight = 13
  object DockSplitter: TSplitter
    Left = 225
    Top = 52
    Height = 471
    Color = clBtnFace
    ParentColor = False
    ExplicitLeft = 400
    ExplicitTop = 248
    ExplicitHeight = 100
  end
  object ControlBar: TControlBar
    Left = 0
    Top = 0
    Width = 784
    Height = 52
    Align = alTop
    AutoSize = True
    BevelEdges = [beTop, beBottom]
    BevelInner = bvNone
    BevelOuter = bvNone
    BevelKind = bkNone
    Color = clBtnFace
    CornerEdge = ceNone
    GradientStartColor = clBtnFace
    ParentBackground = False
    ParentColor = False
    TabOrder = 0
    OnBandPaint = OnControlBarBandPaint
    object ConnectToolBar: TToolBar
      Left = 11
      Top = 2
      Width = 48
      Height = 22
      AutoSize = True
      Caption = #1055#1086#1076#1082#1083#1102#1095#1077#1085#1080#1077
      DrawingStyle = dsGradient
      GradientStartColor = clBtnFace
      Images = ImageList
      GradientDrawingOptions = [gdoHotTrack]
      TabOrder = 0
      Transparent = False
      object ConnectToolButton: TToolButton
        Left = 0
        Top = 0
        Action = ToolsConnectAction
      end
      object ConnectDisconnectToolButton: TToolButton
        Left = 23
        Top = 0
        Action = ToolsDisconnectAction
      end
    end
    object StandardToolBar: TToolBar
      Left = 74
      Top = 2
      Width = 314
      Height = 22
      Caption = #1057#1090#1072#1085#1076#1072#1088#1090#1085#1072#1103
      DrawingStyle = dsGradient
      GradientStartColor = clBtnFace
      Images = ImageList
      GradientDrawingOptions = [gdoHotTrack]
      TabOrder = 1
      Transparent = False
      object StandardFileNewToolButton: TToolButton
        Left = 0
        Top = 0
        Action = FileNewAction
      end
      object StandardFileOpenToolButton: TToolButton
        Left = 23
        Top = 0
        Action = FileOpenAction
      end
      object StandardFileSaveToolButton: TToolButton
        Left = 46
        Top = 0
        Action = FileSaveAction
      end
      object StandardSeparator1ToolButton: TToolButton
        Left = 69
        Top = 0
        Width = 8
        Style = tbsSeparator
      end
      object StandardFilePrintToolButton: TToolButton
        Left = 77
        Top = 0
        Action = FilePrintAction
      end
      object StandardPrintPreviewToolButton: TToolButton
        Left = 100
        Top = 0
        Action = FilePrintPreviewAction
      end
      object StandardSeparator2ToolButton: TToolButton
        Left = 123
        Top = 0
        Width = 8
        Style = tbsSeparator
      end
      object StandardNavigateBackwardToolButton: TToolButton
        Left = 131
        Top = 0
        Action = ViewNavigateBackwardAction
        Style = tbsDropDown
      end
      object StandardNavigateForwardToolButton: TToolButton
        Left = 169
        Top = 0
        Action = ViewNavigateForwardAction
      end
      object StandardSeparator3ToolButton: TToolButton
        Left = 192
        Top = 0
        Width = 8
        Style = tbsSeparator
      end
      object StandardFileTreeToolButton: TToolButton
        Left = 200
        Top = 0
        Action = ViewFileTreeAction
      end
      object StandardFileListToolButton: TToolButton
        Left = 223
        Top = 0
        Action = ViewFileListAction
      end
      object StandardSeparator4ToolButton: TToolButton
        Left = 246
        Top = 0
        Width = 8
        Style = tbsSeparator
      end
      object StandardFileClosePanel: TPanel
        Left = 254
        Top = 0
        Width = 60
        Height = 22
        BevelOuter = bvNone
        ParentBackground = False
        TabOrder = 0
        object StandardFileCloseToolBar: TToolBar
          Left = 0
          Top = 0
          Width = 60
          Height = 21
          AutoSize = True
          ButtonHeight = 21
          ButtonWidth = 51
          DrawingStyle = dsGradient
          EdgeInner = esNone
          EdgeOuter = esNone
          GradientDrawingOptions = [gdoHotTrack]
          ShowCaptions = True
          TabOrder = 0
          Transparent = False
          object StandardFileCloseToolButton: TToolButton
            Left = 0
            Top = 0
            Action = FileCloseAction
            AutoSize = True
          end
        end
      end
    end
    object ReportToolBar: TToolBar
      Left = 11
      Top = 28
      Width = 130
      Height = 22
      Caption = #1054#1090#1095#1077#1090
      DrawingStyle = dsGradient
      GradientStartColor = clBtnFace
      Images = ImageList
      GradientDrawingOptions = [gdoHotTrack]
      TabOrder = 2
      object ReportOutlineToolButton: TToolButton
        Left = 0
        Top = 0
        Action = ViewOutlineAction
      end
      object ReportSeparator1ToolButton: TToolButton
        Left = 23
        Top = 0
        Width = 8
        Style = tbsSeparator
      end
      object ReportZoomUpToolButton: TToolButton
        Left = 31
        Top = 0
        Action = ViewZoomUpAction
      end
      object ReportScalePanel: TPanel
        Left = 54
        Top = 0
        Width = 51
        Height = 22
        BevelOuter = bvNone
        ParentBackground = False
        TabOrder = 0
        object ReportScaleComboBox: TComboBox
          Left = 1
          Top = 1
          Width = 49
          Height = 21
          Enabled = False
          TabOrder = 0
          TabStop = False
          Text = '100%'
          Items.Strings = (
            '25%'
            '50%'
            '75%'
            '100%'
            '150%'
            '200%')
        end
      end
      object ReportZoomDownToolButton: TToolButton
        Left = 105
        Top = 0
        Action = ViewZoomDownAction
      end
    end
    object DataToolBar: TToolBar
      Left = 156
      Top = 28
      Width = 342
      Height = 22
      Caption = #1044#1072#1085#1085#1099#1077
      DrawingStyle = dsGradient
      GradientStartColor = clBtnFace
      Images = ImageList
      GradientDrawingOptions = [gdoHotTrack]
      TabOrder = 3
      object DataQueryExecuteToolButton: TToolButton
        Left = 0
        Top = 0
        Action = QueryExecuteAction
      end
      object DataSeparator1ToolButton: TToolButton
        Left = 23
        Top = 0
        Width = 8
        Style = tbsSeparator
      end
      object DataSaveRecordToolButton: TToolButton
        Left = 31
        Top = 0
        Action = DataSaveRecordAction
      end
      object DataCancelInputToolButton: TToolButton
        Left = 54
        Top = 0
        Action = DataCancelInputAction
      end
      object DataSeparator2ToolButton: TToolButton
        Left = 77
        Top = 0
        Width = 8
        Style = tbsSeparator
      end
      object DataFirstToolButton: TToolButton
        Left = 85
        Top = 0
        Action = DataFirstAction
      end
      object DataPreviousToolButton: TToolButton
        Left = 108
        Top = 0
        Action = DataPreviousAction
      end
      object DataSeparator3ToolButton: TToolButton
        Left = 131
        Top = 0
        Width = 8
        ImageIndex = 39
        Style = tbsSeparator
      end
      object DataRecordPanel: TPanel
        Left = 139
        Top = 0
        Width = 93
        Height = 22
        BevelOuter = bvNone
        ParentBackground = False
        TabOrder = 0
        object DataRecordLabel: TLabel
          Left = 45
          Top = 4
          Width = 44
          Height = 13
          AutoSize = False
          Caption = #1080#1079' 0'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGrayText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object DataRecordEdit: TEdit
          AlignWithMargins = True
          Left = 4
          Top = 2
          Width = 37
          Height = 18
          Margins.Left = 4
          Margins.Top = 2
          Margins.Right = 52
          Margins.Bottom = 2
          TabStop = False
          Align = alClient
          BevelInner = bvSpace
          BevelKind = bkFlat
          BevelOuter = bvSpace
          BorderStyle = bsNone
          Enabled = False
          TabOrder = 0
          Text = '0'
        end
      end
      object DataSeparator4ToolButton: TToolButton
        Left = 232
        Top = 0
        Width = 8
        Style = tbsSeparator
      end
      object DataNextToolButton: TToolButton
        Left = 240
        Top = 0
        Action = DataNextAction
      end
      object DataLastToolButton: TToolButton
        Left = 263
        Top = 0
        Action = DataLastAction
      end
      object DataSeparator5ToolButton: TToolButton
        Left = 286
        Top = 0
        Width = 8
        Style = tbsSeparator
      end
      object DataNewRecordToolButton: TToolButton
        Left = 294
        Top = 0
        Action = DataNewRecordAction
      end
      object DataDeleteRecordToolButton: TToolButton
        Left = 317
        Top = 0
        Action = DataDeleteRecordAction
      end
    end
  end
  object DockPanel: TPanel
    Left = 0
    Top = 52
    Width = 225
    Height = 471
    Align = alLeft
    BevelOuter = bvNone
    ParentBackground = False
    TabOrder = 1
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 523
    Width = 784
    Height = 19
    Panels = <>
    SimplePanel = True
  end
  object ActionList: TActionList
    Images = ImageList
    Left = 56
    Top = 400
    object FileNewAction: TAction
      Category = 'File'
      Caption = #1057#1086#1079#1076'&'#1072#1090#1100'...'
      Enabled = False
      ImageIndex = 0
      ShortCut = 16462
    end
    object FileOpenAction: TAction
      Category = 'File'
      Caption = '&'#1054#1090#1082#1088#1099#1090#1100'...'
      Enabled = False
      ImageIndex = 1
      ShortCut = 16463
    end
    object FileCloseAction: TWindowClose
      Category = 'File'
      Caption = #1047#1072#1082#1088'&'#1099#1090#1100
      Enabled = False
    end
    object FileSaveAction: TAction
      Category = 'File'
      Caption = '&'#1057#1086#1093#1088#1072#1085#1080#1090#1100
      Enabled = False
      ImageIndex = 2
      ShortCut = 16467
    end
    object FileSaveAsAction: TAction
      Category = 'File'
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' &'#1082#1072#1082'...'
      Enabled = False
    end
    object FilePageSetupAction: TAction
      Category = 'File'
      Caption = #1055#1072#1088#1072'&'#1084#1077#1090#1088#1099' '#1089#1090#1088#1072#1085#1080#1094#1099'...'
      Enabled = False
    end
    object FilePrintPreviewAction: TAction
      Category = 'File'
      Caption = #1055#1088#1077#1076'&'#1074#1072#1088#1080#1090#1077#1083#1100#1085#1099#1081' '#1087#1088#1086#1089#1084#1086#1090#1088
      Enabled = False
      ImageIndex = 3
    end
    object FilePrintAction: TAction
      Category = 'File'
      Caption = '&'#1055#1077#1095#1072#1090#1100'...'
      Enabled = False
      ImageIndex = 4
      ShortCut = 16464
    end
    object FileExitAction: TFileExit
      Category = 'File'
      Caption = #1042#1099'&'#1093#1086#1076
    end
    object EditUndoAction: TEditUndo
      Category = 'Edit'
      Caption = '&'#1054#1090#1084#1077#1085#1080#1090#1100
      Enabled = False
      ImageIndex = 5
      ShortCut = 16474
    end
    object EditCutAction: TEditCut
      Category = 'Edit'
      Caption = #1042#1099#1088#1077#1079#1072#1090'&'#1100
      Enabled = False
      ImageIndex = 6
      ShortCut = 16472
    end
    object EditCopyAction: TEditCopy
      Category = 'Edit'
      Caption = '&'#1050#1086#1087#1080#1088#1086#1074#1072#1090#1100
      Enabled = False
      ImageIndex = 7
      ShortCut = 16451
    end
    object EditPasteAction: TEditPaste
      Category = 'Edit'
      Caption = #1042#1089#1090#1072#1074'&'#1080#1090#1100
      Enabled = False
      ImageIndex = 8
      ShortCut = 16470
    end
    object EditDeleteAction: TEditDelete
      Category = 'Edit'
      Caption = '&'#1059#1076#1072#1083#1080#1090#1100
      Enabled = False
      ImageIndex = 9
      ShortCut = 46
    end
    object EditSelectAllAction: TEditSelectAll
      Category = 'Edit'
      Caption = #1042'&'#1099#1076#1077#1083#1080#1090#1100' '#1074#1089#1077
      Enabled = False
      ShortCut = 16449
    end
    object EditFindAction: TAction
      Category = 'Edit'
      Caption = '&'#1053#1072#1081#1090#1080'...'
      Enabled = False
      ImageIndex = 10
      ShortCut = 16454
    end
    object EditGoToAction: TAction
      Category = 'Edit'
      Caption = '&'#1055#1077#1088#1077#1081#1090#1080'...'
      Enabled = False
      ShortCut = 16455
    end
    object ViewFileTreeAction: TAction
      Category = 'View'
      AutoCheck = True
      Caption = '&'#1050#1072#1090#1072#1083#1086#1075
      Checked = True
      ImageIndex = 11
      ShortCut = 119
      OnExecute = OnViewFileTreeActionExecute
    end
    object ViewFileListAction: TAction
      Category = 'View'
      Caption = '&'#1055#1086#1076#1088#1086#1073#1085#1086#1089#1090#1080' '#1082#1072#1090#1072#1083#1086#1075#1072
      ImageIndex = 12
      ShortCut = 118
      OnExecute = OnViewFileListActionExecute
    end
    object ViewOutlineAction: TAction
      Category = 'View'
      Caption = #1052#1080#1085#1080#1072'&'#1090#1102#1088#1099
      Enabled = False
      ImageIndex = 13
    end
    object ViewZoomUpAction: TAction
      Category = 'View'
      Caption = '&'#1059#1074#1077#1083#1080#1095#1080#1090#1100
      Enabled = False
      ImageIndex = 14
    end
    object ViewZoomDownAction: TAction
      Category = 'View'
      Caption = #1059'&'#1084#1077#1085#1100#1096#1080#1090#1100
      Enabled = False
      ImageIndex = 15
    end
    object ViewZoomAction: TAction
      Category = 'View'
      Caption = #1052#1072#1089'&'#1096#1090#1072#1073'...'
      Enabled = False
    end
    object ViewToolbarStandardAction: TAction
      Category = 'View'
      AutoCheck = True
      Caption = '&'#1057#1090#1072#1085#1076#1072#1088#1090#1085#1072#1103
    end
    object ViewToolbarConnectAction: TAction
      Category = 'View'
      AutoCheck = True
      Caption = '&'#1055#1086#1076#1082#1083#1102#1095#1077#1085#1080#1077
    end
    object ViewToolbarDataAction: TAction
      Category = 'View'
      AutoCheck = True
      Caption = '&'#1044#1072#1085#1085#1099#1077
    end
    object ViewToolbarReportAction: TAction
      Category = 'View'
      AutoCheck = True
      Caption = '&'#1054#1090#1095#1077#1090
    end
    object ViewNavigateBackwardAction: TAction
      Category = 'View'
      Caption = #1053'&'#1072#1079#1072#1076
      Enabled = False
      ImageIndex = 16
      ShortCut = 16501
    end
    object ViewNavigateForwardAction: TAction
      Category = 'View'
      Caption = '&'#1042#1087#1077#1088#1077#1076
      Enabled = False
      ImageIndex = 17
      ShortCut = 24693
    end
    object DataFirstAction: TAction
      Category = 'Data'
      Caption = '&'#1055#1077#1088#1074#1072#1103' '#1079#1072#1087#1080#1089#1100
      Enabled = False
      ImageIndex = 19
    end
    object DataPreviousAction: TAction
      Category = 'Data'
      Caption = #1055#1088#1077#1076'&'#1099#1076#1091#1097#1072#1103' '#1079#1072#1087#1080#1089#1100
      Enabled = False
      ImageIndex = 20
    end
    object DataNextAction: TAction
      Category = 'Data'
      Caption = #1057'&'#1083#1077#1076#1091#1102#1097#1072#1103' '#1079#1072#1087#1080#1089#1100
      Enabled = False
      ImageIndex = 21
    end
    object DataLastAction: TAction
      Category = 'Data'
      Caption = #1055#1086#1089#1083#1077'&'#1076#1085#1103#1103' '#1079#1072#1087#1080#1089#1100
      Enabled = False
      ImageIndex = 22
    end
    object DataNewRecordAction: TAction
      Category = 'Data'
      Caption = '&'#1053#1086#1074#1072#1103' '#1079#1072#1087#1080#1089#1100
      Enabled = False
      ImageIndex = 23
    end
    object DataDeleteRecordAction: TAction
      Category = 'Data'
      Caption = '&'#1059#1076#1072#1083#1080#1090#1100' '#1079#1072#1087#1080#1089#1100
      Enabled = False
      ImageIndex = 24
    end
    object DataSaveRecordAction: TAction
      Category = 'Data'
      Caption = '&'#1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1079#1072#1087#1080#1089#1100
      Enabled = False
      ImageIndex = 25
    end
    object DataCancelInputAction: TAction
      Category = 'Data'
      Caption = '&'#1054#1090#1084#1077#1085#1080#1090#1100' '#1074#1074#1086#1076
      Enabled = False
      ImageIndex = 26
    end
    object QueryExecuteAction: TAction
      Category = 'Query'
      Caption = '&'#1042#1099#1087#1086#1083#1085#1080#1090#1100
      Enabled = False
      ImageIndex = 18
      ShortCut = 116
    end
    object ToolsConnectAction: TAction
      Category = 'Tools'
      Caption = #1055#1086#1076#1082#1083#1102'&'#1095#1080#1090#1100' '#1082' '#1073#1072#1079#1077' '#1076#1072#1085#1085#1099#1093'...'
      ImageIndex = 27
      OnExecute = OnToolsConnectActionExecute
    end
    object ToolsDisconnectAction: TAction
      Category = 'Tools'
      Caption = '&'#1054#1090#1082#1083#1102#1095#1080#1090#1100' '#1086#1090' '#1073#1072#1079#1099' '#1076#1072#1085#1085#1099#1093
      Enabled = False
      ImageIndex = 28
      OnExecute = OnToolsDisconnectActionExecute
    end
    object ToolsOptionsAction: TAction
      Category = 'Tools'
      Caption = #1055'&'#1072#1088#1072#1084#1077#1090#1088#1099'...'
      Enabled = False
    end
    object WindowCascadeAction: TWindowCascade
      Category = 'Window'
      Caption = '&'#1050#1072#1089#1082#1072#1076
      Enabled = False
    end
    object WindowTileHorizontalAction: TWindowTileHorizontal
      Category = 'Window'
      Caption = '&'#1043#1086#1088#1080#1079#1086#1085#1090#1072#1083#1100#1085#1086
      Enabled = False
    end
    object WindowTileVerticalAction: TWindowTileVertical
      Category = 'Window'
      Caption = '&'#1042#1077#1088#1090#1080#1082#1072#1083#1100#1085#1086
      Enabled = False
    end
    object WindowMinimizeAllAction: TWindowMinimizeAll
      Category = 'Window'
      Caption = '&'#1057#1074#1077#1088#1085#1091#1090#1100' '#1074#1089#1077
      Enabled = False
    end
    object WindowCloseAllAction: TAction
      Category = 'Window'
      Caption = '&'#1047#1072#1082#1088#1099#1090#1100' '#1074#1089#1077
      Enabled = False
      ImageIndex = 29
    end
    object WindowWindowsAction: TAction
      Category = 'Window'
      Caption = '&'#1054#1082#1085#1072'...'
      Enabled = False
    end
    object HelpContextAction: TAction
      Category = 'Help'
      Caption = '&'#1057#1087#1088#1072#1074#1082#1072' '#1041#1077#1083#1099#1081#1040#1088#1084'.'#1044#1077#1089#1082#1090#1086#1087
      Enabled = False
      ShortCut = 112
    end
    object HelpAboutAction: TAction
      Category = 'Help'
      Caption = '&'#1054' '#1087#1088#1086#1075#1088#1072#1084#1084#1077'...'
      Enabled = False
    end
  end
  object MainMenu: TMainMenu
    Images = ImageList
    Left = 88
    Top = 400
    object FileMenuItem: TMenuItem
      Caption = '&'#1060#1072#1081#1083
      object FileNewMenuItem: TMenuItem
        Action = FileNewAction
      end
      object FileOpenMenuItem: TMenuItem
        Action = FileOpenAction
      end
      object FileCloseMenuItem: TMenuItem
        Action = FileCloseAction
      end
      object FileSeparator1MenuItem: TMenuItem
        Caption = '-'
      end
      object FileSaveMenuItem: TMenuItem
        Action = FileSaveAction
      end
      object FileSaveAsMenuItem: TMenuItem
        Action = FileSaveAsAction
      end
      object FileSeparator2MenuItem: TMenuItem
        Caption = '-'
      end
      object FilePageSetupMenuItem: TMenuItem
        Action = FilePageSetupAction
      end
      object FilePrintPreviewMenuItem: TMenuItem
        Action = FilePrintPreviewAction
      end
      object FilePrintMenuItem: TMenuItem
        Action = FilePrintAction
      end
      object FileSeparator3MenuItem: TMenuItem
        Caption = '-'
      end
      object FileExitMenuItem: TMenuItem
        Action = FileExitAction
      end
    end
    object EditMenuItem: TMenuItem
      Caption = '&'#1055#1088#1072#1074#1082#1072
      object EditUndoMenuItem: TMenuItem
        Action = EditUndoAction
      end
      object EditSeparator1MenuItem: TMenuItem
        Caption = '-'
      end
      object EditCutMenuItem: TMenuItem
        Action = EditCutAction
      end
      object EditCopyMenuItem: TMenuItem
        Action = EditCopyAction
      end
      object EditPasteMenuItem: TMenuItem
        Action = EditPasteAction
      end
      object EditDeleteMenuItem: TMenuItem
        Action = EditDeleteAction
      end
      object EditSeparator2MenuItem: TMenuItem
        Caption = '-'
      end
      object EditSelectAllMenuItem: TMenuItem
        Action = EditSelectAllAction
      end
      object EditSeparator3MenuItem: TMenuItem
        Caption = '-'
      end
      object EditFindMenuItem: TMenuItem
        Action = EditFindAction
      end
      object EditGoToMenuItem: TMenuItem
        Action = EditGoToAction
      end
    end
    object ViewMenuItem: TMenuItem
      Caption = '&'#1042#1080#1076
      object ViewFileTreeMenuItem: TMenuItem
        Action = ViewFileTreeAction
        AutoCheck = True
      end
      object ViewFileListMenuItem: TMenuItem
        Action = ViewFileListAction
      end
      object ViewSeparator1MenuItem: TMenuItem
        Caption = '-'
      end
      object ViewOutlineMenuItem: TMenuItem
        Action = ViewOutlineAction
      end
      object ViewSeparator2MenuItem: TMenuItem
        Caption = '-'
      end
      object ViewZoomUpMenuItem: TMenuItem
        Action = ViewZoomUpAction
      end
      object ViewZoomDownMenuItem: TMenuItem
        Action = ViewZoomDownAction
      end
      object ViewZoomMenuItem: TMenuItem
        Action = ViewZoomAction
      end
      object ViewSeparator3MenuItem: TMenuItem
        Caption = '-'
      end
      object ViewToolbarsMenuItem: TMenuItem
        Caption = #1055#1072#1085#1077#1083#1080' &'#1080#1085#1089#1090#1088#1091#1084#1077#1085#1090#1086#1074
        object ViewToolbarStandardMenuItem: TMenuItem
          Action = ViewToolbarStandardAction
          AutoCheck = True
        end
        object ViewToolbarConnectMenuItem: TMenuItem
          Action = ViewToolbarConnectAction
          AutoCheck = True
        end
        object ViewToolbarDataMenuItem: TMenuItem
          Action = ViewToolbarDataAction
          AutoCheck = True
        end
        object ViewToolbarReportMenuItem: TMenuItem
          Action = ViewToolbarReportAction
          AutoCheck = True
        end
      end
      object ViewSeparator4MenuItem: TMenuItem
        Caption = '-'
      end
      object ViewNavigateBackwardMenuItem: TMenuItem
        Action = ViewNavigateBackwardAction
      end
      object ViewNavigateForwardMenuItem: TMenuItem
        Action = ViewNavigateForwardAction
      end
    end
    object QueryMenuItem: TMenuItem
      Caption = '&'#1047#1072#1087#1088#1086#1089
      object QueryExecuteMenuItem: TMenuItem
        Action = QueryExecuteAction
      end
    end
    object DataMenuItem: TMenuItem
      Caption = '&'#1044#1072#1085#1085#1099#1077
      object DataFirstMenuItem: TMenuItem
        Action = DataFirstAction
      end
      object DataPreviousMenuItem: TMenuItem
        Action = DataPreviousAction
      end
      object DataNextMenuItem: TMenuItem
        Action = DataNextAction
      end
      object DataLastMenuItem: TMenuItem
        Action = DataLastAction
      end
      object DataSeparator1MenuItem: TMenuItem
        Caption = '-'
      end
      object DataNewRecordMenuItem: TMenuItem
        Action = DataNewRecordAction
      end
      object DataDeleteRecordMenuItem: TMenuItem
        Action = DataDeleteRecordAction
      end
      object DataSeparator2MenuItem: TMenuItem
        Caption = '-'
      end
      object DataSaveRecordMenuItem: TMenuItem
        Action = DataSaveRecordAction
      end
      object DataCancelInputMenuItem: TMenuItem
        Action = DataCancelInputAction
      end
    end
    object ToolsMenuItem: TMenuItem
      Caption = #1057'&'#1077#1088#1074#1080#1089
      object ToolsConnectMenuItem: TMenuItem
        Action = ToolsConnectAction
      end
      object ToolsDisconnectMenuItem: TMenuItem
        Action = ToolsDisconnectAction
      end
      object ToolsSeparator1MenuItem: TMenuItem
        Caption = '-'
      end
      object ToolsOptionsMenuItem: TMenuItem
        Action = ToolsOptionsAction
      end
    end
    object WindowMenuItem: TMenuItem
      Caption = '&'#1054#1082#1085#1086
      object WindowCascadeMenuItem: TMenuItem
        Action = WindowCascadeAction
      end
      object WindowTileHorizontalMenuItem: TMenuItem
        Action = WindowTileHorizontalAction
      end
      object WindowTileVerticalMenuItem: TMenuItem
        Action = WindowTileVerticalAction
      end
      object WindowMinimizeAllMenuItem: TMenuItem
        Action = WindowMinimizeAllAction
      end
      object WindowSeparator1MenuItem: TMenuItem
        Caption = '-'
      end
      object WindowCloseAllMenuItem: TMenuItem
        Action = WindowCloseAllAction
      end
      object WindowSeparator2MenuItem: TMenuItem
        Caption = '-'
      end
      object WindowWindowsMenuItem: TMenuItem
        Action = WindowWindowsAction
      end
    end
    object HelpMenuItem: TMenuItem
      Caption = #1057#1087#1088#1072'&'#1074#1082#1072
      object HelpContextMenuItem: TMenuItem
        Action = HelpContextAction
      end
      object HelpSeparator1MenuItem: TMenuItem
        Caption = '-'
      end
      object HelpAboutMenuItem: TMenuItem
        Action = HelpAboutAction
      end
    end
  end
  object XPManifest: TXPManifest
    Left = 120
    Top = 400
  end
  object ImageList: TImageList
    Left = 152
    Top = 400
  end
end
