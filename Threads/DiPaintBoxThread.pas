unit DiPaintBoxThread;

interface

uses
  System.Classes, Vcl.ExtCtrls, Vcl.Forms, Winapi.Messages, Winapi.Windows;

const
  WM_USERDRAW = WM_USER + 3;

type
  TPaintBoxThread = class(TThread)
  private
    { Private declarations }
    FFormHandle: HWND;
  protected
    procedure Execute; override;
  public
    constructor Create(const AFormHandle: HWND);
  end;

implementation

{
  Important: Methods and properties of objects in visual components can only be
  used in a method called using Synchronize, for example,

      Synchronize(UpdateCaption);  

  and UpdateCaption could look like,

    procedure TPaintBoxThread.UpdateCaption;
    begin
      Form1.Caption := 'Updated in a thread';
    end; 
    
    or 
    
    Synchronize(
      procedure
      begin
        Form1.Caption := 'Updated in thread via an anonymous method'
      end
      )
    );
    
  where an anonymous method is passed.
  
  Similarly, the developer can call the Queue method with similar parameters as 
  above, instead passing another TThread class as the first parameter, putting
  the calling thread in a queue with the other thread.
    
}

{ TPaintBoxThread }

constructor TPaintBoxThread.Create(const AFormHandle: HWND);
begin
  inherited Create;
  FFormHandle := AFormHandle;
end;

procedure TPaintBoxThread.Execute;
var
  N: Integer;
  I: Integer;
begin
  N := 1;
  while not Terminated do
  begin
    I := N - 1;

    while I > 1 do
    begin
      if N mod I = 0 then
        Break;
      Dec(I)
    end;

    if I = 1 then
      PostMessage(FFormHandle, WM_USERDRAW, N, N + 100);

    Inc(N);
    Sleep(100);
  end;
end;

end.
