program Desktop;

{$R 'DiDesktopAppWindow.res' '..\..\AppWindows\DiDesktopAppWindow.rc'}

uses
  Forms,
  DiDesktopAppWindow in '..\..\AppWindows\DiDesktopAppWindow.pas' {DesktopAppWindow},
  DiFileTreeDockWindow in '..\..\DockWindows\DiFileTreeDockWindow.pas' {FileTreeDockWindow},
  DiDesktopAppDataModule in '..\..\DataModules\DiDesktopAppDataModule.pas' {DesktopAppDataModule: TDataModule},
  DiConnectionDialogBox in '..\..\DialogBoxes\DiConnectionDialogBox.pas' {ConnectionDialogBox},
  DiFileDataModule in '..\..\DataModules\DiFileDataModule.pas' {FileDataModule: TDataModule},
  DiIConnection in '..\..\Interfaces\DiIConnection.pas',
  DiType in '..\..\Types\DiType.pas',
  DiFileReaderDataModule in '..\..\DataModules\DiFileReaderDataModule.pas' {FileReaderDataModule: TDataModule},
  DiFileListMdiWindow in '..\..\MdiWindows\DiFileListMdiWindow.pas' {FileListMdiWindow};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Desktop';
  Application.CreateForm(TDesktopAppWindow, DesktopAppWindow);
  Application.CreateForm(TFileTreeDockWindow, FileTreeDockWindow);
  Application.CreateForm(TDesktopAppDataModule, DesktopAppDataModule);
  Application.CreateForm(TFileListMdiWindow, FileListMdiWindow);
  Application.Run;
end.
