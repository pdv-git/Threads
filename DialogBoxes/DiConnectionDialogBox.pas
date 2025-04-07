unit DiConnectionDialogBox;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,
  DiType;

type
  TConnectionDialogBox = class(TForm)
    InformationLabel: TLabel;
    ServerLabel: TLabel;
    DatabaseLabel: TLabel;
    UserLabel: TLabel;
    PasswordLabel: TLabel;
    ServerEdit: TEdit;
    DatabaseEdit: TEdit;
    WindowsRadioButton: TRadioButton;
    SQLServerRadioButton: TRadioButton;
    UserEdit: TEdit;
    PasswordEdit: TEdit;
    SavePasswordCheckBox: TCheckBox;
    AcceptButton: TButton;
    CancelButton: TButton;
    procedure OnWindowsRadioButtonClick(Sender: TObject);
    procedure OnSQLServerRadioButtonClick(Sender: TObject);
  private
    { Private declarations }
    class function GetIniFileName: string;
    class function CreateConnectionString(const AConnectionString: WideString): TStrings;
    class procedure LoadConnectionString(out AConnectionType: TConnectionType; out AConnectionString: WideString);
    procedure ReadConnectionString(const AConnectionString: WideString);
    procedure WriteConnectionString(var AConnectionString: WideString);
    procedure SaveConnectionString(AConnectionString: WideString);
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    class function Run(out AConnectionType: TConnectionType; out AConnectionString: WideString; out AServer: WideString;
      out ADatabase: WideString; out AUid: WideString; out APwd: WideString; out ATrustedConnection: Boolean): Boolean;
    class procedure GetConnectionString(out AConnectionType: TConnectionType; out AConnectionString: WideString; out AServer: WideString;
      out ADatabase: WideString; out AUid: WideString; out APwd: WideString; out ATrustedConnection: Boolean);
  end;

implementation

{$R *.dfm}

uses
  StrUtils, IniFiles, DB;

resourcestring
  SConnectionStringNotFound = 'Connection string not found.';
  SConnectionTypeNotFound = 'Connection type not found.';
  SConnectionTypeNotExist = 'Connection type must be <ADO> or <ODBC> or <CUSTOM>.';

const
  SConnectionSection = 'Connection';
  SConnectionType = 'ConnectionType';
  SADOConnectionType = 'ADO';
  SOdbcConnectionType = 'ODBC';
  SCustomConnectionType = 'CUSTOM';
  SConnectionString = 'ConnectionString';
  SServer = 'Server';
  SDatabase = 'Database';
  SUid = 'Uid';
  SPwd = 'Pwd';
  STrustedConnection = 'Trusted_Connection';

{ TConnectDialogBox }

constructor TConnectionDialogBox.Create(AOwner: TComponent);
begin
  inherited;
end;


destructor TConnectionDialogBox.Destroy;
begin
  inherited;
end;

procedure TConnectionDialogBox.OnWindowsRadioButtonClick(Sender: TObject);
begin
  UserEdit.Enabled := False;
  PasswordEdit.Enabled := False;
  SavePasswordCheckBox.Enabled := False;
end;

procedure TConnectionDialogBox.OnSQLServerRadioButtonClick(Sender: TObject);
begin
  UserEdit.Enabled := True;
  PasswordEdit.Enabled := True;
  SavePasswordCheckBox.Enabled := True;
end;

class function TConnectionDialogBox.Run(out AConnectionType: TConnectionType; out AConnectionString: WideString; out AServer: WideString;
  out ADatabase: WideString; out AUid: WideString; out APwd: WideString; out ATrustedConnection: Boolean): Boolean;
var
  LConnectionDialogBox: TConnectionDialogBox;
  LConnectionString: WideString;
