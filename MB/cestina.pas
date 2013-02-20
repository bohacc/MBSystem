unit cestina;

interface

//uses Tools;

//////////////////// Ë·st kÛdov˝ch str·nek ///////////////////
type
  tnackod=(csKamenik,csLatin2,csWindows,csKAM_DB);

function bez_diakritiky(s :string) : string;
function bez_diakritiky_char(s : pchar) : pchar;
Function Utf2Win(s:string):string;
Function Win2Utf(const s:string):string;
Function Win2Proc(s:string):string;
Function Lat2Kam(s:string):string;
Function Kam2Lat(s:string):string;
Function KAM_DB2Win(s:string):string;
Function Kam2Win(s:string):string;
Function Win2Kam(s:string):string;
Function Lat2Win(s:string):string;
Function Win2Lat(s:string):string;
Function CodePageConvertStr(a:string;zdroj,cil:tnackod):string;
Function CodePageConvertCh(a:char;zdroj,cil:tnackod):char;
function UpperChar(Key : Char) : Char;
function AnsiUpperChar(Key : Char) : Char;
function replace_to_percents(p_anchor:String):String;

//////////////////// mluvnick· Ë·st ///////////////////
function TvarSlova(Count : integer; Str : string) : string;
function je(Count : integer): String;
function jeX(Count : integer): String;

implementation

uses
  Sysutils;

//////////////////// Ë·st kÛdov˝ch str·nek ///////////////////

// ·‰ÈÏÎÌÛıˆÙ˙˘¸˚˝ûöË¯ÔùÚæ
// ¡ƒ…ÃÀÕ”’÷‘⁄Ÿ‹€›éä»ÿœç“º

