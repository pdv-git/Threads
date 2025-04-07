unit DiFileTreeDockWindow;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ImgList, Menus, ActnList, ComCtrls, Buttons, ExtCtrls,
  DiType, System.ImageList, System.Actions;

type
  TFileTreeDockWindow = class(TForm)
    ActionList: TActionList;
    AddCatalogAction: TAction;
    AddDocumentAction: TAction;
    AddFormAction: TAction;
    AddReportAction: TAction;
    AddScriptAction: TAction;
    AddModuleAction: TAction;
    OpenFileAction: TAction;
    EditFileAction: TAction;
    RenameAction: TAction;
    DeleteAction: TAction;
    RefreshCatalogAction: TAction;
    ShowPropertiesAction: TAction;
    PopupMenu: TPopupMenu;
    AddMenuItem: TMenuItem;
    AddCatalogMenuItem: TMenuItem;
    Separator1MenuItem: TMenuItem;
    AddDocumentMenuItem: TMenuItem;
    AddFormMenuItem: TMenuItem;
    AddReportMenuItem: TMenuItem;
    AddScriptMenuItem: TMenuItem;
    AddModuleMenuItem: TMenuItem;
    Separator2MenuItem: TMenuItem;
    OpenFileMenuItem: TMenuItem;
    EditFileMenuItem: TMenuItem;
    Separator3MenuItem: TMenuItem;
    RenameMenuItem: TMenuItem;
    DeleteMenuItem: TMenuItem;
    Separator4MenuItem: TMenuItem;
    RefreshCatalogMenuItem: TMenuItem;
    ShowPropertiesMenuItem: TMenuItem;
    ImageList: TImageList;
    TitlePanel: TPanel;
    CloseSpeedButton: TSpeedButton;
    TreeView: TTreeView;
    procedure OnCloseSpeedButtonClick(Sender: TObject);
    procedure OnTreeViewDeletion(Sender: TObject; Node: TTreeNode);
    procedure OnTreeViewChange(Sender: TObject; Node: TTreeNode);
    procedure OnTreeViewExpanding(Sender: TObject; Node: TTreeNode;
      var AllowExpansion: Boolean);
    procedure OnTreeViewContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
    procedure OnTreeViewEditing(Sender: TObject; Node: TTreeNode;
      var AllowEdit: Boolean);
    procedure OnOpenFileActionExecute(Sender: TObject);
    procedure OnEditFileActionExecute(Sender: TObject);
    procedure OnRenameActionExecute(Sender: TObject);
    procedure OnDeleteActionExecute(Sender: TObject);
    procedure OnRefreshCatalogActionExecute(Sender: TObject);
    procedure OnShowPropertiesActionExecute(Sender: TObject);
    procedure OnTreeViewEdited(Sender: TObject; Node: TTreeNode;
      var S: string);
    procedure OnTreeViewDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure OnTreeViewDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
  private
    { Private declarations }
    procedure Clear;
    procedure AddCatalog(const ANode: TTreeNode);
    procedure OpenFile(const ANode: TTreeNode);
    procedure GetCatalogList(const ANode: TTreeNode);
    procedure RenameCatalog(const ANode: TTreeNode; const ACatalogName: WideString);
    procedure RemoveCatalog(const ANode: TTreeNode);
    procedure MoveCatalog(const ASourceNode: TTreeNode; const ATargetNode: TTreeNode);
    procedure AddFile(const ANode: TTreeNode; const AFileType: TFileType);
    procedure GetFileList(const ANode: TTreeNode);
    procedure RenameFile(const ANode: TTreeNode; const AFileName: WideString);
    procedure RemoveFile(const ANode: TTreeNode);
    procedure MoveFile(const ASourceNode: TTreeNode; const ATargetNode: TTreeNode);
    procedure RefreshCatalog(const ANode: TTreeNode; const AExpanded: Boolean);
    procedure ShowDatabaseProperties(const ANode: TTreeNode);
    procedure ShowFileProperties(const ANode: TTreeNode);
  protected
    { Protected declarations }
    procedure DoAddFile(const ANode: TTreeNode; const AFileType: TFileType);
    procedure DoAddCatalog(const ANode: TTreeNode);
    procedure DoOpenFile(const ANode: TTreeNode);
    procedure DoEditFile(const ANode: TTreeNode);
    procedure DoRename(const ANode: TTreeNode);
    procedure DoDelete(const ANode: TTreeNode);
    procedure DoRefreshCatalog(const ANode: TTreeNode);
    procedure DoShowProperties(const ANode: TTreeNode);
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Connect;
    procedure Disconnect;
    procedure Synchronize(const ANode: TTreeNode);
  end;