begin
  Result := False;
  LConnectionDialogBox := TConnectionDialogBox.Create(nil);
  try
    LConnectionDialogBox.LoadConnectionString(AConnectionType, LConnectionString);
    LConnectionDialogBox.ReadConnectionString(LConnectionString);
            
    if LConnectionDialogBox.ShowModal = mrOk then
    begin
      Result := True;
      LConnectionDialogBox.WriteConnectionString(LConnectionString);
      LConnectionDialogBox.SaveConnectionString(LConnectionString);

      AConnectionString := LConnectionString;
      AServer := LConnectionDialogBox.ServerEdit.Text;
      ADatabase := LConnectionDialogBox.DatabaseEdit.Text;
      AUid := LConnectionDialogBox.UserEdit.Text;
      APwd := LConnectionDialogBox.PasswordEdit.Text;
      ATrustedConnection := LConnectionDialogBox.WindowsRadioButton.Checked;
    end;
  finally
    LConnectionDialogBox.Free;
  end;
end;

class procedure TConnectionDialogBox.GetConnectionString(out AConnectionType: TConnectionType; out AConnectionString: WideString; out AServer: WideString;
  out ADatabase: WideString; out AUid: WideString; out APwd: WideString; out ATrustedConnection: Boolean);
  procedure LReadConnectionString(const AConnectionString: WideString; out AServer: WideString;
    out ADatabase: WideString; out AUid: WideString; out APwd: WideString; out ATrustedConnection: Boolean);
  var
    LConnectionString: TStrings;
    LName: WideString;
    I: Integer;
  begin
    LConnectionString := CreateConnectionString(AConnectionString);
    try
      for I := 0 to LConnectionString.Count - 1 do
      begin
        LName := LConnectionString.Names[I];
        if AnsiSameText(LName, SServer) then                  AServer := LConnectionString.ValueFromIndex[I]
        else if AnsiSameText(LName, SDatabase) then           ADatabase := LConnectionString.ValueFromIndex[I]
        else if AnsiSameText(LName, SUid) then                AUid := LConnectionString.ValueFromIndex[I]
        else if AnsiSameText(LName, SPwd) then                APwd := LConnectionString.ValueFromIndex[I]
        else if AnsiSameText(LName, STrustedConnection) then  ATrustedConnection := AnsiSameText(LConnectionString.ValueFromIndex[I], 'Yes');
      end;
    finally
      LConnectionString.Free;
    end;
  end;
begin
  LoadConnectionString(AConnectionType, AConnectionString);
  LReadConnectionString(AConnectionString, AServer, ADatabase, AUid, APwd, ATrustedConnection);
end;

class procedure TConnectionDialogBox.LoadConnectionString(out AConnectionType: TConnectionType; out AConnectionString: WideString);
var
  LIniFile: TIniFile;
  LConnectionType: WideString;
begin
  LIniFile := TIniFile.Create(GetIniFileName);
  try
    AConnectionString := LIniFile.ReadString(SConnectionSection, SConnectionString, '');
    if AConnectionString = EmptyWideStr then
      DatabaseError(SConnectionStringNotFound);
    LConnectionType := LIniFile.ReadString(SConnectionSection, SConnectionType, '');
    if LConnectionType = EmptyWideStr then
      DatabaseError(SConnectionTypeNotFound)
    else if AnsiSameText(LConnectionType, SADOConnectionType) then
      AConnectionType := ctADO
    else if AnsiSameText(LConnectionType, SOdbcConnectionType) then
      AConnectionType := ctODBC
    else if AnsiSameText(LConnectionType, SCustomConnectionType) then
      AConnectionType := ctCUSTOM
    else
      DatabaseError(SConnectionTypeNotExist);
  finally
    LIniFile.Free;
  end;
end;

class function TConnectionDialogBox.GetIniFileName: string;
begin
  Result := ChangeFileExt(Application.ExeName, '.ini');
end;

class function TConnectionDialogBox.CreateConnectionString(const AConnectionString: WideString): TStrings;
begin
  Result := TStringList.Create;
  Result.LineBreak := ';';
  Result.Text := AConnectionString;
end;

