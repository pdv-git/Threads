unit DiCtrlComboBox;

interface

uses
  Windows, Messages, SysUtils, Classes,
{$IF CompilerVersion >= 23}
  Vcl.Controls, Vcl.StdCtrls, Vcl.Graphics;
{$ELSE}
  Controls, StdCtrls, Graphics;
{$IFEND}

type

{ TComboBox }

  TComboBox = class(TCustomComboBox)
  private
    { Private declarations }
    FUpDropdown: Boolean;
    FButtonWidth: Integer;
    msMouseInControl: Boolean;
    FListHandle: HWND;
    FListInstance: Pointer;
    FDefListProc: Pointer;
    FChildHandle: HWND;
    FSolidBorder: Boolean;
    FReadOnly: Boolean;
    FEditOffset: Integer;
    FListWidth: Integer;
    procedure ListWndProc(var Message: TMessage);
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
    procedure CNCommand(var Message: TWMCommand); message CN_COMMAND;
    procedure CMEnabledChanged(var Msg: TMessage); message CM_ENABLEDCHANGED;
    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
    procedure PaintButtonGlyph(DC: HDC; X: Integer; Y: Integer; Color: TColor);
    procedure PaintButton(ButtonStyle: Integer);
    procedure PaintBorder(DC: HDC; const SolidBorder: Boolean);
//    procedure PaintDisabled;
    function GetSolidBorder: Boolean;
    function GetListHeight: Integer;
    procedure SetReadOnly(Value: Boolean);
  protected
    { Protected declarations }
    procedure CreateParams(var Params: TCreateParams); override;
    procedure ComboWndProc(var Message: TMessage; ComboWnd: HWnd; ComboProc: Pointer); override;
    procedure WndProc(var Message: TMessage); override;
    procedure CreateWnd; override;
    procedure DrawImage(DC: HDC; Index: Integer; R: TRect); dynamic;
//    property ListWidth: Integer read FListWidth write FListWidth;
//    property ReadOnly: Boolean read FReadOnly write SetReadOnly default False;
    property SolidBorder: Boolean read FSolidBorder;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    { Published declarations }
    property ListWidth: Integer read FListWidth write FListWidth;
    property ReadOnly: Boolean read FReadOnly write SetReadOnly default False;
    property Color;
    property DragMode;
    property DragCursor;
    property DropDownCount;
    property Enabled;
    property Font;
    property ItemHeight;
    property Items;
//    property ListWidth;
    property MaxLength;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property Sorted;
    property TabOrder;
    property TabStop;
    property Text;
//    property ReadOnly;
    property Visible;
    property ItemIndex;
    property OnChange;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnDrawItem;
    property OnDropDown;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnStartDrag;
{$IFDEF Delphi4}
    property Anchors;
    property BiDiMode;
    property Constraints;
    property DragKind;
    property ParentBiDiMode;
    property OnEndDock;
    property OnStartDock;
{$ENDIF}
  end;

procedure Register;

implementation

uses
{$IF CompilerVersion >= 23}
  Vcl.Forms;
{$ELSE}
  Forms;
{$IFEND}

{$IFDEF Delphi6}
{$WARN SYMBOL_DEPRECATED OFF}
{$ENDIF}

procedure Register;
begin
  RegisterComponents('Di.Ctrl', [TComboBox]);
end;

{ Utility functions }

function Min(val1, val2: Word): Word;
begin
  Result := val1;
  if val1 > val2 then
    Result := val2;
end;

function GetFontMetrics(Font: TFont): TTextMetric;
var
  DC: HDC;
  SaveFont: HFont;
begin
  DC := GetDC(0);
  SaveFont := SelectObject(DC, Font.Handle);
  GetTextMetrics(DC, Result);
  SelectObject(DC, SaveFont);
  ReleaseDC(0, DC);
end;

function GetFontHeight(Font: TFont): Integer;
begin
  Result := GetFontMetrics(Font).tmHeight;
end;

function Blend(C1, C2: TColor; W1: Integer): TColor;
var
  W2, A1, A2, D, F, G: Integer;
