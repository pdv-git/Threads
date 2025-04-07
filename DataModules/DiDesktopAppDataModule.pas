unit DiDesktopAppDataModule;

interface

uses
  SysUtils, Classes, Contnrs, DB, Forms, Variants,
  DiIConnection;

type
  TDesktopAppDataModule = class(TDataModule)
  private
    { Private declarations }
    FIConnection: IConnection;
    FServer: WideString;
    FDatabase: WideString;
    FUid: WideString;
    FPwd: WideString;
    FTrustedConnection: Boolean;
  protected
    { Protected declarations }
    procedure DoAfterConnect;
    procedure DoAfterDisconnect;
    procedure DoBeforeDisconnect;
    procedure OnAfterConnect(Sender: TObject);
    procedure OnAfterDisconnect(Sender: TObject);
    procedure OnBeforeDisconnect(Sender: TObject);
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Connect(const ALoginPrompt: Boolean);
    procedure Disconnect;
  end;

var
  DesktopAppDataModule: TDesktopAppDataModule;

implementation

{$R *.dfm}

uses
  DiDesktopAppWindow, DiFileTreeDockWindow,
  DiConnectionDialogBox, DiFileDataModule,
  DiType;

{ TCustomConnectionDataModule }

constructor TDesktopAppDataModule.Create(AOwner: TComponent);
begin
  inherited;
end;

destructor TDesktopAppDataModule.Destroy;
begin
  Disconnect;
  inherited;
end;

procedure TDesktopAppDataModule.Connect(const ALoginPrompt: Boolean);
var
  LConnectionType: TConnectionType;
  LConnectionString: WideString;
  LServer: WideString;
  LDatabase: WideString;
  LUid: WideString;
  LPwd: WideString;
  LTrustedConnection: Boolean;
begin
  if ALoginPrompt then
  begin
    if not TConnectionDialogBox.Run(LConnectionType, LConnectionString, LServer, LDatabase, LUid, LPwd, LTrustedConnection) then
      Exit;
  end
  else
    TConnectionDialogBox.GetConnectionString(LConnectionType, LConnectionString, LServer, LDatabase, LUid, LPwd, LTrustedConnection);

  //  Отключение от базы данных
  FIConnection := CreateIConnection(Self, LConnectionType);
  FIConnection.ConnectionString := LConnectionString;
  FIConnection.Connection.AfterConnect := OnAfterConnect;
  FIConnection.Connection.AfterDisconnect := OnAfterDisconnect;
  FIConnection.Connection.BeforeDisconnect := OnBeforeDisconnect;
  FServer := LServer;
  FDatabase := LDatabase;
  FUid := LUid;
  FPwd := LPwd;
  FTrustedConnection := LTrustedConnection;

  //  Подключение к базе данных
  FIConnection.Open;
end;

procedure TDesktopAppDataModule.Disconnect;
begin
  if FIConnection <> nil then
    FIConnection := nil;
  if Assigned(FileDataModule) then
    FreeAndNil(FileDataModule);
end;

procedure TDesktopAppDataModule.DoAfterConnect;
begin
  FileDataModule := TFileDataModule.Create(nil, FIConnection);
  DesktopAppWindow.Connect;
  FileTreeDockWindow.Connect;
//  if Assigned(FileListMdiWindow) then
//    FileListMdiWindow.Connect;
end;

procedure TDesktopAppDataModule.DoAfterDisconnect;
begin
  DesktopAppWindow.Disconnect;
  FileTreeDockWindow.Disconnect;
//  if Assigned(FileListMdiWindow) then
//    FileListMdiWindow.Disconnect;
end;

procedure TDesktopAppDataModule.DoBeforeDisconnect;
begin
//
end;

procedure TDesktopAppDataModule.OnAfterConnect(Sender: TObject);
begin
  DoAfterConnect;
end;

procedure TDesktopAppDataModule.OnAfterDisconnect(Sender: TObject);
begin
  DoAfterDisconnect;
end;

procedure TDesktopAppDataModule.OnBeforeDisconnect(Sender: TObject);
begin
  DoBeforeDisconnect;
end;

end.
