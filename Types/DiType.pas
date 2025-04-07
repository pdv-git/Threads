unit DiType;

interface

uses
  SysUtils, Classes;

type

{ Misc types }

  TConnectionType = (ctADO = 1, ctODBC, ctCUSTOM);

  TConnectionRecordPtr = ^TConnectionRecord;
  TConnectionRecord = packed record
    Id: Variant;
    Name: WideString;
    Description: Variant;
    ConnectionTypeId: TConnectionType;
    ConnectionString: WideString;
    ConnectionTimeout: Byte;
    AfterConnectCommands: WideString;
    BeforeDisconnectCommands: WideString;
  end;

  TFileType = (ftDatabase = -1, ftCatalog, ftDocument, ftForm, ftReport, ftScript, ftModule);

  TFileRecordPtr = ^TFileRecord;
  TFileRecord = packed record
    Id: Variant;
    CatalogId: Variant;
    FileType: TFileType;
    Name: string;
    Xml: string;
    IsEmpty: Boolean;
  end;

const

{ ConnectionTypeNames }

  ConnectionTypeNames: array[TConnectionType] of WideString = (
    'ADO', 'ODBC', 'CUSTOM');

{ FileTypeNames }

  FileTypeNames: array[TFileType] of WideString = (
    'База данных', 'Папка', 'Документ', 'Форма', 'Отчет', 'Скрипт', 'Модуль');

implementation

end.
