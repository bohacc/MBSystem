unit Utils;

{$mode objfpc}{$H+}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uConsts, Menus, ToolWin, ComCtrls,
  ExtCtrls, StdCtrls, ImgList, ActnList, DB,
  DBCtrls, DBGrids, sqldb, ZDataset, dproces;

function AppVerze(const Filename: string): string;
function Replace_char(_Str: string; _RepStr: string = ' ';
  _NewRepStr: string = ''): string;
function InitMenu(_MainMenu: TMainMenu; _Name: string; _Caption: TCaption;
  Sort: integer = -1): boolean;
procedure InitPopup(_PopupMenu: TPopupMenu; _Name: string;
  _Caption: TCaption; _OnClick: TNotifyEvent;
  _Checked: boolean = False; _Enable: boolean = True);
procedure Refresh_DataSet(_DataSet: TDataSet; _Query: TZQuery = nil);
function ExecSql_old(_sql: string): string;
procedure ExecSql(_sql: string);
procedure miMainMenuClick(Sender: TObject);
procedure InitDBComboSQL(_SQL: string; _ComboBox: TDBComboBox);
procedure InitComboSQL(_SQL: string; _ComboBox: TComboBox);
function Get_cached_int(_sql: string; _text: string): integer;
function Get_cached_string(_sql: string; _text: string): string;
function Get_licence(_str: string): boolean;
function Get_ComputerName: string;
function Get_UserName: string;
function GetDiskInfo(Disk: char; var sVolName, sVolBuff: string;
  var iSerNum: integer): boolean;
procedure trideni(_Query: TZQuery; _Column: TColumn; _SQL_Default: string;
  var _Q: integer);
function generuj_uc(_s: string; lan: integer = 0): string;
function generuj_licenci(_s: string): string;
//function Diakritika(_s : char) : char;
function Q(s: string): string;
function get_param(s: string): string;

function porovnej_ref_kod(astr, amaska, odd: string): integer;
function najdi_ref_kod(astr, amaska, odd: string): string;
function najdi_ucet(astr: string): string;
function najdi_var_symb(astr: string): string;
function najdi_podani_doruceno(astr: string): string;
function najdi_bezne_cislo(astr: string): string;
function najdi_podani_overeno(astr: string): string;
function najdi_zaslanych_priloh(astr: string): string;
function najdi_zpusob_podani(astr: string): string;
function najdi_podpis_cert_platny(astr: string): string;
function najdi_soud(astr: string): string;
function najdi_typ_formulare(astr: string): string;
function najdi_spis_znacka(astr: string): string;
function najdi_ke_zpracovani(astr: string): string;
function replace(str: string; find: string; new: string): string;
function neprelozitelne_objekty: boolean;
function getDateFormat(str: string): string;
procedure exportZalobyTxt(tbl:string);
procedure exportZalobyZpravyTxt(tbl: string);
procedure exportZalobyZpravyTypyTxt(tbl: string);
procedure importZalobyZpravyTypyTxt(tbl: string);
procedure importZalobyZpravyTxt(tbl: string; tbl_ref : string);
procedure importZalobyTxt(tbl: string);
procedure split(Delimiter: String; Str : String; Arr : TStrings; Frm : TfrmProces);

var
  _savebookmark: TBookmarkStr;

implementation

uses Data_module, FMain;

function Replace_char(_Str: string; _RepStr: string = ' ';
  _NewRepStr: string = ''): string;
var
  i: integer;
  w: string;
begin
  w := _Str;
  if _Str <> '' then
  begin
    w := '';
    for i := 1 to Length(_Str) do
    begin
      if _Str[i] = _RepStr then
        w := w + _NewRepStr
      else
        w := w + _Str[i];
    end;

  end;
  Result := w;
end;

function AppVerze(const Filename: string): string;
var
  dwHandle: THandle;
  dwSize:   DWORD;
  lpData, lpData2: Pointer;
  uiSize:   UINT;
