unit DiDesktopAppWindow;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  XPMan, Dialogs, StdActns, ActnList, Menus, StdCtrls, ExtCtrls, ComCtrls,
  ImgList, ToolWin,
  DiGdiplusImageList, DiCtrlComboBox, System.ImageList, System.Actions;

{$I DiDesktopAppWindow.inc}

const
  WM_USERCONNECT = WM_USER + 1;

type
  TDesktopAppWindow = class(TForm)
    XPManifest: TXPManifest;
    ImageList: TImageList;
    ActionList: TActionList;
    FileNewAction: TAction;
    FileOpenAction: TAction;
    FileCloseAction: TWindowClose;
    FileSaveAction: TAction;
    FileSaveAsAction: TAction;
    FilePageSetupAction: TAction;
    FilePrintPreviewAction: TAction;
    FilePrintAction: TAction;
    FileExitAction: TFileExit;
    EditUndoAction: TEditUndo;
    EditCutAction: TEditCut;
    EditCopyAction: TEditCopy;
    EditPasteAction: TEditPaste;
    EditDeleteAction: TEditDelete;
    EditSelectAllAction: TEditSelectAll;
    EditFindAction: TAction;
    EditGoToAction: TAction;
    ViewFileTreeAction: TAction;
    ViewFileListAction: TAction;
    ViewOutlineAction: TAction;
    ViewZoomUpAction: TAction;
    ViewZoomDownAction: TAction;
    ViewZoomAction: TAction;
    ViewToolbarStandardAction: TAction;
    ViewToolbarConnectAction: TAction;
    ViewToolbarDataAction: TAction;
    ViewToolbarReportAction: TAction;
    ViewNavigateBackwardAction: TAction;
    ViewNavigateForwardAction: TAction;
    DataFirstAction: TAction;
    DataPreviousAction: TAction;
    DataNextAction: TAction;
    DataLastAction: TAction;
    DataNewRecordAction: TAction;
    DataDeleteRecordAction: TAction;
    DataSaveRecordAction: TAction;
    DataCancelInputAction: TAction;
    QueryExecuteAction: TAction;
    ToolsConnectAction: TAction;
    ToolsDisconnectAction: TAction;
    ToolsOptionsAction: TAction;
    WindowCascadeAction: TWindowCascade;
    WindowTileHorizontalAction: TWindowTileHorizontal;
    WindowTileVerticalAction: TWindowTileVertical;
    WindowMinimizeAllAction: TWindowMinimizeAll;
    WindowCloseAllAction: TAction;
    WindowWindowsAction: TAction;
    HelpContextAction: TAction;
    HelpAboutAction: TAction;
    MainMenu: TMainMenu;
    FileMenuItem: TMenuItem;
    FileNewMenuItem: TMenuItem;
    FileOpenMenuItem: TMenuItem;
    FileCloseMenuItem: TMenuItem;
    FileSeparator1MenuItem: TMenuItem;
    FileSaveMenuItem: TMenuItem;
    FileSaveAsMenuItem: TMenuItem;
    FileSeparator2MenuItem: TMenuItem;
    FilePageSetupMenuItem: TMenuItem;
    FilePrintPreviewMenuItem: TMenuItem;
    FilePrintMenuItem: TMenuItem;
    FileSeparator3MenuItem: TMenuItem;
    FileExitMenuItem: TMenuItem;
    EditMenuItem: TMenuItem;
    EditUndoMenuItem: TMenuItem;
    EditSeparator1MenuItem: TMenuItem;
    EditCutMenuItem: TMenuItem;
    EditCopyMenuItem: TMenuItem;
    EditPasteMenuItem: TMenuItem;
    EditDeleteMenuItem: TMenuItem;
    EditSeparator2MenuItem: TMenuItem;
    EditSelectAllMenuItem: TMenuItem;
    EditSeparator3MenuItem: TMenuItem;
    EditFindMenuItem: TMenuItem;
    EditGoToMenuItem: TMenuItem;
    ViewMenuItem: TMenuItem;
    ViewFileTreeMenuItem: TMenuItem;
    ViewFileListMenuItem: TMenuItem;
    ViewSeparator1MenuItem: TMenuItem;
    ViewOutlineMenuItem: TMenuItem;
    ViewSeparator2MenuItem: TMenuItem;
    ViewZoomUpMenuItem: TMenuItem;
    ViewZoomDownMenuItem: TMenuItem;
    ViewZoomMenuItem: TMenuItem;
    ViewSeparator3MenuItem: TMenuItem;
    ViewToolbarsMenuItem: TMenuItem;
    ViewToolbarStandardMenuItem: TMenuItem;
    ViewToolbarConnectMenuItem: TMenuItem;
    ViewToolbarDataMenuItem: TMenuItem;
    ViewToolbarReportMenuItem: TMenuItem;
    ViewSeparator4MenuItem: TMenuItem;
    ViewNavigateBackwardMenuItem: TMenuItem;
    ViewNavigateForwardMenuItem: TMenuItem;
    QueryMenuItem: TMenuItem;
    QueryExecuteMenuItem: TMenuItem;
    DataMenuItem: TMenuItem;
    DataFirstMenuItem: TMenuItem;
    DataPreviousMenuItem: TMenuItem;
    DataNextMenuItem: TMenuItem;
    DataLastMenuItem: TMenuItem;
    DataSeparator1MenuItem: TMenuItem;
    DataNewRecordMenuItem: TMenuItem;
    DataDeleteRecordMenuItem: TMenuItem;
    DataSeparator2MenuItem: TMenuItem;
    DataSaveRecordMenuItem: TMenuItem;
    DataCancelInputMenuItem: TMenuItem;
    ToolsMenuItem: TMenuItem;
    ToolsConnectMenuItem: TMenuItem;
    ToolsDisconnectMenuItem: TMenuItem;
    ToolsSeparator1MenuItem: TMenuItem;
    ToolsOptionsMenuItem: TMenuItem;
    WindowMenuItem: TMenuItem;
    WindowCascadeMenuItem: TMenuItem;
    WindowTileHorizontalMenuItem: TMenuItem;
    WindowTileVerticalMenuItem: TMenuItem;
    WindowMinimizeAllMenuItem: TMenuItem;
    WindowSeparator1MenuItem: TMenuItem;
    WindowCloseAllMenuItem: TMenuItem;
    WindowSeparator2MenuItem: TMenuItem;
    WindowWindowsMenuItem: TMenuItem;
    HelpMenuItem: TMenuItem;
    HelpContextMenuItem: TMenuItem;
    HelpSeparator1MenuItem: TMenuItem;
    HelpAboutMenuItem: TMenuItem;
    ControlBar: TControlBar;
    ConnectToolBar: TToolBar;
    ConnectToolButton: TToolButton;
    ConnectDisconnectToolButton: TToolButton;
    StandardToolBar: TToolBar;
    StandardFileNewToolButton: TToolButton;
    StandardFileOpenToolButton: TToolButton;
    StandardFileSaveToolButton: TToolButton;
    StandardSeparator1ToolButton: TToolButton;
    StandardFilePrintToolButton: TToolButton;
    StandardPrintPreviewToolButton: TToolButton;
    StandardSeparator2ToolButton: TToolButton;
    StandardNavigateBackwardToolButton: TToolButton;
    StandardNavigateForwardToolButton: TToolButton;
    StandardSeparator3ToolButton: TToolButton;
    StandardFileTreeToolButton: TToolButton;
    StandardFileListToolButton: TToolButton;
    StandardSeparator4ToolButton: TToolButton;
    StandardFileClosePanel: TPanel;
    StandardFileCloseToolBar: TToolBar;
    StandardFileCloseToolButton: TToolButton;
    ReportToolBar: TToolBar;
    ReportOutlineToolButton: TToolButton;
    ReportSeparator1ToolButton: TToolButton;
    ReportZoomUpToolButton: TToolButton;
    ReportScalePanel: TPanel;
    ReportScaleComboBox: TComboBox;
    ReportZoomDownToolButton: TToolButton;
    DataToolBar: TToolBar;
    DataQueryExecuteToolButton: TToolButton;
    DataSeparator1ToolButton: TToolButton;
    DataSaveRecordToolButton: TToolButton;
    DataCancelInputToolButton: TToolButton;
    DataSeparator2ToolButton: TToolButton;
    DataFirstToolButton: TToolButton;
    DataPreviousToolButton: TToolButton;
    DataSeparator3ToolButton: TToolButton;
    DataRecordPanel: TPanel;
    DataRecordLabel: TLabel;
    DataRecordEdit: TEdit;
    DataSeparator4ToolButton: TToolButton;
    DataNextToolButton: TToolButton;
    DataLastToolButton: TToolButton;
    DataSeparator5ToolButton: TToolButton;
    DataNewRecordToolButton: TToolButton;
    DataDeleteRecordToolButton: TToolButton;
    DockPanel: TPanel;
    DockSplitter: TSplitter;
    StatusBar: TStatusBar;
    procedure OnFormShow(Sender: TObject);
    procedure OnControlBarBandPaint(Sender: TObject; Control: TControl;
      Canvas: TCanvas; var ARect: TRect; var Options: TBandPaintOptions);
    procedure OnViewFileListActionExecute(Sender: TObject);
    procedure OnViewFileTreeActionExecute(Sender: TObject);
    procedure OnToolsConnectActionExecute(Sender: TObject);
    procedure OnToolsDisconnectActionExecute(Sender: TObject);
  private
    { Private declarations }
    procedure WMUserConnect(var Message: TMessage); message WM_USERCONNECT;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Connect;
    procedure Disconnect;
  end;

