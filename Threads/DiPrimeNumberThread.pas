unit DiPrimeNumberThread;

interface

uses
  System.Classes, System.SysUtils, System.SyncObjs, Winapi.Messages,
  Winapi.Windows, Vcl.ComCtrls, Vcl.Dialogs;

const
  WM_USERADDITEM = WM_USER + 2;

type
  TPrimeNumberThread = class(TThread)
  private
    { Private declarations }
    FFormHandle: HWND;
  protected
    procedure Execute; override;
  public
    constructor Create(AFormHandle: HWND);
  end;

implementation

{ 
  Important: Methods and properties of objects in visual components can only be
  used in a method called using Synchronize, for example,

      Synchronize(UpdateCaption);

  and UpdateCaption could look like,

    procedure TPrimeNumberThread.UpdateCaption;
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

{ TPrimeNumberThread }

constructor TPrimeNumberThread.Create(AFormHandle: HWND);
begin
  inherited Create;
  FFormHandle := AFormHandle;
end;

procedure TPrimeNumberThread.Execute;
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
      PostMessage(FFormHandle, WM_USERADDITEM, N, 0);

    Inc(N);
    Sleep(100);
  end;
end;

end.
