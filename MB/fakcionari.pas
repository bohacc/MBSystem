unit FAkcionari; 

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  FSablona, db, DBGrids, ExtCtrls, ComCtrls, sqldb, DbCtrls, StdCtrls, Menus,
  ZDataset, ZSqlUpdate;

type

  { TfrmAkcionari }

  TfrmAkcionari = class(TfrmSablona)
    Bevel1: TBevel;
    edJmeno: TDBEdit;
    edHodnotaDiv: TDBEdit;
    edProcentoDiv: TDBEdit;
    edHrubaDiv: TDBEdit;
    edDanDiv: TDBEdit;
    edCistaDiv: TDBEdit;
    dsDividenda: TDatasource;
    DBNavigator1: TDBNavigator;
    dsSoucty: TDatasource;
    edID: TDBEdit;
    edPrijmeni: TDBEdit;
    edUlice: TDBEdit;
    edMesto: TDBEdit;
    edPsc: TDBEdit;
    edRodne: TDBEdit;
    edOP: TDBEdit;
    edOS: TDBEdit;
    edAkcie: TDBEdit;
    DBGrid2: TDBGrid;
    dsPohyb: TDatasource;
    DBGrid1: TDBGrid;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    lbAkcie: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    miNastaveniDividendy: TMenuItem;
    miPrevodAll: TMenuItem;
    miPrevod: TMenuItem;
    miSestavy: TMenuItem;
    miAkcionari: TMenuItem;
    Panel2: TPanel;
    pcAkcie: TPageControl;
    Panel1: TPanel;
    qrDividendaADRESA: TStringField;
    qrDividendaCISTA_DIV: TLongintField;
    qrDividendaDAN_DIV: TFloatField;
    qrDividendaHODNOTA: TFloatField;
    qrDividendaHRUBA_DIV: TFloatField;
    qrDividendaJMENO: TStringField;
    qrDividendaPRIJMENI: TStringField;
    qrDividendaPROC_DIV: TFloatField;
    qrDividendaRC: TStringField;
    qrMasterAKCIE: TBCDField;
    qrMasterDIVIDENDA: TBCDField;
    qrMasterID: TLongintField;
    qrMasterJMENO: TStringField;
    qrMasterMESTO: TStringField;
    qrMasterOP: TStringField;
    qrMasterOS: TStringField;
    qrMasterPRIJMENI: TStringField;
    qrMasterPSC: TStringField;
    qrMasterRC: TStringField;
    qrMasterULICE: TStringField;
    qrPohybCISLO: TLongintField;
    qrPohybCISLO_AKCIE: TLargeintField;
    qrPohybDATUM: TDateField;
    qrPohybHODNOTA: TFloatField;
    qrPohybID: TLongintField;
    qrPohybPOZNAMKA: TMemoField;
    qrPohybSERIE: TStringField;
    qrPohybTEXT: TBlobField;
    qrPohybTYP: TStringField;
    qrSoucty: TZQuery;
    qrSouctyCELKEM: TFloatField;
    qrSouctyHODNOTA: TLongintField;
    qrSouctyPOCET: TLongintField;
    qrSouctyTYP: TStringField;
    qrText: TZQuery;
    qrDividenda: TZQuery;
    ToolBar2: TToolBar;
    toolbtn: TToolButton;
    toolbtn2: TToolButton;
    ToolButton6: TToolButton;
    tbOznacitVse: TToolButton;
    tsAkcie: TTabSheet;
    qrPohyb: TZQuery;
    UpdatePohyb: TZUpdateSQL;
    procedure Button1Click(Sender: TObject);
    procedure DBNavigator1Click(Sender: TObject; Button: TDBNavButtonType);
    procedure edHrubaDivChange(Sender: TObject);
    procedure edPrijmeniChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure miVychoziDotazClick(Sender: TObject);
    procedure NavigatorClick(Sender: TObject; Button: TDBNavButtonType);
    procedure NavigatorDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure Panel1Click(Sender: TObject);
    procedure pcAkcieChange(Sender: TObject);
    procedure qrDividendaAfterPost(DataSet: TDataSet);
    procedure qrDividendaBeforeOpen(DataSet: TDataSet);
    procedure qrMasterAfterApplyUpdates(Sender: TObject);
    procedure qrMasterAfterPost(DataSet: TDataSet);
    procedure qrMasterBeforeApplyUpdates(Sender: TObject);
    procedure qrMasterBeforeEdit(DataSet: TDataSet);
    procedure qrMasterBeforeInsert(DataSet: TDataSet);
    procedure qrMasterAfterOpen(DataSet: TDataSet);
    procedure qrPohybAfterPost(DataSet: TDataSet);
    procedure qrPohybBeforeOpen(DataSet: TDataSet);
    procedure qrPohybBeforePost(DataSet: TDataSet);
    procedure qrSouctyAfterPost(DataSet: TDataSet);
    procedure qrSouctyBeforeInsert(DataSet: TDataSet);
    procedure qrSouctyBeforeOpen(DataSet: TDataSet);
    procedure qrTextAfterPost(DataSet: TDataSet);
    procedure toolbtn2Click(Sender: TObject);
    procedure toolbtnClick(Sender: TObject);
    procedure ToolButton5Click(Sender: TObject);
    procedure miSouhrnAkciiClick(Sender: TObject);
    procedure ToolButton3Click(Sender: TObject);
    procedure miPrevodClick(Sender: TObject);
    procedure miStitkyIClick(Sender: TObject);
    procedure miStitkyIIClick(Sender: TObject);
    procedure miHistorieAkcieClick(Sender: TObject);
    procedure qrMasterBeforePost(DataSet: TDataSet);
    procedure qrMasterAfterScroll(DataSet: TDataSet);
    procedure miVybratVseClick(Sender: TObject);
    procedure miSeznamAkcionaruIIClick(Sender: TObject);
    procedure tbOznacitVseClick(Sender: TObject);
    procedure miPrevodAllClick(Sender: TObject);
    procedure DBGrid1TitleClick(Column: TColumn);
    procedure miSouhrnAkcii2Click(Sender: TObject);
    procedure miNastaveniDividendyClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dsMasterDataChange(Sender: TObject; Field: TField);
    procedure miVyplatniListinaClick(Sender: TObject);
    procedure miVyplatniListina2Click(Sender: TObject);
    procedure miVyplatniListina3Click(Sender: TObject);
    procedure DBGridTitleClick(Column: TColumn);
    procedure DBGrid2TitleClick(Column: TColumn);
    procedure qrPohybAfterDelete(DataSet: TDataSet);
    procedure miSeznamAkcionaruIIIClick(Sender: TObject);
    procedure qrMasterNewRecord(DataSet: TDataSet);
    procedure edFindKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure NavigatorBeforeAction(Sender: TObject; Button: TNavigateBtn);
    procedure miSoucetAkciiZaTypAllClick(Sender: TObject);
    procedure miAkcionarVypisClick(Sender: TObject);
    procedure miSeznamakcionClick(Sender: TObject);
    procedure ToolButton6Click(Sender: TObject);
  private
    FPohybSQL : String;
    FMasterSQL : String;
    FSouctySQL : String;
    FMasterSort : Integer;
    FSouctySort : Integer;
    FPohybSort : Integer;
    procedure Spocti_dividenda(_Akcionar : String);
  public
    { public declarations }
  end; 

