unit DiGdiplusImageList;

interface

uses
  Classes, Contnrs, Gdipobj,
{$IF CompilerVersion >= 23}
  Vcl.ImgList, Vcl.Graphics, Vcl.Dialogs;
{$ELSE}
  ImgList, Graphics, Dialogs;
{$IFEND}

type

{ TImageList }

  TImageList = class(TCustomImageList)
  private
    { Private declarations }
    FIsAllowDisabled: Boolean;
    FEnabledBitmaps: TObjectList;
    FDisabledBitmaps: TObjectList;
    function CreateBitmap(const AModule: HMODULE; const AResId: WORD): TGPBitmap;
  protected
    procedure DoDraw(Index: Integer; Canvas: TCanvas; X, Y: Integer; Style: Cardinal; Enabled: Boolean = True); override;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
//    constructor Create(AOwner: TComponent; const AIsAllowDisabled: Boolean); reintroduce;
    destructor Destroy; override;
    function AddBitmap(const AModule: HMODULE; const AResId: WORD): Integer;
  end;

procedure Register;

implementation

uses
  Windows, ActiveX, Gdipapi;

procedure Register;
begin
  RegisterComponents('Di.Gdiplus', [TImageList]);
end;

{ TImageList }

constructor TImageList.Create(AOwner: TComponent);
begin
  inherited;
  FIsAllowDisabled := True;
  FEnabledBitmaps := TObjectList.Create;
  FDisabledBitmaps := TObjectList.Create;
end;

//constructor TImageList.Create(AOwner: TComponent; const AIsAllowDisabled: Boolean);
//begin
//  inherited Create(AOwner);
//  FIsAllowDisabled := AIsAllowDisabled;
//  FEnabledBitmaps := TObjectList.Create;
//  FDisabledBitmaps := TObjectList.Create;
//end;

destructor TImageList.Destroy;
begin
  FEnabledBitmaps.Free;
  FDisabledBitmaps.Free;
  inherited Destroy;
end;

function TImageList.CreateBitmap(const AModule: HMODULE; const AResId: WORD): TGPBitmap;
var
  LResInfo: HRSRC;
  LResData: HGLOBAL;
  LResMem: Pointer;
  LResSize: DWORD;
  LHeap: THandle;
  LHeapMem: Pointer;
  LStream: IStream;
begin
  Result := nil;
  LResInfo := FindResource(AModule, MAKEINTRESOURCE(AResId), RT_RCDATA);
  if LResInfo <> 0 then
  begin
    LResData := LoadResource(AModule, LResInfo);
    if LResData <> 0 then
    begin
      LResMem := LockResource(LResData);
      if Assigned(LResMem) then
      begin
        LResSize := SizeofResource(AModule, LResInfo);
        LHeap := GetProcessHeap();
        LHeapMem := HeapAlloc(LHeap, 0, LResSize);
				CopyMemory(LHeapMem, LResMem, LResSize);
				if CreateStreamOnHGlobal(HGLOBAL(LHeapMem), False, LStream) = S_OK then
        begin
					Result := TGPBitmap.Create(LStream, FALSE);
					LStream._Release;
        end;
				HeapFree(LHeap, 0, LHeapMem);
      end;
			FreeResource(LResData);
    end;
  end;
end;

function TImageList.AddBitmap(const AModule: HMODULE; const AResId: WORD): Integer;
const
  CColorMatrix: TColorMatrix = ((0.2125, 0.2125, 0.2125, 0.0, 0.0),
                                (0.2577, 0.2577, 0.2577, 0.0, 0.0),
                                (0.0361, 0.0361, 0.0361, 0.0, 0.0),
                                (0.0,    0.0,    0.0,    0.7, 0.0),
                                (0.38,   0.38,   0.38,   0.0, 0.0));
var
  LBitmap: TGPBitmap;
  LEnabledBitmap: TGPBitmap;
  LDisabledBitmap: TGPBitmap;
  LEnabledGraphics: TGPGraphics;
  LDisabledGraphics: TGPGraphics;
  LImageAttributes: TGPImageAttributes;
  LWidth: Integer;
  LHeight: Integer;
begin
  Result := -1;
  LBitmap := CreateBitmap(AModule, AResId);
  if Assigned(LBitmap) then
  begin
    LWidth := LBitmap.GetWidth;
    LHeight := LBitmap.GetHeight;
    LEnabledBitmap := TGPBitmap.Create(LWidth, LHeight, PixelFormat32bppPARGB);
    LEnabledGraphics := TGPGraphics.Create(LEnabledBitmap);
    try
      LEnabledGraphics.DrawImage(LBitmap, 0, 0, LWidth, LHeight);
      FEnabledBitmaps.Add(LEnabledBitmap);
      AddIcon(nil);
      Result := FEnabledBitmaps.Count - 1;
      if FIsAllowDisabled then
      begin
        LDisabledBitmap := TGPBitmap.Create(LWidth, LHeight, PixelFormat32bppPARGB);
        LDisabledGraphics := TGPGraphics.Create(LDisabledBitmap);
        try
          LImageAttributes := TGPImageAttributes.Create;
          try
            LImageAttributes.ClearColorMatrix(ColorAdjustTypeBitmap);
            LImageAttributes.SetColorMatrix(CColorMatrix, ColorMatrixFlagsDefault, ColorAdjustTypeBitmap);
            LDisabledGraphics.DrawImage(LBitmap, MakeRect(0, 0, LWidth, LHeight),
              0, 0, LWidth, LHeight, UnitPixel, LImageAttributes, nil, nil);
            FDisabledBitmaps.Add(LDisabledBitmap);
          finally
            LImageAttributes.Free;
          end;
        finally
          LDisabledGraphics.Free;
        end;
      end;
    finally
      LEnabledGraphics.Free;
    end;
  end;
end;

procedure TImageList.DoDraw(Index: Integer; Canvas: TCanvas; X, Y: Integer;
  Style: Cardinal; Enabled: Boolean = True);
var
  LGraphics: TGPGraphics;
  LBitmap: TGPBitmap;
  LWidth: Integer;
  LHeight: Integer;
begin
  LGraphics := TGPGraphics.Create(Canvas.Handle);
  try
    if not Enabled and FIsAllowDisabled then LBitmap := FDisabledBitmaps[Index] as TGPBitmap
    else                                     LBitmap := FEnabledBitmaps[Index] as TGPBitmap;
    LWidth := LBitmap.GetWidth;
    LHeight := LBitmap.GetHeight;
    //	”становка параметров дл€ быстрой отрисовки https://www.codeproject.com/tips/66909/rendering-fast-with-gdi-what-to-do-and-what-not-to
    	LGraphics.SetCompositingMode({CompositingModeSourceCopy} CompositingModeSourceOver);
    LGraphics.SetCompositingQuality(CompositingQualityHighSpeed);
    LGraphics.SetPixelOffsetMode(PixelOffsetModeNone);
    LGraphics.SetSmoothingMode(SmoothingModeNone);
    LGraphics.SetInterpolationMode(InterpolationModeDefault);
    LGraphics.DrawImage(LBitmap, X, Y{, LWidth, LHeight});
  finally
    LGraphics.Free;
  end;
end;

end.
