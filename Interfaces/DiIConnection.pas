unit DiIConnection;

interface

uses
  Classes, SysUtils, DB, //ADODB,
  DiType;

type

{ IConnection }

  IConnection = interface
    ['{9F5AAA8D-076A-4466-A12E-714B6A144DEA}']
    procedure BeginTrans;
    procedure Close;
    procedure CommitTrans;
    function GetConnection: TCustomConnection;
    function GetConnectionString: WideString;
    function GetConnectionTimeout: Cardinal;
    function GetConnectionType: TConnectionType;
    function GetInTransaction: Boolean;
    function GetNeedCommit: Boolean;
    procedure Open;
    procedure RollbackTrans;
    procedure SetConnectionString(const Value: WideString);
    procedure SetConnectionTimeout(const Value: Cardinal);
    procedure SetNeedCommit(const Value: Boolean);
    property Connection: TCustomConnection read GetConnection;
    property ConnectionString: WideString read GetConnectionString write SetConnectionString;
    property ConnectionTimeout: Cardinal read GetConnectionTimeout write SetConnectionTimeout;
    property ConnectionType: TConnectionType read GetConnectionType;
    property InTransaction: Boolean read GetInTransaction;
    property NeedCommit: Boolean read GetNeedCommit write SetNeedCommit;
  end;

{ TIADOConnection }

//  TIADOConnection = class (TInterfacedObject, IConnection)
//  private
//    { Private declarations }
//    FConnection: TADOConnection;
//    FConnectionString: WideString;
//    FNeedCommit: Boolean;
//    procedure BeginTrans;
//    procedure Close;
//    procedure CommitTrans;
//    function GetConnection: TCustomConnection;
//    function GetConnectionString: WideString;
//    function GetConnectionTimeout: Cardinal;
//    function GetConnectionType: TConnectionType;
//    function GetInTransaction: Boolean;
//    function GetNeedCommit: Boolean;
//    procedure Open;
//    procedure RollbackTrans;
//    procedure SetConnectionString(const Value: WideString);
//    procedure SetConnectionTimeout(const Value: Cardinal);
//    procedure SetNeedCommit(const Value: Boolean);
//  public
//    { Public declarations }
//    constructor Create(AOwner: TComponent);
//    destructor Destroy; override;
//  end;

{ TICustomConnection }

  TICustomConnection = class (TInterfacedObject, IConnection)
  private
    { Private declarations }
    FConnection: TCustomConnection;
    FConnectionString: WideString;
    procedure BeginTrans;
    procedure Close;
    procedure CommitTrans;
    function GetConnection: TCustomConnection;
    function GetConnectionString: WideString;
    function GetConnectionTimeout: Cardinal;
    function GetConnectionType: TConnectionType;
    function GetInTransaction: Boolean;
    function GetNeedCommit: Boolean;
    procedure Open;
    procedure RollbackTrans;
    procedure SetConnectionString(const Value: WideString);
    procedure SetConnectionTimeout(const Value: Cardinal);
    procedure SetNeedCommit(const Value: Boolean);
  public
    { Public declarations }
    constructor Create(AOwner: TComponent);
    destructor Destroy; override;
  end;

  function CreateIConnection(AOwner: TComponent;
    const AConnectionType: TConnectionType): IConnection;

implementation

function CreateIConnection(AOwner: TComponent;
  const AConnectionType: TConnectionType): IConnection;
begin
  case AConnectionType of
//    ctADO: Result := TIADOConnection.Create(AOwner);
    ctCustom: Result := TICustomConnection.Create(AOwner);
  end;
end;

{ TIADOConnection }

//constructor TIADOConnection.Create(AOwner: TComponent);
//begin
//  inherited Create;
//  FConnection := TADOConnection.Create(AOwner);
//  FConnection.LoginPrompt := False;
//end;
//
//destructor TIADOConnection.Destroy;
//begin
//  if Assigned(FConnection) then
//    FreeAndNil(FConnection);
//  inherited;
//end;
//
//procedure TIADOConnection.BeginTrans;
//begin
//  FConnection.BeginTrans;
//end;
//
//procedure TIADOConnection.Close;
//begin
//  FConnection.Close;
//end;
//
//procedure TIADOConnection.CommitTrans;
//begin
//  FConnection.CommitTrans;
//end;
//
//function TIADOConnection.GetConnection: TCustomConnection;
//begin
//  Result := FConnection;
//end;
//
//function TIADOConnection.GetConnectionString: WideString;
//begin
//  Result := FConnectionString;
//end;
//
//function TIADOConnection.GetConnectionTimeout: Cardinal;
//begin
//  Result := FConnection.ConnectionTimeout;
//end;
//
//function TIADOConnection.GetConnectionType: TConnectionType;
//begin
//  Result := ctADO;
//end;
//
//function TIADOConnection.GetInTransaction: Boolean;
//begin
//  Result := FConnection.InTransaction;
//end;
//
//function TIADOConnection.GetNeedCommit: Boolean;
//begin
//  if FConnection.InTransaction then
//    Result := FNeedCommit
//  else
//    Result := False;
//end;
//
//procedure TIADOConnection.Open;
//begin
//  FConnection.Open;
//end;
//
//procedure TIADOConnection.RollbackTrans;
//begin
//  FConnection.RollbackTrans;
//end;
//
//procedure TIADOConnection.SetConnectionString(const Value: WideString);
//begin
//  FConnectionString := Value;
//  FConnection.ConnectionString := Value;
//end;
//
//procedure TIADOConnection.SetConnectionTimeout(const Value: Cardinal);
//begin
//  FConnection.ConnectionTimeout := Value;
//end;
//
//procedure TIADOConnection.SetNeedCommit(const Value: Boolean);
//begin
//  FNeedCommit := Value;
//end;

{ TICustomConnection }

constructor TICustomConnection.Create(AOwner: TComponent);
begin
  inherited Create;
  FConnection := TCustomConnection.Create(AOwner);
  FConnection.LoginPrompt := False;
end;

destructor TICustomConnection.Destroy;
begin
  if Assigned(FConnection) then
    FreeAndNil(FConnection);
  inherited;
end;

procedure TICustomConnection.BeginTrans;
begin
//
end;

procedure TICustomConnection.Close;
begin
  FConnection.Close;
end;

procedure TICustomConnection.CommitTrans;
begin
//
end;

function TICustomConnection.GetConnection: TCustomConnection;
begin
  Result := FConnection;
end;

function TICustomConnection.GetConnectionString: WideString;
begin
  Result := FConnectionString;
end;

function TICustomConnection.GetConnectionTimeout: Cardinal;
begin
  Result := 0;
end;

function TICustomConnection.GetConnectionType: TConnectionType;
begin
  Result := ctCUSTOM;
end;

function TICustomConnection.GetInTransaction: Boolean;
begin
  Result := False;
end;

function TICustomConnection.GetNeedCommit: Boolean;
begin
  Result := False;
end;

procedure TICustomConnection.Open;
begin
  FConnection.Open;
end;

procedure TICustomConnection.RollbackTrans;
begin
//
end;

procedure TICustomConnection.SetConnectionString(const Value: WideString);
begin
  FConnectionString := Value;
end;

procedure TICustomConnection.SetConnectionTimeout(const Value: Cardinal);
begin
//
end;

procedure TICustomConnection.SetNeedCommit(const Value: Boolean);
begin
//
end;

end.