var
  DesktopAppWindow: TDesktopAppWindow;

implementation

{$R *.dfm}

uses
  DiDesktopAppDataModule, DiFixVistaAlt, DiFileListMdiWindow;

{ TDesktopAppWindow }

constructor TDesktopAppWindow.Create(AOwner: TComponent);
var
  LResId: WORD;
begin
  inherited;
  TFixVistaAlt.Create(Self);
{$IF CompilerVersion >= 23)}
  DoubleBuffered := False;
  ControlBar.DoubleBuffered	:= False;
	ConnectToolBar.DoubleBuffered := False;
	StandardToolBar.DoubleBuffered := False;      //  TODO: Проблема при отрисовке с двойной буфферицацией в 10.3
  StandardFileCloseToolBar.DoubleBuffered := False;
	ReportToolBar.DoubleBuffered := False;
	DataToolBar.DoubleBuffered := False;
{$ELSE}
  DoubleBuffered := True;
  ControlBar.DoubleBuffered	:= True;
	ConnectToolBar.DoubleBuffered := True;
	StandardToolBar.DoubleBuffered := True;
  StandardFileCloseToolBar.DoubleBuffered := True;
	ReportToolBar.DoubleBuffered := True;
	DataToolBar.DoubleBuffered := True;
{$IFEND}
  for LResId := 1 + ImageOffset to ImageCount + ImageOffset do
    ImageList.AddBitmap(HInstance, LResId);
	ViewFileTreeMenuItem.ImageIndex := -1;
	ViewFileListMenuItem.ImageIndex := -1;