begin
  if C1 < 0 then C1 := GetSysColor(C1 and $FF);
  if C2 < 0 then C2 := GetSysColor(C2 and $FF);

  if W1 >= 100 then D := 1000
  else D := 100;

  W2 := D - W1;
  F := D div 2;

  A2 := C2 shr 16 * W2;
  A1 := C1 shr 16 * W1;
  G := (A1 + A2 + F) div D and $FF;
  Result := G shl 16;

  A2 := (C2 shr 8 and $FF) * W2;
  A1 := (C1 shr 8 and $FF) * W1;
  G := (A1 + A2 + F) div D and $FF;
  Result := Result or G shl 8;

  A2 := (C2 and $FF) * W2;
  A1 := (C1 and $FF) * W1;
  G := (A1 + A2 + F) div D and $FF;
  Result := Result or G;
end;

{ TComboBox }

constructor TComboBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FListInstance := MakeObjectInstance(ListWndProc);
  FDefListProc := nil;
  FButtonWidth := 11;
  ItemHeight := GetFontHeight(Font);
  Width := 100;
  FEditOffset := 0;
end;

destructor TComboBox.Destroy;
begin
  inherited Destroy;
  FreeObjectInstance(FListInstance);
end;

procedure TComboBox.SetReadOnly(Value: Boolean);
begin
  if FReadOnly <> Value then
  begin
    FReadOnly := Value;
    if HandleAllocated then
      SendMessage(EditHandle, EM_SETREADONLY, Ord(Value), 0);
  end;
end;

procedure TComboBox.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
    Style := (Style and not CBS_DROPDOWNLIST) or CBS_OWNERDRAWFIXED or CBS_DROPDOWN;
end;

procedure TComboBox.CreateWnd;
begin
  inherited;
  SendMessage(EditHandle, EM_SETREADONLY, Ord(FReadOnly), 0);
  // Desiding, which of the handles is DropDown list handle...
  if FChildHandle <> EditHandle then
    FListHandle := FChildHandle;
  //.. and superclassing it
  FDefListProc := Pointer(GetWindowLong(FListHandle, GWL_WNDPROC));
  SetWindowLong(FListHandle, GWL_WNDPROC, Longint(FListInstance));
end;

procedure TComboBox.ListWndProc(var Message: TMessage);
var
  p: TPoint;

  procedure CallDefaultProc;
  begin
    with Message do
      Result := CallWindowProc(FDefListProc, FListHandle, Msg, WParam, LParam);
  end;

begin
  case Message.Msg of
    LB_SETTOPINDEX:
      begin
        if ItemIndex > DropDownCount then
          CallDefaultProc;
      end;
    WM_WINDOWPOSCHANGING:
      with TWMWindowPosMsg(Message).WindowPos^ do
      begin
        // calculating the size of the drop down list
        if FListWidth <> 0 then
          cx := FListWidth else
          cx := Width;
        cy := GetListHeight;
        p.x := cx;
        p.y := cy + GetFontHeight(Font) + 6;
        p := ClientToScreen(p);
        FUpDropdown := False;
        if p.y > Screen.Height then //if DropDownList showing below
          begin
            FUpDropdown := True;
          end;
      end;
    else
      CallDefaultProc;
  end;
end;

procedure TComboBox.WndProc(var Message: TMessage);
begin
  case Message.Msg of
    WM_SETTEXT:
      Invalidate;
     WM_PARENTNOTIFY:
       if LoWord(Message.wParam)=WM_CREATE then begin
         if FDefListProc <> nil then
           begin
             // This check is necessary to be sure that combo is created, not
             // RECREATED (somehow CM_RECREATEWND does not work)
             SetWindowLong(FListHandle, GWL_WNDPROC, Longint(FDefListProc));
             FDefListProc := nil;
             FChildHandle := Message.lParam;
           end
          else
           begin
             // WM_Create is the only event I found where I can get the ListBox handle.
             // The fact that combo box usually creates more then 1 handle complicates the
             // things, so I have to have the FChildHandle to resolve it later (in CreateWnd).
             if FChildHandle = 0 then
               FChildHandle := Message.lParam
             else
               FListHandle := Message.lParam;
           end;
       end;
    WM_WINDOWPOSCHANGING:
      MoveWindow(EditHandle, 3+FEditOffset, 3, Width-FButtonWidth-8-FEditOffset,
        Height-6, True);
  end;
  inherited;
end;