var
  frmAkcionari: TFrmAkcionari;

implementation

uses  dakcie_pohyb,uProc,Utils,ssouhrn_akcii,dprevod_akcie,sStitky,sstitky2,
      shistorie_akcie,sseznam_akcionaru2,ssouhrn_akcii2,svyplatni_listina,
      svyplatni_listina2,svyplatni_listina3,sseznam_akcionaru3,sSoucetAkciiZaTypAll,
      svypis_akcionare,sseznam_akcionaru,Data_module,FParametry;

{ TfrmAkcionari }

procedure TfrmAkcionari.FormCreate(Sender: TObject);
begin
  inherited;
  qrPohyb.Open;
  qrSoucty.Open;
  qrDividenda.Open;

  FPohybSQL:=qrPohyb.SQL.Text;
  FMasterSQL:=qrMaster.SQL.Text;
  FSouctySQL:=qrSoucty.SQL.Text;
end;

procedure TfrmAkcionari.edPrijmeniChange(Sender: TObject);
begin

end;

procedure TfrmAkcionari.edHrubaDivChange(Sender: TObject);
begin

end;

procedure TfrmAkcionari.Button1Click(Sender: TObject);
begin

end;

procedure TfrmAkcionari.DBNavigator1Click(Sender: TObject;
  Button: TDBNavButtonType);
begin
  if Button in [nbInsert,nbEdit] then
  begin
  try
    if qrMaster.Modified then
      qrMaster.Post;
    //Refresh_DataSet(Navigator.DataSource.DataSet,qrMaster);
    if not(Assigned(frmAkciePohyb)) then
      Application.CreateForm(TfrmAkciePohyb,frmAkciePohyb);
    //qrPohyb0.Database.StartTransaction;
    frmAkciePohyb.ShowModal;
  except
  end;
  end;
