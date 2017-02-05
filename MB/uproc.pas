unit uProc;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Utils, uConsts, sqldb, ZDataset, ZStoredProcedure, ZSqlProcessor,
  LResources, Forms, Controls, Dialogs, db, DBGrids, DBCtrls,
  smtpsend, pop3send, synachar, synautil, mimemess, MimePart, ZSqlUpdate, Grids,StdCtrls;

function Get_Cislo_Dokladu(_Typ : Integer; _Rok : Integer) : Integer;
function Get_crypt_password(_Password : string) : string;
procedure Prevod_akcie(_ID_AKCIE : integer; _ID_AKCIONARE : integer; _DOKLAD : String; _DATUM : TDateTime; _SLOUCIT : Integer; _SQL : string);
function Get_NewID : Integer;
function Get_param(_Kod : string) : String;
procedure doplnit_udaje_ze_zprav;
procedure prijmout_postu;
procedure predavaci_protokol_excel(g:TDBGrid; tab: string);
procedure podaci_list_excel(g:TDBGrid; tab: string);
procedure export_prikazu(g:TDBGrid; tab: string);
procedure export_prikazu_KB_KM(g:TDBGrid; tab: string);
procedure prubeh_davky(g:TDBGrid; tab: string);
procedure ImportSpis(tab : String);
procedure ExportSpis(g: TDBGrid; tab, aFile : String);
function Get_text_part(_part : TMimePart) : TStringList;
procedure initComboExekutor(cb : TDBComboBox);
procedure exportZalob(g: TDBGrid; tab: string);
procedure nastavitUHR_SOP(DBGrid : TDBGrid; tab : String; dataSet: TDataSet; query : TZQuery);
procedure importZalob(g: TDBGrid; tab: string);

implementation

uses Data_module,DProces,DPOP3Pripojeni,DProcesQuery,DOznameniPostupiteleOPostoupeniPohledavky,
     Cestina,mimeinln,DDatum;

function Get_Cislo_Dokladu(_Typ : Integer; _Rok : Integer) : Integer;
var
  xCislo : Integer;
  qrTemp : TZQuery;
begin
  try
    qrTemp:=TZQuery.Create(nil);
    qrTemp.Connection:=DM.OracleConnection;
    //qrTemp.Transaction:=DM.SQLTransaction;
    qrTemp.SQL.Text:='SELECT GET_CISLO_DOKLADU('+IntToStr(_Typ)+','+IntToStr(_Rok)+') FROM DUAL';
    qrTemp.Open;
    xCislo:=qrTemp.Fields.Fields[0].AsInteger;
  finally
    qrTemp.free;
  end;
  Result:=xCislo;
end;

function Get_crypt_password(_Password : string) : string;
var
  password : String;
  qrTemp : TZQuery;
begin
  try
    qrTemp:=TZQuery.Create(nil);
    qrTemp.Connection:=DM.OracleConnection;
    //qrTemp.Transaction:=DM.SQLTransaction;
    qrTemp.SQL.Text:='SELECT GET_CRYPT_PASSWORD('''+_Password+''') FROM DUAL';
    qrTemp.Open;
    password:=qrTemp.Fields.Fields[0].AsString;
  finally
    qrTemp.free;
  end;
  Result:=password;
end;

procedure Prevod_akcie(_ID_AKCIE : integer; _ID_AKCIONARE : integer; _DOKLAD : String; _DATUM : TDateTime; _SLOUCIT : Integer; _SQL : string);
var
  qrTemp : TZQuery;
begin
  try
    qrTemp:=TZQuery.Create(nil);
    qrTemp.Connection:=DM.OracleConnection;
    //qrTemp.Transaction:=DM.SQLTransaction;
    qrTemp.SQL.Text:='PREVOD_AKCIE('+IntToStr(_ID_AKCIE)+','+IntToStr(_ID_AKCIONARE)+','''+_DOKLAD+''','''+DateToStr(_DATUM)+''','+IntToStr(_SLOUCIT)+','''+_SQL+''')';
    qrTemp.ExecSQL;
  finally
    qrTemp.free;
  end;
end;

function Get_NewID : Integer;
var
  xID : Integer;
  qrTemp : TZQuery;
begin
  try
    qrTemp:=TZQuery.Create(nil);
    qrTemp.Connection:=DM.OracleConnection;
    //qrTemp.Transaction:=DM.SQLTransaction;
    qrTemp.SQL.Text:='SELECT GET_NEWID FROM DUAL';
    qrTemp.Open;
    xID:=qrTemp.Fields.Fields[0].AsInteger;
  finally
    qrTemp.free;
  end;
  Result:=xID;
end;

function Get_param(_Kod : string) : String;
var
  xKOD : String;
  qrTemp : TZQuery;
begin
  try
    qrTemp:=TZQuery.Create(nil);
    qrTemp.Connection:=DM.OracleConnection;
    //qrTemp.Transaction:=DM.SQLTransaction;
    qrTemp.SQL.Text:='SELECT GET_PARAM('''+_KOD+''') FROM DUAL';
    qrTemp.Open;
    xKOD:=qrTemp.Fields.Fields[0].AsString;
  finally
    qrTemp.free;
  end;
  Result:=xKOD;
end;

procedure doplnit_udaje_ze_zprav;
var
  xKOD : String;
  qrTemp : TZQuery;
  proc : TZSQLProcessor;
begin
  try
    //qrTemp:=TZQuery.Create(nil);
    //qrTemp.Connection:=DM.OracleConnection;
    //qrTemp.SQL.Text:='EXEC DOPLNIT_UDAJE_ZE_ZPRAV';
    //qrTemp.ExecSQL;

    proc:=TZSQLProcessor.Create(nil);
    proc.Connection:=DM.OracleConnection;
    proc.Script.Text:='UPDATE ZALOBY Z SET VS_SOUDU=(SELECT MAX(VAR_SYMB) FROM ZALOBY_ZPRAVY WHERE REF_KOD=Z.REF_KOD AND TYP_ZPRAVY=4) WHERE VS_SOUDU IS NULL;'+
                      'UPDATE ZALOBY Z SET CU_SOUDU=(SELECT MAX(UCET) FROM ZALOBY_ZPRAVY WHERE REF_KOD=Z.REF_KOD AND TYP_ZPRAVY=4) WHERE CU_SOUDU IS NULL;'+
                      'UPDATE ZALOBY Z SET SPIS_ZNACKA=(SELECT MAX(SPISOVA_ZNACKA) FROM ZALOBY_ZPRAVY WHERE REF_KOD=Z.REF_KOD AND TYP_ZPRAVY=3) WHERE SPIS_ZNACKA IS NULL;'+
                      'UPDATE ZALOBY Z SET SOUD=(SELECT MAX(SOUD) FROM ZALOBY_ZPRAVY WHERE REF_KOD=Z.REF_KOD) WHERE SOUD IS NULL;'+
                      'UPDATE ZALOBY Z SET ZPRAVA_DORUCENI=DECODE((SELECT COUNT(*) FROM ZALOBY_ZPRAVY WHERE REF_KOD=Z.REF_KOD AND TYP_ZPRAVY=1),0,0,1) WHERE ZPRAVA_DORUCENI IS NULL;'+
                      'UPDATE ZALOBY Z SET ZPRAVA_OVERENI=DECODE((SELECT COUNT(*) FROM ZALOBY_ZPRAVY WHERE REF_KOD=Z.REF_KOD AND TYP_ZPRAVY=2),0,0,1) WHERE ZPRAVA_OVERENI IS NULL;'+
                      'UPDATE ZALOBY Z SET ZPRAVA_PL_ROZKAZ=DECODE((SELECT COUNT(*) FROM ZALOBY_ZPRAVY WHERE REF_KOD=Z.REF_KOD AND TYP_ZPRAVY=4),0,0,1) WHERE ZPRAVA_PL_ROZKAZ IS NULL;'+
                      'UPDATE ZALOBY Z SET ZPRAVA_ZAPRACOVANI=DECODE((SELECT COUNT(*) FROM ZALOBY_ZPRAVY WHERE REF_KOD=Z.REF_KOD AND TYP_ZPRAVY=3),0,0,1) WHERE ZPRAVA_ZAPRACOVANI IS NULL;'+
                      'UPDATE ZALOBY Z SET ZALOBA=(SELECT MAX(DATUM_ODESLANI) FROM ZALOBY_ZPRAVY WHERE REF_KOD=Z.REF_KOD AND TYP_ZPRAVY=4) WHERE ZALOBA IS NULL;'+
                      'UPDATE ZALOBY_OSTATNI Z SET VS_SOUDU=(SELECT MAX(VAR_SYMB) FROM ZALOBY_ZPRAVY WHERE REF_KOD=Z.REF_KOD AND TYP_ZPRAVY=4) WHERE VS_SOUDU IS NULL;'+
                      'UPDATE ZALOBY_OSTATNI Z SET CU_SOUDU=(SELECT MAX(UCET) FROM ZALOBY_ZPRAVY WHERE REF_KOD=Z.REF_KOD AND TYP_ZPRAVY=4) WHERE CU_SOUDU IS NULL;'+
                      'UPDATE ZALOBY_OSTATNI Z SET SPIS_ZNACKA=(SELECT MAX(SPISOVA_ZNACKA) FROM ZALOBY_ZPRAVY WHERE REF_KOD=Z.REF_KOD AND TYP_ZPRAVY=3) WHERE SPIS_ZNACKA IS NULL;'+
                      'UPDATE ZALOBY_OSTATNI Z SET SOUD=(SELECT MAX(SOUD) FROM ZALOBY_ZPRAVY WHERE REF_KOD=Z.REF_KOD) WHERE SOUD IS NULL;'+
                      'UPDATE ZALOBY_OSTATNI Z SET ZPRAVA_DORUCENI=DECODE((SELECT COUNT(*) FROM ZALOBY_ZPRAVY WHERE REF_KOD=Z.REF_KOD AND TYP_ZPRAVY=1),0,0,1) WHERE ZPRAVA_DORUCENI IS NULL;'+
                      'UPDATE ZALOBY_OSTATNI Z SET ZPRAVA_OVERENI=DECODE((SELECT COUNT(*) FROM ZALOBY_ZPRAVY WHERE REF_KOD=Z.REF_KOD AND TYP_ZPRAVY=2),0,0,1) WHERE ZPRAVA_OVERENI IS NULL;'+
                      'UPDATE ZALOBY_OSTATNI Z SET ZPRAVA_PL_ROZKAZ=DECODE((SELECT COUNT(*) FROM ZALOBY_ZPRAVY WHERE REF_KOD=Z.REF_KOD AND TYP_ZPRAVY=4),0,0,1) WHERE ZPRAVA_PL_ROZKAZ IS NULL;'+
                      'UPDATE ZALOBY_OSTATNI Z SET ZPRAVA_ZAPRACOVANI=DECODE((SELECT COUNT(*) FROM ZALOBY_ZPRAVY WHERE REF_KOD=Z.REF_KOD AND TYP_ZPRAVY=3),0,0,1) WHERE ZPRAVA_ZAPRACOVANI IS NULL;'+
                      'UPDATE ZALOBY_OSTATNI Z SET ZALOBA=(SELECT MAX(DATUM_ODESLANI) FROM ZALOBY_ZPRAVY WHERE REF_KOD=Z.REF_KOD AND TYP_ZPRAVY=4) WHERE ZALOBA IS NULL;';
    proc.Execute;
  finally
    //qrTemp.free;
    proc.Free;
  end;
end;

procedure prijmout_postu;
var
  pop : TPOP3Send;
  i,n,s,s2,typ,id,error_typ : Integer;
  MIME : TMimeMess;
  PART,PART2 : TMimePart;
  telo,subtelo,test : TStringList;
  predmet,odesilatel,MessageID,ref_kod,tmpx : string;
  str : UTF8String;
  datum: TDateTime;
  UCET,VAR_SYMB,PODANI_DORUCENE_DATUM,BEZNE_CISLO,
  PODANI_OVERENO_DATUM,ZASLANYCH_PRILOH,ZPUSOB_PODANI,
  PODPIS_CERTIF_PLATNY,SOUD,TYP_FORMULARE,SPISOVA_ZNACKA,
  KE_ZPRACOVANI : String;
  qt : TZQuery;
  ukladat_telo,maska_oddelovac,maska,hledat_subtela,
  smazat,kontrola : String;
  mem : TMemo;
begin
  pop:=TPOP3Send.create;
  telo:=TStringList.Create;
  test:=TStringList.Create;
  subtelo:=TStringList.Create;
  MIME:=TMimeMess.Create;
  PART:=TMimePart.Create;
  n:=0;
  error_typ:=0;
  smazat:=get_param('ZALOBY_ZPRAVY_SMAZAT_ZE_SERVERU');
  kontrola:=get_param('ZALOBY_ZPRAVY_KONTROLOVAT_DUPLICITU');
  hledat_subtela:=get_param('ZALOBY_ZPRAVY_HLEDAT_V_SUBTELE');
  maska:=get_param('ZALOBY_MASKA_REF_KOD');
  maska_oddelovac:=get_param('ZALOBY_MASKA_ODDELOVAC_REF_KOD');
  ukladat_telo:=get_param('ZALOBY_ZPRAVY_UKLADAT_TELO');
  try
    try
      if not Assigned(frmProces) then
        Application.CreateForm(TfrmProces,frmProces);
      frmProces.lbProces.Caption:='Probíhá stahování zpráv ze serveru, čekejte';
      frmProces.ProgressBar1.Min:=1;
      frmProces.ProgressBar1.Step:=1;

      pop.AutoTLS := true;
      if (get_param('ZALOBY_ZPRAVY_POP3_JMENO')='') or
         (get_param('ZALOBY_ZPRAVY_POP3_HESLO')='')
       then
      begin
        if not Assigned(frmPOP3Pripojeni) then
          Application.CreateForm(TfrmPOP3Pripojeni,frmPOP3Pripojeni);
        if frmPop3Pripojeni.Edit1.Text='' then
          frmPop3Pripojeni.Edit1.Text:=get_param('ZALOBY_ZPRAVY_POP3_JMENO');
        frmPop3Pripojeni.Edit2.Text:=get_param('ZALOBY_ZPRAVY_POP3_HESLO');
        frmPOP3Pripojeni.ShowModal;
        pop.Username:=frmPop3Pripojeni.Edit1.Text;
        pop.Password:=frmPop3Pripojeni.Edit2.Text;
        pop.TargetHost:=get_param('ZALOBY_ZPRAVY_POP3');
      end
      else
      begin
        pop.Username:=get_param('ZALOBY_ZPRAVY_POP3_JMENO');
        pop.Password:=get_param('ZALOBY_ZPRAVY_POP3_HESLO');
        pop.TargetHost:=get_param('ZALOBY_ZPRAVY_POP3');
      end;
      pop.AuthType:=POP3AuthAll;

      if not pop.login then
        MessageDlg('Nepodařilo se připojit na poštovní server '+get_param('ZALOBY_ZPRAVY_POP3')+'!',mtError,[mbOK],0);

      pop.list(0);
      if pop.Stat then
      begin
        frmProces.ProgressBar1.Max:=pop.StatCount;
        frmProces.ProgressBar1.Position:=1;
        frmProces.ShowOnTop;
        for i:=1 to pop.StatCount do
        begin
          frmProces.lbPom.Caption:='Aktuální: '+ IntToStr(i) +', Celkem: '+IntToStr(pop.StatCount);
          frmProces.ProgressBar1.StepIt;
          frmProces.Repaint;
          frmProces.Canvas.Refresh;

          pop.Retr(i);
          MIME.Lines.Text:=pop.FullResult.Text;
          MIME.DecodeMessage;

          // HTML
          if (UpperCase(MIME.MessagePart.Primary)='TEXT')and (UpperCase(MIME.MessagePart.Secondary)='HTML') then
            MIME.MessagePart.ForcedHTMLConvert:=true;

          // zjisteni existence
          if (ExecSQL_old('SELECT NVL((SELECT COUNT(*) FROM ZALOBY_ZPRAVY WHERE ID_ZPRAVY='+Q(MIME.Header.MessageID)+'),0) FROM DUAL')='0')
            or (kontrola<>'1')
          then
          begin
            MIME.MessagePart.DecodePart;

            // promazani promennych
            UCET:='';
            VAR_SYMB:='';
            PODANI_DORUCENE_DATUM:='';
            BEZNE_CISLO:='';
            PODANI_OVERENO_DATUM:='';
            ZASLANYCH_PRILOH:='';
            ZPUSOB_PODANI:='';
            PODPIS_CERTIF_PLATNY:='';
            SOUD:='';
            TYP_FORMULARE:='';
            SPISOVA_ZNACKA:='';
            KE_ZPRACOVANI:='';

            // hlavicka
            predmet:=UTF8Encode(MIME.Header.Subject);
            datum:=MIME.Header.Date;
            odesilatel:=MIME.Header.From;
            if pos('<',odesilatel)>0 then
              odesilatel:=copy(odesilatel,pos('<',odesilatel)+1,pos('>',odesilatel)-(pos('<',odesilatel)+1));
            MessageID:=MIME.Header.MessageID;

            // kontrola
            //test.Add(InlineDecode(pop.FullResult.Text, CP1250));
            //test.Add('++++++00+');
            //tmpx:=pop.FullResult.Text;
            {mem:=TMemo.Create(nil);
            mem.Lines.LoadFromStream(MIME.MessagePart.DecodedLines);
            ShowMessage(mem.Text);
            ShowMessage(copy(pop.FullResult.Text,4900,100));
            ShowMessage(pop.FullResult.Text);
            exit;}

            // telo
            telo.Clear;
            telo.LoadFromStream(MIME.MessagePart.DecodedLines);

            //test.Add(Telo.Text);
            //test.Add('++++++01+');

            // HTML
            MIME.MessagePart.ForcedHTMLConvert:=false;

            telo.Text:=UTF8Encode(telo.Text);

            // sub tela
            if hledat_subtela='1' then
              telo.Add(Get_text_part(MIME.MessagePart).Text);
            //exit;

            {if hledat_subtela='1' then
            begin
              for s:=0 to MIME.MessagePart.GetSubPartCount-1 do
              begin
                PART:=MIME.MessagePart.GetSubPart(s);
                // HTML
                if (UpperCase(MIME.MessagePart.Primary)='TEXT')and (UpperCase(MIME.MessagePart.Secondary)='HTML') then
                  MIME.MessagePart.ForcedHTMLConvert:=true;
                PART.DecodePart;
                subtelo.Clear;
                subtelo.LoadFromStream(PART.DecodedLines);
                if (pos('evidenčním číslem:',UTF8Encode(subtelo.Text))>0) or
                   (pos('eviden?ním ?íslem:',UTF8Encode(subtelo.Text))>0) then
                begin
                  telo.Add(UTF2WIN(subtelo.Text));
                end;

                // HTML
                MIME.MessagePart.ForcedHTMLConvert:=false;

                for s2:=0 to PART.GetSubPartCount-1 do
                begin
                  PART2:=PART.GetSubPart(s);
                  if (UpperCase(PART2.Primary)='TEXT')and (UpperCase(PART2.Secondary)='HTML') then
                    PART2.ForcedHTMLConvert:=true;
                  PART2.DecodePart;
                  subtelo.Clear;
                  subtelo.LoadFromStream(PART2.DecodedLines);
                  test.Add(subtelo.Text);
                  test.Add('++++++012+');
                  PART2.ForcedHTMLConvert:=false;
                end;
              end;
            end;}

            // hledání polí

            // zjisteni typu
            typ:=StrToInt(ExecSQL_old('SELECT NVL((SELECT MAX(TYP) AS TYP FROM ZPRAVY_TYPY WHERE '+Q(predmet)+' LIKE ''%''||PREDMET||''%'' ),0) FROM DUAL'));
            {test.clear;
            test.Add(IntToStr(typ));
            test.Add('+++++++');
            test.Add(Q(predmet)+' LIKE ''%''||PREDMET||''%''');
            test.Add('+++++++');
            test.Add(ExecSQL_old('SELECT PREDMET FROM ZPRAVY_TYPY WHERE TYP=1'));
            test.Add('+++++++');
            test.Add(ExecSQL_old('SELECT PREDMET FROM ZPRAVY_TYPY WHERE TYP=2'));
            test.Add('+++++++');
            test.Add(predmet);
            test.SaveToFile(Application.Location+'EmailX'+IntToStr(i)+'.txt');
            test.Clear;}


            //ShowMessage(ExecSQL_old('SELECT PREDMET FROM ZPRAVY_TYPY WHERE ID=1'));
            // ref kod
            if typ > 0 then
              ref_kod:=najdi_ref_kod(telo.Text,maska,maska_oddelovac);
            //telo.SaveToFile('C:\Martin\Emaily\Email'+ref_kod+'typ'+IntToStr(typ)+'.txt');

            if typ=4 then
            begin
              UCET:=copy(najdi_ucet(telo.Text),1,30);
              VAR_SYMB:=copy(najdi_var_symb(telo.Text),1,30);
              PODANI_DORUCENE_DATUM:=copy(najdi_podani_doruceno(telo.Text),1,30);
            end;

            if typ=3 then
            begin
              VAR_SYMB:=copy(najdi_var_symb(telo.Text),1,30);
              PODANI_OVERENO_DATUM:=copy(najdi_podani_overeno(telo.Text),1,30);
              PODANI_DORUCENE_DATUM:=copy(najdi_podani_doruceno(telo.Text),1,30);
              SOUD:=copy(najdi_soud(telo.Text),1,60);
              BEZNE_CISLO:=copy(najdi_bezne_cislo(telo.Text),1,30);
              KE_ZPRACOVANI:=copy(najdi_ke_zpracovani(telo.Text),1,30);
              SPISOVA_ZNACKA:=copy(najdi_spis_znacka(telo.Text),1,30);
            end;

            if typ=2 then
            begin
              VAR_SYMB:=copy(najdi_var_symb(telo.Text),1,30);
              PODANI_OVERENO_DATUM:=copy(najdi_podani_overeno(telo.Text),1,30);
              PODANI_DORUCENE_DATUM:=copy(najdi_podani_doruceno(telo.Text),1,30);
              SOUD:=copy(najdi_soud(telo.Text),1,60);
              BEZNE_CISLO:=copy(najdi_bezne_cislo(telo.Text),1,30);
              ZASLANYCH_PRILOH:=copy(najdi_zaslanych_priloh(telo.Text),1,30);
              ZPUSOB_PODANI:=copy(najdi_zpusob_podani(telo.Text),1,30);
              PODPIS_CERTIF_PLATNY:=copy(najdi_podpis_cert_platny(telo.Text),1,30);
              TYP_FORMULARE:=copy(najdi_typ_formulare(telo.Text),1,30);
            end;

            if typ=1 then
            begin
              VAR_SYMB:=copy(najdi_var_symb(telo.Text),1,30);
              BEZNE_CISLO:=copy(najdi_bezne_cislo(telo.Text),1,30);
              PODANI_DORUCENE_DATUM:=copy(najdi_podani_doruceno(telo.Text),1,30);
              ZASLANYCH_PRILOH:=copy(najdi_zaslanych_priloh(telo.Text),1,30);
              ZPUSOB_PODANI:=copy(najdi_zpusob_podani(telo.Text),1,30);
              SOUD:=copy(najdi_soud(telo.Text),1,60);
              TYP_FORMULARE:=copy(najdi_typ_formulare(telo.Text),1,30);
            end;

            if typ=0 then
            begin
              error_typ:=1;
              //MessageDlg('Ke zprávě s předmětem "'+predmet+'" nebyl definován typ v číselníku, nebude tedy přijata. Informujte programátora.',mtWarning,[mbOK],0)
              {test.Add(predmet);
              test.Add(odesilatel);
              test.Add(DateToStr(Datum));
              test.Add('Typ = 0');
              test.SaveToFile(Application.Location+'EmailB'+IntToStr(i)+'.txt');}
            end
            else
            begin
              //test.clear;
              {test.Add('+++++++');
              test.Add(predmet);
              test.Add('+++++++');
              test.Add(ref_kod);
              test.Add('+++++++');
              test.Add(telo.Text);
              test.SaveToFile(Application.Location+'EmailX'+IntToStr(i)+'.txt');
              test.Clear;}
              if length(ref_kod)>0 then
              begin
                if pos('nebylo možné podat',telo.Text)>0 then typ:=5;
                id:=StrToInt(ExecSQL_old('SELECT SEQ_ZALOBY_ZPRAVY_ID.NEXTVAL FROM DUAL'));
                ExecSQL('INSERT INTO ZALOBY_ZPRAVY(REF_KOD,DATUM_STAZENI,ID,TYP_ZPRAVY,PREDMET,DATUM_ODESLANI,ODESILATEL,ID_ZPRAVY,'+
                        'UCET,VAR_SYMB,PODANI_DORUCENE_DATUM,BEZNE_CISLO,PODANI_OVERENO_DATUM,ZASLANYCH_PRILOH,ZPUSOB_PODANI,'+
                        'PODPIS_CERTIF_PLATNY,SOUD,TYP_FORMULARE,SPISOVA_ZNACKA,KE_ZPRACOVANI)'+
                        '  VALUES('+Q(ref_kod)+',TO_DATE('+Q(DateToStr(Date()))+'),'+IntToStr(id)+','+Q(IntToStr(typ))+','+Q(predmet)+',TO_DATE('+Q(DateToStr(datum))+'),'+Q(Odesilatel)+','+Q(MessageID)+
                        ','+Q(ucet)+','+Q(var_symb)+','+Q(PODANI_DORUCENE_DATUM)+','+Q(BEZNE_CISLO)+','+Q(PODANI_OVERENO_DATUM)+',NVL('+Q(ZASLANYCH_PRILOH)+',0)'+
                        ','+Q(ZPUSOB_PODANI)+','+Q(PODPIS_CERTIF_PLATNY)+','+Q(SOUD)+','+Q(TYP_FORMULARE)+','+Q(SPISOVA_ZNACKA)+','+Q(KE_ZPRACOVANI)+')');
                ExecSQL('COMMIT');
                if ukladat_telo='1' then
                begin
                  try
                    qt:=TZQuery.Create(nil);
                    qt.Connection:=DM.OracleConnection;
                    qt.SQL.Add('UPDATE ZALOBY_ZPRAVY SET TELO = :TELO WHERE ID = :ID');
                    qt.ParamByName('ID').DataType:=ftInteger;
                    qt.ParamByName('ID').AsInteger:=id;
                    qt.ParamByName('TELO').DataType:=ftOraClob;
                    qt.ParamByName('TELO').AsMemo:=UTF8Encode(telo.Text);
                    qt.ExecSQL;
                  finally
                    qt.Free;
                  end;
                end;
                n:=n+1;
                if smazat='1' then
                  pop.Dele(i);
              end
              else
              begin
                {test.Add(predmet);
                test.Add(odesilatel);
                test.Add(DateToStr(Datum));
                test.SaveToFile(Application.Location+'EmailC'+IntToStr(i)+'.txt');}
              end;
            end;
          end;
        end;
      end;
      pop.logout;
      frmProces.Close;
      doplnit_udaje_ze_zprav;
      if error_typ=1 then
        MessageDlg('Byly nalezeny zprávy s předmětem, který nemá definován typ v číselníku, nebyly tedy přijaty. Informujte programátora.',mtWarning,[mbOK],0);
      if n=0 then
        MessageDlg('Nemáte žádnou novou zprávu. ',mtInformation,[mbOK],0)
      else
      begin
        MessageDlg('Zprávy byly přijmuty (nalezeno: '+IntToStr(pop.StatCount)+', přijato: '+IntToStr(n)+')',mtInformation,[mbOK],0);
      end;
    except
      on E : Exception do
      begin
        if Assigned(frmProces) then
          if frmProces.IsVisible then
            frmProces.Close;
        MessageDlg('Import skončil chybou: '+E.Message+'!',mtError,[mbOK],0);
      end;
    end;
  finally
    pop.Free;
    MIME.Free;
    telo.Free;
    subtelo.Free;
    test.Free;
    if Assigned(frmProces) then
      if frmProces.IsVisible then
        frmProces.Close;
  end;

