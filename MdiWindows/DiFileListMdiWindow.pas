unit DiFileListMdiWindow;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ExtCtrls, StdCtrls, ToolWin, Menus, ActnList,
  System.Actions;

type
  TFileListMdiWindow = class(TForm)
    PanelLeft: TPanel;
    Splitter: TSplitter;
    PanelRight: TPanel;
    procedure OnFormClose(Sender: TObject; var Action: TCloseAction);
    procedure OnFormResize(Sender: TObject);
    procedure OnPanelRightResize(Sender: TObject);
    procedure OnPanelLeftResize(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Connect;
    procedure Disconnect;
  end;

var
  FileListMdiWindow: TFileListMdiWindow;

implementation

{$R *.dfm}

function EnumChildProc(AHandle: HWND; lParam: LPARAM): BOOL; stdcall;
begin
  if GetParent(AHandle) = TPanel(lParam).Handle then
    MoveWindow(AHandle, 0, 0, TPanel(lParam).ClientWidth, TPanel(lParam).ClientHeight, True);
end;

{ TFileListMdiWindow }

constructor TFileListMdiWindow.Create(AOwner: TComponent);
begin
  inherited;
  Position := poDefault;
end;

destructor TFileListMdiWindow.Destroy;
begin
  FileListMdiWindow := nil;
  inherited;
end;

procedure TFileListMdiWindow.OnFormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TFileListMdiWindow.Connect;
begin
//
end;

procedure TFileListMdiWindow.Disconnect;
begin
//
end;

procedure TFileListMdiWindow.OnFormResize(Sender: TObject);
begin
  PanelLeft.Width := TForm(Sender).Width div 2;
end;

procedure TFileListMdiWindow.OnPanelLeftResize(Sender: TObject);
begin
  EnumChildWindows(PanelLeft.Handle, @EnumChildProc, LPARAM(PanelLeft));
end;

procedure TFileListMdiWindow.OnPanelRightResize(Sender: TObject);
begin
  EnumChildWindows(PanelRight.Handle, @EnumChildProc, LPARAM(PanelRight));
end;

end.