procedure TComboBox.WMPaint(var Message: TWMPaint);
var
  PS {, PSE}: TPaintStruct;
begin
  BeginPaint(Handle,PS);
  try
//    if Enabled then
//    begin
      DrawImage(PS.HDC, ItemIndex ,Rect(3, 3, FEditOffset + 3, Height - 3));
      if GetSolidBorder then
      begin
        PaintBorder(PS.HDC, True);
        if DroppedDown then
          PaintButton(2)
        else
          PaintButton(1);
      end else
      begin
        PaintBorder(PS.HDC, False);
        PaintButton(0);
      end;
//    end else
//    begin
//      BeginPaint(EditHandle, PSE);
//      try
//        PaintDisabled;
//      finally
//        EndPaint(EditHandle, PSE);
//      end;
//    end;
  finally
    EndPaint(Handle,PS);
  end;
  Message.Result := 0;
end;

procedure TComboBox.DrawImage(DC: HDC; Index: Integer; R: TRect);
begin
  if FEditOffset > 0 then
   FillRect(DC, R, GetSysColorBrush(COLOR_WINDOW));
end;

procedure TComboBox.ComboWndProc(var Message: TMessage; ComboWnd: HWnd;
  ComboProc: Pointer);
var
  DC: HDC;
begin
  inherited;
  if (ComboWnd = EditHandle) then
    case Message.Msg of
      WM_SETFOCUS:
        begin
          DC:=GetWindowDC(Handle);
          PaintBorder(DC,True);
          PaintButton(1);
          ReleaseDC(Handle,DC);
        end;
      WM_KILLFOCUS:
        begin
          DC:=GetWindowDC(Handle);
          PaintBorder(DC,False);
          PaintButton(0);
          ReleaseDC(Handle,DC);
        end;
    end;
end;

procedure TComboBox.CNCommand(var Message: TWMCommand);
begin
  inherited;
  if (Message.NotifyCode in [CBN_CLOSEUP]) then
    PaintButton(1);
end;

procedure TComboBox.PaintBorder(DC: HDC; const SolidBorder: Boolean);
var
  R: TRect;
begin
  GetWindowRect(Handle, R);
  OffsetRect(R, -R.Left, -R.Top);
  if SolidBorder then
    FrameRect(DC, R, GetSysColorBrush(COLOR_HIGHLIGHT))
  else
    FrameRect(DC, R, GetSysColorBrush({}COLOR_BTNFACE{}{COLOR_WINDOW}));
  InflateRect(R, -1, -1);
  FrameRect(DC, R, GetSysColorBrush(COLOR_WINDOW));
  InflateRect(R, -1, -1);
  R.Right:=R.Right - FButtonWidth - 2;
  FrameRect(DC, R, GetSysColorBrush(COLOR_WINDOW));
end;

procedure TComboBox.PaintButtonGlyph(DC: HDC; X: Integer; Y: Integer; Color: TColor);
var
  Pen, SavePen: HPEN;
begin
  Pen := CreatePen(PS_SOLID, 1, ColorToRGB(Color));
  SavePen := SelectObject(DC, Pen);
  MoveToEx(DC, X, Y, nil);
  LineTo(DC, X + 5, Y);
  MoveToEx(DC, X + 1, Y + 1, nil);
  LineTo(DC, X + 4, Y + 1);
  MoveToEx(DC, x + 2, Y + 2, nil);
  LineTo(DC, X + 3, Y + 2);
  SelectObject(DC, SavePen);
  DeleteObject(Pen);
end;

procedure TComboBox.PaintButton(ButtonStyle: Integer);
var
  R: TRect;
  DC: HDC;
  X, Y: Integer;

  procedure FillButton(DC: HDC; R: TRect; Color: TColor);
  var
    Brush, SaveBrush: HBRUSH;
  begin
    Brush := CreateSolidBrush(ColorToRGB(Color));
    SaveBrush := SelectObject(DC, Brush);
    FillRect(DC, R, Brush);
    SelectObject(DC, SaveBrush);
    DeleteObject(Brush);
  end;

  procedure PaintButtonLine(DC: HDC; Color: TColor);
  var
    Pen, SavePen: HPEN;
    R: TRect;
  begin
    GetWindowRect(Handle, R);
    OffsetRect (R, -R.Left, -R.Top);
    InflateRect(R, -FButtonWidth - 4, -1);
    Pen := CreatePen(PS_SOLID, 1, ColorToRGB(Color));
    SavePen := SelectObject(DC, Pen);
    MoveToEx(DC, R.Right, R.Top, nil);
    LineTo(DC, R.Right, R.Bottom);
    SelectObject(DC, SavePen);
    DeleteObject(Pen);
  end;