end;

procedure TfrmAkcionari.NavigatorClick(Sender: TObject;
  Button: TDBNavButtonType);
begin
  inherited;
end;

procedure TfrmAkcionari.DBGrid1DblClick(Sender: TObject);
begin
  inherited;
  try
    if qrMaster.Modified then
      qrMaster.Post;
    if not(Assigned(frmAkciePohyb)) then
      Application.CreateForm(TfrmAkciePohyb,frmAkciePohyb);
    qrPohyb.Edit;
    frmAkciePohyb.ShowModal;
  except
  end;
end;

procedure TfrmAkcionari.miVychoziDotazClick(Sender: TObject);
begin

end;

procedure TfrmAkcionari.NavigatorDragDrop(Sender, Source: TObject; X, Y: Integer
  );
begin

end;

procedure TfrmAkcionari.Panel1Click(Sender: TObject);
begin

end;

procedure TfrmAkcionari.pcAkcieChange(Sender: TObject);
begin

end;

procedure TfrmAkcionari.qrDividendaAfterPost(DataSet: TDataSet);
begin
  qrDividenda.ApplyUpdates;
end;

procedure TfrmAkcionari.qrDividendaBeforeOpen(DataSet: TDataSet);
begin
  qrDividenda.Params.ParamByName('ID').DataType:=ftInteger;
end;

procedure TfrmAkcionari.qrMasterAfterApplyUpdates(Sender: TObject);
begin
  inherited;
end;

procedure TfrmAkcionari.qrMasterAfterOpen(DataSet: TDataSet);
begin

end;

procedure TfrmAkcionari.qrMasterAfterPost(DataSet: TDataSet);
begin
  inherited;
end;

procedure TfrmAkcionari.qrMasterBeforeApplyUpdates(Sender: TObject);
begin

end;

procedure TfrmAkcionari.qrMasterBeforeInsert(DataSet: TDataSet);
begin
  inherited;
  //DM.OracleConnection.StartTransaction;
end;

procedure TfrmAkcionari.qrPohybAfterPost(DataSet: TDataSet);
begin
  qrPohyb.ApplyUpdates;
end;

procedure TfrmAkcionari.qrPohybBeforeOpen(DataSet: TDataSet);
begin
  qrPohyb.Params.ParamByName('ID').DataType:=ftInteger;
end;

procedure TfrmAkcionari.qrPohybBeforePost(DataSet: TDataSet);
begin
  inherited;
  qrPohyb.FieldByName('ID').AsInteger:=Get_NewID;
  if qrPohyb.FieldByName('CISLO').AsString='' then
     qrPohyb.FieldByName('CISLO').AsInteger:=qrMasterID.AsInteger;
end;

procedure TfrmAkcionari.qrSouctyAfterPost(DataSet: TDataSet);
begin
  qrSoucty.ApplyUpdates;
end;

procedure TfrmAkcionari.qrSouctyBeforeInsert(DataSet: TDataSet);
begin
  //DM.OracleConnection.StartTransaction;
end;

procedure TfrmAkcionari.qrSouctyBeforeOpen(DataSet: TDataSet);
begin
  qrSoucty.Params.ParamByName('ID').DataType:=ftInteger;
end;

procedure TfrmAkcionari.qrTextAfterPost(DataSet: TDataSet);
begin
  qrText.ApplyUpdates;
end;

procedure TfrmAkcionari.toolbtn2Click(Sender: TObject);
begin

end;

procedure TfrmAkcionari.toolbtnClick(Sender: TObject);
begin
  Refresh_DataSet(DBNavigator1.DataSource.DataSet,qrPohyb);
end;

procedure TfrmAkcionari.ToolButton5Click(Sender: TObject);
begin
  Refresh_DataSet(DBNavigator1.DataSource.DataSet,qrPohyb);
end;

procedure TfrmAkcionari.miSouhrnAkciiClick(Sender: TObject);
begin
  inherited;
  if not Assigned(frmSouhrnAkcii) then
    Application.CreateForm(TfrmSouhrnAkcii,frmSouhrnAkcii);

  frmSouhrnAkcii.qrMaster.Close;
  frmSouhrnAkcii.qrMaster.Open;
  frmSouhrnAkcii.QuickRep1.Preview.Show;
end;

procedure TfrmAkcionari.ToolButton3Click(Sender: TObject);
begin
  inherited;
  miPrevod.Click;
end;