var
  FileTreeDockWindow: TFileTreeDockWindow;

implementation

{$R *.dfm}

uses
  DiDesktopAppWindow, DiFileListMdiWindow,
  DiDesktopAppDataModule, DiFileDataModule;

const
  SModuleCatalog = 'Modules';

{ TFileTreeDockWindow }

constructor TFileTreeDockWindow.Create(AOwner: TComponent);
begin
  inherited;
  TitlePanel.DoubleBuffered := True;
  TreeView.DoubleBuffered := True;
  ManualDock(DesktopAppWindow.DockPanel);
end;

destructor TFileTreeDockWindow.Destroy;
begin
  inherited;
end;

procedure TFileTreeDockWindow.Connect;
var
  LNode: TTreeNode;
  LFileRecordPtr: TFileRecordPtr;
begin
  New(LFileRecordPtr);

  with LFileRecordPtr^ do
  begin
    Id := Null;
    CatalogId := Null;
    FileType := ftDatabase;
    Name := SModuleCatalog;
    IsEmpty := False;
  end;

  LNode := TreeView.Items.AddObject(nil, LFileRecordPtr.Name, LFileRecordPtr);

  with LNode do
  begin
    ImageIndex := Integer(ftDatabase) + 1;
    SelectedIndex := Integer(ftDatabase) + 1;
    StateIndex := Integer(ftDatabase) + 1;
  end;

  GetCatalogList(LNode);
  GetFileList(LNode);

  //  Выбор узла
  TreeView.Selected := LNode;
end;

procedure TFileTreeDockWindow.Disconnect;
begin
  Clear;
end;

procedure TFileTreeDockWindow.OnCloseSpeedButtonClick(Sender: TObject);
begin
  DesktopAppWindow.ViewFileTreeAction.Execute;
end;

procedure TFileTreeDockWindow.OnTreeViewEditing(Sender: TObject;
  Node: TTreeNode; var AllowEdit: Boolean);
begin
  case TFileRecordPtr(Node.Data).FileType of
    ftDatabase:
      AllowEdit := False;
    else
      AllowEdit := True;
  end;
end;

procedure TFileTreeDockWindow.OnTreeViewContextPopup(Sender: TObject;
  MousePos: TPoint; var Handled: Boolean);
begin
  TreeView.Selected := TreeView.Selected;
end;

procedure TFileTreeDockWindow.OnTreeViewExpanding(Sender: TObject;
  Node: TTreeNode; var AllowExpansion: Boolean);
begin
	if Node.HasChildren then
		if not Assigned(Node.getFirstChild.Data) then
    begin
			Node.DeleteChildren();
			GetCatalogList(Node);
      GetFileList(Node);
    end;
end;

procedure TFileTreeDockWindow.OnTreeViewChange(Sender: TObject;
  Node: TTreeNode);
begin
  Synchronize(Node);
  if Assigned(Node) then
    if Node.HasChildren then
      if not Assigned(Node.getFirstChild.Data) then
      begin
        Node.DeleteChildren();
        GetCatalogList(Node);
        GetFileList(Node);
      end;
//  if Assigned(FormFileList) then
//    FormFileList.Synchronize(Node);
end;

procedure TFileTreeDockWindow.OnTreeViewEdited(Sender: TObject;
  Node: TTreeNode; var S: string);
//var
//  LName: WideString;
begin
  case TFileRecordPtr(Node.Data).FileType of
    ftDatabase:
      ;
    ftCatalog:
    begin
//      LName := S;
      RenameCatalog(Node, S);
//      S := LName;
    end
    else
    begin
//      LName := S;
      RenameFile(Node, S);
//      S := LName;
    end;
  end;
end;

procedure TFileTreeDockWindow.OnTreeViewDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
  function LIsChildNode(const ASourceNode: TTreeNode; const ATargetNode: TTreeNode): Boolean;
  var
    LNode: TTreeNode;
  begin
    LNode := ATargetNode.Parent;
    while Assigned(LNode) do
    begin
      if LNode = ASourceNode then
      begin
        Result := True;
        Exit;
      end;
      LNode := LNode.Parent;
    end;
    Result := False;
  end;
var
  LSourceNode: TTreeNode;
  LTargetNode: TTreeNode;