end;

destructor TDesktopAppWindow.Destroy;
begin
  inherited;
end;

procedure TDesktopAppWindow.Connect;
begin
  ToolsDisconnectAction.Enabled := True;
end;

procedure TDesktopAppWindow.Disconnect;
begin
  ToolsDisconnectAction.Enabled := False;
end;

procedure TDesktopAppWindow.WMUserConnect(var Message: TMessage);
begin
  LockWindowUpdate(0);
  DesktopAppDataModule.Connect(
//{$IFDEF DEBUG}
//    False
//{$ELSE}
    True
//{$ENDIF DEBUG}
  );
end;

procedure TDesktopAppWindow.OnFormShow(Sender: TObject);
begin
//  LockWindowUpdate(Handle);
  PostMessage(Handle, WM_USERCONNECT, 0, 0);
end;

procedure TDesktopAppWindow.OnControlBarBandPaint(Sender: TObject;
  Control: TControl; Canvas: TCanvas; var ARect: TRect;
  var Options: TBandPaintOptions);
begin
  Options := [bpoGrabber];
end;

procedure TDesktopAppWindow.OnViewFileListActionExecute(Sender: TObject);
begin
  if not Assigned(FileListMdiWindow) then
    Application.CreateForm(TFileListMdiWindow, FileListMdiWindow)
  else
    FileListMdiWindow.BringToFront;
end;

procedure TDesktopAppWindow.OnViewFileTreeActionExecute(Sender: TObject);
begin
  LockWindowUpdate(Handle);
  try
    if (Sender as TAction).Checked then
    begin
      DockSplitter.Visible := True;
      DockPanel.Visible := True;
    end
    else
    begin
      DockSplitter.Visible := False;
      DockPanel.Visible := False;
    end;
  finally
    LockWindowUpdate(0);
  end;
end;

procedure TDesktopAppWindow.OnToolsConnectActionExecute(Sender: TObject);
begin
  DesktopAppDataModule.Connect(True);
end;

procedure TDesktopAppWindow.OnToolsDisconnectActionExecute(Sender: TObject);
begin
  DesktopAppDataModule.Disconnect;
end;

initialization
  ReportMemoryLeaksOnShutdown := True;

end.