procedure TfrmAkcionari.miPrevodClick(Sender: TObject);
var
  i:integer;
  v: variant;
  temp : string;
  table : TDataSet;
begin
  inherited;
  if not(Assigned(frmPrevodAkcie)) then
      Application.CreateForm(TfrmPrevodAkcie,frmPrevodAkcie);
  if DBGrid1.SelectedRows.CurrentRowSelected then
  begin
    frmPrevodAkcie.qrAkcie.Close;
    Table:=DBGrid1.DataSource.Dataset;
    for i:=0 to DBGrid1.SelectedRows.Count-1 do
    begin
      Table.Bookmark:=AnsiString(DBGrid1.SelectedRows[i]);
      if i=0 then
        temp:=Table.FieldByName('ID').AsString
      else
        temp:=temp+','+Table.FieldByName('ID').AsString;
    end;
    frmPrevodAkcie.qrAkcie.SQL.Text:='SELECT * FROM AKCIE WHERE ID IN ('+temp+')';
    frmPrevodAkcie.qrAkcie.Open;
    frmPrevodAkcie.qrAkcionari.Close;
    {
    for i:=1 to frmPrevodAkcie.qrAkcionari.ParamCount-1 do
    begin
      frmPrevodAkcie.qrAkcionari.Params[i].Value:=v;
    end;
    }
    frmPrevodAkcie.qrAkcionari.Params.ParamByName('AKCIONAR').AsInteger:=qrMaster.fieldByName('ID').AsInteger;
    frmPrevodAkcie.qrAkcionari.Open;
    frmPrevodAkcie.edDatum.Text:=DateToStr(Date);
    frmPrevodAkcie.edDoklad.Text:='999999';
    frmPrevodAkcie.edJmeno.Clear;
    frmPrevodAkcie.edPrijmeni.Clear;
    frmPrevodAkcie.edID.Clear;
    frmPrevodAkcie.cbSloucit.Checked:=False;
    frmPrevodAkcie.ShowModal;
  end
  else
    MessageDlg('Musíte označit alespoň jednu akcii.',mtWarning,[mbOK],0);
end;

procedure TfrmAkcionari.miStitkyIClick(Sender: TObject);
var
  qrTemp : TZQuery;
  i : Integer;
  bID1,bID2,bID3 : string;
begin
  inherited;

  qrTemp:=TZQuery.Create(nil);
  qrTemp.ReadOnly:=False;
  qrTemp.Connection:=qrMaster.Connection;
  //qrTemp.Transaction:=qrMaster.Transaction;
  qrTemp.SQL.Text:='SELECT ID FROM AKCIONARI ORDER BY PRIJMENI';
  qrTemp.Open;
  qrTemp.First;

  ExecSql('DELETE HROMADNE_TISKY');