begin
  LSourceNode := TreeView.Selected;
  if Assigned(LSourceNode) then
    case TFileRecordPtr(LSourceNode.Data).FileType of
      ftDatabase:
        Accept := False;
      else
      begin
        LTargetNode := TreeView.GetNodeAt(X, Y);
        if Assigned(LTargetNode) and (LSourceNode <> LTargetNode) then
          case TFileRecordPtr(LTargetNode.Data).FileType of
            ftDatabase, ftCatalog:
            begin
              if TFileRecordPtr(LSourceNode.Data).FileType = ftCatalog then
                Accept := (TFileRecordPtr(LTargetNode.Data).Id <> TFileRecordPtr(LSourceNode.Data).CatalogId) and
                          not LIsChildNode(LSourceNode, LTargetNode)
              else
                Accept := TFileRecordPtr(LTargetNode.Data).Id <> TFileRecordPtr(LSourceNode.Data).CatalogId;
            end
            else
              Accept := False;
          end
        else
          Accept := False;
      end;
    end
  else
    Accept := False;
end;

procedure TFileTreeDockWindow.OnTreeViewDragDrop(Sender, Source: TObject; X,
  Y: Integer);
var
  LSourceNode: TTreeNode;
  LTargetNode: TTreeNode;
begin
  LSourceNode := TreeView.Selected;
  if Assigned(LSourceNode) then
  begin
    LTargetNode := TreeView.GetNodeAt(X, Y);
    if Assigned(LTargetNode) then
      if TFileRecordPtr(LSourceNode.Data).FileType = ftCatalog then
        MoveCatalog(LSourceNode, LTargetNode)
      else
        MoveFile(LSourceNode, LTargetNode);
  end;
end;


procedure TFileTreeDockWindow.OnTreeViewDeletion(Sender: TObject;
  Node: TTreeNode);
begin
  if Assigned(Node.Data) then
    Dispose(TFileRecordPtr(Node.Data));
end;

procedure TFileTreeDockWindow.OnOpenFileActionExecute(Sender: TObject);
begin
  DoOpenFile(TreeView.Selected);
end;

procedure TFileTreeDockWindow.OnEditFileActionExecute(Sender: TObject);
begin
  DoEditFile(TreeView.Selected);
end;

procedure TFileTreeDockWindow.OnRenameActionExecute(Sender: TObject);
begin
  DoRename(TreeView.Selected);
end;

procedure TFileTreeDockWindow.OnDeleteActionExecute(Sender: TObject);
begin
  DoDelete(TreeView.Selected);
end;

procedure TFileTreeDockWindow.OnRefreshCatalogActionExecute(Sender: TObject);
begin
  DoRefreshCatalog(TreeView.Selected);
end;

procedure TFileTreeDockWindow.OnShowPropertiesActionExecute(Sender: TObject);
begin
  DoShowProperties(TreeView.Selected);
end;

procedure TFileTreeDockWindow.DoAddCatalog(const ANode: TTreeNode);
var
  LNode: TTreeNode;
begin
  if Assigned(ANode) then
    case TFileRecordPtr(ANode.Data).FileType of
      ftDatabase, ftCatalog:
        LNode := ANode;
      else
        LNode := ANode.Parent;
    end
  else
    LNode := nil;

  AddCatalog(LNode);
end;

procedure TFileTreeDockWindow.DoAddFile(const ANode: TTreeNode;
  const AFileType: TFileType);
var
  LNode: TTreeNode;
begin
  if Assigned(ANode) then
    case TFileRecordPtr(ANode.Data).FileType of
      ftDatabase, ftCatalog:
        LNode := ANode;
      else
        LNode := ANode.Parent;
    end
  else
    LNode := nil;

  AddFile(LNode, AFileType);
end;

procedure TFileTreeDockWindow.DoEditFile(const ANode: TTreeNode);
begin
//
end;

procedure TFileTreeDockWindow.DoOpenFile(const ANode: TTreeNode);
begin
  if Assigned(ANode) then
  begin
    case TFileRecordPtr(ANode.Data).FileType of
      ftDatabase, ftCatalog, ftModule:
        ;
      else
        OpenFile(ANode);
    end;
  end;
end;

procedure TFileTreeDockWindow.DoRename(const ANode: TTreeNode);
begin
  if Assigned(ANode) then
  begin
    case TFileRecordPtr(ANode.Data).FileType of
      ftDatabase:
        ;
      else
        ANode.EditText;
    end;
  end;
end;