begin
  Result := '';
  dwSize := GetFileVersionInfoSize(PChar(FileName), dwSize);
  if dwSize <> 0 then
  begin
    GetMem(lpData, dwSize);
    if GetFileVersionInfo(PChar(FileName), dwHandle, dwSize, lpData) then
    begin
      uiSize := Sizeof(TVSFixedFileInfo);
      VerQueryValue(lpData, '\', lpData2, uiSize);
      with PVSFixedFileInfo(lpData2)^ do
        Result := Format('%d.%02d.%02d.%02d', [HiWord(dwProductVersionMS),
          LoWord(dwProductVersionMS), HiWord(dwProductVersionLS), LoWord(dwProductVersionLS)]);
    end;
    FreeMem(lpData, dwSize);
  end;
end;

function InitMenu(_MainMenu: TMainMenu; _Name: string; _Caption: TCaption;
  Sort: integer = -1): boolean;
var
  MenuItem: TMenuItem;
begin
  try
    MenuItem := TMenuItem.Create(nil);

    if Sort = -1 then
    begin
      MenuItem      := TMenuItem.Create(nil);
      MenuItem.Name := _Name;
      MenuItem.Caption := _Caption;
      _MainMenu.Items.Add(MenuItem);
    end
    else
    begin
      MenuItem      := TMenuItem.Create(nil);
      MenuItem.Name := _Name;
      MenuItem.Caption := _Caption;
      _MainMenu.Items[Sort].Add(MenuItem);
    end;

{  if Sort= -1 then
  begin
   MenuItem:=TMenuItem.Create(nil);
   MenuItem.Name:=_Name;
   MenuItem.Caption:=_Caption;
   MainMenu.Items.Add(MenuItem);
  end;

  if Sort = 0 then
  begin
   MenuItem:=TMenuItem.Create(nil);
   MenuItem.Name:=_Name;
   MenuItem.Caption:=_Caption;
   MainMenu.Items[0].Add(MenuItem);
  end;

  if Sort = 1 then
  begin
   MenuItem:=TMenuItem.Create(nil);
   MenuItem.Name:=_Name;
   MenuItem.Caption:=_Caption;
   MainMenu.Items[1].Add(MenuItem);
  end;
}
    Result := True;
  finally
  end;
end;

procedure InitPopup(_PopupMenu: TPopupMenu; _Name: string;
  _Caption: TCaption; _OnClick: TNotifyEvent;
  _Checked: boolean = False; _Enable: boolean = True);
var
  MenuItem: TMenuItem;
begin
  try
    MenuItem      := TMenuItem.Create(nil);
    MenuItem.Caption := _Caption;
    MenuItem.Name := _Name;
    MenuItem.OnClick := _OnClick;
    MenuItem.Checked := _Checked;
    MenuItem.Enabled := _Enable;

    _PopupMenu.Items.Add(MenuItem);
  finally
  end;
end;

{
procedure commit_tr(_DataSet : TDataSet; _Transaction : TTransaction);
var
_save : TBookmarkStr;
_hwnd : HWND;
begin
 _save := _DataSet.Bookmark;
 try
   try
    _DataSet.DisableControls;
    _Transaction.Commit;
    _DataSet.Open;
   finally
    _DataSet.EnableControls;
    _DataSet.Bookmark:=_save;
   end;
 except
   MessageBox(_hwnd,'Chyba při commitu transakce.','Chyba',MB_OK);
 end;
end;

procedure rollback_tr(_DataSet : TIBDataSet; _Transaction : TIBTransaction);
var
_save : TBookmarkStr;
_hwnd : HWND;
begin
 _save := _DataSet.Bookmark;
 try
   try
    _DataSet.DisableControls;
    _Transaction.Rollback;
    _DataSet.Open;
   finally
    _DataSet.EnableControls;
    _DataSet.Bookmark:=_save;
   end;
 except
   MessageBox(_hwnd,'Chyba při rollbacku transakce.','Chyba', MB_OK);
 end;
end;
}
procedure Refresh_DataSet(_DataSet: TDataSet; _Query: TZQuery = nil);
var
  _save: TBookmark;
begin
  try
    //try
      //_save := _DataSet.Bookmark;
      _save := _Query.Bookmark;
      //_DataSet.DisableControls;
      //((_DataSet)as TQuery).Database.StartTransaction;
      //((_DataSet)as TQuery).Close;
      //((_DataSet)as TQuery).Open;
      //((_DataSet)as TQuery).Refresh;
      //((_DataSet)as TQuery).Database.Commit;
      //_Query.Database.StartTransaction;
      _Query.DisableControls;
      _Query.Close;
      _Query.Open;
      _Query.EnableControls;
      //_Query.Refresh;
      //_DataSet.Close;
      //_DataSet.Open;
      //_DataSet.Refresh;
      //_Query.Database.Commit;
      //((_DataSet)as TQuery).Database.Commit;
    //finally
      //_DataSet.EnableControls;
      //_DataSet.Bookmark:=_save;
      _Query.Bookmark := _save;
      //else
      //  ;
      //_Query.Bookmark:=_savebookmark;
    //end;
  except
  end;
end;

function ExecSql_old(_sql: string): string;
var
  _Query: TZQuery;
  _Value: string;
begin
  _Query := nil;
  try
    _Query := TZQuery.Create(nil);
    _Query.Connection := DM.OracleConnection;
    //_Query.RequestLive:=True;
    //_Query.Transaction:=DM.SQLTransaction;
    _Query.SQL.Text := _sql;
    _Query.Open;

    _Value := _Query.Fields.Fields[0].AsString;
    //if _Value = '' then _Value:='0';
    Result := _Value;
  finally
    if Assigned(_Query) then
    begin
      _Query.Close;
      _Query.Free;
      _Query := nil;
    end;
  end;
end;

procedure ExecSql(_sql: string);
var
  _Query: TZQuery;
begin
  _Query := nil;
  try
    _Query := TZQuery.Create(nil);
    _Query.Connection := DM.OracleConnection;
    _Query.ReadOnly := False;
    //_Query.Transaction:=DM.SQLTransaction;
    _Query.SQL.Text := _sql;
    _Query.ExecSQL;

  finally
    if Assigned(_Query) then
    begin
      _Query.Close;
      _Query.Free;
      _Query := nil;
    end;
  end;
end;

procedure miMainMenuClick(Sender: TObject);
begin
  TForm(Sender).Show;
end;

procedure InitComboSQL(_SQL: string; _ComboBox: TComboBox);
var
  _Query: TZQuery;
begin
  _Query := nil;
  try
    _Query := TZQuery.Create(nil);
    _Query.Connection := DM.OracleConnection;
    _Query.ReadOnly := False;
    //_Query.Transaction:=DM.SQLTransaction;
    _Query.SQL.Text := _SQL;
    _Query.Open;
    _ComboBox.Items.Clear;

    while not _Query.EOF do
    begin
      _ComboBox.Items.Add(_Query.Fields.Fields[0].AsString);
      _Query.Next;
    end;

  finally
    if Assigned(_Query) then
    begin
      _Query.Close;
      _Query.Free;
      _Query := nil;
    end;
  end;

end;

procedure InitDBComboSQL(_SQL: string; _ComboBox: TDBComboBox);
var
  _Query: TZQuery;
begin
  _Query := nil;
  try
    _Query := TZQuery.Create(nil);
    _Query.Connection := DM.OracleConnection;
    _Query.ReadOnly := False;
    //_Query.Transaction:=DM.SQLTransaction;
    _Query.SQL.Text := _SQL;
    _Query.Open;
    _ComboBox.Items.Clear;

    while not _Query.EOF do
    begin
      _ComboBox.Items.Add(_Query.Fields.Fields[0].AsString);
      _Query.Next;
    end;

  finally
    if Assigned(_Query) then
    begin
      _Query.Close;
      _Query.Free;
      _Query := nil;
    end;
  end;

end;

function Get_cached_int(_sql: string; _text: string): integer;
var
  _Query: TZQuery;
  _c:     string;
begin
  _Query := nil;
  try
    _Query := TZQuery.Create(nil);
    _Query.Connection := DM.OracleConnection;
    _Query.ReadOnly := False;
    //_Query.Transaction:=DM.SQLTransaction;
    _c     := _SQL + '''' + _text + '''';
    _Query.SQL.Text := _c;
    _Query.Open;

    Result := _Query.Fields.Fields[0].AsInteger;
  finally
    if Assigned(_Query) then
    begin
      _Query.Close;
      _Query.Free;
      _Query := nil;
    end;
  end;

end;

function Get_cached_string(_sql: string; _text: string): string;
var
  _Query: TZQuery;
  _c:     string;
  _r:     string;
begin
  _r     := '';
  _Query := nil;
  try
    _Query := TZQuery.Create(nil);
    _Query.Connection := DM.OracleConnection;
    _Query.ReadOnly := False;
    //_Query.Transaction:=DM.SQLTransaction;
    _c     := _SQL + _text;
    _Query.SQL.Text := _c;
    if _text <> '' then
    begin
      _Query.Open;
      _r := _Query.Fields.Fields[0].AsString;
    end;
  finally
    if Assigned(_Query) then
    begin
      _Query.Close;
      _Query.Free;
      _Query := nil;
    end;
  end;

  Result := _r;

end;

function Get_licence(_str: string): boolean;
var
  r:      boolean;
  _l, _c: string;
  _Query: TZQuery;
begin
  r      := False;
  _Query := nil;
  try
    _Query := TZQuery.Create(nil);
    _Query.Connection := DM.OracleConnection;
    _Query.ReadOnly := False;
    //_Query.Transaction:=DM.SQLTransaction;
    _c     := 'SELECT KOD FROM LICENCE';
    _Query.SQL.Text := _c;
    _Query.Open;
    _l := _Query.Fields.Fields[0].AsString;
  finally
    if Assigned(_Query) then
    begin
      _Query.Close;
      _Query.Free;
      _Query := nil;
    end;
  end;

  if length(_l) <> 13 then
  begin
    r := False;
  end
  else
  begin

    r := True;
  end;

  Result := r;
end;

function Get_ComputerName: string;
const
  cnMaxLen = 254;
var
  sCompName:     string;
  dwCompNameLen: DWord;
begin
  Result := '';
  dwCompNameLen := cnMaxLen - 1;
  SetLength(sCompName, cnMaxLen);
  GetComputerName(PChar(sCompName), dwCompNameLen);
  SetLength(sCompName, dwCompNameLen);
  Result := sCompName;
  if dwCompNameLen = cnMaxLen - 1 then
    Result := '';
end;

function Get_UserName: string;
const
  cnMaxLen = 254;
var
  sUserName:     string;
  dwUserNameLen: DWord;
begin
  Result := '';
  dwUserNameLen := cnMaxLen - 1;
  SetLength(sUserName, cnMaxLen);
  GetUserName(PChar(sUserName), dwUserNameLen);
  SetLength(sUserName, dwUserNameLen);
  Result := sUserName;
  if dwUserNameLen = cnMaxLen - 1 then
    Result := '';
end;

function GetDiskInfo(Disk: char; var sVolName, sVolBuff: string;
  var iSerNum: integer): boolean;
var
  VolName: array [0..255] of char;
  DriveName: array [0..255] of char;
  VolNameSize: integer;
  MaxCompLength: cardinal;
  FSNameBuffer: array [0..255] of char;
  FSNameSize: integer;
  Flags: cardinal;
begin
  // Nastevení a vymazání základních parametru
  Result := False;
  FillChar(DriveName, SizeOf(DriveName), #0);
  FillChar(VolName, SizeOf(VolName), #0);
  FillChar(FSNameBuffer, SizeOf(FSNameBuffer), #0);

  VolNameSize := SizeOf(VolName);
  FSNameSize  := SizeOf(FSNameBuffer);

  // Nastavení názvu disku
  DriveName[0] := Disk;
  DriveName[1] := ':';
  DriveName[2] := #92;

  // Získání vlastních informací pomocí GetVolumeInformation
  Result := GetVolumeInformation(DriveName, VolName, VolNameSize,
    @iSerNum, MaxCompLength, Flags, FSNameBuffer, FSNameSize);

  // Naplnění předávaných parametrů
  sVolName := StrPas(VolName);
  sVolBuff := StrPas(FSNameBuffer);
end;

procedure trideni(_Query: TZQuery; _Column: TColumn; _SQL_Default: string;
  var _Q: integer);
var
  p:  TParams;
  i:  integer;
  t:  TFieldType;
  qq: integer;
  bRequestLive: boolean;
begin

  if _Q = 0 then
    qq := 1
  else
  if _Q = 1 then
    qq := 2
  else
    qq := 0;

  _Q := qq;

  {
   _Query:=TQuery.Create(nil);
   _Query.DatabaseName:=DM.Database.DatabaseName;
   _Query.RequestLive:=True;
   _Query.SessionName:=DM.Database.SessionName;
   }
  try
    bRequestLive := _Query.ReadOnly;
    p := _Query.Params;
    //_Query.DisableControls;
    _Query.Close;
    if _Q = 0 then
      _Query.SQL.Text := _SQL_Default
    else
    if _Q = 1 then
    begin
      if pos('ORDER', uppercase(_SQL_Default)) > 0 then
        _Query.SQL.Text := copy(_SQL_Default, 1, pos('ORDER', uppercase(_SQL_Default)) - 1) +
          ' ORDER BY ' + _Column.FieldName + ' ASC'
      //'SELECT * FROM ('+_SQL_Default+') S ORDER BY '+_Column.FieldName+' ASC'
      else
        _Query.SQL.Text := _SQL_Default + ' ORDER BY ' + _Column.FieldName + ' ASC';
      //'SELECT * FROM ('+_SQL_Default+') S ORDER BY '+_Column.FieldName+' ASC'
    end
    else
    begin
      if pos('ORDER', uppercase(_SQL_Default)) > 0 then
        _Query.SQL.Text := copy(_SQL_Default, 1, pos('ORDER', uppercase(_SQL_Default)) - 1) +
          ' ORDER BY ' + _Column.FieldName + ' DESC'
      //'SELECT * FROM ('+_SQL_Default+') S ORDER BY '+_Column.FieldName+' DESC';
      else
        _Query.SQL.Text := _SQL_Default + ' ORDER BY ' + _Column.FieldName + ' DESC';
      //'SELECT * FROM ('+_SQL_Default+') S ORDER BY '+_Column.FieldName+' DESC';
    end;

    _Query.ReadOnly := bRequestLive;
    //_Query.Params:=p;
    {
    for i:=1 to _Query.ParamCount do
    begin
      _Query.Params.Items[i-1].DataType:=p.Items[i-1].DataType;
    end;
    }
    _Query.Open;
    //_Query.EnableControls;
  except
    //_Query.DisableControls;
    _Query.Close;
    _Query.SQL.Text := _SQL_Default;
    _Query.ReadOnly := False;
    //_Query.Params:=p;
    _Query.Open;
    //_Query.EnableControls;
  end;
end;

function generuj_licenci(_s: string): string;
var
  l, a, aa, b, c, cc, d, dd, p, s: string;
  i, n: integer;
  m:    currency;
begin

  //-- Platnost licence
  //p:=copy(_s,length(_s)-8,length(_s));

  n := 0;
  m := 0;
  for i := 1 to length(_s) do
  begin
    n  := n + 1;
    aa := aa + _s[i];
    if n = 6 then
    begin
      m  := m + StrToFloat(aa);
      n  := 0;
      aa := '';
    end;
    if (i = length(_s)) and (length(aa) < 6) then
      a := FloatToStr(m) + aa;
  end;

  b := IntToStr(length(_s));
  if length(b) = 1 then
    b := '000' + b
  else
  if length(b) = 2 then
    b := '00' + b
  else
  if length(b) = 3 then
    b := '0' + b
  else
  if length(b) = 0 then
    b := '0000';

  cc := Get_ComputerName;
  for i := 1 to length(cc) do
  begin
    n := Ord(cc[i]);
    c := c + IntToStr(n);
  end;
  c  := c + '-';
  cc := Get_UserName;
  for i := 1 to length(cc) do
  begin
    n := Ord(cc[i]);
    c := c + IntToStr(n);
  end;


  l := a + '-' + b; //+'-'+p; //+'-'+c+'-'+d;

  Result := l;
end;

function generuj_uc(_s: string; lan: integer = 0): string;
var
  uc, s: string;
  i, n:  integer;
begin

  if lan = 1 then
    s := _s
  else
    s := _s + Get_ComputerName + Get_UserName;
  for i := 1 to length(s) do
  begin
    n  := Ord(s[i]);
    uc := uc + IntToStr(n);
  end;

  Result := uc;

end;

{function Diakritika(_s : char) : char;
var
_c : char;
_n : string;
_m : string;
_abc : string;
i : integer;
ii : integer;
begin
 try  // 123456789ABCDEF
  _n := 'ÁČĎÉĚÍŇÓŘŠŤÚŮÝŽ';
  _m := 'ACDEEINORSTUUYZ';
  _abc := '';

  i:=0;
  while i < length(_n) do
   begin
    i:=i+1;
    if _n[i] = _s then
      _c:=_m[i];
   end;

  if _c = '' then
  begin
    ii:=0;
    while ii < length(_abc) do
     begin
       ii:=ii+1;
       if _abc[ii] = _s then
         _c:=_s;
     end;
  end;

 finally
   Result := _c;
 end;
end;
}

function Q(s: string): string;
var
  str: string;
begin
  str    := '''' + s + '''';
  Result := str;
end;

function get_param(s: string): string;
var
  r: string;
begin
  try
    r      := ExecSql_old('SELECT HODNOTA FROM PARAMETRY WHERE KOD=' + Q(s));
    Result := r;
  except
    Result := '';
  end;
end;

function porovnej_ref_kod(astr, amaska, odd: string): integer;
var
  p, n, pocet: integer;
  aSTR_TMP, aSTR_MASKA, aTMP, aTMP_MASKA: string;
begin
  try
    p     := 1;
    n     := 0;
    pocet := 0;

    aTMP := aMASKA;
    while POS(odd, aTMP) > 0 do
    begin
      aTMP  := copy(aTMP, POS(odd, aTMP) + 1, length(aTMP) - POS(odd, aTMP));
      pocet := pocet + 1;
    end;

    aSTR_TMP   := aSTR;
    aSTR_MASKA := aMASKA;
    while POS(odd, aSTR_TMP) > 0 do
    begin
      n := n + 1;
      if POS(odd, aSTR_TMP) <> POS(odd, aSTR_MASKA) then
      begin
        p := 0;
        exit;
      end;
      aSTR_TMP   := copy(aSTR_TMP, POS(odd, aSTR_TMP) + 1, length(aSTR_TMP) - POS(odd, aSTR_TMP));
      aSTR_MASKA := copy(aSTR_MASKA, POS(odd, aSTR_MASKA) + 1, length(aSTR_MASKA) -
        POS(odd, aSTR_MASKA));
    end;

    if n <> pocet then
      p := 0;

    Result := p;

  except
    Result := 0;
  end;
end;

function najdi_ref_kod(astr, amaska, odd: string): string;
var
  p, aPOCET_PRED, aPOCET_CELKEM, aPOCET_ZA: integer;
  aSTR_TMP, aTMP, aREF_KOD: string;
begin
  try
    aPOCET_PRED   := POS(odd, aMASKA) - 1;
    aPOCET_CELKEM := LENGTH(aMASKA);
    aSTR_TMP      := aSTR;
    while POS(odd, aSTR_TMP) > 0 do
    begin
      aTMP     := copy(aSTR_TMP, POS(odd, aSTR_TMP) + 1, length(aSTR_TMP) - POS(odd, aSTR_TMP));
      aSTR_TMP := copy(aSTR_TMP, POS(odd, aSTR_TMP) - aPOCET_PRED, aPOCET_CELKEM);
      if porovnej_ref_kod(aSTR_TMP, aMASKA, odd) = 1 then
      begin
        aREF_KOD := aSTR_TMP;
        break;
      end
      else
        aSTR_TMP := aTMP;
    end;

    Result := aREF_KOD;

  except
    Result := '';
  end;
end;

function najdi_ucet(astr: string): string;
var
  r, f, Text: string;
  z, k: integer;
begin
  try
    Text := UTF8Encode(astr);
    f    := 'číslo účtu ';
    z    := pos(f, Text);
    if z = 0 then
    begin
      f := '?íslo ú?tu ';
      z := pos(f, Text);
    end;
    if z = 0 then
    begin
      f := '??slo ??tu ';
      z := pos(f, Text);
    end;
    //ShowMessage(IntToStr(z));
    k := pos('/', copy(Text, z + length(f), 30));
    if (k > 0) and (z > 0) then
      r := copy(Text, z + length(f), k + 4);
  finally
    Result := r;
  end;
end;

function najdi_var_symb(astr: string): string;
var
  r, f, t, s, Text: string;
  z, k: integer;
begin
  try
    Text := UTF8Encode(astr);
    f    := 'VS :';
    z    := pos(f, Text);
    if z = 0 then
    begin
      f := 'variabilním symbolem ';
      z := pos(f, Text);
    end;
    if z = 0 then
    begin
      f := 'variabiln?m symbolem ';
      z := pos(f, Text);
    end;
    if z > 0 then
    begin
      t := copy(Text, z + length(f), 10);
      for k := 1 to 10 do
      begin
        s := copy(t, k, 1);
        if pos(s, '0123456789') > 0 then
          r := r + s
        else
          break;
      end;
    end;
  finally
    Result := r;
  end;
end;

function najdi_podani_doruceno(astr: string): string;
var
  r, f, t, s: string;
  z, k: integer;
begin
  try
    f := 'doručeno dne ';
    z := pos(f, astr);
    if z = 0 then
    begin
      f := 'doru?eno dne ';
      z := pos(f, astr);
    end;
    if z = 0 then
    begin
      f := 'doručené dne ';
      z := pos(f, astr);
    end;
    if z = 0 then
    begin
      f := 'doru?ené dne ';
      z := pos(f, astr);
    end;
    if z > 0 then
      t := copy(astr, z + length(f), 21);
    {for k:=1 to 21 do
    begin
      s:=copy(t,k,1);
      if pos(s,'0123456789. :v')>0 then
        r:=r+s
      else
        break;
    end;}
  finally
    Result := t;
  end;
end;

function najdi_bezne_cislo(astr: string): string;
var
  r, f, t, s: string;
  z, k: integer;
begin
  try
    f := 'běžným číslem ';
    z := pos(f, astr);
    if z = 0 then
    begin
      f := 'b?žným ?íslem ';
      z := pos(f, astr);
    end;
    if z > 0 then
    begin
      t := copy(astr, z + length(f), 30);
      for k := 1 to 30 do
      begin
        s := copy(t, k, 1);
        if pos(s, '0123456789/') > 0 then
          r := r + s
        else
          break;
      end;
    end;
  finally
    Result := r;
  end;
end;

function najdi_podani_overeno(astr: string): string;
var
  r, f, t, s: string;
  z, k: integer;
begin
  try
    f := 'bylo ověřeno dne ';
    z := pos(f, astr);
    if z = 0 then
    begin
      f := 'a ověřené dne ';
      z := pos(f, astr);
    end;
    if z = 0 then
    begin
      f := 'bylo ov??eno dne ';
      z := pos(f, astr);
    end;
    if z > 0 then
      t := copy(astr, z + length(f), 21);
    {for k:=1 to 21 do
    begin
      s:=copy(t,k,1);
      if pos(s,'0123456789. :v')>0 then
        r:=r+s
      else
        break;
    end;}
  finally
    Result := t;
  end;
end;

function najdi_zaslanych_priloh(astr: string): string;
var
  r, f, t, s: string;
  z, k: integer;
begin
  try
    f := 'Počet zaslaných příloh: ';
    z := pos(f, astr);
    if z = 0 then
    begin
      f := 'Po?et zaslaných p?íloh: ';
      z := pos(f, astr);
    end;
    if z > 0 then
    begin
      t := copy(astr, z + length(f), 5);
      for k := 1 to 5 do
      begin
        s := copy(t, k, 1);
        if pos(s, '0123456789') > 0 then
          r := r + s
        else
          break;
      end;
    end;
  finally
    Result := r;
  end;
end;

function najdi_zpusob_podani(astr: string): string;
var
  r, f, t, s: string;
  z, k: integer;
begin
  try
    f := 'Bylo podáno ';
    z := pos(f, astr);
    if z > 0 then
      t := copy(astr, z + length(f), pos(' formulářem', astr) - (z + length(f)));
  finally
    Result := t;
  end;
end;

function najdi_podpis_cert_platny(astr: string): string;
var
  r, f, t, s: string;
  z, k: integer;
begin
  try
    f := 'byl vyhodnocen jako ';
    z := pos(f, astr);
    if z > 0 then
      t := copy(astr, z + length(f), pos('.', copy(astr, z + length(f), 30)) - 1);
  finally
    Result := t;
  end;
end;

function najdi_soud(astr: string): string;
var
  r, f, t, s, s2, st, st2, Text: string;
  z, k, p, p2: integer;
begin
  try
    Text := UTF8Encode(astr);
    f    := ' SOUD ';
    z    := pos(f, UpperCase(Text));
    //ShowMessage(IntToStr(z));
    if z > 0 then
    begin
      for k := 1 to 50 do
      begin
        s  := copy(Text, z - k, 1);
        s2 := copy(Text, z - (k + 5), 6);
        if (s = #13) or (s = #10) or (s = #13 + #10) or (s = #10 + #10) or (s2 = '<span>') then
          break
        else
        begin
          p  := k;
          st := s + st;
        end;
      end;
      for k := 1 to 50 do
      begin
        s  := copy(Text, (z - 1) + k, 1);
        s2 := copy(Text, (z - 1) + k, 7);
        if (s = #13) or (s = #10) or (s = #13 + #10) or (s = #10 + #10) or (s2 = '</span>') then
          break
        else
        begin
          p   := k;
          st2 := st2 + s;
        end;
      end;
    end;
    if (length(st) > 0) or (length(st2) > 0) then
      t := st + st2;
  finally
    Result := t;
  end;
end;

function najdi_typ_formulare(astr: string): string;
var
  r, f, t, s: string;
  z, k: integer;
begin
  try
    f := 'formulářem typu ';
    z := pos(f, astr);
    if z = 0 then
    begin
      f := 'formulá?em typu ';
      z := pos(f, astr);
    end;
    if z > 0 then
      t := copy(astr, z + length(f), pos('.', copy(astr, z + length(f), 30)) - 1);
  finally
    Result := t;
  end;
end;

function najdi_spis_znacka(astr: string): string;
var
  r, f, t, s: string;
  z, k: integer;
begin
  try
    f := 'spisové značce "';
    z := pos(f, astr);
    if z = 0 then
    begin
      f := 'spisové zna?ce "';
      z := pos(f, astr);
    end;
    if z > 0 then
      t := copy(astr, z + length(f), pos('" a ke', copy(astr, z + length(f), 30)) - 1);
  finally
    Result := t;
  end;
end;

function najdi_ke_zpracovani(astr: string): string;
var
  r, f, t, s: string;
  z, k: integer;
begin
  try
    f := 'ke zpracování dne ';
    z := pos(f, astr);
    if z > 0 then
      t := copy(astr, z + length(f), 21);
  finally
    Result := t;
  end;
end;

function replace(str: string; find: string; new: string): string;
var
  r:    string;
  p, i: integer;
begin
  r := str;
  i := 0;
  while pos(find, r) > 0 do
  begin
    //ShowMessage(r+'A');
    p := pos(find, r);
    //ShowMessage(IntToStr(p));
    if p > 1 then
      r := copy(r, 1, p - 1) + new + copy(r, p + length(find), length(r) - (p - 1 + length(find)))
    else
      r := new + copy(r, p + length(find), length(r) - (p - 1 + length(find)));
    i := i + 1;
    //ShowMessage(IntToStr(i));
    if i > 32000 then
      break;
    //ShowMessage(r+'B');
  end;
  Result := r;
end;

function neprelozitelne_objekty: boolean;
var
  r: boolean;
  v: string;
begin
  r := False;
  try
    v := ExecSql_old('Select count(*) From user_objects where status <> ''VALID''');
    r := 0 < StrToInt(v);
  finally
  end;
  Result := r;
end;

function getDateFormat(str: string): string;
var
  tmp, fmt, del: string;
begin
  try
    tmp := str;
    fmt := ExecSql_old('SELECT MAX(DATE_FORMAT) FROM NASTAVENI_SYSTEMU');
    if length(fmt) > 0 then
    begin
      fmt := replace(fmt, '0', '');
      fmt := replace(fmt, '1', '');
      fmt := replace(fmt, '2', '');
      fmt := replace(fmt, '3', '');
      fmt := replace(fmt, '4', '');
      fmt := replace(fmt, '5', '');
      fmt := replace(fmt, '6', '');
      fmt := replace(fmt, '7', '');
      fmt := replace(fmt, '8', '');
      fmt := replace(fmt, '9', '');
      fmt := copy(fmt, 1, 1);

      del := str;
      del := replace(del, '0', '');
      del := replace(del, '1', '');
      del := replace(del, '2', '');
      del := replace(del, '3', '');
      del := replace(del, '4', '');
      del := replace(del, '5', '');
      del := replace(del, '6', '');
      del := replace(del, '7', '');
      del := replace(del, '8', '');
      del := replace(del, '9', '');
      del := copy(del, 1, 1);
      tmp := replace(str, del, fmt);

    end;
  except
    tmp := str;
  end;
  Result := tmp;
end;

procedure exportZalobyTxt(tbl: string);
var
  _Query: TZQuery;
  _list:  TStringList;
  row:    string;
begin
  _Query := nil;
  try
    if not Assigned(frmProces) then
    begin
      Application.CreateForm(TfrmProces, frmProces);
    end;
    frmProces.ShowOnTop;
    frmProces.lbProces.Caption      := 'Probíhá export žalob, čekejte...';
    frmProces.ProgressBar1.Step     := 1;
    frmProces.ProgressBar1.Min      := 1;
    frmProces.ProgressBar1.Position := 1;
    frmProces.ShowOnTop;
    frmProces.lbPom.Caption := '0';
    frmProces.Repaint;
    _list  := TStringList.Create;
    _Query := TZQuery.Create(nil);
    _Query.Connection := DM.OracleConnection;
    _Query.ReadOnly := true;
    _Query.SQL.Text := 'SELECT * FROM '+tbl;
    _Query.Open;
    frmProces.ProgressBar1.Max := _Query.RecordCount;
    _Query.First;
    row := '';
    while not _Query.EOF do
    begin
      row := row + _Query.FieldByName('ID').AsString + ';';
      row := row + _Query.FieldByName('VAR_SYMB').AsString + ';';
      row := row + _Query.FieldByName('JMENO_CP').AsString + ';';
      row := row + _Query.FieldByName('DATUM_CAS').AsString + ';';
      row := row + _Query.FieldByName('DLUZNA_CASTKA').AsString + ';';
      row := row + _Query.FieldByName('JIZDNE').AsString + ';';
      row := row + _Query.FieldByName('POKUTA').AsString + ';';
      row := row + _Query.FieldByName('RODNE_CISLO').AsString + ';';
      row := row + _Query.FieldByName('ULICE').AsString + ';';
      row := row + _Query.FieldByName('CISLO_DOMU').AsString + ';';
      row := row + _Query.FieldByName('MESTO').AsString + ';';
      row := row + _Query.FieldByName('OBVOD').AsString + ';';
      row := row + _Query.FieldByName('PSC').AsString + ';';
      row := row + _Query.FieldByName('REF_KOD').AsString + ';';
      row := row + _Query.FieldByName('UZAMCENA').AsString + ';';
      row := row + _Query.FieldByName('DATUM_IMPORTU').AsString + ';';
      row := row + _Query.FieldByName('DATUM_UZAMCENI').AsString + ';';
      row := row + _Query.FieldByName('PL_PRIKAZ').AsString + ';';
      row := row + _Query.FieldByName('UHRADA').AsString + ';';
      row := row + _Query.FieldByName('SPLATNOST').AsString + ';';
      row := row + _Query.FieldByName('SOUD').AsString + ';';
      row := row + _Query.FieldByName('ZALOBA').AsString + ';';
      row := row + _Query.FieldByName('NAROK').AsString + ';';
      row := row + _Query.FieldByName('VS_SOUDU').AsString + ';';
      row := row + _Query.FieldByName('CU_SOUDU').AsString + ';';
      row := row + _Query.FieldByName('SPIS_ZNACKA').AsString + ';';
      row := row + _Query.FieldByName('UHR_SOP').AsString + ';';
      row := row + _Query.FieldByName('ODVOLANI').AsString + ';';
      row := row + _Query.FieldByName('JEDNANI').AsString + ';';
      row := row + _Query.FieldByName('ROZSUDEK').AsString + ';';
      row := row + _Query.FieldByName('PR_MOC').AsString + ';';
      row := row + _Query.FieldByName('NAVRH').AsString + ';';
      row := row + _Query.FieldByName('PRIKAZ').AsString + ';';
      row := row + _Query.FieldByName('CASTKA').AsString + ';';
      row := row + _Query.FieldByName('SKONCENO').AsString + ';';
      row := row + _Query.FieldByName('CISLO').AsString + ';';
      row := row + _Query.FieldByName('DATUM_UHRADY').AsString + ';';
      row := row + _Query.FieldByName('ZEMREL').AsString + ';';
      row := row + _Query.FieldByName('ZAPLATIL_PRED_PODANIM').AsString + ';';
      row := row + _Query.FieldByName('ZAPLATIL_CASTKA').AsString + ';';
      row := row + _Query.FieldByName('USNESENI').AsString + ';';
      row := row + _Query.FieldByName('EXEKUTOR').AsString + ';';
      row := row + _Query.FieldByName('ZPRAVA_DORUCENI').AsString + ';';
      row := row + _Query.FieldByName('ZPRAVA_OVERENI').AsString + ';';
      row := row + _Query.FieldByName('ZPRAVA_PL_ROZKAZ').AsString + ';';
      row := row + _Query.FieldByName('ZPRAVA_ZAPRACOVANI').AsString + ';';
      row := row + _Query.FieldByName('VYMOZENO').AsString + ';';
      row := row + _Query.FieldByName('SKONCENO_DUVOD').AsString + ';';

      try
        row := row + _Query.FieldByName('INSOLVENCE').AsString + ';';
        row := row + _Query.FieldByName('SPLATKOVY_KALENDAR').AsString + ';';
        row := row + _Query.FieldByName('USNESENI_DATUM').AsString + ';';
        row := row + _Query.FieldByName('OPRAVNE_USNESENI_DATUM').AsString + ';';
        row := row + _Query.FieldByName('USNESENI_CJ').AsString + ';';
      except

      end;
      row := row + _Query.FieldByName('EXEKUCNI_PRIKAZ').AsString;
      row := row + '<EOF>';
      _list.add(row);
      row := '';
      frmProces.ProgressBar1.StepIt;
      frmProces.lbPom.Caption := IntToStr(_Query.RecNo);
      frmProces.Repaint;
      _Query.Next;
    end;
    _Query.Close;
    frmProces.Close;
    _list.savetofile('export/'+tbl+'.txt');
  finally
    if Assigned(_Query) then
    begin
      _Query.Close;
      _Query.Free;
      _Query := nil;
    end;
    _list.free;
  end;
end;

procedure exportZalobyZpravyTxt(tbl: string);
var
  _Query,_Query2: TZQuery;
  _list,_list2:  TStringList;
  row,telo:    string;
begin
  _Query := nil;
  _Query2 := nil;
  try
    if not Assigned(frmProces) then
    begin
      Application.CreateForm(TfrmProces, frmProces);
    end;
    frmProces.ShowOnTop;
    frmProces.lbProces.Caption      := 'Probíhá export zpráv žalob, čekejte...';
    frmProces.ProgressBar1.Step     := 1;
    frmProces.ProgressBar1.Min      := 1;
    frmProces.ProgressBar1.Position := 1;
    frmProces.ShowOnTop;
    frmProces.lbPom.Caption := '0';
    frmProces.Repaint;
    _list  := TStringList.Create;
    _list2  := TStringList.Create;
    _Query := TZQuery.Create(nil);
    _Query.Connection := DM.OracleConnection;
    _Query.ReadOnly := true;
    _Query.SQL.Text := 'SELECT * FROM '+tbl;
    _Query.Open;
    _Query2 := TZQuery.Create(nil);
    _Query2.Connection := DM.OracleConnection;
    _Query2.ReadOnly := false;
    frmProces.ProgressBar1.Max := _Query.RecordCount;
    _Query.First;
    row := '';
    telo := '';
    while not _Query.EOF do
    begin
      row := row + _Query.FieldByName('REF_KOD').AsString + ';';
      row := row + _Query.FieldByName('DATUM_STAZENI').AsString + ';';
      row := row + _Query.FieldByName('ID').AsString + ';';
      row := row + _Query.FieldByName('TYP_ZPRAVY').AsString + ';';
      row := row + _Query.FieldByName('PREDMET').AsString + ';';
      row := row + _Query.FieldByName('DATUM_ODESLANI').AsString + ';';
      row := row + _Query.FieldByName('ODESILATEL').AsString + ';';
      row := row + _Query.FieldByName('ID_ZPRAVY').AsString + ';';
      row := row + _Query.FieldByName('UCET').AsString + ';';
      row := row + _Query.FieldByName('VAR_SYMB').AsString + ';';
      row := row + _Query.FieldByName('PODANI_DORUCENE_DATUM').AsString + ';';
      row := row + _Query.FieldByName('BEZNE_CISLO').AsString + ';';
      row := row + _Query.FieldByName('PODANI_OVERENO_DATUM').AsString + ';';
      row := row + _Query.FieldByName('ZASLANYCH_PRILOH').AsString + ';';
      row := row + _Query.FieldByName('ZPUSOB_PODANI').AsString + ';';
      row := row + _Query.FieldByName('PODPIS_CERTIF_PLATNY').AsString + ';';
      row := row + _Query.FieldByName('SOUD').AsString + ';';
      row := row + _Query.FieldByName('TYP_FORMULARE').AsString + ';';
      row := row + _Query.FieldByName('SPISOVA_ZNACKA').AsString + ';';
      row := row + _Query.FieldByName('KE_ZPRACOVANI').AsString;
      row := row + '<EOF>';

      _list.add(row);

      _Query2.SQL.Text := 'SELECT TELO FROM '+tbl+' WHERE ID='+_Query.FieldByName('ID').AsString;
      _Query2.Open;
      telo := '';
      telo := _Query2.FieldByName('TELO').AsString;
      _Query2.Close;
      _list2.Text := telo;
      _list2.savetofile('export/'+tbl+'-'+_Query.FieldByName('ID').AsString+'.txt');
      telo := '';
      _list2.Clear;

      row := '';
      frmProces.ProgressBar1.StepIt;
      frmProces.lbPom.Caption := IntToStr(_Query.RecNo);
      frmProces.Repaint;
      _Query.Next;
    end;
    _Query.Close;
    frmProces.Close;
    _list.savetofile('export/'+tbl+'.txt');
  finally
    if Assigned(_Query) then
    begin
      _Query.Close;
      _Query.Free;
      _Query := nil;
    end;
    if Assigned(_Query2) then
    begin
      _Query2.Close;
      _Query2.Free;
      _Query2 := nil;
    end;
    _list.free;
    _list2.free;
  end;
end;

procedure exportZalobyZpravyTypyTxt(tbl: string);
var
  _Query: TZQuery;
  _list:  TStringList;
  row:    string;
begin
  _Query := nil;
  try
    if not Assigned(frmProces) then
    begin
      Application.CreateForm(TfrmProces, frmProces);
    end;
    frmProces.ShowOnTop;
    frmProces.lbProces.Caption      := 'Probíhá export typů zpáv žalob, čekejte...';
    frmProces.ProgressBar1.Step     := 1;
    frmProces.ProgressBar1.Min      := 1;
    frmProces.ProgressBar1.Position := 1;
    frmProces.ShowOnTop;
    frmProces.lbPom.Caption := '0';
    frmProces.Repaint;
    _list  := TStringList.Create;
    _Query := TZQuery.Create(nil);
    _Query.Connection := DM.OracleConnection;
    _Query.ReadOnly := true;
    _Query.SQL.Text := 'SELECT * FROM '+tbl;
    _Query.Open;
    frmProces.ProgressBar1.Max := _Query.RecordCount;
    _Query.First;
    row := '';
    while not _Query.EOF do
    begin
      row := row + _Query.FieldByName('ID').AsString + ';';
      row := row + _Query.FieldByName('PREDMET').AsString + ';';
      row := row + _Query.FieldByName('NAZEV').AsString + ';';
      row := row + _Query.FieldByName('POPIS').AsString + ';';
      row := row + _Query.FieldByName('TYP').AsString;
      row := row + '<EOF>';
      _list.add(row);
      row := '';
      frmProces.ProgressBar1.StepIt;
      frmProces.lbPom.Caption := IntToStr(_Query.RecNo);
      frmProces.Repaint;
      _Query.Next;
    end;
    _Query.Close;
    frmProces.Close;
    _list.Text := UTF8Decode(_list.Text);
    _list.savetofile('export/'+tbl+'.txt');
  finally
    if Assigned(_Query) then
    begin
      _Query.Close;
      _Query.Free;
      _Query := nil;
    end;
    _list.free;
  end;
end;

procedure importZalobyZpravyTypyTxt(tbl: string);
var
  _list,_list_row,rows : TStringList;
  row,id,predmet,nazev,popis,typ : String;
  i,_od,_do : Integer;
begin
  _list := TStringList.Create;
  _list_row := TStringList.Create;
  rows := TStringList.Create;
  try
    if not Assigned(frmProces) then
    begin
      Application.CreateForm(TfrmProces, frmProces);
    end;
    frmProces.ShowOnTop;
    frmProces.lbProces.Caption      := 'Probíhá import typů zpáv žalob, čekejte...';
    frmProces.ProgressBar1.Step     := 1;
    frmProces.ProgressBar1.Min      := 1;
    frmProces.ProgressBar1.Position := 1;
    frmProces.ShowOnTop;
    frmProces.lbPom.Caption := '0';
    frmProces.Repaint;

    _list.LoadFromFile('export/'+tbl+'.txt');

    split('<EOF>'+#13#10, _list.Text, rows, frmProces);

    frmProces.lbProces.Caption      := 'Probíhá import typů zpáv žalob, čekejte...';
    frmProces.ProgressBar1.Position := 1;
    frmProces.lbPom.Caption := '0';
    frmProces.ProgressBar1.Max := rows.count;

    for i := 1 to rows.Count do
    begin
      frmProces.ProgressBar1.StepIt;
      frmProces.lbPom.Caption := IntToStr(i);
      frmProces.Repaint;

      id := '';
      predmet := '';
      nazev := '';
      popis := '';
      typ := '';

      if pos(';', rows.Strings[i-1]) > 0 then
      begin
        split(';', rows.Strings[i-1], _list_row, frmProces);
        id := _list_row.Strings[0];
        predmet := _list_row.Strings[1];
        nazev := _list_row.Strings[2];
        popis := _list_row.Strings[3];
        typ := _list_row.Strings[4];
        ExecSQL('INSERT INTO '+tbl+'/*(ID,PREDMET,NAZEV,POPIS,TYP)*/'+
              ' VALUES('+id+','''+predmet+''','''+nazev+''','''+popis+''','''+typ+''')');
      end;
    end;
    frmProces.Close;
  finally
    _list.free;
    _list_row.free;
    rows.free;
  end;
end;

procedure importZalobyZpravyTxt(tbl: String; tbl_ref : String);
var
  _list,_list_tmp,_list_telo,_list_row,rows : TStringList;
  qt : TZQuery;
  ref_kod,
  datum_stazeni,
  id,
  typ_zpravy,
  predmet,
  datum_odeslani,
  odesilatel,
  id_zpravy,
  ucet,
  var_symb,
  podani_dorucene_datum,
  bezne_cislo,
  podani_overeno_datum,
  zaslanych_priloh,
  zpusob_podani,
  podpis_certif_platny,
  soud,
  typ_formulare,
  spisova_znacka,
  ke_zpracovani,
  telo : String;
  i : Integer;
begin
  _list := TStringList.Create;
  _list_telo := TStringList.Create;
  _list_row := TStringList.Create;
  _list_tmp := TStringList.Create;
  rows := TStringList.Create;
  try
    if not Assigned(frmProces) then
    begin
      Application.CreateForm(TfrmProces, frmProces);
    end;
    frmProces.ShowOnTop;
    frmProces.lbProces.Caption      := 'Probíhá import zpávy žalob, čekejte...';
    frmProces.ProgressBar1.Step     := 1;
    frmProces.ProgressBar1.Min      := 1;
    frmProces.ProgressBar1.Position := 1;
    frmProces.ShowOnTop;
    frmProces.lbPom.Caption := '0';
    frmProces.Repaint;

    qt:=TZQuery.Create(nil);
    qt.Connection:=DM.OracleConnection;


    _list.Clear;
    try
      _list.LoadFromFile('export/'+tbl+'.txt');
    finally
    end;

    split('<EOF>'+#13#10, _list.Text, rows, frmProces);

    frmProces.lbProces.Caption      := 'Probíhá import zpávy žalob, čekejte...';
    frmProces.ProgressBar1.Position := 1;
    frmProces.lbPom.Caption := '0';
    frmProces.ProgressBar1.Max := rows.count;

    for i := 1 to rows.Count do
    begin
      frmProces.ProgressBar1.StepIt;
      frmProces.lbPom.Caption := IntToStr(i);
      frmProces.Repaint;

      ref_kod := '';
      datum_stazeni := '';
      id := '';
      typ_zpravy := '';
      predmet := '';
      datum_odeslani := '';
      odesilatel := '';
      id_zpravy := '';
      ucet := '';
      var_symb := '';
      podani_dorucene_datum := '';
      bezne_cislo := '';
      podani_overeno_datum := '';
      zaslanych_priloh := '';
      zpusob_podani := '';
      podpis_certif_platny := '';
      soud := '';
      typ_formulare := '';
      spisova_znacka := '';
      ke_zpracovani := '';

      if pos(';', rows.Strings[i-1]) > 0 then
      begin
        split(';', rows.Strings[i-1], _list_row, frmProces);

        ref_kod := UTF8Decode(_list_row.Strings[0]);
        datum_stazeni := UTF8Decode(_list_row.Strings[1]);
        id := UTF8Decode(_list_row.Strings[2]);
        typ_zpravy := UTF8Decode(_list_row.Strings[3]);
        predmet := UTF8Decode(_list_row.Strings[4]);
        datum_odeslani := UTF8Decode(_list_row.Strings[5]);
        odesilatel := UTF8Decode(_list_row.Strings[6]);
        id_zpravy := UTF8Decode(_list_row.Strings[7]);
        ucet := UTF8Decode(_list_row.Strings[8]);
        var_symb := UTF8Decode(_list_row.Strings[9]);
        podani_dorucene_datum := UTF8Decode(_list_row.Strings[10]);
        bezne_cislo := UTF8Decode(_list_row.Strings[11]);
        podani_overeno_datum := UTF8Decode(_list_row.Strings[12]);
        zaslanych_priloh := UTF8Decode(_list_row.Strings[13]);
        zpusob_podani := UTF8Decode(_list_row.Strings[14]);
        podpis_certif_platny := UTF8Decode(_list_row.Strings[15]);
        soud := UTF8Decode(_list_row.Strings[16]);
        typ_formulare := UTF8Decode(_list_row.Strings[17]);
        spisova_znacka := UTF8Decode(_list_row.Strings[18]);
        ke_zpracovani := UTF8Decode(_list_row.Strings[19]);

        qt.SQL.Text := 'INSERT INTO '+tbl+' VALUES('+
                       ':REF_KOD,'+
                       ':DATUM_STAZENI,'+
                       ':ID,'+
                       ':TYP_ZPRAVY,'+
                       ':PREDMET,'+
                       ':DATUM_ODESLANI,'+
                       ':ODESILATEL,'+
                       ':ID_ZPRAVY,'+
                       ':UCET,'+
                       ':VAR_SYMB,'+
                       ':PODANI_DORUCENE_DATUM,'+
                       ':BEZNE_CISLO,'+
                       ':PODANI_OVERENO_DATUM,'+
                       ':ZASLANYCH_PRILOH,'+
                       ':ZPUSOB_PODANI,'+
                       ':PODPIS_CERTIF_PLATNY,'+
                       ':SOUD,'+
                       ':TYP_FORMULARE,'+
                       ':SPISOVA_ZNACKA,'+
                       ':KE_ZPRACOVANI,'+
                       ':TELO'+
                       ')';
          qt.ParamByName('REF_KOD').DataType:=ftString;
          qt.ParamByName('REF_KOD').AsString:=ref_kod;
          qt.ParamByName('DATUM_STAZENI').DataType:=ftString;
          qt.ParamByName('DATUM_STAZENI').AsString:=datum_stazeni;
          qt.ParamByName('ID').DataType:=ftString;
          qt.ParamByName('ID').AsString:=id;
          qt.ParamByName('TYP_ZPRAVY').DataType:=ftString;
          qt.ParamByName('TYP_ZPRAVY').AsString:=typ_zpravy;
          qt.ParamByName('PREDMET').DataType:=ftString;
          qt.ParamByName('PREDMET').AsString:=predmet;
          qt.ParamByName('DATUM_ODESLANI').DataType:=ftString;
          qt.ParamByName('DATUM_ODESLANI').AsString:=datum_odeslani;
          qt.ParamByName('ODESILATEL').DataType:=ftString;
          qt.ParamByName('ODESILATEL').AsString:=odesilatel;
          qt.ParamByName('ID_ZPRAVY').DataType:=ftString;
          qt.ParamByName('ID_ZPRAVY').AsString:=id_zpravy;
          qt.ParamByName('UCET').DataType:=ftString;
          qt.ParamByName('UCET').AsString:=ucet;
          qt.ParamByName('VAR_SYMB').DataType:=ftString;
          qt.ParamByName('VAR_SYMB').AsString:=var_symb;
          qt.ParamByName('PODANI_DORUCENE_DATUM').DataType:=ftString;
          qt.ParamByName('PODANI_DORUCENE_DATUM').AsString:=podani_dorucene_datum;
          qt.ParamByName('BEZNE_CISLO').DataType:=ftString;
          qt.ParamByName('BEZNE_CISLO').AsString:=bezne_cislo;
          qt.ParamByName('PODANI_OVERENO_DATUM').DataType:=ftString;
          qt.ParamByName('PODANI_OVERENO_DATUM').AsString:=podani_overeno_datum;
          qt.ParamByName('ZASLANYCH_PRILOH').DataType:=ftString;
          qt.ParamByName('ZASLANYCH_PRILOH').AsString:=zaslanych_priloh;
          qt.ParamByName('ZPUSOB_PODANI').DataType:=ftString;
          qt.ParamByName('ZPUSOB_PODANI').AsString:=zpusob_podani;
          qt.ParamByName('PODPIS_CERTIF_PLATNY').DataType:=ftString;
          qt.ParamByName('PODPIS_CERTIF_PLATNY').AsString:=podpis_certif_platny;
          qt.ParamByName('SOUD').DataType:=ftString;
          qt.ParamByName('SOUD').AsString:=soud;
          qt.ParamByName('TYP_FORMULARE').DataType:=ftString;
          qt.ParamByName('TYP_FORMULARE').AsString:=typ_formulare;
          qt.ParamByName('SPISOVA_ZNACKA').DataType:=ftString;
          qt.ParamByName('SPISOVA_ZNACKA').AsString:=spisova_znacka;
          qt.ParamByName('KE_ZPRACOVANI').DataType:=ftString;
          qt.ParamByName('KE_ZPRACOVANI').AsString:=ke_zpracovani;
          qt.ParamByName('TELO').DataType:=ftOraClob;
          qt.ParamByName('TELO').AsMemo:='';
          qt.ExecSQL;

        try
          _list_telo.Clear;
          _list_telo.LoadFromFile('export/'+tbl+'-'+id+'.txt');
        finally
        end;

        if Length(_list_telo.Text) > 0 then
        begin
          qt.SQL.Text := 'UPDATE '+tbl+' SET TELO = :TELO WHERE ID = :ID';
          qt.ParamByName('ID').DataType:=ftInteger;
          qt.ParamByName('ID').AsInteger:=StrToInt(id);
          qt.ParamByName('TELO').DataType:=ftOraClob;
          qt.ParamByName('TELO').AsMemo:=UTF8Decode(_list_telo.Text);
          qt.ExecSQL;
        end;
      end;
    end;
    frmProces.Close;
  finally
    if Assigned(qt) then
    begin
      qt.Close;
      qt.Free;
      qt := nil;
    end;
    _list.free;
    _list_row.free;
    _list_telo.free;
    rows.free;
  end;
end;

procedure importZalobyTxt(tbl: string);
var
  _list,_list_row,rows : TStringList;
  row,predmet,nazev,popis,typ : String;
  i,_od,_do : Integer;
  qt : TZQuery;
  id,
  var_symb,
  jmeno_cp,
  datum_cas,
  dluzna_castka,
  jizdne,
  pokuta,
  rodne_cislo,
  ulice,
  cislo_domu,
  mesto,
  obvod,
  psc,
  ref_kod,
  uzamcena,
  datum_importu,
  datum_uzamceni,
  pl_prikaz,
  uhrada,
  splatnost,
  soud,
  zaloba,
  narok,
  vs_soudu,
  cu_soudu,
  spis_znacka,
  uhr_sop,
  odvolani,
  jednani,
  rozsudek,
  pr_moc,
  navrh,
  prikaz,
  castka,
  skonceno,
  cislo,
  datum_uhrady,
  zemrel,
  zaplatil_pred_podanim,
  zaplatil_castka,
  usneseni,
  exekutor,
  zprava_doruceni,
  zprava_overeni,
  zprava_pl_rozkaz,
  zprava_zapracovani,
  vymozeno,
  skonceno_duvod,
  insolvence,
  splatkovy_kalendar,
  usneseni_datum,
  opravne_usneseni_datum,
  usneseni_cj,
  exekucni_prikaz : String;
  vice_sql : String;
  vice : Boolean;
begin
  _list := TStringList.Create;
  _list_row := TStringList.Create;
  rows := TStringList.Create;
  qt:=TZQuery.Create(nil);
  qt.Connection:=DM.OracleConnection;
  vice := false;
  vice_sql := '';
  if tbl = 'ZALOBY' then
  begin
    vice := true;
  end;
  if vice then
  begin
    vice_sql := ':INSOLVENCE,'+
                ':SPLATKOVY_KALENDAR,'+
                ':USNESENI_DATUM,'+
                ':OPRAVNE_USNESENI_DATUM,'+
                ':USNESENI_CJ,';
  end;
  try
    if not Assigned(frmProces) then
    begin
      Application.CreateForm(TfrmProces, frmProces);
    end;
    frmProces.ShowOnTop;
    frmProces.lbProces.Caption      := 'Probíhá import žalob, čekejte...';
    frmProces.ProgressBar1.Step     := 1;
    frmProces.ProgressBar1.Min      := 1;
    frmProces.ProgressBar1.Position := 1;
    frmProces.ShowOnTop;
    frmProces.lbPom.Caption := '0';
    frmProces.Repaint;

    _list.LoadFromFile('export/'+tbl+'.txt');

    split('<EOF>'+#13#10, _list.Text, rows, frmProces);

    frmProces.lbProces.Caption      := 'Probíhá import žalob, čekejte...';
    frmProces.ProgressBar1.Position := 1;
    frmProces.lbPom.Caption := '0';
    frmProces.ProgressBar1.Max := rows.count;

    for i := 1 to rows.Count do
    begin
      frmProces.ProgressBar1.StepIt;
      frmProces.lbPom.Caption := IntToStr(i);
      frmProces.Repaint;

      id := '';
      var_symb := '';
      jmeno_cp := '';
      datum_cas := '';
      dluzna_castka := '';
      jizdne := '';
      pokuta := '';
      rodne_cislo := '';
      ulice := '';
      cislo_domu := '';
      mesto := '';
      obvod := '';
      psc := '';
      ref_kod := '';
      uzamcena := '';
      datum_importu := '';
      datum_uzamceni := '';
      pl_prikaz := '';
      uhrada := '';
      splatnost := '';
      soud := '';
      zaloba := '';
      narok := '';
      vs_soudu := '';
      cu_soudu := '';
      spis_znacka := '';
      uhr_sop := '';
      odvolani := '';
      jednani := '';
      rozsudek := '';
      pr_moc := '';
      navrh := '';
      prikaz := '';
      castka := '';
      skonceno := '';
      cislo := '';
      datum_uhrady := '';
      zemrel := '';
      zaplatil_pred_podanim := '';
      zaplatil_castka := '';
      usneseni := '';
      exekutor := '';
      zprava_doruceni := '';
      zprava_overeni := '';
      zprava_pl_rozkaz := '';
      zprava_zapracovani := '';
      vymozeno := '';
      skonceno_duvod := '';
      insolvence := '';
      splatkovy_kalendar := '';
      usneseni_datum := '';
      opravne_usneseni_datum := '';
      usneseni_cj := '';
      exekucni_prikaz := '';

      if pos(';', rows.Strings[i-1]) > 0 then
      begin
        split(';', rows.Strings[i-1], _list_row, frmProces);
        id := UTF8Decode(_list_row.Strings[0]); //StringReplace(_list_row.Strings[0], #13#10, '', [rfReplaceAll])
        var_symb := UTF8Decode(_list_row.Strings[1]);
        jmeno_cp := UTF8Decode(_list_row.Strings[2]);
        datum_cas := UTF8Decode(_list_row.Strings[3]);
        dluzna_castka := UTF8Decode(_list_row.Strings[4]);
        jizdne := UTF8Decode(_list_row.Strings[5]);
        pokuta := UTF8Decode(_list_row.Strings[6]);
        rodne_cislo := UTF8Decode(_list_row.Strings[7]);
        ulice := UTF8Decode(_list_row.Strings[8]);
        cislo_domu := UTF8Decode(_list_row.Strings[9]);
        mesto := UTF8Decode(_list_row.Strings[10]);
        obvod := UTF8Decode(_list_row.Strings[11]);
        psc := UTF8Decode(_list_row.Strings[12]);
        ref_kod := UTF8Decode(_list_row.Strings[13]);
        uzamcena := UTF8Decode(_list_row.Strings[14]);
        datum_importu := UTF8Decode(_list_row.Strings[15]);
        datum_uzamceni := UTF8Decode(_list_row.Strings[16]);
        pl_prikaz := UTF8Decode(_list_row.Strings[17]);
        uhrada := UTF8Decode(_list_row.Strings[18]);
        splatnost := UTF8Decode(_list_row.Strings[19]);
        soud := UTF8Decode(_list_row.Strings[20]);
        zaloba := UTF8Decode(_list_row.Strings[21]);
        narok := UTF8Decode(_list_row.Strings[22]);
        vs_soudu := UTF8Decode(_list_row.Strings[23]);
        cu_soudu := UTF8Decode(_list_row.Strings[24]);
        spis_znacka := UTF8Decode(_list_row.Strings[25]);
        uhr_sop := UTF8Decode(_list_row.Strings[26]);
        odvolani := UTF8Decode(_list_row.Strings[27]);
        jednani := UTF8Decode(_list_row.Strings[28]);
        rozsudek := UTF8Decode(_list_row.Strings[29]);
        pr_moc := UTF8Decode(_list_row.Strings[30]);
        navrh := UTF8Decode(_list_row.Strings[31]);
        prikaz := UTF8Decode(_list_row.Strings[32]);
        castka := UTF8Decode(_list_row.Strings[33]);
        skonceno := UTF8Decode(_list_row.Strings[34]);
        cislo := UTF8Decode(_list_row.Strings[35]);
        datum_uhrady := UTF8Decode(_list_row.Strings[36]);
        zemrel := UTF8Decode(_list_row.Strings[37]);
        zaplatil_pred_podanim := UTF8Decode(_list_row.Strings[38]);
        zaplatil_castka := UTF8Decode(_list_row.Strings[39]);
        usneseni := UTF8Decode(_list_row.Strings[40]);
        exekutor := UTF8Decode(_list_row.Strings[41]);
        zprava_doruceni := UTF8Decode(_list_row.Strings[42]);
        zprava_overeni := UTF8Decode(_list_row.Strings[43]);
        zprava_pl_rozkaz := UTF8Decode(_list_row.Strings[44]);
        zprava_zapracovani := UTF8Decode(_list_row.Strings[45]);
        vymozeno := UTF8Decode(_list_row.Strings[46]);
        skonceno_duvod := UTF8Decode(_list_row.Strings[47]);

        if vice then
        begin
          insolvence := UTF8Decode(_list_row.Strings[48]);
          splatkovy_kalendar := UTF8Decode(_list_row.Strings[49]);
          usneseni_datum := UTF8Decode(_list_row.Strings[50]);
          opravne_usneseni_datum := UTF8Decode(_list_row.Strings[51]);
          usneseni_cj := UTF8Decode(_list_row.Strings[52]);
          exekucni_prikaz := UTF8Decode(_list_row.Strings[53]);
        end
        else
        begin
          exekucni_prikaz := UTF8Decode(_list_row.Strings[48]);
        end;

        qt.Params.Clear;
        qt.SQL.Text := 'INSERT INTO '+tbl+' VALUES('+
                       ':ID,'+
                       ':VAR_SYMB,'+
                       ':JMENO_CP,'+
                       ':DATUM_CAS,'+
                       ':DLUZNA_CASTKA,'+
                       ':JIZDNE,'+
                       ':POKUTA,'+
                       ':RODNE_CISLO,'+
                       ':ULICE,'+
                       ':CISLO_DOMU,'+
                       ':MESTO,'+
                       ':OBVOD,'+
                       ':PSC,'+
                       ':REF_KOD,'+
                       ':UZAMCENA,'+
                       ':DATUM_IMPORTU,'+
                       ':DATUM_UZAMCENI,'+
                       ':PL_PRIKAZ,'+
                       ':UHRADA,'+
                       ':SPLATNOST,'+
                       ':SOUD,'+
                       ':ZALOBA,'+
                       ':NAROK,'+
                       ':VS_SOUDU,'+
                       ':CU_SOUDU,'+
                       ':SPIS_ZNACKA,'+
                       ':UHR_SOP,'+
                       ':ODVOLANI,'+
                       ':JEDNANI,'+
                       ':ROZSUDEK,'+
                       ':PR_MOC,'+
                       ':NAVRH,'+
                       ':PRIKAZ,'+
                       ':CASTKA,'+
                       ':SKONCENO,'+
                       ':CISLO,'+
                       ':DATUM_UHRADY,'+
                       ':ZEMREL,'+
                       ':ZAPLATIL_PRED_PODANIM,'+
                       ':ZAPLATIL_CASTKA,'+
                       ':USNESENI,'+
                       ':EXEKUTOR,'+
                       ':ZPRAVA_DORUCENI,'+
                       ':ZPRAVA_OVERENI,'+
                       ':ZPRAVA_PL_ROZKAZ,'+
                       ':ZPRAVA_ZAPRACOVANI,'+
                       ':VYMOZENO,'+
                       ':SKONCENO_DUVOD,'+
                       vice_sql+
                       ':EXEKUCNI_PRIKAZ'+
                       ')';
        qt.ParamByName('ID').DataType:=ftString;
        qt.ParamByName('ID').AsString:=id;
        qt.ParamByName('VAR_SYMB').DataType:=ftString;
        qt.ParamByName('VAR_SYMB').AsString:=var_symb;
        qt.ParamByName('JMENO_CP').DataType:=ftString;
        qt.ParamByName('JMENO_CP').AsString:=jmeno_cp;
        qt.ParamByName('DATUM_CAS').DataType:=ftDate;
        qt.ParamByName('DATUM_CAS').AsString:=datum_cas;
        qt.ParamByName('DLUZNA_CASTKA').DataType:=ftString;
        qt.ParamByName('DLUZNA_CASTKA').AsString:=dluzna_castka;
        qt.ParamByName('JIZDNE').DataType:=ftString;
        qt.ParamByName('JIZDNE').AsString:=jizdne;
        qt.ParamByName('POKUTA').DataType:=ftString;
        qt.ParamByName('POKUTA').AsString:=pokuta;
        qt.ParamByName('RODNE_CISLO').DataType:=ftString;
        qt.ParamByName('RODNE_CISLO').AsString:=rodne_cislo;
        qt.ParamByName('ULICE').DataType:=ftString;
        qt.ParamByName('ULICE').AsString:=ulice;
        qt.ParamByName('CISLO_DOMU').DataType:=ftString;
        qt.ParamByName('CISLO_DOMU').AsString:=cislo_domu;
        qt.ParamByName('MESTO').DataType:=ftString;
        qt.ParamByName('MESTO').AsString:=mesto;
        qt.ParamByName('OBVOD').DataType:=ftString;
        qt.ParamByName('OBVOD').AsString:=obvod;
        qt.ParamByName('PSC').DataType:=ftString;
        qt.ParamByName('PSC').AsString:=psc;
        qt.ParamByName('REF_KOD').DataType:=ftString;
        qt.ParamByName('REF_KOD').AsString:=ref_kod;
        qt.ParamByName('UZAMCENA').DataType:=ftString;
        qt.ParamByName('UZAMCENA').AsString:=uzamcena;
        qt.ParamByName('DATUM_IMPORTU').DataType:=ftString;
        qt.ParamByName('DATUM_IMPORTU').AsString:=datum_importu;
        qt.ParamByName('DATUM_UZAMCENI').DataType:=ftString;
        qt.ParamByName('DATUM_UZAMCENI').AsString:=datum_uzamceni;
        qt.ParamByName('PL_PRIKAZ').DataType:=ftString;
        qt.ParamByName('PL_PRIKAZ').AsString:=pl_prikaz;
        qt.ParamByName('UHRADA').DataType:=ftString;
        qt.ParamByName('UHRADA').AsString:=uhrada;
        qt.ParamByName('SPLATNOST').DataType:=ftString;
        qt.ParamByName('SPLATNOST').AsString:=splatnost;
        qt.ParamByName('SOUD').DataType:=ftString;
        qt.ParamByName('SOUD').AsString:=soud;
        qt.ParamByName('ZALOBA').DataType:=ftString;
        qt.ParamByName('ZALOBA').AsString:=zaloba;
        qt.ParamByName('NAROK').DataType:=ftString;
        qt.ParamByName('NAROK').AsString:=narok;
        qt.ParamByName('VS_SOUDU').DataType:=ftString;
        qt.ParamByName('VS_SOUDU').AsString:=vs_soudu;
        qt.ParamByName('CU_SOUDU').DataType:=ftString;
        qt.ParamByName('CU_SOUDU').AsString:=cu_soudu;
        qt.ParamByName('SPIS_ZNACKA').DataType:=ftString;
        qt.ParamByName('SPIS_ZNACKA').AsString:=spis_znacka;
        qt.ParamByName('UHR_SOP').DataType:=ftString;
        qt.ParamByName('UHR_SOP').AsString:=uhr_sop;
        qt.ParamByName('ODVOLANI').DataType:=ftString;
        qt.ParamByName('ODVOLANI').AsString:=odvolani;
        qt.ParamByName('JEDNANI').DataType:=ftString;
        qt.ParamByName('JEDNANI').AsString:=jednani;
        qt.ParamByName('ROZSUDEK').DataType:=ftString;
        qt.ParamByName('ROZSUDEK').AsString:=rozsudek;
        qt.ParamByName('PR_MOC').DataType:=ftString;
        qt.ParamByName('PR_MOC').AsString:=pr_moc;
        qt.ParamByName('NAVRH').DataType:=ftString;
        qt.ParamByName('NAVRH').AsString:=navrh;
        qt.ParamByName('PRIKAZ').DataType:=ftString;
        qt.ParamByName('PRIKAZ').AsString:=prikaz;
        qt.ParamByName('CASTKA').DataType:=ftString;
        qt.ParamByName('CASTKA').AsString:=castka;
        qt.ParamByName('SKONCENO').DataType:=ftString;
        qt.ParamByName('SKONCENO').AsString:=skonceno;
        qt.ParamByName('CISLO').DataType:=ftString;
        qt.ParamByName('CISLO').AsString:=cislo;
        qt.ParamByName('DATUM_UHRADY').DataType:=ftString;
        qt.ParamByName('DATUM_UHRADY').AsString:=datum_uhrady;
        qt.ParamByName('ZEMREL').DataType:=ftString;
        qt.ParamByName('ZEMREL').AsString:=zemrel;
        qt.ParamByName('ZAPLATIL_PRED_PODANIM').DataType:=ftString;
        qt.ParamByName('ZAPLATIL_PRED_PODANIM').AsString:=zaplatil_pred_podanim;
        qt.ParamByName('ZAPLATIL_CASTKA').DataType:=ftString;
        qt.ParamByName('ZAPLATIL_CASTKA').AsString:=zaplatil_castka;
        qt.ParamByName('USNESENI').DataType:=ftString;
        qt.ParamByName('USNESENI').AsString:=usneseni;
        qt.ParamByName('EXEKUTOR').DataType:=ftString;
        qt.ParamByName('EXEKUTOR').AsString:=exekutor;
        qt.ParamByName('ZPRAVA_DORUCENI').DataType:=ftString;
        qt.ParamByName('ZPRAVA_DORUCENI').AsString:=zprava_doruceni;
        qt.ParamByName('ZPRAVA_OVERENI').DataType:=ftString;
        qt.ParamByName('ZPRAVA_OVERENI').AsString:=zprava_overeni;
        qt.ParamByName('ZPRAVA_PL_ROZKAZ').DataType:=ftString;
        qt.ParamByName('ZPRAVA_PL_ROZKAZ').AsString:=zprava_pl_rozkaz;
        qt.ParamByName('ZPRAVA_ZAPRACOVANI').DataType:=ftString;
        qt.ParamByName('ZPRAVA_ZAPRACOVANI').AsString:=zprava_zapracovani;
        qt.ParamByName('VYMOZENO').DataType:=ftString;
        qt.ParamByName('VYMOZENO').AsString:=vymozeno;
        qt.ParamByName('SKONCENO_DUVOD').DataType:=ftString;
        qt.ParamByName('SKONCENO_DUVOD').AsString:=skonceno_duvod;

        if vice then
        begin
          qt.ParamByName('INSOLVENCE').DataType:=ftString;
          qt.ParamByName('INSOLVENCE').AsString:=insolvence;
          qt.ParamByName('SPLATKOVY_KALENDAR').DataType:=ftString;
          qt.ParamByName('SPLATKOVY_KALENDAR').AsString:=splatkovy_kalendar;
          qt.ParamByName('USNESENI_DATUM').DataType:=ftString;
          qt.ParamByName('USNESENI_DATUM').AsString:=usneseni_datum;
          qt.ParamByName('OPRAVNE_USNESENI_DATUM').DataType:=ftString;
          qt.ParamByName('OPRAVNE_USNESENI_DATUM').AsString:=opravne_usneseni_datum;
          qt.ParamByName('USNESENI_CJ').DataType:=ftString;
          qt.ParamByName('USNESENI_CJ').AsString:=usneseni_cj;
        end;

        qt.ParamByName('EXEKUCNI_PRIKAZ').DataType:=ftString;
        qt.ParamByName('EXEKUCNI_PRIKAZ').AsString:=exekucni_prikaz;
        //ShowMessage('*'+id+'*');
        qt.ExecSQL;
      end;
    end;
    frmProces.Close;
  finally
    if Assigned(qt) then
    begin
      qt.Close;
      qt.Free;
      qt := nil;
    end;
    _list.free;
    _list_row.free;
    rows.free;
  end;
end;

procedure split(Delimiter: String; Str : String; Arr : TStrings; Frm : TfrmProces);
var
  i,j,_od,_do : Integer;
  val : String;
  _list : TStringList;
begin
  Arr.Clear;
  i := 1;
  j := 0;
  _list := TStringList.Create;
  _list.Text := Str;

  if Assigned(Frm) then
  begin
    Frm.lbProces.Caption      := 'Probíhá split, čekejte...';
    Frm.ProgressBar1.Position := 1;
    Frm.lbPom.Caption := '0';
    Frm.ProgressBar1.Max := _list.count;
  end;

  while pos(Delimiter, copy(Str, i, Length(Str) - i + 1)) > 0 do
  begin
    j := j + 1;
    if Assigned(Frm) then
    begin
      Frm.ProgressBar1.StepIt;
      Frm.lbPom.Caption := IntToStr(j) + ' - ' + IntToStr(_list.count);
      Frm.Repaint;
    end;

    _od := i;
    _do := pos(Delimiter, copy(Str, i, Length(Str) - i + 1)) - 1;
    val := copy(Str, _od, _do);
    Arr.add(val);
    i := i + _do + Length(Delimiter);
  end;
  if i > 0 then
  begin
    val := copy(Str, i, Length(Str) - i + 1);
    if copy(val, length(val) - 1, 2) = #13#10 then
    begin
      val := copy(val, 1, Length(val) - 2);
    end;
    Arr.add(val);
  end;
  _list.free;
end;

end.

