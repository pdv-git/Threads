library Module1;

{ Important note about DLL memory management: ShareMem must be the
  first unit in your library's USES clause AND your project's (select
  Project-View Source) USES clause if your DLL exports any procedures or
  functions that pass strings as parameters or function results. This
  applies to all strings passed to and from your DLL--even those that
  are nested in records and classes. ShareMem is the interface unit to
  the BORLNDMM.DLL shared memory manager, which must be deployed along
  with your DLL. To avoid using BORLNDMM.DLL, pass string information
  using PChar or ShortString parameters. }

uses
  ShareMem,
  System.SysUtils,
  System.Classes,
  Winapi.Windows,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  DiLeftDockWindow in '..\..\DockWindows\DiLeftDockWindow.pas' {LeftDockWindow},
  DiRightDockWindow in '..\..\DockWindows\DiRightDockWindow.pas' {RightDockWindow},
  DiPrimeNumberThread in '..\..\Threads\DiPrimeNumberThread.pas',
  DiPaintBoxThread in '..\..\Threads\DiPaintBoxThread.pas';

const
  sFileInfo =
'<?xml version="1.0" encoding="utf-8"?> ' + sLineBreak  +
'<module name="Задачи"> ' + sLineBreak  +
'  <parameters> ' + sLineBreak  +
'    <parameter name="AppWindowHandle" data_type="integer" value=""/> ' + sLineBreak +
'    <parameter name="ConnectionString" data_type="string" value=""/> ' + sLineBreak +
'  </parameters> ' +  sLineBreak  +
'  <commands> ' +  sLineBreak  +
'    <command name="Левая панель" procedure="Left"/> ' +  sLineBreak  +
'    <command name="Правая панель" procedure="Right"/> ' +  sLineBreak +
'  </commands> ' +  sLineBreak  +
'</module>';

var
  GFileInfo: string;

{$R *.res}

function FileInfo: PChar; stdcall;
begin
  Result := sFileInfo;
end;

procedure Left(AParent: TWinControl); stdcall;
begin
  if not Assigned(LeftDockWindow) then
  begin
    LeftDockWindow := TLeftDockWindow.CreateParented(AParent.Handle);
    MoveWindow(LeftDockWindow.Handle, 0, 0, AParent.ClientWidth, AParent.ClientHeight, True);
  end;
end;

procedure Right(AParent: TWinControl); stdcall;
begin
  if not Assigned(RightDockWindow) then
  begin
    RightDockWindow := TRightDockWindow.CreateParented(AParent.Handle);
    MoveWindow(RightDockWindow.Handle, 0, 0, AParent.ClientWidth, AParent.ClientHeight, True);
  end;
end;

exports
  FileInfo, Left, Right;

begin
end.