procedure TFileTreeDockWindow.DoDelete(const ANode: TTreeNode);
begin
  if Assigned(ANode) then
    case TFileRecordPtr(ANode.Data).FileType of
      ftDatabase:
        ;
      ftCatalog:
        RemoveCatalog(ANode);
      else
        RemoveFile(ANode);
    end;
end;

procedure TFileTreeDockWindow.DoRefreshCatalog(const ANode: TTreeNode);
var
  LNode: TTreeNode;
  LExpanded: Boolean;
begin
  if Assigned(ANode) then
  begin
    case TFileRecordPtr(ANode.Data).FileType of
      ftDatabase, ftCatalog:
      begin
        LExpanded := ANode.Expanded;
        LNode := ANode;
      end
      else
      begin
        LExpanded := False;
        LNode := ANode.Parent;
      end;
    end;
    RefreshCatalog(LNode, LExpanded);
  end
  else
    RefreshCatalog(nil, False);
end;

procedure TFileTreeDockWindow.DoShowProperties(const ANode: TTreeNode);
begin
  if Assigned(ANode) then
    case TFileRecordPtr(ANode.Data).FileType of
      ftDatabase:
        ShowDatabaseProperties(ANode);
      ftCatalog:
        ;
      else
        ShowFileProperties(ANode);
    end;
end;

procedure TFileTreeDockWindow.Clear;
begin
  //  Сброс активного узла
  TreeView.Selected := nil;

  //  Очистка дерева
  TreeView.Items.Clear;
end;

procedure TFileTreeDockWindow.AddCatalog(const ANode: TTreeNode);
begin
//
end;

procedure TFileTreeDockWindow.AddFile(const ANode: TTreeNode; const AFileType: TFileType);
begin
//
end;

procedure TFileTreeDockWindow.OpenFile(const ANode: TTreeNode);
type
  TFileProc = procedure (AParent: TWinControl); stdcall;
var
  LFileRecordPtr: TFileRecordPtr;
  LModule: HModule;
  LFileProc: TFileProc;
begin
  LFileRecordPtr := ANode.Data;
  LModule := LoadLibrary(PChar(string(LFileRecordPtr^.CatalogId)));
  if LModule <> 0 then
  try
    @LFileProc := GetProcAddress(LModule, PChar(string(LFileRecordPtr^.Id)));
    if @LFileProc <> nil then
    begin
      if string(LFileRecordPtr^.Id) = 'Left' then
        LFileProc(FileListMdiWindow.PanelLeft)
      else
        LFileProc(FileListMdiWindow.PanelRight)
    end;
  finally
//    FreeLibrary(LModule);
  end;
end;

procedure TFileTreeDockWindow.GetCatalogList(const ANode: TTreeNode);
var
  LCatalogId: Variant;
  LCatalogList: TList;
  LFileRecordPtr: TFileRecordPtr;
  LNode: TTreeNode;
  I: Integer;
begin
  LCatalogList := TList.Create;
  try
    if Assigned(ANode) then LCatalogId := TFileRecordPtr(ANode.Data).Id
    else                    LCatalogId := Null;

    if LCatalogId = Null then
      LCatalogId := ExtractFilePath(Application.ExeName) + SModuleCatalog;

    FileDataModule.FileReaderDataModule.GetCatalogList(LCatalogId, LCatalogList);

    for I := 0 to LCatalogList.Count - 1 do
    begin
      LFileRecordPtr := TFileRecordPtr(LCatalogList[I]);
      LNode := TreeView.Items.AddChildObject(ANode, LFileRecordPtr.Name, LFileRecordPtr);

      with LNode do
      begin
        ImageIndex := Integer(ftCatalog) + 1;
        SelectedIndex := Integer(ftCatalog) + 1;
        StateIndex := Integer(ftCatalog) + 1;
      end;

      if not LFileRecordPtr.IsEmpty then
        TreeView.Items.AddChildObject(LNode, EmptyWideStr, nil);
    end;

  finally
    LCatalogList.Free;
  end;
end;

procedure TFileTreeDockWindow.GetFileList(const ANode: TTreeNode);

  procedure GetFileTaskList(const ANode: TTreeNode; AFileRecordPtr: TFileRecordPtr);
  var
    LFileTaskList: TList;
    LFileRecordPtr: TFileRecordPtr;
    LNode: TTreeNode;
    I: Integer;
  begin
    LFileTaskList := TList.Create;
    try
      FileDataModule.FileReaderDataModule.GetFileTaskList(AFileRecordPtr.Id, AFileRecordPtr.Xml, LFileTaskList);

      for I := 0 to LFileTaskList.Count - 1 do
      begin
        LFileRecordPtr := TFileRecordPtr(LFileTaskList[I]);
        LNode := TreeView.Items.AddChildObject(ANode, LFileRecordPtr.Name, LFileRecordPtr);

        with LNode do
        begin
          ImageIndex := Integer(LFileRecordPtr.FileType) + 1;
          SelectedIndex := Integer(LFileRecordPtr.FileType) + 1;
          StateIndex := Integer(LFileRecordPtr.FileType) + 1;
        end;
      end;
    finally
      LFileTaskList.Free;
    end;
  end;