begin
  DC := GetWindowDC(Handle);
  X := Trunc(FButtonWidth / 2) + Width - FButtonWidth - 4;
  Y := Trunc((Height - 4) / 2) + 1;
  SetRect(R, Width - FButtonWidth - 3, 1, Width - 1, Height - 1);
  if ButtonStyle = 0 then //No 3D border
  begin
    FillButton(DC, R, clBtnFace);
    FrameRect(DC, R, GetSysColorBrush(COLOR_WINDOW));
    PaintButtonLine(DC, clWindow);
    PaintButtonGlyph(DC, X, Y, clBtnText);
  end;
  if ButtonStyle = 1 then //3D up border
  begin
    FillButton(DC, R, Blend(clHighlight, clWindow, 30));
    PaintButtonLine(DC, clHighlight);
    PaintButtonGlyph(DC, X, Y, clBtnText);
  end;
  if ButtonStyle = 2 then //3D down border
  begin
    FillButton(DC, R, Blend(clHighlight, clWindow, 50));
    PaintButtonLine(DC, clHighlight);
    PaintButtonGlyph(DC, X, Y, clCaptionText);
  end;
  ReleaseDC(Handle, DC);
end;
//
//procedure TCtrlComboBox.PaintDisabled;
//var
//  R: TRect;
//  Brush, SaveBrush: HBRUSH;
//  DC: HDC;
//  BtnShadowBrush: HBRUSH;
//begin
//  BtnShadowBrush := GetSysColorBrush(COLOR_BTNSHADOW);
//  DC := GetWindowDC(Handle);
//  Brush := CreateSolidBrush(GetSysColor(COLOR_BTNFACE));
//  SaveBrush := SelectObject(DC, Brush);
//  FillRect(DC, ClientRect, Brush);
//  SelectObject(DC, SaveBrush);
//  DeleteObject(Brush);
//  GetWindowRect(Handle, R);
//  OffsetRect(R, -R.Left, -R.Top);
//  FrameRect(DC, R, BtnShadowBrush);
//  PaintButtonGlyph(DC, Trunc(FButtonWidth / 2) + Width - FButtonWidth - 4,
//    Trunc((Height - 4) / 2) + 1, clGrayText);
//  ReleaseDC(Handle,DC);
//end;

procedure TComboBox.CMEnabledChanged(var Msg: TMessage);
begin
  inherited;
  Invalidate;
end;

procedure TComboBox.CMMouseEnter(var Message: TMessage);
var
  DC: HDC;
begin
  inherited;
  msMouseInControl := True;
  if Enabled and not (GetFocus = EditHandle) and not DroppedDown then
  begin
    DC:=GetWindowDC(Handle);
    PaintBorder(DC, True);
    PaintButton(1);
    ReleaseDC(Handle, DC);
  end;
end;

procedure TComboBox.CMMouseLeave(var Message: TMessage);
var
  DC: HDC;
begin
  inherited;
  msMouseInControl := False;
  if Enabled  and not (GetFocus = EditHandle) and not DroppedDown then
  begin
    DC:=GetWindowDC(Handle);
    PaintBorder(DC, False);
    PaintButton(0);
    ReleaseDC(Handle, DC);
  end;
end;

function TComboBox.GetSolidBorder: Boolean;
begin
  Result := ((csDesigning in ComponentState)) or
    (DroppedDown or (GetFocus = EditHandle) or msMouseInControl);
end;

function TComboBox.GetListHeight: Integer;
begin
  Result := ItemHeight * Min(DropDownCount, Items.Count) + 2;
  if (DropDownCount <= 0) or (Items.Count = 0) then
    Result := ItemHeight + 2;
end;

procedure TComboBox.CMFontChanged(var Message: TMessage);
begin
  inherited;
  ItemHeight := GetFontHeight(Font);
  RecreateWnd;
end;
end.
