unit DiGdipus;

interface

uses
  Windows, Gdipapi;

implementation

var
  GGdiplusStartupInput: GdiplusStartupInput;
  GGdiplusStartupOutput: GdiplusStartupOutput;
  GGdiplusToken: ULONG;

initialization
	GdiplusStartup(GGdiplusToken, @GGdiplusStartupInput, @GGdiplusStartupOutput);

finalization
  GdiplusShutdown(GGdiplusToken);

end.