var
  LCatalogId: Variant;
  LFileList: TList;
  LFileRecordPtr: TFileRecordPtr;
  LNode: TTreeNode;
  I: Integer;
begin
  LFileList := TList.Create;
  try
    LCatalogId := TFileRecordPtr(ANode.Data).Id;

    if LCatalogId = Null then
      LCatalogId := ExtractFilePath(Application.ExeName) + SModuleCatalog;

    FileDataModule.FileReaderDataModule.GetFileList(LCatalogId, LFileList);

    for I := 0 to LFileList.Count - 1 do
    begin
      LFileRecordPtr := TFileRecordPtr(LFileList[I]);
      LNode := TreeView.Items.AddChildObject(ANode, LFileRecordPtr.Name, LFileRecordPtr);

      with LNode do
      begin
        ImageIndex := Integer(LFileRecordPtr.FileType) + 1;
        SelectedIndex := Integer(LFileRecordPtr.FileType) + 1;
        StateIndex := Integer(LFileRecordPtr.FileType) + 1;
      end;

      GetFileTaskList(LNode, LFileRecordPtr);
    end;

  finally
    LFileList.Free;
  end;
end;

procedure TFileTreeDockWindow.MoveCatalog(const ASourceNode: TTreeNode; const ATargetNode: TTreeNode);
begin
//
end;

procedure TFileTreeDockWindow.MoveFile(const ASourceNode: TTreeNode; const ATargetNode: TTreeNode);
begin
//
end;

procedure TFileTreeDockWindow.RenameCatalog(const ANode: TTreeNode;
  const ACatalogName: WideString);
begin
//
end;

procedure TFileTreeDockWindow.RenameFile(const ANode: TTreeNode;
  const AFileName: WideString);
begin
//
end;

procedure TFileTreeDockWindow.RemoveCatalog(const ANode: TTreeNode);
begin
//
end;

procedure TFileTreeDockWindow.RemoveFile(const ANode: TTreeNode);
begin
//
end;

procedure TFileTreeDockWindow.RefreshCatalog(const ANode: TTreeNode;
  const AExpanded: Boolean);
begin
  if Assigned(ANode) then
  begin
    if ANode.HasChildren then ANode.DeleteChildren;
    GetCatalogList(ANode);
    GetFileList(ANode);

    if AExpanded then ANode.Expanded := True;
  end
  else
  begin
    Clear;
    GetCatalogList(nil);
    GetFileList(nil);
  end;
end;

procedure TFileTreeDockWindow.ShowDatabaseProperties(
  const ANode: TTreeNode);
begin
//
end;

procedure TFileTreeDockWindow.ShowFileProperties(const ANode: TTreeNode);
begin
//
end;