procedure TConnectionDialogBox.ReadConnectionString(const AConnectionString: WideString);
var
  LConnectionString: TStrings;
  LName: WideString;
  I: Integer;
begin
  LConnectionString := CreateConnectionString(AConnectionString);
  try
    for I := 0 to LConnectionString.Count - 1 do
    begin
      LName := LConnectionString.Names[I];
      if AnsiSameText(LName, SServer) then                  ServerEdit.Text := LConnectionString.ValueFromIndex[I]
      else if AnsiSameText(LName, SDatabase) then           DatabaseEdit.Text := LConnectionString.ValueFromIndex[I]
      else if AnsiSameText(LName, SUid) then                UserEdit.Text := LConnectionString.ValueFromIndex[I]
      else if AnsiSameText(LName, SPwd) then                PasswordEdit.Text := LConnectionString.ValueFromIndex[I]
      else if AnsiSameText(LName, STrustedConnection) then  WindowsRadioButton.Checked := AnsiSameText(LConnectionString.ValueFromIndex[I], 'Yes');
    end;
    SavePasswordCheckBox.Checked := PasswordEdit.Text <> '';
  finally
    LConnectionString.Free;
  end;
end;

procedure TConnectionDialogBox.WriteConnectionString(var AConnectionString: WideString);
var
  LConnectionString: TStrings;
  LName: WideString;
  I: Integer;
begin
  LConnectionString := CreateConnectionString(AConnectionString);
  try
    for I := 0 to LConnectionString.Count - 1 do
    begin
      LName := LConnectionString.Names[I];
      if AnsiSameText(LName, SServer) then                  LConnectionString[I] := LName + LConnectionString.NameValueSeparator + ServerEdit.Text
      else if AnsiSameText(LName, SDatabase) then           LConnectionString[I] := LName + LConnectionString.NameValueSeparator + DatabaseEdit.Text //LConnectionString.ValueFromIndex[I] := EditDatabase.Text
      else if AnsiSameText(LName, SUid) then                LConnectionString[I] := LName + LConnectionString.NameValueSeparator + UserEdit.Text //LConnectionString.ValueFromIndex[I] := EditUser.Text
      else if AnsiSameText(LName, SPwd) then                LConnectionString[I] := LName + LConnectionString.NameValueSeparator + PasswordEdit.Text //LConnectionString.ValueFromIndex[I] := EditPassword.Text //IfThen(CheckBoxSavePassword.Checked, EditPassword.Text, '')
      else if AnsiSameText(LName, STrustedConnection) then  LConnectionString[I] := LName + LConnectionString.NameValueSeparator + IfThen(WindowsRadioButton.Checked, 'Yes', 'No'); //LConnectionString.ValueFromIndex[I] := IfThen(RadioButtonWindows.Checked, 'Yes', 'No');
    end;
    AConnectionString := LConnectionString.Text;
  finally
    LConnectionString.Free;
  end;
end;

procedure TConnectionDialogBox.SaveConnectionString(AConnectionString: WideString);
  procedure LHidePasswordConnectionString(var AConnectionString: WideString);
  var
    LConnectionString: TStrings;
    LName: WideString;
    I: Integer;
  begin
    LConnectionString := CreateConnectionString(AConnectionString);
    try
      for I := 0 to LConnectionString.Count - 1 do
      begin
        LName := LConnectionString.Names[I];
        if AnsiSameText(LName, SPwd) then
          LConnectionString[I] := LName + LConnectionString.NameValueSeparator + EmptyWideStr;
      end;
      AConnectionString := LConnectionString.Text;
    finally
      LConnectionString.Free;
    end;
  end;
var
  LIniFile: TIniFile;
begin
  LIniFile := TIniFile.Create(GetIniFileName);
  try
    if not SavePasswordCheckBox.Checked then
      LHidePasswordConnectionString(AConnectionString);
    LIniFile.WriteString(SConnectionSection, SConnectionString, AConnectionString)
  finally
    LIniFile.Free;
  end;
end;

end.