try

  if not Assigned(frmStitkyI) then
    Application.CreateForm(TfrmStitkyI,frmStitkyI);

  i:=0;
  while not(qrTemp.Eof) do
  begin
    qrTemp.Next;
    bID1:=qrTemp.fieldByName('ID').AsString;
    qrTemp.Next;
    if qrTemp.Eof then
      bID2:=''
    else
    begin
      bID2:=qrTemp.fieldByName('ID').AsString;
    end;
    qrTemp.Next;
    if qrTemp.Eof then
      bID3:=''
    else
    begin
      bID3:=qrTemp.fieldByName('ID').AsString;
    end;
    i:=i+1;
    ExecSQL('INSERT INTO HROMADNE_TISKY(SESSIONID,PK1,PK2,PK3,SORT_ORDER) VALUES('+'999999'+','''+bID1+''','''+bID2+''','''+bID3+''','+IntToStr(i)+')');
  end;

  frmStitkyI.qrMaster.Close;
  frmStitkyI.qrMaster.Open;
  frmStitkyI.QuickRep1.Preview.Show;

finally
  qrTemp.Free;
end;

end;

procedure TfrmAkcionari.miStitkyIIClick(Sender: TObject);
var
  qrTemp : TZQuery;
  i : Integer;
  bID1,bID2,bID3 : string;
begin
  inherited;

  qrTemp:=TZQuery.Create(nil);
  qrTemp.ReadOnly:=False;
  qrTemp.Connection:=qrMaster.Connection;
  //qrTemp.Transaction:=qrMaster.Transaction;
  qrTemp.SQL.Text:='SELECT ID FROM AKCIONARI ORDER BY PRIJMENI';
  qrTemp.Open;
  qrTemp.First;

  ExecSql('DELETE HROMADNE_TISKY');

try

  if not Assigned(frmStitkyII) then
    Application.CreateForm(TfrmStitkyII,frmStitkyII);

  i:=0;
  while not(qrTemp.Eof) do
  begin
    qrTemp.Next;
    bID1:=qrTemp.fieldByName('ID').AsString;
    qrTemp.Next;
    if qrTemp.Eof then
      bID2:=''
    else
    begin
      bID2:=qrTemp.fieldByName('ID').AsString;
    end;
    qrTemp.Next;
    if qrTemp.Eof then
      bID3:=''
    else
    begin
      bID3:=qrTemp.fieldByName('ID').AsString;
    end;
    i:=i+1;
    ExecSQL('INSERT INTO HROMADNE_TISKY(SESSIONID,PK1,PK2,PK3,SORT_ORDER) VALUES('+'999999'+','''+bID1+''','''+bID2+''','''+bID3+''','+IntToStr(i)+')');
  end;

  frmStitkyII.qrMaster.Close;
  frmStitkyII.qrMaster.Open;
  frmStitkyII.QuickRep1.Preview.Show;

finally
  qrTemp.Free;
end;

end;

procedure TfrmAkcionari.miHistorieAkcieClick(Sender: TObject);
begin
  inherited;
  if not Assigned(frmHistorie_akcie) then
    Application.CreateForm(TfrmHistorie_akcie,frmHistorie_akcie);

  frmHistorie_akcie.qrMaster.Close;
  frmHistorie_akcie.qrMaster.Params.ParamByName('CISLO').AsInteger:=qrPohyb.fieldByName('CISLO_AKCIE').AsInteger;
  frmHistorie_akcie.qrMaster.Open;
  frmHistorie_akcie.QuickRep1.Preview.Show;
end;

procedure TfrmAkcionari.qrMasterBeforePost(DataSet: TDataSet);
begin
  inherited;
  //qrMaster.FieldByName('ID').AsInteger:=Get_NewID;
end;

procedure TfrmAkcionari.ToolButton6Click(Sender: TObject);
begin
  inherited;
  miPrevod.Click;
end;

procedure TfrmAkcionari.qrMasterAfterScroll(DataSet: TDataSet);
var
  q : TZQuery;
begin
  inherited;
  q:=TZQuery.Create(nil);
try
if not (qrMaster.State in[dsInsert]) then
begin
  q.Connection:=qrMaster.Connection;
  //q.Transaction:=qrMaster.Transaction;
  q.SQL.Text:='SELECT  ''doklad: ''||doklad||'', číslo akcie: ''||cislo_akcie||'', typ: ''||typ||'', ''||text||'' ''||jmeno_prijmeni||'', datum: ''||datum FROM '+
              '( '+
              'SELECT * FROM ( '+
              '  SELECT ID,''převod od akcionáře:'' AS TEXT,DOKLAD,CISLO_AKCIE,TYP,DATUM,JMENO_ODKUD||'' ''||PRIJMENI_ODKUD AS JMENO_PRIJMENI,'+
              '         JMENO_ODKUD AS JMENO,PRIJMENI_ODKUD AS PRIJMENI,ULICE_ODKUD AS ULICE,MESTO_ODKUD AS MESTO,PSC_ODKUD AS PSC,RC_ODKUD AS RC FROM POHYB WHERE ID_AKCIONARE_KAM='+qrMasterID.AsString+
              '    UNION ALL '+
              '  SELECT ID,''převod k akcionáři:'' AS TEXT,DOKLAD,CISLO_AKCIE,TYP,DATUM,JMENO_KAM||'' ''||PRIJMENI_KAM AS JMENO_PRIJMENI,'+
              '         JMENO_KAM AS JMENO,PRIJMENI_KAM AS PRIJMENI,ULICE_KAM AS ULICE,MESTO_KAM AS MESTO,PSC_KAM AS PSC,RC_KAM AS RC FROM POHYB WHERE ID_AKCIONARE_ODKUD='+qrMasterID.AsString+
              '  ) '+
              'ORDER BY ID DESC '+
              ') WHERE ROWNUM=1 ';

{
              'select '+
              ' ''doklad: ''||doklad||'', číslo akcie: ''||cislo_akcie||'', typ: ''||typ||'', ''||text||'' ''||jmeno_prijmeni||'', datum: ''||datum '+
              'from '+
              '(select '+
              '  po.*,decode('+qrMasterID.AsString+',po.id_akcionare_kam,''převod od akcionáře:'',''převod k akcionáři:'') as text, '+
              '  decode('+qrMasterID.AsString+',po.id_akcionare_kam,(select jmeno||'' ''||prijmeni from akcionari where id=po.id_akcionare_odkud),(select jmeno||'' ''||prijmeni from akcionari where id=po.id_akcionare_kam)) as jmeno_prijmeni'+
              ' from '+
              '  pohyb po '+
              ' where id=(select max(id) from '+
              '   ( '+
              '   (select p.id,p.doklad,p.cislo_akcie,p.typ,''převod od akcionáře:''||p.jmeno||'' ''||p.prijmeni as jmeno,p.datum from pohyb p where id_akcionare_kam='+qrMasterID.AsString+' and datum=(select max(datum) from pohyb where id_akcionare_kam='+qrMasterID.AsString+')) '+
              '    union all '+
              '   (select p.id,p.doklad,p.cislo_akcie,p.typ,''převod k akcionáři:''||(select jmeno||'' ''||prijmeni from akcionari where id='+qrMasterID.AsString+') as jmeno,p.datum from pohyb p where id_akcionare_odkud='+qrMasterID.AsString+' and datum=(select max(datum) from pohyb where id_akcionare_odkud='+qrMasterID.AsString+')) '+
              '   ) '+
              ' ) '+
              ')';
}

{
  q.SQL.Text:='select '+
              ' ''doklad: ''||doklad||'', číslo akcie: ''||cislo_akcie||'', typ: ''||typ||'', od akcionáře: ''||jmeno||'' ''||prijmeni||'', datum: ''||datum '+
              'from '+
              '(select '+
              '  * '+
              ' from '+
              '  pohyb '+
              ' where id=(select max(id) from (select * from pohyb where id_akcionare_kam='+qrMasterID.AsString+' and datum=(select max(datum) from pohyb where id_akcionare_kam='+qrMasterID.AsString+'))) '+
              ')';
}

  q.Open;
  lbAkcie.Caption:=q.Fields[0].AsString;
  q.Close;
end;
finally
  q.free;
end;

end;

procedure TfrmAkcionari.miVybratVseClick(Sender: TObject);
begin
  inherited;
  {}
end;

procedure TfrmAkcionari.miSeznamAkcionaruIIClick(Sender: TObject);
begin
  inherited;
  if not Assigned(frmSeznamAkcionaru2) then
    Application.CreateForm(TfrmSeznamAkcionaru2,frmSeznamAkcionaru2);

  frmSeznamAkcionaru2.qrMaster.Close;
  frmSeznamAkcionaru2.qrMaster.Open;
  frmSeznamAkcionaru2.qrFirma.Close;
  frmSeznamAkcionaru2.qrFirma.Open;
  frmSeznamAkcionaru2.QuickRep1.Preview.Show;
end;

procedure TfrmAkcionari.tbOznacitVseClick(Sender: TObject);
begin
  inherited;
  miPrevodAll.Click;
end;

procedure TfrmAkcionari.miPrevodAllClick(Sender: TObject);
var
  i:integer;
  v: variant;
  temp : string;
  table : TDataSet;
begin
  inherited;
  if not(Assigned(frmPrevodAkcie)) then
      Application.CreateForm(TfrmPrevodAkcie,frmPrevodAkcie);

  //if DBGrid1.SelectedRows.Curren) then
  //begin
    frmPrevodAkcie.qrAkcie.Close;
    {
    Table:=DBGrid1.DataSource.Dataset;
    for i:=0 to DBGrid1.SelectedRows.Count-1 do
    begin
      Table.Bookmark:=DBGrid1.SelectedRows[i];
      if i=0 then
        temp:=Table.FieldByName('ID').AsString
      else
        temp:=temp+','+Table.FieldByName('ID').AsString;
    end;
    }
    frmPrevodAkcie.qrAkcie.SQL.Text:='SELECT * FROM AKCIE WHERE CISLO='''+qrMasterID.AsString+'''';
    //frmPrevodAkcie.qrAkcie.ParamByName('ID').AsInteger:=qrPohyb0.fieldByName('ID').AsInteger;
    frmPrevodAkcie.qrAkcie.Open;
    frmPrevodAkcie.qrAkcionari.Close;
    {
    for i:=1 to frmPrevodAkcie.qrAkcionari.ParamCount-1 do
    begin
      frmPrevodAkcie.qrAkcionari.Params[i].Value:=v;
    end;
    }
    frmPrevodAkcie.qrAkcionari.Params.ParamByName('AKCIONAR').AsInteger:=qrMaster.fieldByName('ID').AsInteger;
    frmPrevodAkcie.qrAkcionari.Open;
    frmPrevodAkcie.edDatum.Text:=DateToStr(Date);
    frmPrevodAkcie.edDoklad.Text:='999999';
    frmPrevodAkcie.edJmeno.Clear;
    frmPrevodAkcie.edPrijmeni.Clear;
    frmPrevodAkcie.edID.Clear;
    frmPrevodAkcie.ShowModal;
  //end
  //else
  //  ShowMessage('Musíte označit jednu akcii.');
end;

procedure TfrmAkcionari.DBGrid1TitleClick(Column: TColumn);
begin
  inherited;
  trideni(qrPohyb,Column,FPohybSQL,FPohybSort);
end;

procedure TfrmAkcionari.miSouhrnAkcii2Click(Sender: TObject);
begin
  inherited;
  if not Assigned(frmSouhrnAkcii2) then
    Application.CreateForm(TfrmSouhrnAkcii2,frmSouhrnAkcii2);

  frmSouhrnAkcii2.qrMaster.Close;
  frmSouhrnAkcii2.qrMaster.Open;
  frmSouhrnAkcii2.QuickRep1.Preview.Show;
end;

procedure TfrmAkcionari.miNastaveniDividendyClick(Sender: TObject);
begin
  inherited;
  if not(Assigned(frmParametry)) then
      Application.CreateForm(TfrmParametry,frmParametry);

  frmParametry.ShowModal;
end;

procedure TfrmAkcionari.FormShow(Sender: TObject);
begin
  //Spocti_dividenda(qrMasterID.AsString);
end;

procedure TfrmAkcionari.Spocti_dividenda(_Akcionar : String);
var
  Hodnota_Dividendy,Cista_Dividenda,Hruba_Dividenda,Dan_Dividendy,Procento_Dividendy: Currency;
begin

  if qrMaster.Active then
  begin
    try
      Hodnota_Dividendy:=StrToFloat(ExecSQL_old('SELECT SUM(HODNOTA) AS HODNOTA FROM AKCIE WHERE CISLO='''+_Akcionar+''''));
      Procento_Dividendy:=StrToFloat(Get_param('PROCENTO_DIVIDENDY'));
      Dan_Dividendy:=StrToFloat(Get_param('PROCENTO_DANE_DIVIDENDY'));
      Hruba_Dividenda:=(Hodnota_Dividendy/100)*Procento_Dividendy;
      Cista_Dividenda:=Hruba_Dividenda-((Hruba_Dividenda/100)*Dan_Dividendy);
    except
      Hodnota_Dividendy:=0;
      Procento_Dividendy:=0;
      Dan_Dividendy:=0;
      Hruba_Dividenda:=0;
      Cista_Dividenda:=0;
    end;

    edHodnotaDiv.Text:=FloatToStr(Hodnota_Dividendy);
    edProcentoDiv.Text:=FloatToStr(Procento_Dividendy);
    edHrubaDiv.Text:=FloatToStr(Hruba_Dividenda);
    edDanDiv.Text:=FloatToStr(Dan_Dividendy);
    edCistaDiv.Text:=FloatToStr(Cista_Dividenda);

  end;
end;

procedure TfrmAkcionari.dsMasterDataChange(Sender: TObject; Field: TField);
begin
  inherited;
  //Spocti_dividenda(qrMasterID.AsString);
end;

procedure TfrmAkcionari.miVyplatniListinaClick(Sender: TObject);
begin
  inherited;
  if not Assigned(frmVyplatniListina) then
    Application.CreateForm(TfrmVyplatniListina,frmVyplatniListina);

  frmVyplatniListina.qrMaster.Close;
  frmVyplatniListina.qrMaster.Open;
  frmVyplatniListina.QuickRep1.Preview.Show;
end;

procedure TfrmAkcionari.miVyplatniListina2Click(Sender: TObject);
begin
  inherited;
  if not Assigned(frmVyplatniListina2) then
    Application.CreateForm(TfrmVyplatniListina2,frmVyplatniListina2);

  frmVyplatniListina2.qrMaster.Close;
  frmVyplatniListina2.qrMaster.Open;
  frmVyplatniListina2.QuickRep1.Preview.Show;
end;

procedure TfrmAkcionari.miVyplatniListina3Click(Sender: TObject);
begin
  inherited;
  if not Assigned(frmVyplatniListina3) then
    Application.CreateForm(TfrmVyplatniListina3,frmVyplatniListina3);

  frmVyplatniListina3.qrMaster.Close;
  frmVyplatniListina3.qrMaster.Open;
  frmVyplatniListina3.QuickRep1.Preview.Show;
end;

procedure TfrmAkcionari.DBGridTitleClick(Column: TColumn);
begin
  inherited;
  trideni(qrMaster,Column,FMasterSQL,FMasterSort);
end;

procedure TfrmAkcionari.DBGrid2TitleClick(Column: TColumn);
begin
  inherited;
  trideni(qrSoucty,Column,FSouctySQL,FSouctySort);
end;

procedure TfrmAkcionari.qrPohybAfterDelete(DataSet: TDataSet);
begin
  inherited;
  qrSoucty.Close;
  qrSoucty.Open;
end;

procedure TfrmAkcionari.miSeznamAkcionaruIIIClick(Sender: TObject);
begin
  inherited;
  if not Assigned(frmSeznamAkcionaru3) then
    Application.CreateForm(TfrmSeznamAkcionaru3,frmSeznamAkcionaru3);

  frmSeznamAkcionaru3.qrMaster.Close;
  frmSeznamAkcionaru3.qrMaster.Open;
  frmSeznamAkcionaru3.qrFirma.Close;
  frmSeznamAkcionaru3.qrFirma.Open;
  frmSeznamAkcionaru3.QuickRep1.Preview.Show;
end;

procedure TfrmAkcionari.qrMasterNewRecord(DataSet: TDataSet);
begin
  inherited;
  qrMaster.FieldByName('ID').AsInteger:=Get_NewID;
end;

procedure TfrmAkcionari.qrMasterBeforeEdit(DataSet: TDataSet);
var
  b : TBookmarkStr;
begin
  inherited;
{
  b:=qrMaster.Bookmark;
  qrMaster.DisableControls;
  qrMaster.Close;
  qrMaster.SQL.Text:=FMasterSQL;
  qrMaster.Open;
  qrMaster.Bookmark:=b;
  qrMaster.EnableControls;
}
  //DM.OracleConnection.StartTransaction;
end;

procedure TfrmAkcionari.edFindKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  //najdi(edFind.Text);
end;

procedure TfrmAkcionari.NavigatorBeforeAction(Sender: TObject;
  Button: TNavigateBtn);
begin
  inherited;
  if Button=nbDelete then
    if ExecSql_old('SELECT (SELECT ''1'' AS NASEL FROM AKCIE WHERE CISLO='''+qrMasterID.AsString+''') AS POLE FROM DUAL')='1' then
      begin
        MessageDlg('Nemůžete smazat akcionáře,který vlastní akcie!',mtWarning,[mbOK],0);
        abort;
      end;
end;

procedure TfrmAkcionari.miSoucetAkciiZaTypAllClick(Sender: TObject);
begin
  inherited;
  if not Assigned(frmSSoucetAkciiZaTypAll) then
    Application.CreateForm(TfrmSSoucetAkciiZaTypAll,frmSSoucetAkciiZaTypAll);

  frmSSoucetAkciiZaTypAll.qrMaster.Close;
  frmSSoucetAkciiZaTypAll.qrMaster.Open;
  frmSSoucetAkciiZaTypAll.QuickRep1.Preview.Show;
end;

procedure TfrmAkcionari.miAkcionarVypisClick(Sender: TObject);
begin
  inherited;
  if not(Assigned(frmVypisAkcionare)) then
    Application.CreateForm(TfrmVypisAkcionare,frmVypisAkcionare);
  frmVypisAkcionare.qrMaster.Close;
  frmVypisAkcionare.qrSlave.Close;
  frmVypisAkcionare.qrMaster.Params.ParamByName('ID').AsInteger:=qrMasterID.AsInteger;
  frmVypisAkcionare.qrSlave.Params.ParamByName('ID').AsInteger:=qrMasterID.AsInteger;
  frmVypisAkcionare.qrMaster.Open;
  frmVypisAkcionare.qrSlave.Open;
  frmVypisAkcionare.QuickRep1.Preview.Show;
end;

procedure TfrmAkcionari.miSeznamakcionClick(Sender: TObject);
begin
  inherited;
  if not Assigned(frmSeznamAkcionaru) then
    Application.CreateForm(TfrmSeznamAkcionaru,frmSeznamAkcionaru);

  frmSeznamAkcionaru.qrMaster.Close;
  frmSeznamAkcionaru.qrMaster.Open;
  frmSeznamAkcionaru.qrFirma.Close;
  frmSeznamAkcionaru.qrFirma.Open;
  frmSeznamAkcionaru.QuickRep1.Preview.Show;
end;


initialization
  {$I fakcionari.lrs}

end.

