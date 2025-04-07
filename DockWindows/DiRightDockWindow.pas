unit DiRightDockWindow;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Vcl.ExtCtrls,
  DiPaintBoxThread;

type
  TRightDockWindow = class(TForm)
    InfoLabel: TLabel;
    StartButton: TButton;
    StopButton: TButton;
    ClearButton: TButton;
    PaintBox: TPaintBox;
    procedure OnStartButtonClick(Sender: TObject);
    procedure OnStopButtonClick(Sender: TObject);
    procedure OnClearButtonClick(Sender: TObject);
  private
    { Private declarations }
    FPaintBoxThread: TPaintBoxThread;
    procedure WMUserDraw(var Message: TMessage); message WM_USERDRAW;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

var
  RightDockWindow: TRightDockWindow;

implementation

{$R *.dfm}

{ TUsersDockWindow }

constructor TRightDockWindow.Create(AOwner: TComponent);
begin
  inherited;
end;

destructor TRightDockWindow.Destroy;
begin
  RightDockWindow := nil;
  inherited;
end;

procedure TRightDockWindow.WMUserDraw(var Message: TMessage);
begin
  PaintBox.Canvas.Lock;
  try
    PaintBox.Canvas.MoveTo(Message.WParam + 5, Message.LParam + 5);
    PaintBox.Canvas.LineTo(Message.WParam * 10, Message.LParam * 10);
  finally
    PaintBox.Canvas.Unlock;
  end;
end;

procedure TRightDockWindow.OnStartButtonClick(Sender: TObject);
begin
  FPaintBoxThread := TPaintBoxThread.Create(Handle);
  FPaintBoxThread.FreeOnTerminate := True;
end;

procedure TRightDockWindow.OnStopButtonClick(Sender: TObject);
begin
  if Assigned(FPaintBoxThread) then
  begin
    FPaintBoxThread.Terminate;
    FPaintBoxThread := nil;
  end;
end;

procedure TRightDockWindow.OnClearButtonClick(Sender: TObject);
begin
  PaintBox.Repaint;
end;

end.
