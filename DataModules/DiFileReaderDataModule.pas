unit DiFileReaderDataModule;

interface

uses
  SysUtils, Classes, Windows, Forms, DB, XMLDoc, XMLIntf,
  DiIConnection, DiType;

type
  TFileReaderDataModule = class(TDataModule)
  private
    { Private declarations }
    FConnection: IConnection;
    function GetFileInfo(const AFileName: string): string;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; const AIConnection: IConnection);
    destructor Destroy; override;
    procedure GetCatalogList(const ACatalogName: string; const ACatalogList: TList);
    procedure GetFileList(const ACatalogName: string; const AFileList: TList);
    function GetFileTaskList(const AFileName: string; const AFileInfo: string; const AFileTaskList: TList): string;
  end;

implementation

{$R *.dfm}

{ TFileReaderDataModule }

constructor TFileReaderDataModule.Create(AOwner: TComponent;
  const AIConnection: IConnection);
begin
  inherited Create(AOwner);
  FConnection := AIConnection;
end;

destructor TFileReaderDataModule.Destroy;
begin
  inherited;
end;

function TFileReaderDataModule.GetFileInfo(const AFileName: string): string;
type
  TFileInfoProc = function : PChar; stdcall;
const
  SFileInfoProc = 'FileInfo';
var
  LModule: HModule;
  LFileInfoProc: TFileInfoProc;
begin
  Result := '';
  LModule := LoadLibrary(PChar(AFileName));
  if LModule <> 0 then
  try
    @LFileInfoProc := GetProcAddress(LModule, SFileInfoProc);
    if @LFileInfoProc <> nil then
      Result := LFileInfoProc();
  finally
    FreeLibrary(LModule);
  end;
end;

procedure TFileReaderDataModule.GetCatalogList(const ACatalogName: string;
  const ACatalogList: TList);
var
  LFindFile: THandle;
  LFindFileData: WIN32_FIND_DATA;
  LFileName: string;
  LFileRecordPtr: TFileRecordPtr;
begin
  LFindFile := FindFirstFile(PChar(ACatalogName + '\*'), LFindFileData);
  if LFindFile <> INVALID_HANDLE_VALUE then
  try
    repeat
      if LFindFileData.dwFileAttributes = FILE_ATTRIBUTE_DIRECTORY then
      begin
        LFileName := string(LFindFileData.cFileName);
        if (LFileName = '.') or (LFileName  = '..') then
          Continue;

        New(LFileRecordPtr);
        with LFileRecordPtr^ do
        begin
          Id := ACatalogName + '\' + LFileName;
          CatalogId := ACatalogName;
          FileType := ftCatalog;
          Name := LFileName;
          Xml := EmptyStr;
          IsEmpty := False;
        end;
        ACatalogList.Add(LFileRecordPtr);
      end;
    until not FindNextFile(LFindFile, LFindFileData);
  finally
    FindClose(LFindFile);
  end;
end;

procedure TFileReaderDataModule.GetFileList(const ACatalogName: string;
  const AFileList: TList);
var
  LFindFile: THandle;
  LFindFileData: WIN32_FIND_DATA;
  LFileName: string;
  LFileRecordPtr: TFileRecordPtr;
begin
  LFindFile := FindFirstFile(PChar(ACatalogName + '\*.dll'), LFindFileData);
  if LFindFile <> INVALID_HANDLE_VALUE then
  try
    repeat
      if LFindFileData.dwFileAttributes <> FILE_ATTRIBUTE_DIRECTORY then
      begin
        LFileName := string(LFindFileData.cFileName);

        New(LFileRecordPtr);
        with LFileRecordPtr^ do
        begin
          Id := ACatalogName + '\' + LFileName;
          CatalogId := ACatalogName;
          FileType := ftModule;
          Name := LFileName;
          Xml := GetFileInfo(Id);
          IsEmpty := False;
        end;
        AFileList.Add(LFileRecordPtr);
      end;
    until not FindNextFile(LFindFile, LFindFileData);
  finally
    FindClose(LFindFile);
  end;
end;

function TFileReaderDataModule.GetFileTaskList(const AFileName: string;
  const AFileInfo: string; const AFileTaskList: TList): string;
var
  LXMLDocument: IXMLDocument;
  LXMLNode: IXMLNode;
  LXMLNodeList1, LXMLNodeList2: IXMLNodeList;
  LFileRecordPtr: TFileRecordPtr;
  I, J: Integer;
begin
  LXMLDocument := TXMLDocument.Create(nil);
  try
    LXMLDocument.LoadFromXML(AFileInfo);
    LXMLNode := LXMLDocument.DocumentElement;
    if Assigned(LXMLNode) then
    begin
      LXMLNodeList1 := LXMLNode.ChildNodes;
      for I := 0 to LXMLNodeList1.Count - 1 do
        if LXMLNodeList1[I].NodeName = 'parameters' then
        begin
          LXMLNodeList2 := LXMLNodeList1[I].ChildNodes;
          for J := 0 to LXMLNodeList2.Count - 1 do
            if LXMLNodeList2[J].NodeName = 'parameter' then
              if LXMLNodeList2[J].Attributes['name'] = 'AppWindowHandle' then
                LXMLNodeList2[J].Attributes['value'] := Application.MainFormHandle
              else if LXMLNodeList2[J].Attributes['name'] = 'ConnectionString' then
                LXMLNodeList2[J].Attributes['value'] := FConnection.ConnectionString;
        end
        else if LXMLNodeList1[I].NodeName = 'commands' then
        begin
          LXMLNodeList2 := LXMLNodeList1[I].ChildNodes;
          for J := 0 to LXMLNodeList2.Count - 1 do
            if LXMLNodeList2[J].NodeName = 'command' then
            begin
              New(LFileRecordPtr);
              with LFileRecordPtr^ do
              begin
                Id := LXMLNodeList2[J].Attributes['procedure'];
                CatalogId := AFileName;
                FileType := ftForm;
                Name := LXMLNodeList2[J].Attributes['name'];
                Xml := EmptyStr;
                IsEmpty := True;
              end;
              AFileTaskList.Add(LFileRecordPtr);
            end;
        end;
    end;
  finally
    LXMLDocument.SaveToXML(Result);
    LXMLDocument := nil;
  end;
end;

end.