procedure TFileTreeDockWindow.Synchronize(const ANode: TTreeNode);
begin
  if Assigned(ANode) then
  begin
    case TFileRecordPtr(ANode.Data).FileType of
      ftDatabase:
      begin
          AddCatalogAction.Enabled := True;
          AddDocumentAction.Enabled := True;
          AddFormAction.Enabled := True;
          AddReportAction.Enabled := True;
          AddScriptAction.Enabled := True;
          AddModuleAction.Enabled := True;
        OpenFileAction.Enabled := False;
        EditFileAction.Enabled := False;
        RenameAction.Enabled := False;
        DeleteAction.Enabled := False;
        RefreshCatalogAction.Enabled := True;
        ShowPropertiesAction.Enabled := True;

        AddMenuItem.Visible := True;
          AddCatalogMenuItem.Visible := True;
          Separator1MenuItem.Visible := True;
          AddDocumentMenuItem.Visible := True;
          AddFormMenuItem.Visible := True;
          AddReportMenuItem.Visible := True;
          AddScriptMenuItem.Visible := True;
          AddModuleMenuItem.Visible := True;
        Separator2MenuItem.Visible := True;
        OpenFileMenuItem.Visible := False;
        EditFileMenuItem.Visible := False;
        Separator3MenuItem.Visible := False;
        RenameMenuItem.Visible := False;
        DeleteMenuItem.Visible := False;
        Separator4MenuItem.Visible := False;
        RefreshCatalogMenuItem.Visible := True;
        ShowPropertiesMenuItem.Visible := True;
      end;
      ftCatalog:
      begin
          AddCatalogAction.Enabled := True;
          AddDocumentAction.Enabled := True;
          AddFormAction.Enabled := True;
          AddReportAction.Enabled := True;
          AddScriptAction.Enabled := True;
          AddModuleAction.Enabled := True;
        OpenFileAction.Enabled := False;
        EditFileAction.Enabled := False;
        RenameAction.Enabled := True;
        DeleteAction.Enabled := True;
        RefreshCatalogAction.Enabled := True;
        ShowPropertiesAction.Enabled := False;

        AddMenuItem.Visible := True;
          AddCatalogMenuItem.Visible := True;
          Separator1MenuItem.Visible := True;
          AddDocumentMenuItem.Visible := True;
          AddFormMenuItem.Visible := True;
          AddReportMenuItem.Visible := True;
          AddScriptMenuItem.Visible := True;
          AddModuleMenuItem.Visible := True;
        Separator2MenuItem.Visible := True;
        OpenFileMenuItem.Visible := False;
        EditFileMenuItem.Visible := False;
        Separator3MenuItem.Visible := False;
        RenameMenuItem.Visible := True;
        DeleteMenuItem.Visible := True;
        Separator4MenuItem.Visible := True;
        RefreshCatalogMenuItem.Visible := True;
        ShowPropertiesMenuItem.Visible := False;
      end;
      ftDocument, ftForm, ftReport, ftScript, ftModule:
      begin
          AddCatalogAction.Enabled := False;
          AddDocumentAction.Enabled := False;
          AddFormAction.Enabled := False;
          AddReportAction.Enabled := False;
          AddScriptAction.Enabled := False;
          AddModuleAction.Enabled := False;
        OpenFileAction.Enabled := True;
        EditFileAction.Enabled := True;
        RenameAction.Enabled := True;
        DeleteAction.Enabled := True;
        RefreshCatalogAction.Enabled := True;
        ShowPropertiesAction.Enabled := True;

        AddMenuItem.Visible := False;
          AddCatalogMenuItem.Visible := False;
          Separator1MenuItem.Visible := False;
          AddDocumentMenuItem.Visible := False;
          AddFormMenuItem.Visible := False;
          AddReportMenuItem.Visible := False;
          AddScriptMenuItem.Visible := False;
          AddModuleMenuItem.Visible := False;
        Separator2MenuItem.Visible := False;
        OpenFileMenuItem.Visible := True;
        EditFileMenuItem.Visible := True;
        Separator3MenuItem.Visible := True;
        RenameMenuItem.Visible := True;
        DeleteMenuItem.Visible := True;
        Separator4MenuItem.Visible := True;
        RefreshCatalogMenuItem.Visible := True;
        ShowPropertiesMenuItem.Visible := True;
      end;
    end;
  end
  else
  begin
      AddCatalogAction.Enabled := False;
      AddDocumentAction.Enabled := False;
      AddFormAction.Enabled := False;
      AddReportAction.Enabled := False;
      AddScriptAction.Enabled := False;
      AddModuleAction.Enabled := False;
    OpenFileAction.Enabled := False;
    EditFileAction.Enabled := False;
    RenameAction.Enabled := False;
    DeleteAction.Enabled := False;
    RefreshCatalogAction.Enabled := False;
    ShowPropertiesAction.Enabled := False;

    AddMenuItem.Visible := False;
      AddCatalogMenuItem.Visible := False;
      Separator1MenuItem.Visible := False;
      AddDocumentMenuItem.Visible := False;
      AddFormMenuItem.Visible := False;
      AddReportMenuItem.Visible := False;
      AddScriptMenuItem.Visible := False;
      AddModuleMenuItem.Visible := False;
    Separator2MenuItem.Visible := False;
    OpenFileMenuItem.Visible := False;
    EditFileMenuItem.Visible := False;
    Separator3MenuItem.Visible := False;
    RenameMenuItem.Visible := False;
    DeleteMenuItem.Visible := False;
    Separator4MenuItem.Visible := False;
    RefreshCatalogMenuItem.Visible := False;
    ShowPropertiesMenuItem.Visible := False;
  end;
end;
end.
