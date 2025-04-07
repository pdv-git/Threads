object ConnectionDialogBox: TConnectionDialogBox
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1057#1086#1077#1076#1080#1085#1077#1085#1080#1077' '#1089' SQL Server'
  ClientHeight = 254
  ClientWidth = 303
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object InformationLabel: TLabel
    Left = 12
    Top = 12
    Width = 264
    Height = 13
    Caption = #1069#1090#1086' '#1087#1086#1076#1082#1083#1102#1095#1077#1085#1080#1077' '#1090#1088#1077#1073#1091#1077#1090' '#1087#1086#1076#1088#1086#1073#1085#1086#1081' '#1080#1085#1092#1086#1088#1084#1072#1094#1080#1080'.'
  end
  object ServerLabel: TLabel
    Left = 12
    Top = 39
    Width = 41
    Height = 13
    Caption = #1057#1077'&'#1088#1074#1077#1088':'
    FocusControl = ServerEdit
  end
  object DatabaseLabel: TLabel
    Left = 12
    Top = 66
    Width = 69
    Height = 13
    Caption = #1041#1072#1079#1072' &'#1076#1072#1085#1085#1099#1093':'
    FocusControl = DatabaseEdit
  end
  object UserLabel: TLabel
    Left = 31
    Top = 141
    Width = 76
    Height = 13
    Caption = #1055#1086#1083#1100'&'#1079#1086#1074#1072#1090#1077#1083#1100':'
    FocusControl = UserEdit
  end
  object PasswordLabel: TLabel
    Left = 31
    Top = 168
    Width = 41
    Height = 13
    Caption = #1055#1072#1088#1086'&'#1083#1100':'
    FocusControl = PasswordEdit
  end
  object ServerEdit: TEdit
    Tag = 1
    Left = 90
    Top = 35
    Width = 200
    Height = 21
    TabOrder = 0
  end
  object DatabaseEdit: TEdit
    Tag = 2
    Left = 90
    Top = 62
    Width = 200
    Height = 21
    TabOrder = 1
  end
  object WindowsRadioButton: TRadioButton
    Tag = 3
    Left = 13
    Top = 92
    Width = 229
    Height = 17
    Caption = #1048#1089#1087#1086#1083#1100#1079#1091#1103' &Windows '#1048#1076#1077#1085#1090#1080#1092#1080#1082#1072#1094#1080#1102
    TabOrder = 2
    OnClick = OnWindowsRadioButtonClick
  end
  object SQLServerRadioButton: TRadioButton
    Tag = 4
    Left = 13
    Top = 113
    Width = 229
    Height = 17
    Caption = #1048#1089#1087#1086#1083#1100#1079#1091#1103' SQL &Server '#1048#1076#1077#1085#1090#1080#1092#1080#1082#1072#1094#1080#1102
    Checked = True
    TabOrder = 3
    TabStop = True
    OnClick = OnSQLServerRadioButtonClick
  end
  object UserEdit: TEdit
    Tag = 5
    Left = 116
    Top = 137
    Width = 174
    Height = 21
    TabOrder = 4
  end
  object PasswordEdit: TEdit
    Tag = 6
    Left = 116
    Top = 164
    Width = 174
    Height = 21
    AutoSize = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    PasswordChar = #8226
    TabOrder = 5
  end
  object SavePasswordCheckBox: TCheckBox
    Tag = 7
    Left = 116
    Top = 188
    Width = 149
    Height = 17
    Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' &'#1084#1086#1081' '#1087#1072#1088#1086#1083#1100
    TabOrder = 6
  end
  object AcceptButton: TButton
    Left = 134
    Top = 215
    Width = 75
    Height = 23
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 7
  end
  object CancelButton: TButton
    Left = 215
    Top = 215
    Width = 75
    Height = 23
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1072
    ModalResult = 2
    TabOrder = 8
  end
end
