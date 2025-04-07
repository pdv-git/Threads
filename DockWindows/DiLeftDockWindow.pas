unit DiLeftDockWindow;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, System.SyncObjs, Vcl.ComCtrls,
  DiPrimeNumberThread;

type
  TLeftDockWindow = class(TForm)
    InfoLabel: TLabel;
    StartButton: TButton;
    StopButton: TButton;
    ClearButton: TButton;
    ListView: TListView;
    procedure OnStartButtonClick(Sender: TObject);
    procedure OnStopButtonClick(Sender: TObject);
    procedure OnClearButtonClick(Sender: TObject);
  private
    { Private declarations }
    FPrimeNumberThread: TPrimeNumberThread;
    procedure WMUserAddItem(var Message: TMessage); message WM_USERADDITEM;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

var
  LeftDockWindow: TLeftDockWindow;

implementation

{$R *.dfm}

{ TRolesDockWindow }
constructor TLeftDockWindow.Create(AOwner: TComponent);
begin
  inherited;
end;

destructor TLeftDockWindow.Destroy;
begin
  LeftDockWindow := nil;
  inherited;
end;

procedure TLeftDockWindow.WMUserAddItem(var Message: TMessage);
begin
  ListView.AddItem(IntToStr(Message.WParam), nil);
end;

procedure TLeftDockWindow.OnStartButtonClick(Sender: TObject);
begin
  FPrimeNumberThread := TPrimeNumberThread.Create(Handle);
  FPrimeNumberThread.FreeOnTerminate := True;
end;

procedure TLeftDockWindow.OnStopButtonClick(Sender: TObject);
begin
  if Assigned(FPrimeNumberThread) then
  begin
    FPrimeNumberThread.Terminate;
    FPrimeNumberThread := nil;
  end;
end;

procedure TLeftDockWindow.OnClearButtonClick(Sender: TObject);
begin
  ListView.Items.Clear;
end;

end.