const
  UTF8max=51;
  UTF8: array[1..UTF8max] of record w:char; u:string[2]; end =
         ((w:'·';u:#195#161), (w:'¡';u:#195#129),
          (w:'‰';u:#195#164), (w:'ƒ';u:#195#132),
          (w:'È';u:#195#169), (w:'…';u:#195#137),
          (w:'Ï';u:#196#155), (w:'Ã';u:#196#154),
          (w:'Î';u:#195#171), (w:'À';u:#195#139),
          (w:'Ì';u:#195#173), (w:'Õ';u:#195#141),
          (w:'Û';u:#195#179), (w:'”';u:#195#147),
          (w:'ı';u:#197#181), (w:'’';u:#197#149),
          (w:'ˆ';u:#195#182), (w:'÷';u:#195#150),
          (w:'Ù';u:#195#180), (w:'‘';u:#195#132),
          (w:'˙';u:#195#186), (w:'⁄';u:#195#154),
          (w:'˘';u:#197#175), (w:'Ÿ';u:#197#174),
          (w:'¸';u:#195#188), (w:'‹';u:#195#156),
          (w:'˚';u:#197#177), (w:'€';u:#197#176),
          (w:'˝';u:#195#189), (w:'›';u:#195#157),
          (w:'û';u:#197#190), (w:'é';u:#197#189),
          (w:'ö';u:#197#161), (w:'ä';u:#197#160),
          (w:'Ë';u:#196#141), (w:'»';u:#196#140),
          (w:'¯';u:#197#153), (w:'ÿ';u:#197#152),
          (w:'Ô';u:#196#143), (w:'œ';u:#196#142),
          (w:'ù';u:#197#165), (w:'ç';u:#197#164),
          (w:'Ú';u:#197#136), (w:'“';u:#197#135),
          (w:'æ';u:#196#190), (w:'º';u:#196#189),
          (w:'ä';u:#197#32),  (w:'¡';u:#195#63),
          (w:'Ú';u:#197#63),
          (w:'Æ';u:'  '),     (w:'∞';u:'¬∞')  // AE   B0
          );
  Procmax=46;

// WW·WW‰WWÈWWÏWWÎWWÌWWÛWWıWWˆWWÙWW˙WW˘WW¸WW˚WW˝WWûWWöWWËWW¯WWÔWWùWWÚWWæWW
// WW¡WWƒWW…WWÃWWÀWWÕWW”WW’WW÷WW‘WW⁄WWŸWW‹WW€WW›WWéWWäWW»WWÿWWœWWçWW“WWºWW

// WW%E1WW%E4WW%E9WW%ECWW%EBWW
// WW%C1WW%C4WW%C9WW%CCWW%CBWW
  Proc: array[1..Procmax] of record w:char; u:string[3]; end =
         ((w:'·';u:'%E1'), (w:'¡';u:'%C1'),
          (w:'‰';u:'%E4'), (w:'ƒ';u:'%C4'),
          (w:'È';u:'%E9'), (w:'…';u:'%C9'),
          (w:'Ï';u:'%EC'), (w:'Ã';u:'%CC'),
          (w:'Î';u:'%EB'), (w:'À';u:'%CB'),
// %EDWW%F3WW%F5WW%F6WW%F4WW%FAWW
// %CDWW%D3WW%D5WW%D6WW%D4WW%DAWW
          (w:'Ì';u:'%ED'), (w:'Õ';u:'%CD'),
          (w:'Û';u:'%F3'), (w:'”';u:'%D3'),
          (w:'ı';u:'%F5'), (w:'’';u:'%D5'),
          (w:'ˆ';u:'%F6'), (w:'÷';u:'%D6'),
          (w:'Ù';u:'%F4'), (w:'‘';u:'%D4'),
          (w:'˙';u:'%FA'), (w:'⁄';u:'%DA'),
// %F9WW%FCWW%FBWW%FDWW%9EWW%9AWW
// %D9WW%DCWW%DBWW%DDWW%8EWW%8AWW
          (w:'˘';u:'%F9'), (w:'Ÿ';u:'%D9'),
          (w:'¸';u:'%FC'), (w:'‹';u:'%DC'),
          (w:'˚';u:'%FB'), (w:'€';u:'%DB'),
          (w:'˝';u:'%FD'), (w:'›';u:'%DD'),
          (w:'û';u:'%9E'), (w:'é';u:'%8E'),
          (w:'ö';u:'%9A'), (w:'ä';u:'%8A'),
// %E8WW%F8WW%EFWW%9DWW%F2WW%BEWW
// %C8WW%D8WW%CFWW%8DWW%D2WW%BCWW
          (w:'Ë';u:'%E8'), (w:'»';u:'%C8'),
          (w:'¯';u:'%F8'), (w:'ÿ';u:'%D8'),
          (w:'Ô';u:'%EF'), (w:'œ';u:'%CF'),
          (w:'ù';u:'%9D'), (w:'ç';u:'%8D'),
          (w:'Ú';u:'%F2'), (w:'“';u:'%D2'),
          (w:'æ';u:'%BE'), (w:'º';u:'%BC')
          );


  xlat: array[0..1] of string=('ÏöË¯û˝·ÌÈ˙˘ÔÚùÃä»ÿé›¡Õ…⁄œ“ç',
         		       'escrzyaieuudntESCRZYAIEUDNT');
(*
·‰ÈÏÌÛÙˆ˙¸
˘˝ûöË¯ÔùÚ‡
æÂ
¡ƒ…ÃÕ”‘÷⁄‹
Ÿ›éä»ÿœç“¿
º≈
*)

  KAM_DB ='·‰È≥ÌÛÙˆ˙¸'+
          'æú≈ ÁÍ‚Ë•¨'+
          'Óè'+
          '∆ƒ…Îıºû÷å‹'+
          'é£Âç«◊˘Êπü'+
          'ù’';

  Latin_2=#160#132#130#216#161#162#147#148#163#129+
          #133#236#167#231#159#253#212#156#229#234+
          #150#146+
          #181#142#144#183#214#224#226#153#233#154+
          #222#237#166#230#172#252#210#155#213#232+
          #149#145;

  Kamenik=#160#132#130#136#161#162#147#148#163#129+
          #150#152#145#168#135#169#131#159#164#170+
          #140#141+
          #143#142#144#137#139#149#167#153#151#154+
          #166#157#146#155#128#158#133#134#165#171+
          #156#138;

  Windows_CS=#225#228#233#236#237#243#244#246#250#252+
          #249#253#158#154#232#248#239#157#242#224+
          #190#229+
          #193#196#201#204#205#211#212#214#218#220+
          #217#221#142#138#200#216#207#141#210#192+
          #188#197;


{var
  nacFrom, nacTo: tNacKod; Adam 14.10.2000 - eliminace warning˘}

Function GetPos(c:char;s:string):integer;
var i:integer;
begin
  i:=1;
  while (i<Length(s)) and (s[i]<>c) do inc(i);
  if i=Length(s) then
     if s[i]<>c then i:=-1;
  result:=i;
end;

Function Utf2Win(s:string):string;
var
  i,j : integer;
  ch:boolean;
  t:String;
begin
  if length(s)<2 then
    begin
      Result:=s;
      EXIT;
    end;
  Result:='';
  i:=1;
  s:=s+' ';
  While i<length(s) do
  begin
    t:=s[i]+s[i+1];
    ch:=False;
    for j:=1 to UTF8max do
    if t=UTF8[j].u then
      begin
        Result:=Result+UTF8[j].w;
        inc(i);
        ch:=True;
        break;
      end;
    if not ch then
      Result:=Result+s[i];
    inc(i);
  end;
end;

Function Win2Utf(const s:string):string;
var
  i,j : integer;
  ch:boolean;
begin
  Result:='';
  for i:=1 to length(s) do
  begin
    ch:=False;
    for j:=1 to UTF8max do
    if s[i]=UTF8[j].w then
      begin
        Result:=Result+UTF8[j].u;
        ch:=True;
        break;
      end;
    if not ch then
      Result:=Result+s[i];
  end;
end;


function bez_diakritiky_char(s : pchar) : pchar;
var
  i,j : integer;
begin
  for i := 0 to strlen(s)-1 do
  for j := 1 to length(xlat[0]) do
  if s[i]=xlat[0][j] then
     s[i]:=xlat[1][j];
  result := s;
end;

function bez_diakritiky(s :string) : string;
var
  i,j : integer;
begin
  Result := s;
  for i:=1 to length(s) do
  begin
     for j:=1 to length(xlat[0]) do
     if Result[i]=xlat[0][j] then
     begin
       Result[i]:=xlat[1][j];
       break;
     end;
  end;
end;


Function CodePageConvertCh(a:char;zdroj,cil:tnackod):char;
var zs,cs:string;
    i:integer;
begin
  case zdroj of
    csLatin2:zs:=Latin_2;
    csKamenik:zs:=Kamenik;
    csWindows:zs:=Windows_CS;
    csKAM_DB:zs:=KAM_DB;
  end;
  case cil of
    csLatin2:cs:=Latin_2;
    csKamenik:cs:=Kamenik;
    csWindows:cs:=Windows_CS;
    csKAM_DB:cs:=KAM_DB;
  end;
  i:=GetPos(a,zs);
  if i=-1 then result:=a else result:=cs[i];
end;


Function CodePageConvertStr(a:string;zdroj,cil:tnackod):string;
var s:string;
    i:integer;
begin
  s:='';
  for i:=1 to Length(a) do
    s:=s+CodePageConvertCh(a[i],zdroj,cil);
  result:=s;
end;



Function Win2Lat(s:string):string;
begin
  result:=CodePageConvertStr(s,csWindows,csLatin2);
end;

Function Lat2Win(s:string):string;
begin
  result:=CodePageConvertStr(s,csLatin2,csWindows);
end;

Function Win2Kam(s:string):string;
begin
  result:=CodePageConvertStr(s,csWindows,csKamenik);
end;

Function KAM_DB2Win(s:string):string;
begin
  result:=CodePageConvertStr(s,csKAM_DB,csWindows);
end;

Function Kam2Win(s:string):string;
begin
  result:=CodePageConvertStr(s,csKamenik,csWindows);
end;

Function Kam2Lat(s:string):string;
begin
  result:=CodePageConvertStr(s,csKamenik,csLatin2);
end;

Function Lat2Kam(s:string):string;
begin
  result:=CodePageConvertStr(s,csLatin2,csKamenik);
end;

function UpperChar(Key : Char) : Char;
var
  Res : String;
begin
  if Key > #32 then
  begin
    Res := Key;
    Res := UpperCase(Bez_Diakritiky(Res));
    Result := Res[1];
  end
  else
    Result := Key;
end;

//////////////////// mluvnick· Ë·st ///////////////////

(**
 * VracÌ slovo ve spr·vnÈm tvar˘ dle mnoûstvÌ
 * Tato funkce pracuje koreknÏ, pokud slovo nenÌ ve speci·lnÌm tvaru
 * P.S. Tato funkce jeötÏ nenÌ kompletnÌ
 *      Bude doplnÏna pr˘bÏûnÏ
 * @param PoËet
 * @param Slovo
 * Nguyen Duy Hoa
 *)
function TvarSlova;
var
  I : integer;
  C : char;
  S : string;
begin
  I := Count mod 100;
  if I > 20 then
    I := I mod 10;
  if I = 0 then
    I := 5;
  if (Str = '') or (I = 1) then
  begin
    Result := Str;
    Exit;
  end;
  S := UpperCase(Bez_Diakritiky(Str));
  C := S[Length(S)];
  if I >= 5 then
  begin
    if C in ['A', 'E', 'I', 'O', 'U', 'Y'] then
    begin
      if C in ['A', 'O', 'Y'] then
      begin
        Delete(Str, Length(Str), 1);
        Delete(S, Length(S), 1);
        if not(S[Length(S)] in ['A', 'E', 'I', 'O', 'U', 'Y']) and
           not(S[Length(S)-1] in ['A', 'E', 'I', 'O', 'U', 'Y']) then
        begin
          C := Str[Length(Str)];
          Str[Length(Str)] := 'e';
          Str := Str + C;
          C := #0;
        end;
      end;
      if C = 'E' then
        Str[Length(Str)] := 'Ì';
    end
    else
      Str := Str + '˘';
  end
  else
  begin
    if C in ['A', 'E', 'I', 'O', 'U', 'Y'] then
    begin
      if C = 'A' then
      begin
        Str[Length(Str)] := 'y';
        C := #0;
      end;
      if C = 'O' then
      begin
        Str[Length(Str)] := 'a';
        C := #0;
      end
    end
    else
    begin
      C := UpCase(Str[Length(Str)]);
      case C of
        'C' : Str := Str + 'e';
        else Str := Str + 'y';
      end
    end
  end;
  Result := Str;
end;

///////////////////////////////////////////////////////
// vracÌ spr·vn˝ tvar slova "je" podle poËtu <Count>
//  Honza Tomsa  23.6.1999
function je(Count : integer): String;
begin
  if (Abs(Count)<=1) or (Abs(Count)>=5) then
    Result := 'je'
  else
    Result := 'jsou';
end;

//////////////////////////////////////////////////////////////
// vracÌ spr·vn˝ tvar v˝razu "je <Count>" podle poËtu <Count>
//  Honza Tomsa  23.6.1999
function jeX(Count : integer): String;
var
  pocetStr: String;
begin
  case Count of
    1: PocetStr := '1';
    2: PocetStr := '2';
    3: PocetStr := 't¯i';
    4: PocetStr := 'Ëty¯i';
    5: PocetStr := 'pÏt';
    else PocetStr := IntToStr(Count);
  end;
  Result := je(Count)+' '+PocetStr;
end;

function AnsiUpperChar(Key : Char) : Char;
var
 t:String;
begin
  t:=Key;
  t := ANSIUpperCase(t);
  if length(t)>0 then
    Key:=t[1];
  result:=Key;
end;

function replace_to_percents(p_anchor:String):String;
var
  t,tmp:String;
  i:Integer;
begin
  tmp:=p_anchor;
//  tohle je tu aby mi to dvakrat nenahradilo %
  tmp:=StringReplace(tmp,'%25','%',[rfReplaceAll, rfIgnoreCase]);
  tmp:=StringReplace(tmp,'%','%25',[rfReplaceAll, rfIgnoreCase]);

  tmp:=StringReplace(tmp,' ','%20',[rfReplaceAll, rfIgnoreCase]);
  tmp:=StringReplace(tmp,'!','%21',[rfReplaceAll, rfIgnoreCase]);
  tmp:=StringReplace(tmp,'"','%22',[rfReplaceAll, rfIgnoreCase]);
  tmp:=StringReplace(tmp,'#','%23',[rfReplaceAll, rfIgnoreCase]);
  tmp:=StringReplace(tmp,'$','%24',[rfReplaceAll, rfIgnoreCase]);
//    tmp:=Replace(tmp,'&','%26');
//    tmp:=Replace(tmp,''','%27');
  tmp:=StringReplace(tmp,'(','%28',[rfReplaceAll, rfIgnoreCase]);
  tmp:=StringReplace(tmp,')','%29',[rfReplaceAll, rfIgnoreCase]);
  tmp:=StringReplace(tmp,'*','%2a',[rfReplaceAll, rfIgnoreCase]);
  tmp:=StringReplace(tmp,'+','%2b',[rfReplaceAll, rfIgnoreCase]);
  tmp:=StringReplace(tmp,',','%2c',[rfReplaceAll, rfIgnoreCase]);
  tmp:=StringReplace(tmp,'-','%2d',[rfReplaceAll, rfIgnoreCase]);
  tmp:=StringReplace(tmp,'.','%2e',[rfReplaceAll, rfIgnoreCase]);
  tmp:=StringReplace(tmp,'/','%2f',[rfReplaceAll, rfIgnoreCase]);
//    tmp:=Replace(tmp,':','%3a');
//    tmp:=Replace(tmp,';','%3b');
  tmp:=StringReplace(tmp,'<','%3c',[rfReplaceAll, rfIgnoreCase]);
//    tmp:=Replace(tmp,'=','%3d');
  tmp:=StringReplace(tmp,'>','%3e',[rfReplaceAll, rfIgnoreCase]);
//    tmp:=Replace(tmp,'?','%3f');
  tmp:=StringReplace(tmp,'@','%40',[rfReplaceAll, rfIgnoreCase]);
  tmp:=StringReplace(tmp,'[','%5b',[rfReplaceAll, rfIgnoreCase]);
  tmp:=StringReplace(tmp,'\','%5c',[rfReplaceAll, rfIgnoreCase]);
  tmp:=StringReplace(tmp,']','%5d',[rfReplaceAll, rfIgnoreCase]);
  tmp:=StringReplace(tmp,'^','%5e',[rfReplaceAll, rfIgnoreCase]);
//    tmp:=Replace(tmp,'_','%5f');
  tmp:=StringReplace(tmp,'`','%60',[rfReplaceAll, rfIgnoreCase]);
  tmp:=StringReplace(tmp,'{','%7b',[rfReplaceAll, rfIgnoreCase]);
  tmp:=StringReplace(tmp,'|','%7c',[rfReplaceAll, rfIgnoreCase]);
  tmp:=StringReplace(tmp,'}','%7d',[rfReplaceAll, rfIgnoreCase]);
//    tmp:=Replace(tmp,'~','%7e');

  result:=tmp
end;

Function Win2Proc(s:string):string;
var
  i,j : integer;
  ch:boolean;
begin
  S:=replace_to_percents(s);
  for i:=1 to length(s) do
  begin
    ch:=False;
    for j:=1 to procmax do
    if s[i]=proc[j].w then
      begin
        Result:=Result+Proc[j].u;
        ch:=True;
        break;
      end;
    if not ch then
      Result:=Result+s[i];
  end;
end;


end.