end;

procedure predavaci_protokol_excel(g:TDBGrid; tab: string);
var
  s: TStringList;
  sd : TSaveDialog;
  h,telo,t,sql_dotaz,styl,Datum,celkem_jizdne,
  celkem_prirazka,celkem_zaznamu,celkem,temp,
  sql_dotaz2,data: string;
  row_count,col_count,pocet_poli,pocet_zaznamu,i : Integer;
  qt : TZQuery;
  table : TDataSet;
  w: WideString;
begin
  if not Assigned(frmTiskZalob) then
    Application.CreateForm(TfrmTiskZalob,frmTiskZalob);
  frmTiskZalob.FSelRows:=g.SelectedRows.Count;
  frmTiskZalob.ShowModal;
  if frmTiskZalob.ModalResult=mrOK then
  begin
    try

    if frmTiskZalob.rbOznacene.Checked then
    begin
      if g.SelectedRows.CurrentRowSelected then
      begin
        Table:=g.DataSource.Dataset;
        for i:=0 to g.SelectedRows.Count-1 do
        begin
          Table.Bookmark:=g.SelectedRows[i];
          if i=0 then
            temp:=Table.FieldByName('ID').AsString
          else
            temp:=temp+','+Table.FieldByName('ID').AsString;
        end;
      end;
    end;

    if not Assigned(frmProcesQuery) then
      Application.CreateForm(TfrmProcesQuery,frmProcesQuery);
    frmProcesQuery.ShowOnTop;
    frmProcesQuery.Repaint;
    qt:=TZQuery.Create(nil);
    sd:=TSaveDialog.Create(nil);
    s:=TStringList.Create;
    pocet_poli:=1;
    pocet_zaznamu:=1;
    qt.Connection:=DM.OracleConnection;

    if frmTiskZalob.rbVse.Checked then
    begin
      sql_dotaz:='SELECT ROWNUM AS "č",S.* FROM (SELECT'+
                 '  VAR_SYMB AS VS, '+
                 '  JIZDNE AS "Jízdné", '+
                 '  POKUTA AS "Přirážka",'+
                 '  GET_JMENO_PRIJMENI(JMENO_CP,1) AS "Jméno",'+
                 '  GET_JMENO_PRIJMENI(JMENO_CP,2) AS "Příjmení",'+
                 '  ULICE AS "Ulice",'+
                 '  CISLO_DOMU AS "č. domu",'+
                 '  MESTO AS "Město",'+
                 '  PSC AS "PSČ",'+
                 '  DATUM_CAS AS "Datum jízdy",'+
                 '  RODNE_CISLO AS "Rodné číslo" '+
                 'FROM '+
                 '  '+tab+' '+
                 'WHERE '+
                 '  NVL(UZAMCENA,0)=0 '+
                 'ORDER BY '+
                 '  VAR_SYMB) S';
      sql_dotaz2:='SELECT '+
                  '  (SELECT COUNT(*) FROM '+tab+' WHERE NVL(UZAMCENA,0)=0) AS R_POCET,'+
                  '  (SELECT SUM(NVL(JIZDNE,0)) FROM '+tab+' WHERE NVL(UZAMCENA,0)=0)+(SELECT SUM(NVL(POKUTA,0)) FROM '+tab+' WHERE NVL(UZAMCENA,0)=0) AS R_CELKEM, '+
                  '  (SELECT SUM(NVL(JIZDNE,0)) FROM '+tab+' WHERE NVL(UZAMCENA,0)=0) AS JIZDNE_CELKEM,'+
                  '  (SELECT SUM(NVL(POKUTA,0)) FROM '+tab+' WHERE NVL(UZAMCENA,0)=0) AS PRIRAZKA_CELKEM '+
                  'FROM '+
                  '  DUAL ';
    end;
    if (frmTiskZalob.rbDatum.Checked) and (frmTiskZalob.edDatumImportu.Text<>'') then
    begin
      sql_dotaz:='SELECT ROWNUM AS "č",S.* FROM (SELECT'+
                 '  VAR_SYMB AS VS,'+
                 '  JIZDNE AS "Jízdné",'+
                 '  POKUTA AS "Přirážka",'+
                 '  GET_JMENO_PRIJMENI(JMENO_CP,1) AS "Jméno",'+
                 '  GET_JMENO_PRIJMENI(JMENO_CP,2) AS "Příjmení",'+
                 '  ULICE AS "Ulice",'+
                 '  CISLO_DOMU AS "č. domu",'+
                 '  MESTO AS "Město",'+
                 '  PSC AS "PSČ",'+
                 '  DATUM_CAS AS "Datum jízdy",'+
                 '  RODNE_CISLO AS "Rodné číslo" '+
                 'FROM '+
                 '  '+tab+' '+
                 'WHERE '+
                 '  NVL(UZAMCENA,0)=0 '+
                 '  AND DATUM_IMPORTU=TO_DATE('''+frmTiskZalob.edDatumImportu.Text+''') '+
                 'ORDER BY '+
                 '  VAR_SYMB) S';
      sql_dotaz2:='SELECT '+
                  '  (SELECT COUNT(*) FROM '+tab+' WHERE NVL(UZAMCENA,0)=0 AND DATUM_IMPORTU=TO_DATE('''+frmTiskZalob.edDatumImportu.Text+''')) AS R_POCET,'+
                  '  (SELECT SUM(NVL(JIZDNE,0)) FROM '+tab+' WHERE NVL(UZAMCENA,0)=0 AND DATUM_IMPORTU=TO_DATE('''+frmTiskZalob.edDatumImportu.Text+'''))+(SELECT SUM(NVL(POKUTA,0)) FROM '+tab+' WHERE NVL(UZAMCENA,0)=0 AND DATUM_IMPORTU=TO_DATE('''+frmTiskZalob.edDatumImportu.Text+''')) AS R_CELKEM, '+
                  '  (SELECT SUM(NVL(JIZDNE,0)) FROM '+tab+' WHERE NVL(UZAMCENA,0)=0 AND DATUM_IMPORTU=TO_DATE('''+frmTiskZalob.edDatumImportu.Text+''')) AS JIZDNE_CELKEM,'+
                  '  (SELECT SUM(NVL(POKUTA,0)) FROM '+tab+' WHERE NVL(UZAMCENA,0)=0 AND DATUM_IMPORTU=TO_DATE('''+frmTiskZalob.edDatumImportu.Text+''')) AS PRIRAZKA_CELKEM '+
                  'FROM '+
                  '  DUAL ';
    end;
    if frmTiskZalob.rbOznacene.Checked then
    begin
      sql_dotaz:='SELECT ROWNUM AS "č",S.* FROM (SELECT'+
                 '  VAR_SYMB AS VS,'+
                 '  JIZDNE AS "Jízdné",'+
                 '  POKUTA AS "Přirážka",'+
                 '  GET_JMENO_PRIJMENI(JMENO_CP,1) AS "Jméno",'+
                 '  GET_JMENO_PRIJMENI(JMENO_CP,2) AS "Příjmení",'+
                 '  ULICE AS "Ulice",'+
                 '  CISLO_DOMU AS "č. domu",'+
                 '  MESTO AS "Město",'+
                 '  PSC AS "PSČ",'+
                 '  DATUM_CAS AS "Datum jízdy",'+
                 '  RODNE_CISLO AS "Rodné číslo" '+
                 'FROM '+
                 '  '+tab+' '+
                 'WHERE '+
                 '  ID IN ('+temp+') '+
                 'ORDER BY '+
                 '  VAR_SYMB) S';
      sql_dotaz2:='SELECT '+
                  '  (SELECT COUNT(*) FROM '+tab+' WHERE ID IN ('+temp+')) AS R_POCET,'+
                  '  (SELECT SUM(NVL(JIZDNE,0)) FROM '+tab+' WHERE ID IN ('+temp+'))+(SELECT SUM(NVL(POKUTA,0)) FROM '+tab+' WHERE ID IN ('+temp+')) AS R_CELKEM, '+
                  '  (SELECT SUM(NVL(JIZDNE,0)) FROM '+tab+' WHERE ID IN ('+temp+')) AS JIZDNE_CELKEM,'+
                  '  (SELECT SUM(NVL(POKUTA,0)) FROM '+tab+' WHERE ID IN ('+temp+')) AS PRIRAZKA_CELKEM '+
                  'FROM '+
                  '  DUAL ';
    end;
    qt.SQL.Text:=sql_dotaz;
    //ShowMessage(sql_dotaz);
    qt.Open;
    pocet_poli:=qt.Fields.Count;
    pocet_zaznamu:=qt.RecordCount;
    qt.First;
    while not (qt.EOF=true) do
    begin
      if length(data)=0 then
      begin
        data:=data+'<Row>';
        for i:=0 to qt.Fields.Count-1 do
        begin
          data:=data+'<Cell><Data ss:Type="String">'+qt.Fields.Fields[i].FieldName+'</Data></Cell>';
        end;
        data:=data+'</Row>';
      end;
      data:=data+'<Row>';
      for i:=0 to qt.Fields.Count-1 do
      begin
        data:=data+'<Cell><Data ss:Type="String">'+qt.Fields.Fields[i].AsString+'</Data></Cell>';
      end;
      data:=data+'</Row>';
      qt.Next;
    end;
    qt.Close;
    qt.SQL.Text:=sql_dotaz2;
    qt.Open;
    Celkem_jizdne:=qt.FieldByName('JIZDNE_CELKEM').AsString;
    Celkem_prirazka:=qt.FieldByName('PRIRAZKA_CELKEM').AsString;
    Celkem_zaznamu:=qt.FieldByName('R_POCET').AsString;
    Celkem:=qt.FieldByName('R_CELKEM').AsString;
    qt.Close;

    // STYLY
    styl:= '<Styles>'+
           '  <Style ss:ID="s62">'+
           '  <Alignment ss:Horizontal="Center" ss:Vertical="Bottom"/>'+
           '  <Borders>'+
           '  <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>'+
           '  </Borders>'+
           '  <Font ss:FontName="Arial Narrow" x:Family="Swiss" ss:Size="14" ss:Bold="1"/>'+
           //'  <Interior ss:Color="#FFFF00" ss:Pattern="Solid"/>'+
           '  </Style>'+
           '  <Style ss:ID="s63">'+
           '  <Font ss:FontName="Arial Narrow" x:Family="Swiss" ss:Size="12" ss:Bold="1"/>'+
           //'  <Interior ss:Color="#FFFF00" ss:Pattern="Solid"/>'+
           '  </Style>'+
           '</Styles>';

    // HLAVICKA
    s.Text:='<?xml version="1.0" encoding="ISOWIN1250"?>'+
            '<Workbook xmlns="urn:schemas-microsoft-com:office:spreadsheet" '+
            'xmlns:html="http://www.w3.org/TR/REC-html40" xmlns:o="urn:schemas-microsoft-com:office:office" '+
            'xmlns:ss="urn:schemas-microsoft-com:office:spreadsheet" xmlns:x="urn:schemas-microsoft-com:office:excel">'+
            '<DocumentProperties xmlns="urn:schemas-microsoft-com:office:office">'+
            '<Author xmlns="urn:schemas-microsoft-com:office:office">Author</Author>'+
            '<Company xmlns="urn:schemas-microsoft-com:office:office">Company</Company>'+
            '<Version xmlns="urn:schemas-microsoft-com:office:office">1</Version>'+
            '</DocumentProperties>'+
            '<OfficeDocumentSettings xmlns="urn:schemas-microsoft-com:office:office">'+
            '<DownloadComponents xmlns="urn:schemas-microsoft-com:office:office" />'+
            '<LocationOfComponents xmlns="urn:schemas-microsoft-com:office:office" HRef="file:///\\phlfsnt01\DOWNLOAD\OfficeXPSrc\" />'+
            '</OfficeDocumentSettings>'+
            '<ExcelWorkbook xmlns="urn:schemas-microsoft-com:office:excel">'+
            '<ProtectStructure xmlns="urn:schemas-microsoft-com:office:excel">False</ProtectStructure>'+
            '<ProtectWindows xmlns="urn:schemas-microsoft-com:office:excel">False</ProtectWindows>'+
            '</ExcelWorkbook>';

    // STYLY
    s.Add(styl);

    // KONEC HLAVICKY
    s.Add('<Worksheet ss:Name="Sheet1">');
    s.Add('<Table ss:ExpandedColumnCount="'+IntToStr(pocet_poli)+'" ss:ExpandedRowCount="'+IntToStr(pocet_zaznamu+16)+'" x:FullColumns="1" x:FullRows="1">');

    // TELO
    Datum:=ExecSQL_old('SELECT GET_PARAM(''ZALOBY_DATUM_PREDANI'') FROM DUAL');
    s.Add('<Row><Cell><Data ss:Type="String"></Data></Cell><Cell><Data ss:Type="String"></Data></Cell><Cell><Data ss:Type="String"></Data></Cell><Cell><Data ss:Type="String"></Data></Cell><Cell><Data ss:Type="String"></Data></Cell><Cell ss:StyleID="s62"><Data ss:Type="String">'+'Předávací protokol'+'</Data></Cell></Row>');
    s.Add('<Row><Cell><Data ss:Type="String"></Data></Cell></Row>');
    s.Add('<Row><Cell><Data ss:Type="String">Dne '+Datum+' byla  v souladu se Smlouvou  o postoupení pohledávek č. ODB20100134 postupitelem předána listinná dokumentace k níže uvedeným pohledávkám.'+'</Data></Cell></Row>');
    S.Add('<Row><Cell><Data ss:Type="String">'+'Současně postupník předal postupiteli ke každé postupované pohledávce písemné oznámení o postoupení pohledávky, a to včetně poštovní obálky.'+'</Data></Cell></Row>');
    S.Add('<Row><Cell><Data ss:Type="String"></Data></Cell></Row>');
    S.Add('<Row><Cell><Data ss:Type="String"></Data></Cell></Row>');

    // TELO - VYPIS DAT
    s.Add(data);

    // TELO
    s.Add('<Row>');
      s.Add('<Cell ss:StyleID="s63"><Data ss:Type="String">Celkem</Data></Cell>');
      s.Add('<Cell ss:StyleID="s63"><Data ss:Type="String"></Data></Cell>');
      s.Add('<Cell ss:StyleID="s63"><Data ss:Type="String">'+Celkem_jizdne+'</Data></Cell>');
      s.Add('<Cell ss:StyleID="s63"><Data ss:Type="String">'+Celkem_prirazka+'</Data></Cell>');
    s.Add('</Row>');
    s.Add('<Row><Cell><Data ss:Type="String"></Data></Cell></Row>');
    s.Add('<Row>');
      s.Add('<Cell ss:StyleID="s63"><Data ss:Type="String">'+'Celkový počet postoupených pohledávek'+'</Data></Cell>');
      s.Add('<Cell><Data ss:Type="String"></Data></Cell>');
      s.Add('<Cell><Data ss:Type="String"></Data></Cell>');
      s.Add('<Cell><Data ss:Type="String"></Data></Cell>');
      s.Add('<Cell ss:StyleID="s63"><Data ss:Type="String">'+Celkem_zaznamu+'</Data></Cell><Cell><Data ss:Type="String">ks</Data></Cell>');
    s.Add('</Row>');
    s.Add('<Row>');
      s.Add('<Cell ss:StyleID="s63"><Data ss:Type="String">'+'Celková výše postoupených pohledávek'+'</Data></Cell>');
      s.Add('<Cell><Data ss:Type="String"></Data></Cell>');
      s.Add('<Cell><Data ss:Type="String"></Data></Cell>');
      s.Add('<Cell><Data ss:Type="String"></Data></Cell>');
      s.Add('<Cell ss:StyleID="s63"><Data ss:Type="String">'+Celkem+'</Data></Cell><Cell><Data ss:Type="String">'+'Kč'+'</Data></Cell>');
    s.Add('</Row>');
    s.Add('<Row><Cell><Data ss:Type="String"></Data></Cell></Row>');
    s.Add('<Row><Cell><Data ss:Type="String"></Data></Cell></Row>');
    s.Add('<Row><Cell><Data ss:Type="String"></Data></Cell></Row>');
    s.Add('<Row>');
      s.Add('<Cell><Data ss:Type="String"></Data></Cell>');
      s.Add('<Cell><Data ss:Type="String"></Data></Cell>');
      s.Add('<Cell><Data ss:Type="String"></Data></Cell>');
      s.Add('<Cell><Data ss:Type="String">podpis</Data></Cell>');
      s.Add('<Cell><Data ss:Type="String"></Data></Cell>');
      s.Add('<Cell><Data ss:Type="String"></Data></Cell>');
      s.Add('<Cell><Data ss:Type="String"></Data></Cell>');
      s.Add('<Cell><Data ss:Type="String"></Data></Cell>');
      s.Add('<Cell><Data ss:Type="String"></Data></Cell>');
      s.Add('<Cell><Data ss:Type="String">podpis</Data></Cell>');
    s.Add('</Row>');
    s.Add('<Row>');
      s.Add('<Cell><Data ss:Type="String"></Data></Cell>');
      s.Add('<Cell><Data ss:Type="String">'+'Za DPO předal:'+'</Data></Cell>');
      s.Add('<Cell><Data ss:Type="String"></Data></Cell>');
      s.Add('<Cell><Data ss:Type="String"></Data></Cell>');
      s.Add('<Cell><Data ss:Type="String"></Data></Cell>');
      s.Add('<Cell><Data ss:Type="String"></Data></Cell>');
      s.Add('<Cell><Data ss:Type="String"></Data></Cell>');
      s.Add('<Cell><Data ss:Type="String">'+'Za spol. FENICIA,  spol. s r.o. převzal:'+'</Data></Cell>');
    s.Add('</Row>');

    // PATICKA
    s.Add('</Table></Worksheet></Workbook>');

    sd.DefaultExt:='.xml';
    sd.Filter:='Soubory typu XML(*.xml)|*.xml';

    if sd.Execute then
      s.SaveToFile(sd.FileName);
    qt.Close;
    frmProcesQuery.Close;

    ShowMessage('Export skončil');

  finally
    qt.Free;
    sd.Free;
    s.Free;
    frmProcesQuery.Close;
  end;

  end;

end;

procedure podaci_list_excel(g:TDBGrid; tab: string);
var
  s: TStringList;
  sd : TSaveDialog;
  h,telo,t,sql_dotaz,styl,Datum,celkem_jizdne,
  celkem_prirazka,celkem_zaznamu,celkem,temp,
  sql_dotaz2,data: string;
  row_count,col_count,pocet_poli,pocet_zaznamu,i : Integer;
  qt : TZQuery;
  table : TDataSet;
  w: WideString;
begin
  if not Assigned(frmTiskZalob) then
    Application.CreateForm(TfrmTiskZalob,frmTiskZalob);
  frmTiskZalob.FSelRows:=g.SelectedRows.Count;
  frmTiskZalob.ShowModal;
  if frmTiskZalob.ModalResult=mrOK then
  begin
    try

    if frmTiskZalob.rbOznacene.Checked then
    begin
      if g.SelectedRows.CurrentRowSelected then
      begin
        Table:=g.DataSource.Dataset;
        for i:=0 to g.SelectedRows.Count-1 do
        begin
          Table.Bookmark:=g.SelectedRows[i];
          if i=0 then
            temp:=Table.FieldByName('ID').AsString
          else
            temp:=temp+','+Table.FieldByName('ID').AsString;
        end;
      end;
    end;

    if not Assigned(frmProcesQuery) then
      Application.CreateForm(TfrmProcesQuery,frmProcesQuery);
    frmProcesQuery.ShowOnTop;
    frmProcesQuery.Repaint;
    qt:=TZQuery.Create(nil);
    sd:=TSaveDialog.Create(nil);
    s:=TStringList.Create;
    pocet_poli:=1;
    pocet_zaznamu:=1;
    qt.Connection:=DM.OracleConnection;

    if frmTiskZalob.rbVse.Checked then
    begin
      sql_dotaz:='SELECT'+
                 '  JMENO_CP,'+
                 '  ULICE||'' ''||CISLO_DOMU AS ULICE_CP,'+
                 '  PSC||'' ''||MESTO AS PSC_MESTO,'+
                 '  ''D'' AS POZN,'+
                 '  VAR_SYMB '+
                 'FROM '+
                 '  '+tab+' '+
                 'WHERE '+
                 '  NVL(UZAMCENA,0)=0 '+
                 'ORDER BY '+
                 '  VAR_SYMB';
    end;
    if (frmTiskZalob.rbDatum.Checked) and (frmTiskZalob.edDatumImportu.Text<>'') then
    begin
      sql_dotaz:='SELECT'+
                 '  JMENO_CP,'+
                 '  ULICE||'' ''||CISLO_DOMU AS ULICE_CP,'+
                 '  PSC||'' ''||MESTO AS PSC_MESTO,'+
                 '  ''D'' AS POZN,'+
                 '  VAR_SYMB '+
                 'FROM '+
                 '  '+tab+' '+
                 'WHERE '+
                 '  NVL(UZAMCENA,0)=0 '+
                 '  AND DATUM_IMPORTU=TO_DATE('''+frmTiskZalob.edDatumImportu.Text+''') '+
                 'ORDER BY '+
                 '  VAR_SYMB';
    end;
    if frmTiskZalob.rbOznacene.Checked then
    begin
      sql_dotaz:='SELECT'+
                 '  JMENO_CP,'+
                 '  ULICE||'' ''||CISLO_DOMU AS ULICE_CP,'+
                 '  PSC||'' ''||MESTO AS PSC_MESTO,'+
                 '  ''D'' AS POZN,'+
                 '  VAR_SYMB '+
                 'FROM '+
                 '  '+tab+' '+
                 'WHERE '+
                 '  ID IN ('+temp+') '+
                 'ORDER BY '+
                 '  VAR_SYMB';
    end;
    qt.SQL.Text:=sql_dotaz;
    qt.Open;
    pocet_poli:=10;//qt.Fields.Count;
    pocet_zaznamu:=qt.RecordCount*3;
    qt.First;
    while not (qt.EOF=true) do
    begin
      if length(data)=0 then
      begin
        data:=data+'<Row>';
          data:=data+'<Cell ss:StyleID="s67"><Data ss:Type="String">Poř.číslo</Data></Cell>';
          data:=data+'<Cell ss:StyleID="s67"><Data ss:Type="String">Podací znaky</Data></Cell>';
          data:=data+'<Cell ss:StyleID="s67"><Data ss:Type="String">Adresát - jméno, příjmení, ulice, číslo domu, PSČ, místo určení 1)</Data></Cell>';
          data:=data+'<Cell ss:StyleID="s67"><Data ss:Type="String">Dobírka 1)</Data></Cell>';
          data:=data+'<Cell ss:StyleID="s67"><Data ss:Type="String">Udaná cena 2)</Data></Cell>';
          data:=data+'<Cell ss:StyleID="s67"><Data ss:Type="String">Poznámka, doplňkové služby</Data></Cell>';
        data:=data+'</Row>';
      end;
      data:=data+'<Row>';
        data:=data+'<Cell ss:StyleID="s64"></Cell><Cell ss:StyleID="s64"></Cell><Cell ss:StyleID="s64"><Data ss:Type="String">'+qt.Fields.Fields[0].AsString+'</Data></Cell><Cell ss:StyleID="s64"></Cell><Cell ss:StyleID="s64"></Cell><Cell ss:StyleID="s64"><Data ss:Type="String">'+qt.Fields.Fields[3].AsString+'</Data></Cell>';
      data:=data+'</Row>';
      data:=data+'<Row>';
        data:=data+'<Cell ss:StyleID="s65"></Cell><Cell ss:StyleID="s65"></Cell><Cell ss:StyleID="s65"><Data ss:Type="String">'+qt.Fields.Fields[1].AsString+'</Data></Cell><Cell ss:StyleID="s65"></Cell><Cell ss:StyleID="s65"></Cell><Cell ss:StyleID="s65"><Data ss:Type="String">'+qt.Fields.Fields[4].AsString+'</Data></Cell>';
      data:=data+'</Row>';
      data:=data+'<Row>';
        data:=data+'<Cell ss:StyleID="s66"></Cell><Cell ss:StyleID="s66"></Cell><Cell ss:StyleID="s66"><Data ss:Type="String">'+qt.Fields.Fields[2].AsString+'</Data></Cell><Cell ss:StyleID="s66"></Cell><Cell ss:StyleID="s66"></Cell><Cell ss:StyleID="s66"></Cell>';
      data:=data+'</Row>';
      qt.Next;
    end;
    qt.Close;

    // STYLY
    styl:= '<Styles>'+
           '  <Style ss:ID="s62">'+
           '  <Alignment ss:Horizontal="Center" ss:Vertical="Bottom"/>'+
           '  <Borders>'+
           '  <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>'+
           '  </Borders>'+
           '  <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="14" ss:Bold="1"/>'+
           //'  <Interior ss:Color="#FFFF00" ss:Pattern="Solid"/>'+
           '  </Style>'+
           '  <Style ss:ID="s63">'+
           '  <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="11" ss:Bold="0"/>'+
           //'  <Interior ss:Color="#FFFF00" ss:Pattern="Solid"/>'+
           '  </Style>'+
           '  <Style ss:ID="s64">'+
           '    <Borders>'+
           '      <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>'+
           '      <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>'+
           '      <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>'+
           '    </Borders>'+
           '  </Style>'+
           '  <Style ss:ID="s65">'+
           '    <Borders>'+
           '      <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>'+
           '      <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>'+
           '    </Borders>'+
           '  </Style>'+
           '  <Style ss:ID="s66">'+
           '    <Borders>'+
           '      <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>'+
           '      <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>'+
           '      <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>'+
           '    </Borders>'+
           '  </Style>'+
           '  <Style ss:ID="s67">'+
           '  <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="11" ss:Bold="1"/>'+
           '    <Borders>'+
           '      <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>'+
           '      <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>'+
           '      <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>'+
           '      <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>'+
           '    </Borders>'+
           '  </Style>'+
           '</Styles>';

    // HLAVICKA
    s.Text:='<?xml version="1.0" encoding="ISOWIN1250"?>'+
            '<Workbook xmlns="urn:schemas-microsoft-com:office:spreadsheet" '+
            'xmlns:html="http://www.w3.org/TR/REC-html40" xmlns:o="urn:schemas-microsoft-com:office:office" '+
            'xmlns:ss="urn:schemas-microsoft-com:office:spreadsheet" xmlns:x="urn:schemas-microsoft-com:office:excel">'+
            '<DocumentProperties xmlns="urn:schemas-microsoft-com:office:office">'+
            '<Author xmlns="urn:schemas-microsoft-com:office:office">Author</Author>'+
            '<Company xmlns="urn:schemas-microsoft-com:office:office">Company</Company>'+
            '<Version xmlns="urn:schemas-microsoft-com:office:office">1</Version>'+
            '</DocumentProperties>'+
            '<OfficeDocumentSettings xmlns="urn:schemas-microsoft-com:office:office">'+
            '<DownloadComponents xmlns="urn:schemas-microsoft-com:office:office" />'+
            '<LocationOfComponents xmlns="urn:schemas-microsoft-com:office:office" HRef="file:///\\phlfsnt01\DOWNLOAD\OfficeXPSrc\" />'+
            '</OfficeDocumentSettings>'+
            '<ExcelWorkbook xmlns="urn:schemas-microsoft-com:office:excel">'+
            '<ProtectStructure xmlns="urn:schemas-microsoft-com:office:excel">False</ProtectStructure>'+
            '<ProtectWindows xmlns="urn:schemas-microsoft-com:office:excel">False</ProtectWindows>'+
            '</ExcelWorkbook>';

    // STYLY
    s.Add(styl);

    // KONEC HLAVICKY
    s.Add('<Worksheet ss:Name="Sheet1">');
    s.Add('<Table ss:ExpandedColumnCount="'+IntToStr(pocet_poli)+'" ss:ExpandedRowCount="'+IntToStr(pocet_zaznamu+14)+'" x:FullColumns="1" x:FullRows="1">');

    // COLUMNS
    s.Add('<Column ss:Index="2" ss:AutoFitWidth="0" ss:Width="99"/>'+
          '<Column ss:AutoFitWidth="0" ss:Width="299.25"/>'+
          '<Column ss:AutoFitWidth="0" ss:Width="60"/>'+
          '<Column ss:AutoFitWidth="0" ss:Width="78.75"/>'+
          '<Column ss:AutoFitWidth="0" ss:Width="138"/>');

    // TELO
    Datum:=ExecSQL_old('SELECT GET_PARAM(''ZALOBY_DATUM_PREDANI'') FROM DUAL');
    s.Add('<Row><Cell></Cell><Cell></Cell><Cell><Data ss:Type="String">POŠTOVNÍ PODACÍ ARCH</Data></Cell><Cell></Cell><Cell></Cell><Cell ss:StyleID="s62"></Cell></Row>');
    s.Add('<Row><Cell></Cell></Row>');
    s.Add('<Row><Cell><Data ss:Type="String">Podavatel: Dopravní podnik Ostrava a.s., Poděbradova 494/2, 701 71  Ostrava</Data></Cell></Row>');
    S.Add('<Row><Cell><Data ss:Type="String">Odesílatel: Dopravní podnik Ostrava a.s., Poděbradova 494/2, 701 71  Ostrava</Data></Cell></Row>');
    S.Add('<Row><Cell></Cell><Cell></Cell><Cell><Data ss:Type="String">Placeno v hotovosti/ Placeno převodem/ Výplatní stroj * (* Nehodící se škrtněte )</Data></Cell><Cell></Cell><Cell></Cell><Cell></Cell><Cell></Cell></Row>');
    S.Add('<Row><Cell></Cell></Row>');

    // TELO - VYPIS DAT
    s.Add(data);

    // TELO
    s.Add('<Row>');
      s.Add('<Cell ss:StyleID="s63"><Data ss:Type="String">1) Vyplní odesílatel</Data></Cell>');
    s.Add('</Row>');
    s.Add('<Row>');
      s.Add('<Cell ss:StyleID="s63"><Data ss:Type="String">2) U Doporučených zásilek - standard, Doporučených zásilek, Doporučených zásilek do zahraničí, Doporučených slepeckých zásilek a</Data></Cell>');
    s.Add('</Row>');
    s.Add('<Row>');
      s.Add('<Cell ss:StyleID="s63"><Data ss:Type="String">Doporučených slepeckých zásilek do zahraničí se neuvádí a sloupec se proškrtne</Data></Cell>');
    s.Add('</Row>');
    s.Add('<Row><Cell></Cell></Row>');
    s.Add('<Row><Cell></Cell></Row>');
    s.Add('<Row><Cell></Cell></Row>');
    s.Add('<Row>');
      s.Add('<Cell><Data ss:Type="String">Česká pošta, s.p., IČ 47114983</Data></Cell>');
      s.Add('<Cell></Cell>');
      s.Add('<Cell></Cell>');
      s.Add('<Cell><Data ss:Type="String">Potvrzení pošty (otisk razítka APOST)</Data></Cell>');
      s.Add('<Cell></Cell>');
      s.Add('<Cell></Cell>');
      s.Add('<Cell></Cell>');
      s.Add('<Cell></Cell>');
      s.Add('<Cell></Cell>');
      s.Add('<Cell></Cell>');
    s.Add('</Row>');

    // PATICKA
    s.Add('</Table></Worksheet></Workbook>');

    sd.DefaultExt:='.xml';
    sd.Filter:='Soubory typu XML(*.xml)|*.xml';

    if sd.Execute then
      s.SaveToFile(sd.FileName);
    qt.Close;
    frmProcesQuery.Close;

    ShowMessage('Export skončil');

  finally
    qt.Free;
    sd.Free;
    s.Free;
    frmProcesQuery.Close;
  end;

  end;

end;

procedure export_prikazu(g:TDBGrid; tab: string);
var
  s: TStringList;
  sd : TSaveDialog;
  pocet_zaznamu,suma_castka,temp,castka,sekv_no,
  kod_banky_prikazce,ucet_prikazce,vs_prikazce,
  ss_prikazce,poznamka_prikazce,kod_banky_prijemce,
  ucet_prijemce,vs_prijemce,ss_prijemce,
  poznamka_prijemce,sql_dotaz,zprava,vs_soudu,
  cu_soudu,ucet,kod_banky: string;
  i : Integer;
  qt : TZQuery;
  table : TDataSet;
begin
  if not Assigned(frmTiskZalob) then
    Application.CreateForm(TfrmTiskZalob,frmTiskZalob);
  frmTiskZalob.FSelRows:=g.SelectedRows.Count;
  frmTiskZalob.ShowModal;
  if frmTiskZalob.ModalResult=mrOK then
  begin
    try

    if frmTiskZalob.rbOznacene.Checked then
    begin
      if g.SelectedRows.CurrentRowSelected then
      begin
        Table:=g.DataSource.Dataset;
        for i:=0 to g.SelectedRows.Count-1 do
        begin
          Table.Bookmark:=g.SelectedRows[i];
          if i=0 then
            temp:=Table.FieldByName('ID').AsString
          else
            temp:=temp+','+Table.FieldByName('ID').AsString;
        end;
      end;
    end;

    if not Assigned(frmProcesQuery) then
      Application.CreateForm(TfrmProcesQuery,frmProcesQuery);

    frmProcesQuery.ShowOnTop;
    frmProcesQuery.Repaint;
    qt:=TZQuery.Create(nil);
    sd:=TSaveDialog.Create(nil);
    s:=TStringList.Create;

    qt.Connection:=DM.OracleConnection;

    if frmTiskZalob.rbVse.Checked then
    begin
      sql_dotaz:='SELECT'+
                 '  VS_SOUDU,'+
                 '  CU_SOUDU '+
                 'FROM '+
                 '  '+tab+' '+
                 'WHERE '+
                 '  NVL(UZAMCENA,0)=0 '+
                 '  AND VS_SOUDU IS NOT NULL '+
                 '  AND CU_SOUDU IS NOT NULL '+
                 'ORDER BY '+
                 '  VAR_SYMB';
    end;
    if (frmTiskZalob.rbDatum.Checked) and (frmTiskZalob.edDatumImportu.Text<>'') then
    begin
      sql_dotaz:='SELECT'+
                 '  VS_SOUDU,'+
                 '  CU_SOUDU '+
                 'FROM '+
                 '  '+tab+' '+
                 'WHERE '+
                 '  NVL(UZAMCENA,0)=0 '+
                 '  AND VS_SOUDU IS NOT NULL '+
                 '  AND CU_SOUDU IS NOT NULL '+
                 '  AND DATUM_IMPORTU=TO_DATE('''+frmTiskZalob.edDatumImportu.Text+''') '+
                 'ORDER BY '+
                 '  VAR_SYMB';
    end;
    if frmTiskZalob.rbOznacene.Checked then
    begin
      sql_dotaz:='SELECT'+
                 '  VS_SOUDU,'+
                 '  CU_SOUDU '+
                 'FROM '+
                 '  '+tab+' '+
                 'WHERE '+
                 '  ID IN ('+temp+') '+
                 '  AND VS_SOUDU IS NOT NULL '+
                 '  AND CU_SOUDU IS NOT NULL '+
                 'ORDER BY '+
                 '  VAR_SYMB';
    end;

    // HLAVICKA
    s.Text:='HI         '+FormatDateTime('yymmdd', Date());

    // TELO
    castka:=ExecSQL_old('SELECT LPAD('''+FloatToStrF(StrToFloat(GET_PARAM('ZALOBY_CASTKA_PRIKAZU')),ffFixed,2,2)+''',15,''0'') FROM DUAL');
    zprava:='          '+
            '          '+
            '          '+
            '          '+
            '          '+
            '          '+
            '          '+
            '          '+
            '          '+
            '          '+
            '          '+
            '          '+
            '          '+
            '          ';
    kod_banky_prikazce:=copy(ExecSQL_old('SELECT KOD_BANKY FROM LICENCE'),1,4);
    ucet_prikazce:=ExecSQL_old('SELECT LPAD('''+copy(Replace(ExecSQL_old('SELECT UCET FROM LICENCE'),'-',''),1,16)+''',16,''0'') FROM DUAL');
    poznamka_prikazce:='          '+
                       '          '+
                       '          ';
    poznamka_prijemce:='          '+
                       '          '+
                       '          ';
    vs_prikazce:='0000000000';
    ss_prikazce:='0000000000';
    qt.SQL.Text:=sql_dotaz;
    qt.Open;
    pocet_zaznamu:=ExecSQL_old('SELECT LPAD('''+IntToStr(qt.RecordCount)+''',6,''0'') FROM DUAL');
    qt.First;
    while not qt.EOF do
    begin
      vs_soudu:=qt.FieldByName('VS_SOUDU').AsString;
      cu_soudu:=qt.FieldByName('CU_SOUDU').AsString;
      kod_banky_prijemce:=copy(cu_soudu,pos('/',cu_soudu)+1,4);
      ucet_prijemce:=ExecSQL_old('SELECT LPAD('''+copy(Replace(copy(cu_soudu,1,pos('/',cu_soudu)-1),'-',''),1,16)+''',16,''0'') FROM DUAL');
      vs_prijemce:=ExecSQL_old('SELECT LPAD('''+copy(vs_soudu,1,10)+''',10,''0'') FROM DUAL');
      ss_prijemce:='0000000000';
      sekv_no:=ExecSQL_old('SELECT LPAD('''+IntToStr(qt.RecNo)+''',5,''0'') FROM DUAL');
      s.Add('01'+
            sekv_no+
            FormatDateTime('yyyymmdd', Date())+
            FormatDateTime('yyyymmdd', Date())+
            'CZK'+
            castka+
            '0'+
            '000'+
            '0'+
            '0000000308'+
            zprava+
            '   '+
            kod_banky_prikazce+
            ucet_prikazce+
            vs_prikazce+
            ss_prikazce+
            poznamka_prikazce+
            '   '+
            kod_banky_prijemce+
            ucet_prijemce+
            vs_prijemce+
            ss_prijemce+
            poznamka_prijemce+
            ' '+
            ' '+
            '       '+#13+#10
            );
      qt.Next;
    end;

    // PATICKA
    //ShowMessage(FloatToStrF(StrToFloat(castka)*qt.RecordCount,ffFixed,2,2));
    suma_castka:=ExecSQL_old('SELECT LPAD('''+FloatToStrF(StrToFloat(castka)*qt.RecordCount,ffFixed,2,2)+''',18,''0'') FROM DUAL');
    s.Add('TI         '+FormatDateTime('yymmdd', Date())+pocet_zaznamu+suma_castka);
    s.Add('00000');

    sd.DefaultExt:='.txt';
    sd.Filter:='Soubory typu TXT(*.txt)|*.txt';

    if sd.Execute then
      s.SaveToFile(sd.FileName);
    qt.Close;
    frmProcesQuery.Close;

  finally
    qt.Free;
    sd.Free;
    s.Free;
    frmProcesQuery.Close;
  end;

end;

end;

procedure export_prikazu_KB_KM(g:TDBGrid; tab: string);
var
  s: TStringList;
  sd : TSaveDialog;
  pocet_zaznamu,suma_castka,temp,castka,sekv_no,
  kod_banky_prikazce,ucet_prikazce,vs_prikazce,
  ss_prikazce,poznamka_prikazce,kod_banky_prijemce,
  ucet_prijemce,vs_prijemce,ss_prijemce,
  poznamka_prijemce,sql_dotaz,zprava,vs_soudu,
  cu_soudu,ucet,kod_banky,davka: string;
  i,k : Integer;
  qt : TZQuery;
  table : TDataSet;
begin
  if not Assigned(frmTiskZalob) then
    Application.CreateForm(TfrmTiskZalob,frmTiskZalob);
  frmTiskZalob.FSelRows:=g.SelectedRows.Count;
  frmTiskZalob.ShowModal;
  k:=1;
  if frmTiskZalob.rbOznacene.Checked and (frmTiskZalob.rbOznacene.Enabled=false) then
  begin
    k:=0;
    MessageDlg('Nejsou označeny žádné záznamy pro export',mtError,[mbOK],0);
  end;

  if (frmTiskZalob.ModalResult=mrOK) and (k=1) then
  begin
    try

    if frmTiskZalob.rbOznacene.Checked then
    begin
      if g.SelectedRows.CurrentRowSelected then
      begin
        Table:=g.DataSource.Dataset;
        for i:=0 to g.SelectedRows.Count-1 do
        begin
          Table.Bookmark:=g.SelectedRows[i];
          if i=0 then
            temp:=Table.FieldByName('ID').AsString
          else
            temp:=temp+','+Table.FieldByName('ID').AsString;
        end;
      end;
    end;

    if not Assigned(frmProcesQuery) then
      Application.CreateForm(TfrmProcesQuery,frmProcesQuery);

    frmProcesQuery.ShowOnTop;
    frmProcesQuery.Repaint;
    qt:=TZQuery.Create(nil);
    sd:=TSaveDialog.Create(nil);
    s:=TStringList.Create;

    qt.Connection:=DM.OracleConnection;

    sql_dotaz:='SELECT'+
                 '  NULL AS ID,'+
                 '  NULL AS VAR_SYMB,'+
                 '  NULL AS REF_KOD,'+
                 '  NULL AS VS_SOUDU,'+
                 '  NULL AS CU_SOUDU '+
                 'FROM '+
                 '  DUAL';

    if frmTiskZalob.rbVse.Checked then
    begin
      sql_dotaz:='SELECT'+
                 '  ID,'+
                 '  VAR_SYMB,'+
                 '  REF_KOD,'+
                 '  VS_SOUDU,'+
                 '  CU_SOUDU '+
                 'FROM '+
                 '  '+tab+' '+
                 'WHERE '+
                 '  NVL(UZAMCENA,0)=0 '+
                 '  AND VS_SOUDU IS NOT NULL '+
                 '  AND CU_SOUDU IS NOT NULL '+
                 'ORDER BY '+
                 '  VAR_SYMB';
    end;
    if (frmTiskZalob.rbDatum.Checked) and (frmTiskZalob.edDatumImportu.Text<>'') then
    begin
      sql_dotaz:='SELECT'+
                 '  ID,'+
                 '  VAR_SYMB,'+
                 '  REF_KOD,'+
                 '  VS_SOUDU,'+
                 '  CU_SOUDU '+
                 'FROM '+
                 '  '+tab+' '+
                 'WHERE '+
                 '  NVL(UZAMCENA,0)=0 '+
                 '  AND VS_SOUDU IS NOT NULL '+
                 '  AND CU_SOUDU IS NOT NULL '+
                 '  AND DATUM_IMPORTU=TO_DATE('''+frmTiskZalob.edDatumImportu.Text+''') '+
                 'ORDER BY '+
                 '  VAR_SYMB';
    end;
    if frmTiskZalob.rbOznacene.Checked and frmTiskZalob.rbOznacene.Enabled then
    begin
      sql_dotaz:='SELECT'+
                 '  ID,'+
                 '  VAR_SYMB,'+
                 '  REF_KOD,'+
                 '  VS_SOUDU,'+
                 '  CU_SOUDU '+
                 'FROM '+
                 '  '+tab+' '+
                 'WHERE '+
                 '  ID IN ('+temp+') '+
                 '  AND VS_SOUDU IS NOT NULL '+
                 '  AND CU_SOUDU IS NOT NULL '+
                 'ORDER BY '+
                 '  VAR_SYMB';
    end;

    // HLAVICKA
    s.Text:='UHL1'+FormatDateTime('ddmmyy', Date())+'                    '+'0000000000'+'000'+'999';
    try
      ExecSQL('UPDATE NASTAVENI_SYSTEMU SET BANKA_CISLO_DAVKY=NVL(BANKA_CISLO_DAVKY,0)+1 WHERE TO_CHAR(BANKA_DATUM_DAVKY,''DD.MM.YYYY'')=TO_CHAR(SYSDATE,''DD.MM.YYYY'')');
      //ExecSQL('COMMIT');
      ExecSQL('UPDATE NASTAVENI_SYSTEMU SET BANKA_DATUM_DAVKY=SYSDATE,BANKA_CISLO_DAVKY=1 WHERE TO_CHAR(BANKA_DATUM_DAVKY,''DD.MM.YYYY'')<>TO_CHAR(SYSDATE,''DD.MM.YYYY'') OR BANKA_DATUM_DAVKY IS NULL');
      davka:=ExecSQL_old('SELECT LPAD(TO_CHAR(NVL(BANKA_CISLO_DAVKY,1)),3,''0'') FROM NASTAVENI_SYSTEMU');
    except
      davka:='001';
    end;
    if length(davka)=0 then davka:='001';
    s.Add('1 1501 '+davka+'001'+' 0100');

    // TELO
    qt.SQL.Text:=sql_dotaz;
    qt.Open;
    qt.First;
    ucet_prikazce:=ExecSQL_old('SELECT UCET FROM LICENCE');
    castka:=Replace(FloatToStrF(StrToFloat(GET_PARAM('ZALOBY_CASTKA_PRIKAZU')),ffFixed,2,2),',','');
    suma_castka:=Replace(FloatToStrF(StrToFloat(GET_PARAM('ZALOBY_CASTKA_PRIKAZU'))*qt.RecordCount,ffFixed,2,2),',','');

    // HLAVICKA2
    s.Add('2'+' '+''+' '+suma_castka+' '+FormatDateTime('ddmmyy', Date()));
    while not qt.EOF do
    begin
      cu_soudu:=qt.FieldByName('CU_SOUDU').AsString;
      if pos('/',cu_soudu)=0 then
      begin
        MessageDlg('U GUIDU: '+qt.FieldByName('REF_KOD').AsString+' VS: '+qt.FieldByName('VAR_SYMB').AsString+' nebyl rozpoznán kód banky. Export byl přerušen.',mtError,[mbOK],0);
        exit;
      end;
      ucet_prijemce:=copy(copy(cu_soudu,1,pos('/',cu_soudu)-1),1,17);
      kod_banky_prijemce:=copy(cu_soudu,pos('/',cu_soudu)+1,4);
      vs_soudu:=qt.FieldByName('VS_SOUDU').AsString;
      s.Add(ucet_prikazce+' '+ucet_prijemce+' '+castka+' '+vs_soudu+' '+'00'+kod_banky_prijemce+'0000'+' '+'0'+' '+'AV:');
      qt.Next;
    end;
    s.Add('3 +');

    // PATICKA
    s.Add('5 +');

    sd.DefaultExt:='.txt';
    sd.Filter:='Soubory typu TXT(*.txt)|*.txt';

    if qt.RecordCount>0 then
    begin
      if sd.Execute then
      begin
        s.SaveToFile(sd.FileName);
        try
        //ShowMessage('UPDATE '+tab+' SET UHR_SOP=SYSDATE WHERE ID IN ('+sql_dotaz+') AND UHR_SOP IS NULL');
          ExecSQL('UPDATE '+tab+' SET UHR_SOP=SYSDATE WHERE ID IN (SELECT ID FROM ('+sql_dotaz+')) AND UHR_SOP IS NULL');
        except
        end;
      end;
    end
    else
      MessageDlg('Pro export platebního příkazu nebyl nalezen žádný záznam s údaji pro platbu',mtError,[mbOK],0);
    qt.Close;
    frmProcesQuery.Close;

  finally
    qt.Free;
    sd.Free;
    s.Free;
    frmProcesQuery.Close;
  end;
end;

end;

procedure prubeh_davky(g:TDBGrid; tab: string);
var
  s: TStringList;
  sd : TSaveDialog;
  h,telo,t,sql_dotaz,styl,Datum,celkem_jizdne,
  celkem_prirazka,celkem_zaznamu,celkem,temp,
  sql_dotaz2,data,pocet: string;
  row_count,col_count,pocet_poli,pocet_zaznamu,i : Integer;
  qt : TZQuery;
  table : TDataSet;
  w: WideString;
begin
  if not Assigned(frmTiskZalob) then
    Application.CreateForm(TfrmTiskZalob,frmTiskZalob);
  frmTiskZalob.FSelRows:=g.SelectedRows.Count;
  frmTiskZalob.ShowModal;
  if frmTiskZalob.ModalResult=mrOK then
  begin
    try

    if frmTiskZalob.rbOznacene.Checked then
    begin
      if g.SelectedRows.CurrentRowSelected then
      begin
        Table:=g.DataSource.Dataset;
        for i:=0 to g.SelectedRows.Count-1 do
        begin
          Table.Bookmark:=g.SelectedRows[i];
          if i=0 then
            temp:=Table.FieldByName('ID').AsString
          else
            temp:=temp+','+Table.FieldByName('ID').AsString;
        end;
      end;
    end;

    if not Assigned(frmProcesQuery) then
      Application.CreateForm(TfrmProcesQuery,frmProcesQuery);
    frmProcesQuery.ShowOnTop;
    frmProcesQuery.Repaint;
    qt:=TZQuery.Create(nil);
    sd:=TSaveDialog.Create(nil);
    s:=TStringList.Create;
    pocet_poli:=1;
    pocet_zaznamu:=1;
    qt.Connection:=DM.OracleConnection;

    if frmTiskZalob.rbVse.Checked then
    begin
      sql_dotaz:='SELECT'+
                 '  (SELECT COUNT(*) FROM '+tab+' WHERE NVL(UZAMCENA,0)=0 AND ZEMREL IS NOT NULL) AS ZEMRELI,'+
                 '  (SELECT COUNT(*) FROM '+tab+' WHERE NVL(UZAMCENA,0)=0 AND ZAPLATIL_PRED_PODANIM IS NOT NULL) AS ZAPL_PRED_ZAL,'+
                 '  (SELECT COUNT(*) FROM '+tab+' WHERE NVL(UZAMCENA,0)=0 AND SPIS_ZNACKA IS NOT NULL) AS PODANE_ZALOBY,'+
                 '  (SELECT COUNT(*) FROM '+tab+' WHERE NVL(UZAMCENA,0)=0 AND UHR_SOP IS NOT NULL) AS UHR_SOP,'+
                 '  (SELECT COUNT(*) FROM '+tab+' WHERE NVL(UZAMCENA,0)=0 AND PL_PRIKAZ IS NOT NULL) AS VYDANE_EPR,'+
                 '  (SELECT COUNT(*) FROM '+tab+' WHERE NVL(UZAMCENA,0)=0 AND ODVOLANI IS NOT NULL) AS ZRUSENE_EPR,'+
                 '  (SELECT COUNT(*) FROM '+tab+' WHERE NVL(UZAMCENA,0)=0 AND ROZSUDEK IS NOT NULL) AS VYDANE_ROZSUDKY,'+
                 '  (SELECT COUNT(*) FROM '+tab+' WHERE NVL(UZAMCENA,0)=0 AND DATUM_UHRADY IS NOT NULL) AS ZAPL_V_NALEZ_RIZ,'+
                 '  (SELECT COUNT(*) FROM '+tab+' WHERE NVL(UZAMCENA,0)=0 AND NAVRH IS NOT NULL) AS NAVRH_NA_EXEKUCI,'+
                 '  (SELECT COUNT(*) FROM '+tab+' WHERE NVL(UZAMCENA,0)=0 AND PRIKAZ IS NOT NULL) AS EXEKUCNI_PRIKAZ,'+
                 '  (SELECT COUNT(*) FROM '+tab+' WHERE NVL(UZAMCENA,0)=0 AND SKONCENO IS NOT NULL) AS ZAPL_V_EXEKUCI, '+
                 '  (SELECT COUNT(*) FROM '+tab+' WHERE NVL(UZAMCENA,0)=0) AS POCET, '+
                 '  (SELECT SUM(NVL(ZAPLATIL_CASTKA,0)) FROM '+tab+' WHERE NVL(UZAMCENA,0)=0) AS ZAPLATIL, ' +
                 '  (SELECT SUM(NVL(NAROK,0)) FROM '+tab+' WHERE NVL(UZAMCENA,0)=0) AS NAROK, ' +
                 '  NVL((SELECT SUM(NVL(NAROK,0)) FROM '+tab+' WHERE NVL(UZAMCENA,0)=0),0) - NVL((SELECT SUM(NVL(ZAPLATIL_CASTKA,0)) FROM '+tab+' WHERE NVL(UZAMCENA,0)=0),0) AS ZBYVA_ZAPLATIT '+
                 'FROM '+
                 '  DUAL';
    end;
    if (frmTiskZalob.rbDatum.Checked) and (frmTiskZalob.edDatumImportu.Text<>'') then
    begin
      sql_dotaz:='SELECT'+
                 '  (SELECT COUNT(*) FROM '+tab+' WHERE NVL(UZAMCENA,0)=0 AND ZEMREL IS NOT NULL AND DATUM_IMPORTU=TO_DATE('''+frmTiskZalob.edDatumImportu.Text+''')) AS ZEMRELI,'+
                 '  (SELECT COUNT(*) FROM '+tab+' WHERE NVL(UZAMCENA,0)=0 AND ZAPLATIL_PRED_PODANIM IS NOT NULL AND DATUM_IMPORTU=TO_DATE('''+frmTiskZalob.edDatumImportu.Text+''')) AS ZAPL_PRED_ZAL,'+
                 '  (SELECT COUNT(*) FROM '+tab+' WHERE NVL(UZAMCENA,0)=0 AND SPIS_ZNACKA IS NOT NULL AND DATUM_IMPORTU=TO_DATE('''+frmTiskZalob.edDatumImportu.Text+''')) AS PODANE_ZALOBY,'+
                 '  (SELECT COUNT(*) FROM '+tab+' WHERE NVL(UZAMCENA,0)=0 AND UHR_SOP IS NOT NULL AND DATUM_IMPORTU=TO_DATE('''+frmTiskZalob.edDatumImportu.Text+''')) AS UHR_SOP,'+
                 '  (SELECT COUNT(*) FROM '+tab+' WHERE NVL(UZAMCENA,0)=0 AND PL_PRIKAZ IS NOT NULL AND DATUM_IMPORTU=TO_DATE('''+frmTiskZalob.edDatumImportu.Text+''')) AS VYDANE_EPR,'+
                 '  (SELECT COUNT(*) FROM '+tab+' WHERE NVL(UZAMCENA,0)=0 AND ODVOLANI IS NOT NULL AND DATUM_IMPORTU=TO_DATE('''+frmTiskZalob.edDatumImportu.Text+''')) AS ZRUSENE_EPR,'+
                 '  (SELECT COUNT(*) FROM '+tab+' WHERE NVL(UZAMCENA,0)=0 AND ROZSUDEK IS NOT NULL AND DATUM_IMPORTU=TO_DATE('''+frmTiskZalob.edDatumImportu.Text+''')) AS VYDANE_ROZSUDKY,'+
                 '  (SELECT COUNT(*) FROM '+tab+' WHERE NVL(UZAMCENA,0)=0 AND DATUM_UHRADY IS NOT NULL AND DATUM_IMPORTU=TO_DATE('''+frmTiskZalob.edDatumImportu.Text+''')) AS ZAPL_V_NALEZ_RIZ,'+
                 '  (SELECT COUNT(*) FROM '+tab+' WHERE NVL(UZAMCENA,0)=0 AND NAVRH IS NOT NULL AND DATUM_IMPORTU=TO_DATE('''+frmTiskZalob.edDatumImportu.Text+''')) AS NAVRH_NA_EXEKUCI,'+
                 '  (SELECT COUNT(*) FROM '+tab+' WHERE NVL(UZAMCENA,0)=0 AND PRIKAZ IS NOT NULL AND DATUM_IMPORTU=TO_DATE('''+frmTiskZalob.edDatumImportu.Text+''')) AS EXEKUCNI_PRIKAZ,'+
                 '  (SELECT COUNT(*) FROM '+tab+' WHERE NVL(UZAMCENA,0)=0 AND SKONCENO IS NOT NULL AND DATUM_IMPORTU=TO_DATE('''+frmTiskZalob.edDatumImportu.Text+''')) AS ZAPL_V_EXEKUCI, '+
                 '  (SELECT COUNT(*) FROM '+tab+' WHERE DATUM_IMPORTU=TO_DATE('''+frmTiskZalob.edDatumImportu.Text+''')) AS POCET, '+
                 '  (SELECT SUM(NVL(ZAPLATIL_CASTKA,0)) FROM '+tab+' WHERE NVL(UZAMCENA,0)=0 AND DATUM_IMPORTU=TO_DATE('''+frmTiskZalob.edDatumImportu.Text+''')) AS ZAPLATIL, ' +
                 '  (SELECT SUM(NVL(NAROK,0)) FROM '+tab+' WHERE NVL(UZAMCENA,0)=0 AND DATUM_IMPORTU=TO_DATE('''+frmTiskZalob.edDatumImportu.Text+''')) AS NAROK, ' +
                 '  NVL((SELECT SUM(NVL(NAROK,0)) FROM '+tab+' WHERE NVL(UZAMCENA,0)=0 AND DATUM_IMPORTU=TO_DATE('''+frmTiskZalob.edDatumImportu.Text+''')),0) - NVL((SELECT SUM(NVL(ZAPLATIL_CASTKA,0)) FROM '+tab+' WHERE NVL(UZAMCENA,0)=0 AND DATUM_IMPORTU=TO_DATE('''+frmTiskZalob.edDatumImportu.Text+''')),0) AS ZBYVA_ZAPLATIT '+
                 'FROM '+
                 '  DUAL';
    end;
    if frmTiskZalob.rbOznacene.Checked then
    begin
      sql_dotaz:='SELECT'+
                 '  (SELECT COUNT(*) FROM '+tab+' WHERE NVL(UZAMCENA,0)=0 AND ZEMREL IS NOT NULL AND ID IN ('+temp+')) AS ZEMRELI,'+
                 '  (SELECT COUNT(*) FROM '+tab+' WHERE NVL(UZAMCENA,0)=0 AND ZAPLATIL_PRED_PODANIM IS NOT NULL AND ID IN ('+temp+')) AS ZAPL_PRED_ZAL,'+
                 '  (SELECT COUNT(*) FROM '+tab+' WHERE NVL(UZAMCENA,0)=0 AND SPIS_ZNACKA IS NOT NULL AND ID IN ('+temp+')) AS PODANE_ZALOBY,'+
                 '  (SELECT COUNT(*) FROM '+tab+' WHERE NVL(UZAMCENA,0)=0 AND UHR_SOP IS NOT NULL AND ID IN ('+temp+')) AS UHR_SOP,'+
                 '  (SELECT COUNT(*) FROM '+tab+' WHERE NVL(UZAMCENA,0)=0 AND PL_PRIKAZ IS NOT NULL AND ID IN ('+temp+')) AS VYDANE_EPR,'+
                 '  (SELECT COUNT(*) FROM '+tab+' WHERE NVL(UZAMCENA,0)=0 AND ODVOLANI IS NOT NULL AND ID IN ('+temp+')) AS ZRUSENE_EPR,'+
                 '  (SELECT COUNT(*) FROM '+tab+' WHERE NVL(UZAMCENA,0)=0 AND ROZSUDEK IS NOT NULL AND ID IN ('+temp+')) AS VYDANE_ROZSUDKY,'+
                 '  (SELECT COUNT(*) FROM '+tab+' WHERE NVL(UZAMCENA,0)=0 AND DATUM_UHRADY IS NOT NULL AND ID IN ('+temp+')) AS ZAPL_V_NALEZ_RIZ,'+
                 '  (SELECT COUNT(*) FROM '+tab+' WHERE NVL(UZAMCENA,0)=0 AND NAVRH IS NOT NULL AND ID IN ('+temp+')) AS NAVRH_NA_EXEKUCI,'+
                 '  (SELECT COUNT(*) FROM '+tab+' WHERE NVL(UZAMCENA,0)=0 AND PRIKAZ IS NOT NULL AND ID IN ('+temp+')) AS EXEKUCNI_PRIKAZ,'+
                 '  (SELECT COUNT(*) FROM '+tab+' WHERE NVL(UZAMCENA,0)=0 AND SKONCENO IS NOT NULL AND ID IN ('+temp+')) AS ZAPL_V_EXEKUCI, '+
                 '  (SELECT COUNT(*) FROM '+tab+' WHERE ID IN ('+temp+')) AS POCET, '+
                 '  (SELECT SUM(NVL(ZAPLATIL_CASTKA,0)) FROM '+tab+' WHERE NVL(UZAMCENA,0)=0 AND ID IN ('+temp+')) AS ZAPLATIL, ' +
                 '  (SELECT SUM(NVL(NAROK,0)) FROM '+tab+' WHERE NVL(UZAMCENA,0)=0 AND ID IN ('+temp+')) AS NAROK, ' +
                 '  NVL((SELECT SUM(NVL(NAROK,0)) FROM '+tab+' WHERE NVL(UZAMCENA,0)=0 AND ID IN ('+temp+')),0) - NVL((SELECT SUM(NVL(ZAPLATIL_CASTKA,0)) FROM '+tab+' WHERE NVL(UZAMCENA,0)=0 AND ID IN ('+temp+')),0) AS ZBYVA_ZAPLATIT '+
                 'FROM '+
                 '  DUAL';
    end;
    //ShowMessage(sql_dotaz);
    qt.SQL.Text:=sql_dotaz;
    qt.Open;
    pocet_poli:=13;//qt.Fields.Count;
    pocet_zaznamu:=qt.RecordCount;
    pocet:=qt.FieldByName('POCET').AsString;
    qt.First;
    while not (qt.EOF=true) do
    begin
      if length(data)=0 then
      begin
        data:=data+'<Row>';
          data:=data+'<Cell ss:StyleID="s67"><Data ss:Type="String">Zemřeli</Data></Cell>';
          data:=data+'<Cell ss:StyleID="s64"><Data ss:Type="Number">'+qt.FieldByName('ZEMRELI').AsString+'</Data></Cell>';
        data:=data+'</Row>';
        data:=data+'<Row>';
          data:=data+'<Cell ss:StyleID="s67"><Data ss:Type="String">Zapl. před žal</Data></Cell>';
          data:=data+'<Cell ss:StyleID="s64"><Data ss:Type="Number">'+qt.FieldByName('ZAPL_PRED_ZAL').AsString+'</Data></Cell>';
        data:=data+'</Row>';
        data:=data+'<Row>';
          data:=data+'<Cell ss:StyleID="s67"><Data ss:Type="String">Podané žaloby</Data></Cell>';
          data:=data+'<Cell ss:StyleID="s64"><Data ss:Type="Number">'+qt.FieldByName('PODANE_ZALOBY').AsString+'</Data></Cell>';
        data:=data+'</Row>';
        data:=data+'<Row>';
          data:=data+'<Cell ss:StyleID="s67"><Data ss:Type="String">Úhr. SOP</Data></Cell>';
          data:=data+'<Cell ss:StyleID="s64"><Data ss:Type="Number">'+qt.FieldByName('UHR_SOP').AsString+'</Data></Cell>';
        data:=data+'</Row>';
        data:=data+'<Row>';
          data:=data+'<Cell ss:StyleID="s67"><Data ss:Type="String">Vydané EPR</Data></Cell>';
          data:=data+'<Cell ss:StyleID="s64"><Data ss:Type="Number">'+qt.FieldByName('VYDANE_EPR').AsString+'</Data></Cell>';
        data:=data+'</Row>';
        data:=data+'<Row>';
          data:=data+'<Cell ss:StyleID="s67"><Data ss:Type="String">Zrušen EPR</Data></Cell>';
          data:=data+'<Cell ss:StyleID="s64"><Data ss:Type="Number">'+qt.FieldByName('ZRUSENE_EPR').AsString+'</Data></Cell>';
        data:=data+'</Row>';
        data:=data+'<Row>';
          data:=data+'<Cell ss:StyleID="s67"><Data ss:Type="String">Vydané rozsudky</Data></Cell>';
          data:=data+'<Cell ss:StyleID="s64"><Data ss:Type="Number">'+qt.FieldByName('VYDANE_ROZSUDKY').AsString+'</Data></Cell>';
        data:=data+'</Row>';
        data:=data+'<Row>';
          data:=data+'<Cell ss:StyleID="s67"><Data ss:Type="String">Zapl. v naléz řízení</Data></Cell>';
          data:=data+'<Cell ss:StyleID="s64"><Data ss:Type="Number">'+qt.FieldByName('ZAPL_V_NALEZ_RIZ').AsString+'</Data></Cell>';
        data:=data+'</Row>';
        data:=data+'<Row>';
          data:=data+'<Cell ss:StyleID="s67"><Data ss:Type="String">Návrh na exekuci</Data></Cell>';
          data:=data+'<Cell ss:StyleID="s64"><Data ss:Type="Number">'+qt.FieldByName('NAVRH_NA_EXEKUCI').AsString+'</Data></Cell>';
        data:=data+'</Row>';
        data:=data+'<Row>';
          data:=data+'<Cell ss:StyleID="s67"><Data ss:Type="String">Exekuční příkaz</Data></Cell>';
          data:=data+'<Cell ss:StyleID="s64"><Data ss:Type="Number">'+qt.FieldByName('EXEKUCNI_PRIKAZ').AsString+'</Data></Cell>';
        data:=data+'</Row>';
        data:=data+'<Row>';
          data:=data+'<Cell ss:StyleID="s67"><Data ss:Type="String">Zapl. v exekuci</Data></Cell>';
          data:=data+'<Cell ss:StyleID="s64"><Data ss:Type="Number">'+qt.FieldByName('ZAPL_V_EXEKUCI').AsString+'</Data></Cell>';
        data:=data+'</Row>';
        data:=data+'<Row>';
          data:=data+'<Cell ss:StyleID="s67"><Data ss:Type="String">Nárok</Data></Cell>';
          data:=data+'<Cell ss:StyleID="s64"><Data ss:Type="Number">'+qt.FieldByName('NAROK').AsString+'</Data></Cell>';
        data:=data+'</Row>';
        data:=data+'<Row>';
          data:=data+'<Cell ss:StyleID="s67"><Data ss:Type="String">Zaplaceno</Data></Cell>';
          data:=data+'<Cell ss:StyleID="s64"><Data ss:Type="Number">'+qt.FieldByName('ZAPLATIL').AsString+'</Data></Cell>';
        data:=data+'</Row>';
        data:=data+'<Row>';
          data:=data+'<Cell ss:StyleID="s67"><Data ss:Type="String">Zbývá zaplatit</Data></Cell>';
          data:=data+'<Cell ss:StyleID="s64"><Data ss:Type="Number">'+qt.FieldByName('ZBYVA_ZAPLATIT').AsString+'</Data></Cell>';
        data:=data+'</Row>';
      end;
      {data:=data+'<Row>';
        data:=data+'<Cell ss:StyleID="s64"><Data ss:Type="Number">'+qt.FieldByName('A').AsString+'</Data></Cell>';
        data:=data+'<Cell ss:StyleID="s64"><Data ss:Type="Number">'+qt.FieldByName('PODANE_ZALOBY').AsString+'</Data></Cell>';
        data:=data+'<Cell ss:StyleID="s64"><Data ss:Type="Number">'+qt.FieldByName('UHR_SOP').AsString+'</Data></Cell>';
        data:=data+'<Cell ss:StyleID="s64"><Data ss:Type="Number">'+qt.FieldByName('VYDANE_EPR').AsString+'</Data></Cell>';
        data:=data+'<Cell ss:StyleID="s64"><Data ss:Type="Number">'+qt.FieldByName('VYDANE_ROZSUDKY').AsString+'</Data></Cell>';
        data:=data+'<Cell ss:StyleID="s64"><Data ss:Type="Number">'+qt.FieldByName('ZAPL_V_NALEZ_RIZ').AsString+'</Data></Cell>';
        data:=data+'<Cell ss:StyleID="s64"><Data ss:Type="Number">'+qt.FieldByName('NAVRH_NA_EXEKUCI').AsString+'</Data></Cell>';
        data:=data+'<Cell ss:StyleID="s64"><Data ss:Type="Number">'+qt.FieldByName('EXEKUCNI_PRIKAZ').AsString+'</Data></Cell>';
        data:=data+'<Cell ss:StyleID="s64"><Data ss:Type="Number">'+qt.FieldByName('ZAPL_V_EXEKUCI').AsString+'</Data></Cell>';
      data:=data+'</Row>';}
      qt.Next;
    end;
    qt.Close;

    // STYLY
    styl:= '<Styles>'+
           '  <Style ss:ID="s62">'+
           '    <Alignment ss:Horizontal="Center" ss:Vertical="Bottom"/>'+
           '    <Borders>'+
           '      <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="2"/>'+
           '    </Borders>'+
           '    <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="14" ss:Bold="1"/>'+
           //'  <Interior ss:Color="#FFFF00" ss:Pattern="Solid"/>'+
           '  </Style>'+
           '    <Style ss:ID="s63">'+
           '    <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="14" ss:Bold="0"/>'+
           '    <Alignment ss:Horizontal="Right" ss:Vertical="Bottom"/>'+
           '    <NumberFormat ss:Format="Standard"/>'+
           //'  <Interior ss:Color="#FFFF00" ss:Pattern="Solid"/>'+
           '  </Style>'+
           '  <Style ss:ID="s64">'+
           '    <Alignment ss:Horizontal="Right" ss:Vertical="Bottom"/>'+
           '    <NumberFormat ss:Format="Standard"/>'+
           //'    <Borders>'+
           //'      <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>'+
           //'      <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>'+
           //'      <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>'+
           //'    </Borders>'+
           '  </Style>'+
           '  <Style ss:ID="s65">'+
           //'    <Borders>'+
           //'      <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>'+
           //'      <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>'+
           //'    </Borders>'+
           '  </Style>'+
           '  <Style ss:ID="s66">'+
           //'    <Borders>'+
           //'      <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>'+
           //'      <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>'+
           //'      <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>'+
           //'    </Borders>'+
           '  </Style>'+
           '  <Style ss:ID="s67">'+
           '    <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="11" ss:Bold="1"/>'+
           '    <Borders>'+
           '      <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>'+
           '      <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>'+
           '      <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>'+
           '      <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>'+
           '    </Borders>'+
           '  </Style>'+
           '  <Style ss:ID="s69">'+
           '    <Alignment ss:Horizontal="Right" ss:Vertical="Bottom"/>'+
           '    <Borders/>'+
           '    <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="14"/>'+
           '    <Interior/>'+
           '    <NumberFormat ss:Format="0"/>'+
           '    <Protection/>'+
           '  </Style>'+
           '</Styles>';

    // HLAVICKA
    s.Text:='<?xml version="1.0" encoding="ISOWIN1250"?>'+
            '<Workbook xmlns="urn:schemas-microsoft-com:office:spreadsheet" '+
            'xmlns:html="http://www.w3.org/TR/REC-html40" xmlns:o="urn:schemas-microsoft-com:office:office" '+
            'xmlns:ss="urn:schemas-microsoft-com:office:spreadsheet" xmlns:x="urn:schemas-microsoft-com:office:excel">'+
            '<DocumentProperties xmlns="urn:schemas-microsoft-com:office:office">'+
            '<Author xmlns="urn:schemas-microsoft-com:office:office">Author</Author>'+
            '<Company xmlns="urn:schemas-microsoft-com:office:office">Company</Company>'+
            '<Version xmlns="urn:schemas-microsoft-com:office:office">1</Version>'+
            '</DocumentProperties>'+
            '<OfficeDocumentSettings xmlns="urn:schemas-microsoft-com:office:office">'+
            '<DownloadComponents xmlns="urn:schemas-microsoft-com:office:office" />'+
            '<LocationOfComponents xmlns="urn:schemas-microsoft-com:office:office" HRef="file:///\\phlfsnt01\DOWNLOAD\OfficeXPSrc\" />'+
            '</OfficeDocumentSettings>'+
            '<ExcelWorkbook xmlns="urn:schemas-microsoft-com:office:excel">'+
            '<ProtectStructure xmlns="urn:schemas-microsoft-com:office:excel">False</ProtectStructure>'+
            '<ProtectWindows xmlns="urn:schemas-microsoft-com:office:excel">False</ProtectWindows>'+
            '</ExcelWorkbook>';

    // STYLY
    s.Add(styl);

    // KONEC HLAVICKY
    s.Add('<Worksheet ss:Name="Sheet1">');
    s.Add('<Table ss:ExpandedColumnCount="'+IntToStr(pocet_poli)+'" ss:ExpandedRowCount="'+IntToStr(pocet_zaznamu+16)+'" x:FullColumns="1" x:FullRows="1">');

    // COLUMNS
    s.Add('<Column ss:AutoFitWidth="0" ss:Width="150"/>'+
          '<Column ss:AutoFitWidth="0" ss:Width="99"/>'+
          '<Column ss:AutoFitWidth="0" ss:Width="99"/>'+
          '<Column ss:AutoFitWidth="0" ss:Width="99"/>'+
          '<Column ss:AutoFitWidth="0" ss:Width="99"/>'+
          '<Column ss:AutoFitWidth="0" ss:Width="99"/>');
          //'<Column ss:AutoFitWidth="0" ss:Width="99"/>'+
          //'<Column ss:AutoFitWidth="0" ss:Width="99"/>'+
          //'<Column ss:AutoFitWidth="0" ss:Width="99"/>');

    // TELO
    Datum:=frmTiskZalob.edDatumImportu.Text;
    s.Add('<Row><Cell><Data ss:Type="String"></Data></Cell><Cell><Data ss:Type="String"></Data></Cell><Cell ss:StyleID="s62"><Data ss:Type="String">Průběh dávky</Data></Cell><Cell ss:StyleID="s69"><Data ss:Type="Number">'+pocet+'</Data></Cell><Cell><Data ss:Type="String"></Data></Cell><Cell><Data ss:Type="String"></Data></Cell></Row>');
    s.Add('<Row><Cell><Data ss:Type="String"></Data></Cell><Cell><Data ss:Type="String"></Data></Cell></Row>');
    s.Add('<Row><Cell><Data ss:Type="String">Popis</Data></Cell><Cell ss:StyleID="s64"><Data ss:Type="String">'+Datum+'</Data></Cell></Row>');

    // TELO - VYPIS DAT
    s.Add(data);

    // PATICKA
    s.Add('</Table></Worksheet></Workbook>');

    sd.DefaultExt:='.xml';
    sd.Filter:='Soubory typu XML(*.xml)|*.xml';

    if sd.Execute then
      s.SaveToFile(sd.FileName);
    qt.Close;
    frmProcesQuery.Close;

    ShowMessage('Export skončil');

  finally
    qt.Free;
    sd.Free;
    s.Free;
    frmProcesQuery.Close;
  end;

  end;

end;

procedure ExportSpis(g: TDBGrid; tab, aFile : String);
var
  s,tmps: TStringList;
  sd : TSaveDialog;
  h,telo,t,sql_dotaz,styl,Datum,celkem_jizdne,
  celkem_prirazka,celkem_zaznamu,celkem,temp,
  sql_dotaz2,data,pocet: string;
  row_count,col_count,pocet_poli,pocet_zaznamu,i : Integer;
  qt : TZQuery;
  table : TDataSet;
  w: WideString;
  FileContents: TStringStream;
begin
  if not Assigned(frmTiskZalob) then
    Application.CreateForm(TfrmTiskZalob,frmTiskZalob);
  frmTiskZalob.FSelRows:=g.SelectedRows.Count;
  frmTiskZalob.ShowModal;
  if frmTiskZalob.ModalResult=mrOK then
  begin
    try

    if frmTiskZalob.rbOznacene.Checked then
    begin
      if g.SelectedRows.CurrentRowSelected then
      begin
        Table:=g.DataSource.Dataset;
        for i:=0 to g.SelectedRows.Count-1 do
        begin
          Table.Bookmark:=g.SelectedRows[i];
          if i=0 then
            temp:=Table.FieldByName('ID').AsString
          else
            temp:=temp+','+Table.FieldByName('ID').AsString;
        end;
      end;
    end;

    if not Assigned(frmProcesQuery) then
      Application.CreateForm(TfrmProcesQuery,frmProcesQuery);
    frmProcesQuery.ShowOnTop;
    frmProcesQuery.Repaint;
    qt:=TZQuery.Create(nil);
    sd:=TSaveDialog.Create(nil);
    s:=TStringList.Create;
    tmps:=TStringList.Create;
    tmps.Text := ' ';
    pocet_poli:=1;
    pocet_zaznamu:=1;
    qt.Connection:=DM.OracleConnection;

    if frmTiskZalob.rbVse.Checked then
    begin
      sql_dotaz:='SELECT'+
                 ' ID, JMENO_CP, CISLO, SOUD, SPIS_ZNACKA, TO_CHAR(PL_PRIKAZ,''DD.MM.YYYY'') AS PL_PRIKAZ, TO_CHAR(ROZSUDEK,''DD.MM.YYYY'') AS ROZSUDEK '+
                 'FROM '+
                 tab+' '+
                 'WHERE '+
                 '  NVL(UZAMCENA,0)=0 '+
                 '  AND ((ODVOLANI IS NULL AND ROZSUDEK IS NULL) OR (ROZSUDEK IS NOT NULL)) '+
                 '  AND SPIS_ZNACKA IS NOT NULL'+
                 '  AND (ROZSUDEK IS NOT NULL OR PL_PRIKAZ IS NOT NULL) '+
                 '  AND PR_MOC IS NULL '+
                 'ORDER BY '+
                 ' DATUM_IMPORTU DESC, CISLO';
    end;
    if (frmTiskZalob.rbDatum.Checked) and (frmTiskZalob.edDatumImportu.Text<>'') then
    begin
      sql_dotaz:='SELECT'+
                 ' ID, JMENO_CP, CISLO, SOUD, SPIS_ZNACKA, TO_CHAR(PL_PRIKAZ,''DD.MM.YYYY'') AS PL_PRIKAZ, TO_CHAR(ROZSUDEK,''DD.MM.YYYY'') AS ROZSUDEK '+
                 'FROM '+
                 tab+' '+
                 'WHERE '+
                 '  NVL(UZAMCENA,0)=0 '+
                 '  AND ((ODVOLANI IS NULL AND ROZSUDEK IS NULL) OR (ROZSUDEK IS NOT NULL)) '+
                 '  AND SPIS_ZNACKA IS NOT NULL'+
                 '  AND (ROZSUDEK IS NOT NULL OR PL_PRIKAZ IS NOT NULL) '+
                 '  AND PR_MOC IS NULL '+
                 '  AND DATUM_IMPORTU=TO_DATE('''+frmTiskZalob.edDatumImportu.Text+''') '+
                 'ORDER BY '+
                 ' DATUM_IMPORTU DESC, CISLO';
    end;
    if frmTiskZalob.rbOznacene.Checked then
    begin
      sql_dotaz:='SELECT'+
                 ' ID, JMENO_CP, CISLO, SOUD, SPIS_ZNACKA, TO_CHAR(PL_PRIKAZ,''DD.MM.YYYY'') AS PL_PRIKAZ, TO_CHAR(ROZSUDEK,''DD.MM.YYYY'') AS ROZSUDEK '+
                 'FROM '+
                 tab+' '+
                 'WHERE '+
                 '  NVL(UZAMCENA,0)=0 '+
                 '  AND ((ODVOLANI IS NULL AND ROZSUDEK IS NULL) OR (ROZSUDEK IS NOT NULL)) '+
                 '  AND SPIS_ZNACKA IS NOT NULL'+
                 '  AND (ROZSUDEK IS NOT NULL OR PL_PRIKAZ IS NOT NULL) '+
                 '  AND PR_MOC IS NULL '+
                 '  AND ID IN ('+temp+') '+
                 'ORDER BY '+
                 ' DATUM_IMPORTU DESC, CISLO';
    end;

    data:='<Row>';
      data:=data+'<Cell><Data ss:Type="String">ID</Data></Cell>';
      data:=data+'<Cell><Data ss:Type="String">Číslo</Data></Cell>';
      data:=data+'<Cell><Data ss:Type="String">Jméno a příjmení</Data></Cell>';
      data:=data+'<Cell><Data ss:Type="String">Soud</Data></Cell>';
      data:=data+'<Cell><Data ss:Type="String">Spis. značka</Data></Cell>';
      data:=data+'<Cell><Data ss:Type="String">Pl. rozkaz</Data></Cell>';
      data:=data+'<Cell><Data ss:Type="String">Rozsudek</Data></Cell>';
      data:=data+'<Cell><Data ss:Type="String">Právní moc</Data></Cell>';
    data:=data+'</Row>';

    tmps.Text := data;
    data:='';

    qt.SQL.Text:=sql_dotaz;
    qt.Open;
    pocet_poli:=8;//qt.Fields.Count;
    pocet_zaznamu:=qt.RecordCount;
    //pocet:=qt.FieldByName('POCET').AsString;
    qt.First;
    while not (qt.EOF=true) do
    begin
      begin
        data:=data+'<Row>';
          data:=data+'<Cell><Data ss:Type="Number">'+qt.FieldByName('ID').AsString+'</Data></Cell>';
          data:=data+'<Cell><Data ss:Type="Number">'+qt.FieldByName('CISLO').AsString+'</Data></Cell>';
          data:=data+'<Cell><Data ss:Type="String">'+qt.FieldByName('JMENO_CP').AsString+'</Data></Cell>';
          data:=data+'<Cell><Data ss:Type="String">'+qt.FieldByName('SOUD').AsString+'</Data></Cell>';
          data:=data+'<Cell><Data ss:Type="String">'+qt.FieldByName('SPIS_ZNACKA').AsString+'</Data></Cell>';
          data:=data+'<Cell><Data ss:Type="String">'+qt.FieldByName('PL_PRIKAZ').AsString+'</Data></Cell>';
          data:=data+'<Cell><Data ss:Type="String">'+qt.FieldByName('ROZSUDEK').AsString+'</Data></Cell>';
          data:=data+'<Cell><Data ss:Type="String"></Data></Cell>';
        data:=data+'</Row>';
        tmps.Add(data);
        data:='';
      end;
      qt.Next;
    end;
    qt.Close;

    // STYLY
    styl:= '<Styles>'+
           '<Style ss:ID="Default" ss:Name="Normal">'+
           '<Alignment ss:Vertical="Bottom"/> '+
           '<Borders/>'+
           '<Font ss:FontName="Calibri" x:CharSet="238" x:Family="Swiss" ss:Size="11" ss:Color="#000000"/>'+
           '<Interior/>'+
           '<NumberFormat/> '+
           '<Protection/> '+
           '</Style>'+
           '<Style ss:ID="s62">'+
           '<Alignment ss:Horizontal="Center" ss:Vertical="Bottom"/>'+
           '<Borders>'+
           '<Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="2"/>'+
           '</Borders>'+
           '<Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="14" ss:Bold="1"/>'+
           //'  <Interior ss:Color="#FFFF00" ss:Pattern="Solid"/>'+
           '</Style>'+
           '<Style ss:ID="s63">'+
           '<Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="14" ss:Bold="0"/>'+
           '<Alignment ss:Horizontal="Right" ss:Vertical="Bottom"/>'+
           //'  <Interior ss:Color="#FFFF00" ss:Pattern="Solid"/>'+
           '</Style>'+
           '<Style ss:ID="s64">'+
           '<Alignment ss:Horizontal="Right" ss:Vertical="Bottom"/>'+
           //'    <Borders>'+
           //'      <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>'+
           //'      <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>'+
           //'      <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>'+
           //'    </Borders>'+
           '</Style>'+
           '<Style ss:ID="s65">'+
           //'    <Borders>'+
           //'      <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>'+
           //'      <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>'+
           //'    </Borders>'+
           '</Style>'+
           '<Style ss:ID="s66">'+
           //'    <Borders>'+
           //'      <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>'+
           //'      <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>'+
           //'      <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>'+
           //'    </Borders>'+
           '</Style>'+
           '<Style ss:ID="s67">'+
           '<Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="11" ss:Bold="1"/>'+
           '<Borders>'+
           '<Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>'+
           '<Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>'+
           '<Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>'+
           '<Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>'+
           '</Borders>'+
           '</Style>'+
           '</Styles>';

    // HLAVICKA
    s.Text:='<?xml version="1.0"?>'+          // encoding="ISOWIN1250"
            '<?mso-application progid="Excel.Sheet"?>'+
            '<Workbook xmlns="urn:schemas-microsoft-com:office:spreadsheet" '+
            'xmlns:html="http://www.w3.org/TR/REC-html40" xmlns:o="urn:schemas-microsoft-com:office:office" '+
            'xmlns:ss="urn:schemas-microsoft-com:office:spreadsheet" xmlns:x="urn:schemas-microsoft-com:office:excel">'+
            '<DocumentProperties xmlns="urn:schemas-microsoft-com:office:office">'+
            '<Author xmlns="urn:schemas-microsoft-com:office:office">Author</Author>'+
            '<Company xmlns="urn:schemas-microsoft-com:office:office">Company</Company>'+
            '<Version xmlns="urn:schemas-microsoft-com:office:office">1</Version>'+
            '</DocumentProperties>'+
            '<OfficeDocumentSettings xmlns="urn:schemas-microsoft-com:office:office">'+
            '<DownloadComponents xmlns="urn:schemas-microsoft-com:office:office" />'+
            '<LocationOfComponents xmlns="urn:schemas-microsoft-com:office:office" HRef="file:///\\phlfsnt01\DOWNLOAD\OfficeXPSrc\" />'+
            '</OfficeDocumentSettings>'+
            '<ExcelWorkbook xmlns="urn:schemas-microsoft-com:office:excel">'+
            '<ProtectStructure xmlns="urn:schemas-microsoft-com:office:excel">False</ProtectStructure>'+
            '<ProtectWindows xmlns="urn:schemas-microsoft-com:office:excel">False</ProtectWindows>'+
            '</ExcelWorkbook>';

    // STYLY
    s.Add(styl);

    // KONEC HLAVICKY
    s.Add('<Worksheet ss:Name="List1">');
    s.Add('<Table ss:ExpandedColumnCount="'+IntToStr(pocet_poli)+'" ss:ExpandedRowCount="'+IntToStr(pocet_zaznamu+1)+'" x:FullColumns="1" x:FullRows="1">');

    // COLUMNS
    s.Add('<Column ss:AutoFitWidth="0" ss:Width="50"/>'+
          '<Column ss:AutoFitWidth="0" ss:Width="50"/>'+
          '<Column ss:AutoFitWidth="0" ss:Width="150"/>'+
          '<Column ss:AutoFitWidth="0" ss:Width="200"/>'+
          '<Column ss:AutoFitWidth="0" ss:Width="150"/>'+
          '<Column ss:AutoFitWidth="0" ss:Width="50"/>'+
          '<Column ss:AutoFitWidth="0" ss:Width="50"/>'+
          '<Column ss:AutoFitWidth="0" ss:Width="50"/>');

    // TELO

    // TELO - VYPIS DAT
    //s.Add(data);
    s.Add(tmps.Text);

    // PATICKA
    s.Add('</Table></Worksheet></Workbook>');
    //s.Text:=bez_diakritiky(s.Text);

    sd.DefaultExt:='xml';
    sd.Filter:='Soubory typu XML(*.xml)|*.xml';

    //FileContents := TStringStream.Create('', TEncoding.UTF8);
    if sd.Execute then
      s.SaveToFile(sd.FileName);
    qt.Close;
    frmProcesQuery.Close;
    ShowMessage('Export skončil');

  finally
    qt.Free;
    sd.Free;
    s.Free;
    frmProcesQuery.Close;
  end;

  end;
end;

procedure ImportSpis(tab : String);
var
  od : TOpenDialog;
  s: TStringList;
  kontrola_oddelovacu,navesti,delimiter,tmp,radek,pravni_moc,id : string;
  i,a,p,pocet,c,ci: Integer;
begin
try
  od := TOpenDialog.Create(nil);
  od.Filter:='Soubory typu CSV (*.csv)|*.csv|Všechny soubory (*.*)|*.*';
  delimiter:=';';
  s:=TStringList.Create;
  pocet:=0;
  c:=0;
  ci:=0;
  kontrola_oddelovacu:=get_param('ZALOBY_IMPORT_KONTROLA_ODDELOVACU');
  if od.Execute then
  begin
    s.LoadFromFile(od.FileName);
    for a:=0 to s.count-1 do
      s[a]:=utf8encode(s[a]);
    navesti:='ID;Číslo;Jméno a příjmení;Soud;Spis. značka;Pl. rozkaz;Rozsudek;Právní moc';
    if UpperCase(navesti)<>UpperCase(s.Strings[0]) then
      MessageDlg('Importovaný soubor má jiné návěstí než se očekává,data nebudou importována. '+
                 'Informujte programátora.',mtError,[mbOK],0)
    else
    begin
      try
        if not Assigned(frmProces) then
          Application.CreateForm(TfrmProces,frmProces);
        frmProces.ShowOnTop;
        frmProces.lbProces.Caption:='Probíhá import žalob, čekejte...';
        frmProces.ProgressBar1.Step:=1;
        frmProces.ProgressBar1.Min:=1;
        frmProces.ProgressBar1.Max:=s.Count;
        frmProces.ProgressBar1.Position:=1;
        frmProces.ShowOnTop;
        for i:=1 to s.Count-1 do
        begin
          p:=0;
          frmProces.ProgressBar1.StepIt;
          frmProces.Repaint;
          frmProces.ShowOnTop;
          radek:=s.Strings[i];
          // -- 0
          tmp:=Copy(Radek,1,Pos(delimiter,radek)-1);
          id:=tmp;
          if Pos(delimiter,radek)>0 then p:=p+1;
          radek:=Copy(Radek,Pos(delimiter,radek)+1,length(radek)-Pos(delimiter,radek));
          //ShowMessage(radek);
          // -- 1
          if Pos(delimiter,radek)>0 then p:=p+1;
          radek:=Copy(Radek,Pos(delimiter,radek)+1,length(radek)-Pos(delimiter,radek));
          //ShowMessage(radek);
          // -- 2
          if Pos(delimiter,radek)>0 then p:=p+1;
          radek:=Copy(Radek,Pos(delimiter,radek)+1,length(radek)-Pos(delimiter,radek));
          //ShowMessage(radek);
          // -- 3
          if Pos(delimiter,radek)>0 then p:=p+1;
          radek:=Copy(Radek,Pos(delimiter,radek)+1,length(radek)-Pos(delimiter,radek));
          //ShowMessage(radek);
          // -- 4
          if Pos(delimiter,radek)>0 then p:=p+1;
          radek:=Copy(Radek,Pos(delimiter,radek)+1,length(radek)-Pos(delimiter,radek));
          //ShowMessage(radek);
          // -- 5
          if Pos(delimiter,radek)>0 then p:=p+1;
          radek:=Copy(Radek,Pos(delimiter,radek)+1,length(radek)-Pos(delimiter,radek));
          //ShowMessage(radek);
          // -- 6
          if Pos(delimiter,radek)>0 then p:=p+1;
          radek:=Copy(Radek,Pos(delimiter,radek)+1,length(radek)-Pos(delimiter,radek));
          //ShowMessage(radek);
          // -- 7
          tmp:=Copy(Radek,1,length(Radek));
          pravni_moc:=tmp;
          if (Pos(delimiter,pravni_moc)>0) and (kontrola_oddelovacu='1') then
          begin
            raise Exception.Create('Importní řádek obsahuje nesprávný počet oddělovačů, což způsobí chybný import dat. Informujte programátora: !');
          end;
          pocet := pocet + 1;
          try
            if length(pravni_moc) > 0 then
            begin
              //if (ExecSql_old('SELECT 1 FROM '+tab+' WHERE PR_MOC IS NULL AND ID = '+id) = '1') then
              ci:=ci+1;
              ExecSql('UPDATE '+tab+' SET PR_MOC = TO_DATE('''+ pravni_moc +''',''DD.MM.YYYY'') WHERE ID = '+id);  //PR_MOC IS NULL AND
            end;
          except
            c:=c+1;
          end;
          //ShowMessage(id + ' / ' + spis_znacka + 'UPDATE '+tab+' SET SPIS_ZNACKA = '''+ spis_znacka +''' WHERE SPIS_ZNACKA IS NULL AND ID = '+id);
        end;

        begin
          frmProces.ProgressBar1.StepIt;
          frmProces.Repaint;
          frmProces.ShowOnTop;
          frmProces.Close;
          MessageDlg('Import skončil! (Celkem k importu: '+IntToStr(pocet)+', chybné: ' + IntToStr(c) + ', naimportováno: '+IntToStr(ci)+')',mtInformation,[mbOK],0);
        end;

      except
        on E : Exception do
        begin
          MessageDlg('Import skončil chybou: '+E.Message+'!',mtError,[mbOK],0);
          frmProces.Close;
        end;
      end;

    end;
  end;

finally
  s.Free;
  od.Free;
end;
end;

function Get_text_part(_part : TMimePart) : TStringList;
var
  subtelo, telo : TStringList;
  PART : TMimePart;
  str : TStringList;
  s : Integer;
begin
  PART:=TMimePart.Create;
  telo:=TStringList.Create;
  subtelo:=TStringList.Create;
  for s:=0 to _part.GetSubPartCount-1 do
  begin
    //ShowMessage('STOP');
    PART:=_part.GetSubPart(s);
    // HTML
    if (UpperCase(PART.Primary)='TEXT')and (UpperCase(PART.Secondary)='HTML') then
      PART.ForcedHTMLConvert:=true;
    PART.DecodePart;
    subtelo.Clear;
    subtelo.LoadFromStream(PART.DecodedLines);
    {if (pos('evidenčním číslem:',UTF8Encode(subtelo.Text))>0) or
       (pos('eviden?n?m ??slem:',UTF8Encode(subtelo.Text))>0) or
       (pos('eviden?ním ?íslem:',UTF8Encode(subtelo.Text))>0) then
    begin
      telo.Add(UTF2WIN(subtelo.Text));
      //telo.Add(subtelo.Text);
    end;}
    PART.ForcedHTMLConvert:=false;
    if PART.GetSubPartCount>0 then
      subtelo.Add(Get_text_part(PART).Text);
    telo.Add(subtelo.Text);
    //ShowMessage(telo.Text);
  end;
  //ShowMessage(telo.Text);
  result := telo;
end;

procedure initComboExekutor(cb : TDBComboBox);
var
  qrExekutori : TZQuery;
begin
  try
    cb.Items.Clear;
    qrExekutori := TZQuery.Create(nil);
    qrExekutori.Connection := DM.OracleConnection;
    qrExekutori.SQL.Text:='SELECT * FROM EXEKUTORI ORDER BY KOD';
    qrExekutori.Open;
    qrExekutori.First;
    cb.Items.Add('');
    while not qrExekutori.EOF do
    begin
      cb.Items.Add(qrExekutori.FieldByName('KOD').AsString);
      qrExekutori.Next;
    end;
  finally
    qrExekutori.Close;
    qrExekutori.Free;
  end;
end;

procedure exportZalob(g: TDBGrid; tab: string);
var
  s: TStringList;
  sd : TSaveDialog;
  sql_dotaz,navesti,radek,temp: string;
  qt : TZQuery;
  Table : TDataSet;
  i : Integer;
  w: WideString;
begin
  if not Assigned(frmTiskZalob) then
    Application.CreateForm(TfrmTiskZalob,frmTiskZalob);
  frmTiskZalob.FSelRows:=g.SelectedRows.Count;
  frmTiskZalob.ShowModal;
  if frmTiskZalob.ModalResult=mrOK then
  begin
    try

    if frmTiskZalob.rbOznacene.Checked then
    begin
      if g.SelectedRows.CurrentRowSelected then
      begin
        Table:=g.DataSource.Dataset;
        for i:=0 to g.SelectedRows.Count-1 do
        begin
          Table.Bookmark:=g.SelectedRows[i];
          if i=0 then
            temp:=Table.FieldByName('ID').AsString
          else
            temp:=temp+','+Table.FieldByName('ID').AsString;
        end;
      end;
    end;

    if not Assigned(frmProcesQuery) then
      Application.CreateForm(TfrmProcesQuery,frmProcesQuery);
    frmProcesQuery.ShowOnTop;
    frmProcesQuery.Repaint;
    qt:=TZQuery.Create(nil);
    qt.Connection:=DM.OracleConnection;
    sd:=TSaveDialog.Create(nil);
    sd.DefaultExt:='csv';
    s:=TStringList.Create;

    if frmTiskZalob.rbVse.Checked then
    begin
      sql_dotaz:='SELECT '+
                 '  CISLO,VAR_SYMB,JMENO_CP,DATUM_CAS,DLUZNA_CASTKA,POKUTA,JIZDNE,RODNE_CISLO,MESTO,ULICE,CISLO_DOMU,PSC,OBVOD,DATUM_IMPORTU,'+
                 '  UZAMCENA,DATUM_UZAMCENI,REF_KOD,ID,SPLATNOST,SOUD,ZALOBA,NAROK,VS_SOUDU,CU_SOUDU,SPIS_ZNACKA,UHR_SOP,PL_PRIKAZ,ODVOLANI,'+
                 '  JEDNANI,ROZSUDEK,PR_MOC,UHRADA,DATUM_UHRADY,NAVRH,PRIKAZ,EXEKUCNI_PRIKAZ,SKONCENO,ZEMREL,ZAPLATIL_PRED_PODANIM,ZAPLATIL_CASTKA,EXEKUTOR, '+    // misto CASTKA -> EXEKUCNI_PRIKAZ
                 '  ZPRAVA_DORUCENI,ZPRAVA_OVERENI,ZPRAVA_PL_ROZKAZ,ZPRAVA_ZAPRACOVANI,VYMOZENO,SKONCENO_DUVOD,INSOLVENCE,SPLATKOVY_KALENDAR,'+
                 '  USNESENI_DATUM,OPRAVNE_USNESENI_DATUM,USNESENI_CJ '+
                 'FROM '+
                 tab+' '+
                 'WHERE '+
                 '  NVL(UZAMCENA,0)=0 '+
                 'ORDER BY '+
                 ' DATUM_IMPORTU DESC, CISLO';
    end;
    if (frmTiskZalob.rbDatum.Checked) and (frmTiskZalob.edDatumImportu.Text<>'') then
    begin
      sql_dotaz:='SELECT '+
                 '  CISLO,VAR_SYMB,JMENO_CP,DATUM_CAS,DLUZNA_CASTKA,POKUTA,JIZDNE,RODNE_CISLO,MESTO,ULICE,CISLO_DOMU,PSC,OBVOD,DATUM_IMPORTU,'+
                 '  UZAMCENA,DATUM_UZAMCENI,REF_KOD,ID,SPLATNOST,SOUD,ZALOBA,NAROK,VS_SOUDU,CU_SOUDU,SPIS_ZNACKA,UHR_SOP,PL_PRIKAZ,ODVOLANI,'+
                 '  JEDNANI,ROZSUDEK,PR_MOC,UHRADA,DATUM_UHRADY,NAVRH,PRIKAZ,EXEKUCNI_PRIKAZ,SKONCENO,ZEMREL,ZAPLATIL_PRED_PODANIM,ZAPLATIL_CASTKA,EXEKUTOR, '+    // misto CASTKA -> EXEKUCNI_PRIKAZ
                 '  ZPRAVA_DORUCENI,ZPRAVA_OVERENI,ZPRAVA_PL_ROZKAZ,ZPRAVA_ZAPRACOVANI,VYMOZENO,SKONCENO_DUVOD,INSOLVENCE,SPLATKOVY_KALENDAR,'+
                 '  USNESENI_DATUM,OPRAVNE_USNESENI_DATUM,USNESENI_CJ '+
                 'FROM '+
                 tab+' '+
                 'WHERE '+
                 '  NVL(UZAMCENA,0)=0 '+
                 '  AND DATUM_IMPORTU=TO_DATE('''+frmTiskZalob.edDatumImportu.Text+''') '+
                 'ORDER BY '+
                 ' DATUM_IMPORTU DESC, CISLO';
    end;
    if frmTiskZalob.rbOznacene.Checked then
    begin
      sql_dotaz:='SELECT '+
                 '  CISLO,VAR_SYMB,JMENO_CP,DATUM_CAS,DLUZNA_CASTKA,POKUTA,JIZDNE,RODNE_CISLO,MESTO,ULICE,CISLO_DOMU,PSC,OBVOD,DATUM_IMPORTU,'+
                 '  UZAMCENA,DATUM_UZAMCENI,REF_KOD,ID,SPLATNOST,SOUD,ZALOBA,NAROK,VS_SOUDU,CU_SOUDU,SPIS_ZNACKA,UHR_SOP,PL_PRIKAZ,ODVOLANI,'+
                 '  JEDNANI,ROZSUDEK,PR_MOC,UHRADA,DATUM_UHRADY,NAVRH,PRIKAZ,EXEKUCNI_PRIKAZ,SKONCENO,ZEMREL,ZAPLATIL_PRED_PODANIM,ZAPLATIL_CASTKA,EXEKUTOR, '+  // misto CASTKA -> EXEKUCNI_PRIKAZ
                 '  ZPRAVA_DORUCENI,ZPRAVA_OVERENI,ZPRAVA_PL_ROZKAZ,ZPRAVA_ZAPRACOVANI,VYMOZENO,SKONCENO_DUVOD,INSOLVENCE,SPLATKOVY_KALENDAR,'+
                 '  USNESENI_DATUM,OPRAVNE_USNESENI_DATUM,USNESENI_CJ '+
                 'FROM '+
                 tab+' '+
                 'WHERE '+
                 '  NVL(UZAMCENA,0)=0 '+
                 '  AND ID IN ('+temp+') '+
                 'ORDER BY '+
                 ' DATUM_IMPORTU DESC, CISLO';
    end;

    qt.SQL.Text:=sql_dotaz;
    qt.Open;
    qt.First;

    navesti:='Číslo;';
    navesti:=navesti+'Var. symb.;';
    navesti:=navesti+'Jméno;';
    navesti:=navesti+'Datum a čas;';
    navesti:=navesti+'Dlužná částka;';
    navesti:=navesti+'Pokuta;';
    navesti:=navesti+'Jízdné;';
    navesti:=navesti+'Rodné číslo;';
    navesti:=navesti+'Město;';
    navesti:=navesti+'Ulice;';
    navesti:=navesti+'Číslo domu;';
    navesti:=navesti+'Psč;';
    navesti:=navesti+'Obvod;';
    navesti:=navesti+'Datum imp.;';
    navesti:=navesti+'Uzamčena;';
    navesti:=navesti+'Datum uzamč.;';
    navesti:=navesti+'GUID;';
    navesti:=navesti+'Id;';
    navesti:=navesti+'Splatnost;';
    navesti:=navesti+'Soud;';
    navesti:=navesti+'Žaloba;';
    navesti:=navesti+'Nárok;';
    navesti:=navesti+'VS soudu;';
    navesti:=navesti+'č.ú. soudu;';
    navesti:=navesti+'Spis. značka;';
    navesti:=navesti+'Uhr. SOP;';
    navesti:=navesti+'Pl. rozkaz;';
    navesti:=navesti+'Zrušen;';
    navesti:=navesti+'Jednání;';
    navesti:=navesti+'Rozsudek;';
    navesti:=navesti+'Pr. moc;';
    navesti:=navesti+'Úhrada;';
    navesti:=navesti+'Datum úhrady;';
    navesti:=navesti+'Návrh;';

    //navesti:=navesti+'Příkaz;';
    navesti:=navesti+'Datum usnesení;';

    //navesti:=navesti+'Částka bez úroků;';
    navesti:=navesti+'Exekuční příkaz;';

    navesti:=navesti+'Skončeno;';
    navesti:=navesti+'Zemřel;';
    navesti:=navesti+'Zaplatil před podáním;';
    navesti:=navesti+'Zaplatil částka;';
    navesti:=navesti+'Exekutor;';
    navesti:=navesti+'Zpráva - doručení;';
    navesti:=navesti+'Zpráva - ověření;';
    navesti:=navesti+'Zpráva - pl. rozkaz;';
    navesti:=navesti+'Zpráva - zapracování;';
    navesti:=navesti+'Vymoženo;';
    navesti:=navesti+'Skončeno důvod;';
    navesti:=navesti+'Insolvence;';
    navesti:=navesti+'Splatkový kalendář;';

    //navesti:=navesti+'Usnesení datum;';
    navesti:=navesti+'Právní moc exe. nákladů;';

    navesti:=navesti+'Opravné usnesení datum';
    navesti:=navesti+'Usnesení č.j.';

    s.Add(Utf2Win(navesti));

    while not qt.EOF do
    begin
      radek:=Replace(qt.FieldByName('CISLO').AsString,';','');
      radek:=radek+';';
      radek:=radek+Replace(qt.FieldByName('VAR_SYMB').AsString,';','');
      radek:=radek+';';
      radek:=radek+Replace(qt.FieldByName('JMENO_CP').AsString,';','');
      radek:=radek+';';
      radek:=radek+Replace(qt.FieldByName('DATUM_CAS').AsString,';','');
      radek:=radek+';';
      radek:=radek+Replace(qt.FieldByName('DLUZNA_CASTKA').AsString,';','');
      radek:=radek+';';
      radek:=radek+Replace(qt.FieldByName('POKUTA').AsString,';','');
      radek:=radek+';';
      radek:=radek+Replace(qt.FieldByName('JIZDNE').AsString,';','');
      radek:=radek+';';
      radek:=radek+Replace(qt.FieldByName('RODNE_CISLO').AsString,';','');
      radek:=radek+';';
      radek:=radek+Replace(qt.FieldByName('MESTO').AsString,';','');
      radek:=radek+';';
      radek:=radek+Replace(qt.FieldByName('ULICE').AsString,';','');
      radek:=radek+';';
      radek:=radek+Replace(qt.FieldByName('CISLO_DOMU').AsString,';','');
      radek:=radek+';';
      radek:=radek+Replace(qt.FieldByName('PSC').AsString,';','');
      radek:=radek+';';
      radek:=radek+Replace(qt.FieldByName('OBVOD').AsString,';','');
      radek:=radek+';';
      radek:=radek+Replace(qt.FieldByName('DATUM_IMPORTU').AsString,';','');
      radek:=radek+';';
      radek:=radek+Replace(qt.FieldByName('UZAMCENA').AsString,';','');
      radek:=radek+';';
      radek:=radek+Replace(qt.FieldByName('DATUM_UZAMCENI').AsString,';','');
      radek:=radek+';';
      radek:=radek+Replace(qt.FieldByName('REF_KOD').AsString,';','');
      radek:=radek+';';
      radek:=radek+Replace(qt.FieldByName('ID').AsString,';','');
      radek:=radek+';';
      radek:=radek+Replace(qt.FieldByName('SPLATNOST').AsString,';','');
      radek:=radek+';';
      radek:=radek+Replace(qt.FieldByName('SOUD').AsString,';','');
      radek:=radek+';';
      radek:=radek+Replace(qt.FieldByName('ZALOBA').AsString,';','');
      radek:=radek+';';
      radek:=radek+Replace(qt.FieldByName('NAROK').AsString,';','');
      radek:=radek+';';
      radek:=radek+Replace(qt.FieldByName('VS_SOUDU').AsString,';','');
      radek:=radek+';';
      radek:=radek+Replace(qt.FieldByName('CU_SOUDU').AsString,';','');
      radek:=radek+';';
      radek:=radek+Replace(qt.FieldByName('SPIS_ZNACKA').AsString,';','');
      radek:=radek+';';
      radek:=radek+Replace(qt.FieldByName('UHR_SOP').AsString,';','');
      radek:=radek+';';
      radek:=radek+Replace(qt.FieldByName('PL_PRIKAZ').AsString,';','');
      radek:=radek+';';
      radek:=radek+Replace(qt.FieldByName('ODVOLANI').AsString,';','');
      radek:=radek+';';
      radek:=radek+Replace(qt.FieldByName('JEDNANI').AsString,';','');
      radek:=radek+';';
      radek:=radek+Replace(qt.FieldByName('ROZSUDEK').AsString,';','');
      radek:=radek+';';
      radek:=radek+Replace(qt.FieldByName('PR_MOC').AsString,';','');
      radek:=radek+';';
      radek:=radek+Replace(qt.FieldByName('UHRADA').AsString,';','');
      radek:=radek+';';
      radek:=radek+Replace(qt.FieldByName('DATUM_UHRADY').AsString,';','');
      radek:=radek+';';
      radek:=radek+Replace(qt.FieldByName('NAVRH').AsString,';','');
      radek:=radek+';';
      radek:=radek+Replace(qt.FieldByName('PRIKAZ').AsString,';','');

      //radek:=radek+';';
      //radek:=radek+Replace(qt.FieldByName('CASTKA').AsString,';','');
      radek:=radek+';';
      radek:=radek+Replace(qt.FieldByName('EXEKUCNI_PRIKAZ').AsString,';','');

      radek:=radek+';';
      radek:=radek+Replace(qt.FieldByName('SKONCENO').AsString,';','');
      radek:=radek+';';
      radek:=radek+Replace(qt.FieldByName('ZEMREL').AsString,';','');
      radek:=radek+';';
      radek:=radek+Replace(qt.FieldByName('ZAPLATIL_PRED_PODANIM').AsString,';','');
      radek:=radek+';';
      radek:=radek+Replace(qt.FieldByName('ZAPLATIL_CASTKA').AsString,';','');
      radek:=radek+';';
      radek:=radek+Replace(qt.FieldByName('EXEKUTOR').AsString,';','');
      radek:=radek+';';
      radek:=radek+Replace(qt.FieldByName('ZPRAVA_DORUCENI').AsString,';','');
      radek:=radek+';';
      radek:=radek+Replace(qt.FieldByName('ZPRAVA_OVERENI').AsString,';','');
      radek:=radek+';';
      radek:=radek+Replace(qt.FieldByName('ZPRAVA_PL_ROZKAZ').AsString,';','');
      radek:=radek+';';
      radek:=radek+Replace(qt.FieldByName('ZPRAVA_ZAPRACOVANI').AsString,';','');
      radek:=radek+';';
      radek:=radek+Replace(qt.FieldByName('VYMOZENO').AsString,';','');
      radek:=radek+';';
      radek:=radek+Replace(qt.FieldByName('SKONCENO_DUVOD').AsString,';','');
      radek:=radek+';';
      radek:=radek+Replace(qt.FieldByName('INSOLVENCE').AsString,';','');
      radek:=radek+';';
      radek:=radek+Replace(qt.FieldByName('SPLATKOVY_KALENDAR').AsString,';','');
      radek:=radek+';';
      radek:=radek+Replace(qt.FieldByName('USNESENI_DATUM').AsString,';','');
      radek:=radek+';';
      radek:=radek+Replace(qt.FieldByName('OPRAVNE_USNESENI_DATUM').AsString,';','');
      radek:=radek+';';
      radek:=radek+Replace(qt.FieldByName('USNESENI_CJ').AsString,';','');

      s.Add(Utf2Win(radek));
      qt.Next;
    end;

    frmProcesQuery.Close;

    if sd.Execute then
      s.SaveToFile(sd.FileName);

    ShowMessage('Export skončil.');

    finally
      frmProcesQuery.Close;
      qt.free;
      sd.free;
      s.free;
    end;

  end;
end;

procedure nastavitUHR_SOP(DBGrid : TDBGrid; tab : String; dataSet: TDataSet; query : TZQuery);
var
  table : TDataSet;
  i : Integer;
  temp : String;
begin
  if not Assigned(dlgDatum) then
    Application.CreateForm(TdlgDatum,dlgDatum);
  //frmDatum.FSelRows:=DBGrid.SelectedRows.Count;
  dlgDatum.ShowModal;
  dlgDatum.Label1.Caption:='Zadejte datum pro Úhr. SOP';
  try
    if dlgDatum.ModalResult=mrOK then
    begin

      //if frmTiskZalob.rbOznacene.Checked then
      //begin
        //if DBGrid.SelectedRows.CurrentRowSelected then
        begin
          Table:=DBGrid.DataSource.Dataset;
          for i:=0 to DBGrid.SelectedRows.Count-1 do
          begin
            Table.Bookmark:=DBGrid.SelectedRows[i];
            if i=0 then
              temp:=Table.FieldByName('ID').AsString
            else
              temp:=temp+','+Table.FieldByName('ID').AsString;
          end;
        end;
      //end;
      if temp = '' then
      begin
        MessageDlg('Nejsou označeny žádné záznamy, nastavení nebude provedeno!',mtError,[mbOK],0);
        exit;
      end;
      if MessageDlg('Nastavit Úhr. SOP', 'Opravdu chcete nastavit pro označené záznamy(celkem: '+IntToStr(DBGrid.SelectedRows.Count)+') datum '+dlgDatum.edDatum.Text+' ?', mtConfirmation,
           [mbYes, mbNo],0) = mrYes
      then
      begin
        try
          ExecSQL('UPDATE '+tab+' SET UHR_SOP=TO_DATE('''+dlgDatum.edDatum.Text+''') WHERE ID IN ('+temp+')');
          MessageDlg('Nastavení datumu pro označené záznamy proběhlo.',mtInformation,[mbOK],0);
          Refresh_DataSet(dataSet,query);
        except
          MessageDlg('Při nastavení datumu pro označené záznamy došlo k chybě!',mtError,[mbOK],0);
        end;
      end;
    end;

  finally
    dlgDatum.Label1.Caption:='Zadejte datum';
  end;
end;

procedure importZalob(g: TDBGrid; tab: string);
var
  s,sch: TStringList;
  od : TOpenDialog;
  sql_dotaz,navesti,radek,temp,id,del: string;
  cislo,var_symb,jmeno_cp,datum_cas,dluzna_castka,
  pokuta,jizdne,rodne_cislo,mesto,ulice,
  cislo_domu,psc,obvod,datum_importu,uzamcena,
  datum_uzamceni,ref_kod,splatnost,soud,zaloba,
  narok,vs_soudu,cu_soudu,spis_znacka,uhr_sop,
  pl_prikaz,odvolani,jednani,rozsudek,pr_moc,
  uhrada,datum_uhrady,navrh,prikaz,castka,
  skonceno,zemrel,zaplatil_pred_podanim,zaplatil_castka,exekutor,
  zprava_doruceni,zprava_overeni,zprava_pl_rozkaz,zprava_zapracovani,
  skonceno_duvod,insolvence,splatkovy_kalendar,
  usneseni_datum,opravne_usneseni_datum,usneseni_cj,vymozeno: String;
  qt : TZQuery;
  //qtu : TZUpdateSQL;
  Table : TDataSet;
  i,p : Integer;
  w: WideString;
begin
  try
    if not Assigned(frmProcesQuery) then
      Application.CreateForm(TfrmProcesQuery,frmProcesQuery);
    frmProcesQuery.ShowOnTop;
    frmProcesQuery.Repaint;
    qt:=TZQuery.Create(nil);
    //qtu:=TZUpdateSQL.Create(nil);
    qt.Connection:=DM.OracleConnection;
    od:=TOpenDialog.Create(nil);
    od.DefaultExt:='csv';
    s:=TStringList.Create;
    sch:=TStringList.Create;

  if od.Execute then
  begin
    s.LoadFromFile(od.FileName);
    //s.Add(UTF2Win(sch.Text));
    del := ';';

    for i:=1 to s.Count-2 do
    begin

      radek := Win2Utf(s.Strings[i]);

      // CISLO
      p := pos(del,radek);
      cislo := copy(radek,1,p-1);
      radek := copy(radek,p+1,length(radek)-p);
      //ShowMessage('STEP'+IntToStr(p)+'-'+copy(radek,1,10)+'-'+copy(radek,10,1));

      // VAR_SYMB
      p := pos(del,radek);
      var_symb := copy(radek,1,p-1);
      radek := copy(radek,p+1,length(radek)-p);

      // JMENO_CP
      p := pos(del,radek);
      jmeno_cp := copy(radek,1,p-1);
      radek := copy(radek,p+1,length(radek)-p);

      // DATUM_CAS
      p := pos(del,radek);
      datum_cas := copy(radek,1,p-1);
      radek := copy(radek,p+1,length(radek)-p);

      // DLUZNA_CASTKA
      p := pos(del,radek);
      dluzna_castka := copy(radek,1,p-1);
      radek := copy(radek,p+1,length(radek)-p);

      // POKUTA
      p := pos(del,radek);
      pokuta := copy(radek,1,p-1);
      radek := copy(radek,p+1,length(radek)-p);

      // JIZDNE
      p := pos(del,radek);
      jizdne := copy(radek,1,p-1);
      radek := copy(radek,p+1,length(radek)-p);

      // RODNE_CISLO
      p := pos(del,radek);
      rodne_cislo := copy(radek,1,p-1);
      radek := copy(radek,p+1,length(radek)-p);

      // MESTO
      p := pos(del,radek);
      mesto := copy(radek,1,p-1);
      radek := copy(radek,p+1,length(radek)-p);

      // ULICE
      p := pos(del,radek);
      ulice := copy(radek,1,p-1);
      radek := copy(radek,p+1,length(radek)-p);

      // CISLO_DOMU
      p := pos(del,radek);
      cislo_domu := copy(radek,1,p-1);
      radek := copy(radek,p+1,length(radek)-p);

      // PSC
      p := pos(del,radek);
      psc := copy(radek,1,p-1);
      radek := copy(radek,p+1,length(radek)-p);

      // OBVOD
      p := pos(del,radek);
      obvod := copy(radek,1,p-1);
      radek := copy(radek,p+1,length(radek)-p);

      // DATUM_IMPORTU
      p := pos(del,radek);
      datum_importu := copy(radek,1,p-1);
      radek := copy(radek,p+1,length(radek)-p);

      // UZAMCENA
      p := pos(del,radek);
      uzamcena := copy(radek,1,p-1);
      radek := copy(radek,p+1,length(radek)-p);

      // DATUM_UZAMCENI
      p := pos(del,radek);
      datum_uzamceni := copy(radek,1,p-1);
      radek := copy(radek,p+1,length(radek)-p);

      // REF_KOD
      p := pos(del,radek);
      ref_kod := copy(radek,1,p-1);
      radek := copy(radek,p+1,length(radek)-p);

      // ID
      p := pos(del,radek);
      id := copy(radek,1,p-1);
      radek := copy(radek,p+1,length(radek)-p);

      // SPLATNOST
      p := pos(del,radek);
      splatnost := copy(radek,1,p-1);
      radek := copy(radek,p+1,length(radek)-p);

      // SOUD
      p := pos(del,radek);
      soud := copy(radek,1,p-1);
      radek := copy(radek,p+1,length(radek)-p);

      // ZALOBA
      p := pos(del,radek);
      zaloba := copy(radek,1,p-1);
      radek := copy(radek,p+1,length(radek)-p);

      // NAROK
      p := pos(del,radek);
      narok := copy(radek,1,p-1);
      radek := copy(radek,p+1,length(radek)-p);

      // VS_SOUDU
      p := pos(del,radek);
      vs_soudu := copy(radek,1,p-1);
      radek := copy(radek,p+1,length(radek)-p);

      // CU_SOUDU
      p := pos(del,radek);
      cu_soudu := copy(radek,1,p-1);
      radek := copy(radek,p+1,length(radek)-p);

      // SPIS_ZNACKA
      p := pos(del,radek);
      spis_znacka := copy(radek,1,p-1);
      radek := copy(radek,p+1,length(radek)-p);

      // UHR_SOP
      p := pos(del,radek);
      uhr_sop := copy(radek,1,p-1);
      radek := copy(radek,p+1,length(radek)-p);

      // PL_PRIKAZ
      p := pos(del,radek);
      pl_prikaz := copy(radek,1,p-1);
      radek := copy(radek,p+1,length(radek)-p);

      // ODVOLANI
      p := pos(del,radek);
      odvolani := copy(radek,1,p-1);
      radek := copy(radek,p+1,length(radek)-p);

      // JEDNANI
      p := pos(del,radek);
      jednani := copy(radek,1,p-1);
      radek := copy(radek,p+1,length(radek)-p);

      // ROZSUDEK
      p := pos(del,radek);
      rozsudek := copy(radek,1,p-1);
      radek := copy(radek,p+1,length(radek)-p);

      // PR_MOC
      p := pos(del,radek);
      pr_moc := copy(radek,1,p-1);
      radek := copy(radek,p+1,length(radek)-p);

      // UHRADA
      p := pos(del,radek);
      uhrada := copy(radek,1,p-1);
      radek := copy(radek,p+1,length(radek)-p);

      // DATUM_UHRADY
      p := pos(del,radek);
      datum_uhrady := copy(radek,1,p-1);
      radek := copy(radek,p+1,length(radek)-p);

      // NAVRH
      p := pos(del,radek);
      navrh := copy(radek,1,p-1);
      radek := copy(radek,p+1,length(radek)-p);

      // PRIKAZ
      p := pos(del,radek);
      prikaz := copy(radek,1,p-1);
      radek := copy(radek,p+1,length(radek)-p);

      // CASTKA nove EXEKUCNI_PRIKAZ
      p := pos(del,radek);
      castka := copy(radek,1,p-1);
      radek := copy(radek,p+1,length(radek)-p);

      // SKONCENO
      p := pos(del,radek);
      skonceno := copy(radek,1,p-1);
      radek := copy(radek,p+1,length(radek)-p);

      // ZEMREL
      p := pos(del,radek);
      zemrel := copy(radek,1,p-1);
      radek := copy(radek,p+1,length(radek)-p);

      // ZAPLATIL_PRED_PODANIM
      p := pos(del,radek);
      zaplatil_pred_podanim := copy(radek,1,p-1);
      radek := copy(radek,p+1,length(radek)-p);

      // ZAPLATIL_CASTKA
      p := pos(del,radek);
      zaplatil_castka := copy(radek,1,p-1);
      radek := copy(radek,p+1,length(radek)-p);

      // EXEKUTOR
      p := pos(del,radek);
      exekutor := copy(radek,1,p-1);
      radek := copy(radek,p+1,length(radek)-p);

      // ZPRAVA_DORUCENI
      p := pos(del,radek);
      zprava_doruceni := copy(radek,1,p-1);
      radek := copy(radek,p+1,length(radek)-p);

      // ZPRAVA_OVERENI
      p := pos(del,radek);
      zprava_overeni := copy(radek,1,p-1);
      radek := copy(radek,p+1,length(radek)-p);

      // ZPRAVA_PL_ROZKAZ
      p := pos(del,radek);
      zprava_pl_rozkaz := copy(radek,1,p-1);
      radek := copy(radek,p+1,length(radek)-p);

      // ZPRAVA_ZAPRACOVANI
      p := pos(del,radek);
      zprava_pl_rozkaz := copy(radek,1,p-1);
      radek := copy(radek,p+1,length(radek)-p);

      // VYMOZENO
      p := pos(del,radek);
      vymozeno := copy(radek,1,p-1);
      radek := copy(radek,p+1,length(radek)-p);

      // SKONCENO_DUVOD
      p := pos(del,radek);
      skonceno_duvod := copy(radek,1,p-1);
      radek := copy(radek,p+1,length(radek)-p);

      // INSOLVENCE
      p := pos(del,radek);
      insolvence := copy(radek,1,p-1);
      radek := copy(radek,p+1,length(radek)-p);

      // SPLATKOVY_KALENDAR
      p := pos(del,radek);
      splatkovy_kalendar := copy(radek,1,p-1);
      radek := copy(radek,p+1,length(radek)-p);

      // USNESENI_DATUM
      p := pos(del,radek);
      usneseni_datum := copy(radek,1,p-1);
      radek := copy(radek,p+1,length(radek)-p);

      // OPRAVNE_USNESENI_DATUM
      p := pos(del,radek);
      opravne_usneseni_datum := copy(radek,1,p-1);
      radek := copy(radek,p+1,length(radek)-p);

      // USNESENI_CJ
      //p := pos(del,radek);
      usneseni_cj := copy(radek,1,length(radek));
      //radek := copy(radek,p+1,length(radek)-p);



      if (ExecSql_old('SELECT COUNT(*) FROM EXEKUTORI WHERE KOD='''+exekutor+'''')='0') and (length(exekutor)>0) then
        ExecSQL('INSERT INTO EXEKUTORI VALUES('''+exekutor+''','''+exekutor+''')');

      //ShowMessage('STEP 2');
      //UPDATE_SQL:='UPDATE '+tab+' SET '+
      //            'WHERE ID = :OLD_ID';
      //qtu.ModifySQL:=UPDATE_SQL:='UPDATE '+tab+' SET ';
      //qt.UpdateObject:=qtu;

      try

      qt.Close;

      if (ExecSql_old('SELECT COUNT(*) FROM '+tab+' WHERE VAR_SYMB='''+var_symb+'''')='0') then
      begin
        qt.SQL.Text:='SELECT * FROM '+tab;
        qt.Open;
        qt.Append;
      end
      else
      begin
        qt.SQL.Text:='SELECT * FROM '+tab+' WHERE VAR_SYMB = '''+var_symb+'''';
        qt.Open;
        qt.Edit;
      end;

      {ShowMessage(getDateFormat(datum_cas)+'*'+
                  getDateFormat(datum_importu)+'*'+
                  getDateFormat(datum_uzamceni)+'*'+
                  getDateFormat(splatnost)+'*'+
                  getDateFormat(zaloba)+'*'+
                  getDateFormat(uhr_sop)+'*'+
                  getDateFormat(pl_prikaz)+'*'+
                  getDateFormat(odvolani)+'*'+
                  getDateFormat(jednani)+'*'+
                  getDateFormat(rozsudek)+'*'+
                  getDateFormat(pr_moc)+'*'+
                  getDateFormat(datum_uhrady)+'*'+
                  getDateFormat(navrh)+'*'+
                  getDateFormat(prikaz)+'*'+
                  getDateFormat(skonceno)+'*'+
                  getDateFormat(zemrel)+'*'+
                  getDateFormat(zaplatil_pred_podanim)+'*'+
                  getDateFormat(usneseni_datum)+'*'+
                  getDateFormat(opravne_usneseni_datum)
                  );  exit; }

      qt.FieldByName('CISLO').AsString := cislo;
      qt.FieldByName('VAR_SYMB').AsString := var_symb;
      qt.FieldByName('JMENO_CP').AsString := jmeno_cp;
      qt.FieldByName('DATUM_CAS').AsString := getDateFormat(datum_cas);
      qt.FieldByName('DLUZNA_CASTKA').AsString := dluzna_castka;
      qt.FieldByName('POKUTA').AsString := pokuta;
      qt.FieldByName('JIZDNE').AsString := jizdne;
      qt.FieldByName('RODNE_CISLO').AsString := rodne_cislo;
      qt.FieldByName('MESTO').AsString := mesto;
      qt.FieldByName('ULICE').AsString := ulice;
      qt.FieldByName('CISLO_DOMU').AsString := cislo_domu;
      qt.FieldByName('PSC').AsString := psc;
      qt.FieldByName('OBVOD').AsString := obvod;
      qt.FieldByName('DATUM_IMPORTU').AsString := getDateFormat(datum_importu);
      qt.FieldByName('UZAMCENA').AsString := uzamcena;
      qt.FieldByName('DATUM_UZAMCENI').AsString := getDateFormat(datum_uzamceni);
      qt.FieldByName('REF_KOD').AsString := ref_kod;
      qt.FieldByName('SPLATNOST').AsString := getDateFormat(splatnost);
      qt.FieldByName('SOUD').AsString := soud;
      qt.FieldByName('ZALOBA').AsString := getDateFormat(zaloba);
      qt.FieldByName('NAROK').AsString := narok;
      qt.FieldByName('VS_SOUDU').AsString := vs_soudu;
      qt.FieldByName('CU_SOUDU').AsString := cu_soudu;
      qt.FieldByName('SPIS_ZNACKA').AsString := spis_znacka;
      qt.FieldByName('UHR_SOP').AsString := getDateFormat(uhr_sop);
      qt.FieldByName('PL_PRIKAZ').AsString := getDateFormat(pl_prikaz);
      qt.FieldByName('ODVOLANI').AsString := getDateFormat(odvolani);
      qt.FieldByName('JEDNANI').AsString := getDateFormat(jednani);
      qt.FieldByName('ROZSUDEK').AsString := getDateFormat(rozsudek);
      qt.FieldByName('PR_MOC').AsString := getDateFormat(pr_moc);
      qt.FieldByName('UHRADA').AsString := uhrada;
      qt.FieldByName('DATUM_UHRADY').AsString := getDateFormat(datum_uhrady);
      qt.FieldByName('NAVRH').AsString := getDateFormat(navrh);
      qt.FieldByName('PRIKAZ').AsString := getDateFormat(prikaz);
      //qt.FieldByName('CASTKA').AsString := castka;
      qt.FieldByName('EXEKUCNI_PRIKAZ').AsString := castka;
      qt.FieldByName('SKONCENO').AsString := getDateFormat(skonceno);
      qt.FieldByName('ZEMREL').AsString := getDateFormat(zemrel);
      qt.FieldByName('ZAPLATIL_PRED_PODANIM').AsString := getDateFormat(zaplatil_pred_podanim);
      qt.FieldByName('ZAPLATIL_CASTKA').AsString := zaplatil_castka;
      qt.FieldByName('EXEKUTOR').AsString := exekutor;
      qt.FieldByName('ZPRAVA_DORUCENI').AsString := zprava_doruceni;
      qt.FieldByName('ZPRAVA_OVERENI').AsString := zprava_overeni;
      qt.FieldByName('ZPRAVA_PL_ROZKAZ').AsString := zprava_pl_rozkaz;
      qt.FieldByName('ZPRAVA_ZAPRACOVANI').AsString := zprava_zapracovani;
      qt.FieldByName('VYMOZENO').AsString :=vymozeno;
      qt.FieldByName('SKONCENO_DUVOD').AsString := skonceno_duvod;
      qt.FieldByName('INSOLVENCE').AsString := insolvence;
      qt.FieldByName('SPLATKOVY_KALENDAR').AsString := splatkovy_kalendar;
      qt.FieldByName('USNESENI_DATUM').AsString := getDateFormat(usneseni_datum);
      qt.FieldByName('OPRAVNE_USNESENI_DATUM').AsString := getDateFormat(opravne_usneseni_datum);
      qt.FieldByName('USNESENI_CJ').AsString := usneseni_cj;
      qt.Post;
      qt.ApplyUpdates;
      //ShowMessage('STEP-'+id);


      except
        on E : Exception do
        begin
          MessageDlg('Nastala chyba při importu řádku '+IntToStr(i)+' var_symb: '+var_symb+', nebude importován! Chyba: '+E.Message+'!',mtWarning,[mbOK],0);
        end;
      end;

    end;
  end;

  frmProcesQuery.Close;

  ShowMessage('Import skončil.');

  finally
    frmProcesQuery.Close;
    qt.free;
    od.free;
    s.free;
    sch.Free;
  end;

end;

end.

