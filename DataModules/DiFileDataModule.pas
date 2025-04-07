unit DiFileDataModule;

interface

uses
  SysUtils, Classes, Forms,
  DiIConnection, DiFileReaderDataModule,
  DiType;

type
  TFileDataModule = class(TDataModule)
  private
    { Private declarations }
    FFileReaderDataModule: TFileReaderDataModule;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; const AIConnection: IConnection);
    destructor Destroy; override;
    property FileReaderDataModule: TFileReaderDataModule read FFileReaderDataModule;
  end;

var
  FileDataModule: TFileDataModule;

implementation

{$R *.dfm}

{ TFileDataModule }

constructor TFileDataModule.Create(AOwner: TComponent;
  const AIConnection: IConnection);
begin
  inherited Create(AOwner);
  FFileReaderDataModule := TFileReaderDataModule.Create(nil, AIConnection);
end;

destructor TFileDataModule.Destroy;
begin
  if Assigned(FFileReaderDataModule) then
    FreeAndNil(FFileReaderDataModule);
  inherited;
end;

end.
