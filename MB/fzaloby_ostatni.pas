unit FZaloby_ostatni;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  fsablona, db, sqldb, DbCtrls, DBGrids, ComCtrls, StdCtrls, ExtCtrls, Menus,
  utils, blcksock, smtpsend, pop3send, synachar, synautil,
  mimemess, MimePart, ZDataset, ZSqlUpdate, Grids, uProc;

type

  ESMTP = class (Exception);
  EPOP3 = class (Exception);

  { TfrmZalobyOstatni }

  TfrmZalobyOstatni = class(TfrmSablona)
    btEditace: TButton;
    btPrijmoutPostu: TButton;
    Button1: TButton;
    cbDatumy: TComboBox;
    cbExekutor: TDBComboBox;
    cbSkoncenoDuvod: TComboBox;
    DBEdit13: TDBEdit;
    DBEdit18: TDBEdit;
    DBEdit19: TDBEdit;
    DBEdit20: TDBEdit;
    DBEdit21: TDBEdit;
    DBEdit22: TDBEdit;
    DBEdit23: TDBEdit;
    DBEdit24: TDBEdit;
    DBEdit25: TDBEdit;
    DBEdit26: TDBEdit;
    DBEdit27: TDBEdit;
    DBEdit28: TDBEdit;
    DBEdit29: TDBEdit;
    DBEdit30: TDBEdit;
    DBEdit31: TDBEdit;
    DBEdit32: TDBEdit;
    DBEdit33: TDBEdit;
    DBEdit34: TDBEdit;
    DBEdit35: TDBEdit;
    DBEdit36: TDBEdit;
    DBEdit38: TDBEdit;
    DBEdit39: TDBEdit;
    DBEdit40: TDBEdit;
    DBEdit41: TDBEdit;
    DBMemo1: TDBMemo;
    dsZpravy: TDatasource;
    DBEdit1: TDBEdit;
    DBEdit10: TDBEdit;
    DBEdit11: TDBEdit;
    DBEdit12: TDBEdit;
    DBEdit14: TDBEdit;
    DBEdit15: TDBEdit;
    DBEdit16: TDBEdit;
    DBEdit17: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    DBEdit6: TDBEdit;
    DBEdit7: TDBEdit;
    DBEdit8: TDBEdit;
    DBEdit9: TDBEdit;
    DBGrid1: TDBGrid;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    Label36: TLabel;
    Label37: TLabel;
    Label38: TLabel;
    Label39: TLabel;
    Label40: TLabel;
    Label41: TLabel;
    Label43: TLabel;
    Label44: TLabel;
    Label45: TLabel;
    Label46: TLabel;
    Label47: TLabel;
    Label48: TLabel;
    Label49: TLabel;
    Label6: TLabel;
    lbPotvrzeni: TLabel;
    lbOvereni: TLabel;
    lbPlatba: TLabel;
    lbZpracovani: TLabel;
    miImporty: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    miExekuce: TMenuItem;
    miExportSpis: TMenuItem;
    miImportSpis: TMenuItem;
    miPrubeh: TMenuItem;
    miPodaciList3: TMenuItem;
    miVytvoritPrikaz: TMenuItem;
    miExportPredavaciProtokol: TMenuItem;
    miExportPodaciList: TMenuItem;
    miExporty: TMenuItem;
    miKontrolaPrijmu: TMenuItem;
    miVymazatDatumPlatby: TMenuItem;
    miDoplnitDatumPlatby: TMenuItem;
    miBezUdajuPlatby: TMenuItem;
    miBezGuidu: TMenuItem;
    miDoplnitUdaje: TMenuItem;
    miZaplacene: TMenuItem;
    miProPrikaz: TMenuItem;
    miPresunoutZArchivu: TMenuItem;
    MenuItem2: TMenuItem;
    miArchivZalob: TMenuItem;
    miArchivovat: TMenuItem;
    miPodaciList2: TMenuItem;
    miHistorie: TMenuItem;
    miTypyZprav: TMenuItem;
    miCiselniky: TMenuItem;
    NavigatorZpravy: TDBNavigator;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    miPredavaciProtokol: TMenuItem;
    miPodaciList: TMenuItem;
    miPrijmoutPostu: TMenuItem;
    miSmlouva: TMenuItem;
    miSestavy: TMenuItem;
    miOdemknoutDatum: TMenuItem;
    miOdemknout: TMenuItem;
    miOdemknoutVse: TMenuItem;
    miUzamknoutDatum: TMenuItem;
    miUzamknout: TMenuItem;
    miUzavritVse: TMenuItem;
    miImportZalob: TMenuItem;
    miZaloby: TMenuItem;
    OpenDialog: TOpenDialog;
    PageControl1: TPageControl;
    Panel1: TPanel;
    Panel2: TPanel;
    qrDatumyDATUM: TDateField;
    qrMasterCISLO: TLongintField;
    qrMasterDATUM_UHRADY: TDateField;
    qrMasterEXEKUTOR: TStringField;
    qrMasterSKONCENO_DUVOD: TSmallintField;
    qrMasterUSNESENI: TStringField;
    qrMasterVYMOZENO: TFloatField;
    qrMasterZAPLATIL_CASTKA: TFloatField;
    qrMasterZAPLATIL_PRED_PODANIM: TDateField;
    qrMasterZEMREL: TDateField;
    qrZpravyBEZNE_CISLO: TStringField;
    qrZpravyDATUM_ODESLANI: TDateField;
    qrZpravyDATUM_STAZENI: TDateField;
    qrZpravyID: TLongintField;
    qrZpravyID_ZPRAVY: TStringField;
    qrZpravyKE_ZPRACOVANI: TStringField;
    qrZpravyODESILATEL: TStringField;
    qrZpravyPODANI_DORUCENE_DATUM: TStringField;
    qrZpravyPODANI_OVERENO_DATUM: TStringField;
    qrZpravyPODPIS_CERTIF_PLATNY: TStringField;
    qrZpravyPREDMET: TStringField;
    qrZpravyREF_KOD: TStringField;
    qrZpravySOUD: TStringField;
    qrZpravySPISOVA_ZNACKA: TStringField;
    qrZpravyTYP_FORMULARE: TStringField;
    qrZpravyTYP_ZPRAVY: TStringField;
    qrZpravyUCET: TStringField;
    qrZpravyVAR_SYMB: TStringField;
    qrZpravyZASLANYCH_PRILOH: TSmallintField;
    qrZpravyZPUSOB_PODANI: TStringField;
    RadioGroup1: TRadioGroup;
    ToolBar2: TToolBar;
    btRefreshZpravy: TToolButton;
    ToolButton2: TToolButton;
    ToolButton6: TToolButton;
    //ToolButton5: TToolButton;
    tsZpravy: TTabSheet;
    qrImportZprav: TZQuery;
    UpdateImportZprav: TZUpdateSQL;
    //qrMaster: TZQuery;
    //UpdateMaster: TZUpdateSQL;
    qrZpravy: TZQuery;
    UpdateZpravy: TZUpdateSQL;
    qrDatumy: TZReadOnlyQuery;
    ZQuery1CASTKA: TFloatField;
    ZQuery1CISLO_DOMU: TStringField;
    ZQuery1CU_SOUDU: TStringField;
    ZQuery1DATUM_CAS: TDateField;
    ZQuery1DATUM_IMPORTU: TDateField;
    ZQuery1DATUM_UZAMCENI: TDateField;
    ZQuery1DLUZNA_CASTKA: TFloatField;
    ZQuery1ID: TLongintField;
    ZQuery1JEDNANI: TDateField;
    ZQuery1JIZDNE: TFloatField;
    ZQuery1JMENO_CP: TStringField;
    ZQuery1MESTO: TStringField;
    ZQuery1NAROK: TFloatField;
    ZQuery1NAVRH: TDateField;
    ZQuery1OBVOD: TStringField;
    ZQuery1ODVOLANI: TDateField;
    ZQuery1PL_PRIKAZ: TDateField;
    ZQuery1POKUTA: TFloatField;
    ZQuery1PRIKAZ: TDateField;
    ZQuery1PR_MOC: TDateField;
    ZQuery1PSC: TStringField;
    ZQuery1REF_KOD: TStringField;
    ZQuery1RODNE_CISLO: TStringField;
    ZQuery1ROZSUDEK: TDateField;
    ZQuery1SKONCENO: TDateField;
    ZQuery1SOUD: TStringField;
    ZQuery1SPIS_ZNACKA: TStringField;
    ZQuery1SPLATNOST: TDateField;
    ZQuery1UHRADA: TFloatField;
    ZQuery1UHR_SOP: TDateField;
    ZQuery1ULICE: TStringField;
    ZQuery1UZAMCENA: TSmallintField;
    ZQuery1VAR_SYMB: TStringField;
    ZQuery1VS_SOUDU: TStringField;
    ZQuery1ZALOBA: TDateField;
    procedure btEditaceClick(Sender: TObject);
    procedure btPrijmoutPostuClick(Sender: TObject);
    procedure btRefreshClick(Sender: TObject);
    procedure btRefreshZpravyClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure cbDatumyChange(Sender: TObject);
    procedure cbSkoncenoDuvodChange(Sender: TObject);
    procedure DBEdit5Change(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure DBGrid1PrepareCanvas(sender: TObject; DataCol: Integer;
      Column: TColumn; AState: TGridDrawState);
    procedure DBGridDblClick(Sender: TObject);
    procedure DBGridDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure DBGridEnter(Sender: TObject);
    procedure DBGridPrepareCanvas(sender: TObject; DataCol: Integer;
      Column: TColumn; AState: TGridDrawState);
    procedure DBGridTitleClick(Column: TColumn);
    procedure dsMasterDataChange(Sender: TObject; Field: TField);
    procedure edFindKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
    procedure MenuItem5Click(Sender: TObject);
    procedure miExekuceClick(Sender: TObject);
    procedure miExportSpisClick(Sender: TObject);
    procedure miImportSpisClick(Sender: TObject);
    procedure miKontrolaPrijmuClick(Sender: TObject);
    procedure miPodaciList3Click(Sender: TObject);
    procedure miArchivovatClick(Sender: TObject);
    procedure miArchivZalobClick(Sender: TObject);
    procedure miBezGuiduClick(Sender: TObject);
    procedure miBezUdajuPlatbyClick(Sender: TObject);
    procedure miDoplnitDatumPlatbyClick(Sender: TObject);
    procedure miDoplnitUdajeClick(Sender: TObject);
    procedure miExportPodaciListClick(Sender: TObject);
    procedure miExportPredavaciProtokolClick(Sender: TObject);
    procedure miHistorieClick(Sender: TObject);
    procedure miImportZalobClick(Sender: TObject);
    procedure miPrubehClick(Sender: TObject);
    procedure miVymazatDatumPlatbyClick(Sender: TObject);
    procedure miVytvoritPrikazClick(Sender: TObject);
    procedure miZaplaceneClick(Sender: TObject);
    procedure miNovyZaznamClick(Sender: TObject);
    procedure miOdemknoutClick(Sender: TObject);
    procedure miOdemknoutDatumClick(Sender: TObject);
    procedure miOdemknoutVseClick(Sender: TObject);
    procedure miPodaciList2Click(Sender: TObject);
    procedure miPodaciListClick(Sender: TObject);
    procedure miPredavaciProtokolClick(Sender: TObject);
    procedure miPresunoutZArchivuClick(Sender: TObject);
    procedure miPrijmoutPostuClick(Sender: TObject);
    procedure miProPrikazClick(Sender: TObject);
    procedure miSmazatZaznamClick(Sender: TObject);
    procedure miSmlouvaClick(Sender: TObject);
    procedure miTypyZpravClick(Sender: TObject);
    procedure miUpravitZaznamClick(Sender: TObject);
    procedure miUzamknoutClick(Sender: TObject);
    procedure miUzamknoutDatumClick(Sender: TObject);
    procedure miUzavritVseClick(Sender: TObject);
    procedure miVychoziDotazClick(Sender: TObject);
    procedure miZavritClick(Sender: TObject);
    procedure miZrusOznaceniClick(Sender: TObject);
    procedure NavigatorBeforeAction(Sender: TObject; Button: TDBNavButtonType);
    procedure NavigatorClick(Sender: TObject; Button: TDBNavButtonType);
    procedure Panel1Click(Sender: TObject);
    procedure pcMainPageChanged(Sender: TObject);
    procedure qrMasterAfterApplyUpdates(Sender: TObject);
    procedure qrMasterAfterPost(DataSet: TDataSet);
    procedure qrMasterBeforeEdit(DataSet: TDataSet);
    procedure qrMasterBeforeInsert(DataSet: TDataSet);
    procedure qrMasterAfterOpen(DataSet: TDataSet);
    procedure qrMasterAfterScroll(DataSet: TDataSet);
    procedure qrMasterBeforePost(DataSet: TDataSet);
    procedure qrMasterNewRecord(DataSet: TDataSet);
    procedure qrZpravyAfterApplyUpdates(Sender: TObject);
    procedure qrZpravyAfterPost(DataSet: TDataSet);
    procedure RadioGroup1Click(Sender: TObject);
    procedure ToolButton10Click(Sender: TObject);
    procedure ToolButton3Click(Sender: TObject);
    procedure UpdateMasterBeforeInsertSQL(Sender: TObject);
    procedure UpdateMasterBeforeInsertSQLStatement(const Sender: TObject;
      StatementIndex: Integer; out Execute: Boolean);
    procedure UpdateMasterBeforeModifySQLStatement(const Sender: TObject;
      StatementIndex: Integer; out Execute: Boolean);
    procedure ZQuery1REF_KODChange(Sender: TField);
  private
    aValue : String;
    FMasterSQL : String;
    FMasterSQL_filter : String;
    FMasterSort : Integer;
    procedure prijmout_postu_ssl;
    procedure info_zpravy;
    procedure otevri_zpravy;
    procedure nastav_datumy;
    procedure initZobrazit;
  public
    { public declarations }
    //FActiveDBGrid : TDBGrid;
  end; 

var
  frmZalobyOstatni: TfrmZalobyOstatni;

implementation

{ TfrmZalobyOstatni }

uses DOznameniPostupiteleOPostoupeniPohledavky,DDatum,FSOPOPPPodaciList,
     FSopopppredavaciprotokol,DProces,FZalobyHistorie,DPOP3Pripojeni,FZalobyTypyZprav,
     DZpravyDetail,SSOPOPPPodaciList2,SProc,fzalobyarchiv,SOznameniPostupiteleOPostoupeniPohledavky,
     FSNezaplacene,FSKzaplaceni,fszaplacene,fsbez_guidu,fsbezudajuplatby,
     ssopopppodacilist3,dPoznamkaUsneseni,SOPOPP2,SExekuce,SOPOPP3;

procedure TfrmZalobyOstatni.btRefreshClick(Sender: TObject);
var
  b: TBookMarkStr;
begin
  inherited;
  //Refresh_DataSet(Navigator.DataSource.DataSet,qrMaster2);
  //Refresh_DataSet(Navigator.DataSource.DataSet,qrNeuzamcene);
  nastav_datumy;
end;

procedure TfrmZalobyOstatni.btRefreshZpravyClick(Sender: TObject);
begin
  Refresh_DataSet(NavigatorZpravy.DataSource.DataSet,qrZpravy);
end;

procedure TfrmZalobyOstatni.Button1Click(Sender: TObject);
begin
  if not Assigned(frmPoznamkaUsneseni) then
      Application.CreateForm(TfrmPoznamkaUsneseni,frmPoznamkaUsneseni);
  frmPoznamkaUsneseni.dsUsneseni.DataSet:=qrMaster;
  frmPoznamkaUsneseni.DBMemo1.DataField:='USNESENI';
  frmPoznamkaUsneseni.ShowModal;
end;

procedure TfrmZalobyOstatni.cbDatumyChange(Sender: TObject);
var
  sql_puv,sql,aWhere,aSelect,aOrder,aDatum,aFrom: String;
  delka_datum : Integer;
begin
{  sql_puv:=qrMaster.SQL.Text;
  sql:=qrMaster.SQL.Text;
  if pos('ORDER',UpperCase(sql))>0 then
    aOrder:=copy(sql,pos('ORDER',UpperCase(sql)),length(sql)-pos('ORDER',UpperCase(sql)));
  if pos('WHERE',UpperCase(sql))>0 then
    if length(aOrder)>0 then
      aWhere:=copy(sql,pos('WHERE',UpperCase(sql)),pos('ORDER',copy(sql,pos('WHERE',UpperCase(sql)),length(sql)-pos('WHERE',UpperCase(sql))))-1)
    else
      aWhere:=copy(sql,pos('WHERE',UpperCase(sql)),length(sql)-pos('WHERE',UpperCase(sql)));
  if pos('FROM',UpperCase(sql))>0 then
    aSelect:=copy(sql,1,pos('FROM',UpperCase(sql))-1)
  else
    aSelect:='SELECT NULL AS ERROR';
  if length(aWhere)>0 then
  begin
    aFrom:=copy(sql,pos('FROM',UpperCase(sql)),pos('WHERE',UpperCase(sql))-1-length(aSelect));
  end
  else
    if length(aOrder)>0 then
      aFrom:=copy(sql,pos('FROM',UpperCase(sql)),pos('ORDER',UpperCase(sql))-1-length(aSelect))
    else
      aFrom:=copy(sql,pos('FROM',UpperCase(sql)),length(sql)-pos('FROM',UpperCase(sql)));

  // -- doplneni datumu
  if (pos('DATUM_IMPORTU',UpperCase(aWhere))>0) and (cbDatumy.Text<>'Všechny') then
  begin
    delka_datum:=pos('AND',UpperCase(copy(aWhere,pos('DATUM_IMPORTU',UpperCase(aWhere)),length(aWhere)-pos('DATUM_IMPORTU',UpperCase(aWhere)))));
    if delka_datum>0 then
      aDatum:=trim(copy(aWhere,pos('DATUM_IMPORTU',UpperCase(aWhere)),delka_datum-1));
    if length(aDatum)=0 then
    begin
      delka_datum:=pos('ORDER',UpperCase(aWhere));
      if delka_datum>0 then
        aDatum:=trim(copy(aWhere,pos('DATUM_IMPORTU',UpperCase(aWhere)),delka_datum-1));
    end;
    if length(aDatum)=0 then
      aDatum:=copy(aWhere,pos('DATUM_IMPORTU',aWhere),length(aWhere)-pos('DATUM_IMPORTU',aWhere));
  end;
  if (length(aDatum)>0) then
    if cbDatumy.Text<>'' then
      aWhere:=Replace_string(aWhere,aDatum,'DATUM_IMPORTU=TO_DATE('''+cbDatumy.Text+''') ')
  else
    if cbDatumy.Text<>'' then
      if length(aWhere)>0 then
        aWhere:=aWhere+' AND DATUM_IMPORTU=TO_DATE('''+cbDatumy.Text+''')'
      else
        aWhere:=aWhere+'WHERE DATUM_IMPORTU=TO_DATE('''+cbDatumy.Text+''')';

  if cbDatumy.Text<>'' then
  begin
    sql:=Trim(aSelect)+' '+aFrom+' '+Trim(aWhere)+' '+Trim(aOrder);
    qrMaster.Close;
    qrMaster.SQL.Text:=sql;
    qrMaster.Open;
    //ShowMessage(aSelect);
    //ShowMessage(aWhere);
    //ShowMessage(aOrder);
    //ShowMessage(aFrom);
    //ShowMessage(sql);
  end;}

    qrMaster.Close;
    if cbDatumy.ItemIndex=0 then
      qrMaster.ParamByName('DATUM_IMPORTU').AsString:=''
    else
      qrMaster.ParamByName('DATUM_IMPORTU').AsDate:=StrToDate(cbDatumy.text);
    qrMaster.Open;

end;

procedure TfrmZalobyOstatni.cbSkoncenoDuvodChange(Sender: TObject);
begin
  if (qrMaster.Active) then
    if (cbSkoncenoDuvod.ItemIndex > 0) then
    begin
      qrMaster.Edit;
      qrMasterSKONCENO_DUVOD.AsInteger:=cbSkoncenoDuvod.ItemIndex;
    end
   else
   begin
     qrMaster.Edit;
     qrMasterSKONCENO_DUVOD.Clear;
   end;
end;

procedure TfrmZalobyOstatni.DBEdit5Change(Sender: TObject);
begin

end;

procedure TfrmZalobyOstatni.DBGrid1DblClick(Sender: TObject);
begin
  if not Assigned(frmZpravyDetail) then
    Application.CreateForm(TfrmZpravyDetail,frmZpravyDetail);
  frmZpravyDetail.dsDetail.DataSet:=qrZpravy;
  frmZpravyDetail.ShowModal;
end;

procedure TfrmZalobyOstatni.DBGrid1PrepareCanvas(sender: TObject; DataCol: Integer;
  Column: TColumn; AState: TGridDrawState);
begin

  if qrZpravy.FieldByName('TYP_ZPRAVY').AsString='5' then
  begin
    if TDBGrid(Sender).Canvas.Brush.Color<>TDBGrid(Sender).SelectedColor then
      TDBGrid(Sender).Canvas.Brush.Color:=clRed;
  end;
end;

procedure TfrmZalobyOstatni.nastav_datumy;
var
  s: string;
  i : Integer;
begin
  i:=0;
  s:=cbDatumy.Text;
  cbDatumy.Clear;
  cbDatumy.Items.Append('Všechny');
  qrDatumy.Close;
  qrDatumy.Open;
  qrDatumy.First;
  while not qrDatumy.EOF do
  begin
    cbDatumy.Items.Append(qrDatumy.FieldByName('DATUM').AsString);
    qrDatumy.Next;
  end;
  if length(s)>0 then
    i:=cbDatumy.Items.IndexOf(s);
  cbDatumy.ItemIndex:=i;
  qrDatumy.Close;
end;

procedure TfrmZalobyOstatni.btEditaceClick(Sender: TObject);
var
  sql_text,aID: string;
begin
  //try
    if qrMaster.ReadOnly then
    begin
      sql_text:=qrMaster.SQL.Text;
      aID:=qrMaster.FieldByName('ID').AsString;
      qrMaster.Close;
      qrMaster.SQL.Text:='SELECT * FROM ZALOBY_OSTATNI WHERE ID = '+aID;
      qrMaster.ReadOnly:=false;
      qrMaster.Open;
      qrMaster.Edit;
      if pcMain.TabIndex=0 then
        pcMain.TabIndex:=1;
    end;
  {except
    qrMaster.Close;
    qrMaster.SQL.Text:=sql_text;
    qrMaster.Open;
  end;}
end;

procedure TfrmZalobyOstatni.btPrijmoutPostuClick(Sender: TObject);
begin
  miPrijmoutPostu.Click;
end;

procedure TfrmZalobyOstatni.DBGridDblClick(Sender: TObject);
begin
  inherited;
end;

procedure TfrmZalobyOstatni.DBGridDrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  {if qrMaster.FieldByName('UZAMCENA').AsInteger=1 then
  begin
    DBGrid.Canvas.Brush.Color:=clGreen;
    DBGrid.Canvas.Font.Color:=clGreen;
  end
  else
  begin
    DBGrid.Canvas.Brush.Color:=clRed;
    DBGrid.Canvas.Font.Color:=clRed;
  end;
  DBGrid.DefaultDrawColumnCell(Rect,DataCol,Column,State);}
end;

procedure TfrmZalobyOstatni.DBGridEnter(Sender: TObject);
begin
  //FActiveDBGrid:=TDBGrid(Sender);
end;

procedure TfrmZalobyOstatni.DBGridPrepareCanvas(sender: TObject; DataCol: Integer;
  Column: TColumn; AState: TGridDrawState);
begin
  if qrMaster.FieldByName('UZAMCENA').AsInteger=1 then
  begin
    if TDBGrid(Sender).Canvas.Brush.Color<>TDBGrid(Sender).SelectedColor then
      TDBGrid(Sender).Canvas.Brush.Color:=$0087F5B4;
  end
  else
    if (TDBGrid(Sender).Canvas.Brush.Color<>TDBGrid(Sender).SelectedColor)
      and not (qrMaster.IsEmpty)
    then
      TDBGrid(Sender).Canvas.Brush.Color:=$00ADF8F5;

  if qrMaster.FieldByName('PR_MOC').IsNull then
  begin
    if TDBGrid(Sender).Canvas.Brush.Color<>TDBGrid(Sender).SelectedColor then
      TDBGrid(Sender).Canvas.Brush.Color:=$00A99FFB;
  end;

  if not qrMaster.FieldByName('EXEKUTOR').IsNull then
  begin
    if TDBGrid(Sender).Canvas.Brush.Color<>TDBGrid(Sender).SelectedColor then
      if qrMaster.FieldByName('EXEKUTOR').AsString = 'BAYER' then
      begin
        TDBGrid(Sender).Canvas.Brush.Color:=$00EFA5F1;
      end
      else
        if qrMaster.FieldByName('EXEKUTOR').AsString = 'TUNKL' then
        begin
          TDBGrid(Sender).Canvas.Brush.Color:=$0079ECAA;
        end
        else
          if qrMaster.FieldByName('EXEKUTOR').AsString = 'HANAK' then
          begin
            TDBGrid(Sender).Canvas.Brush.Color:=$00CDA7B4;
          end;
  end
  else
  begin
    //cbExekutor.Color:=clDefault;
  end;

  if not qrMaster.FieldByName('SKONCENO_DUVOD').IsNull then
  begin
    if TDBGrid(Sender).Canvas.Brush.Color<>TDBGrid(Sender).SelectedColor then
      TDBGrid(Sender).Canvas.Brush.Color:=$00FEB7A5;
  end;
end;

procedure TfrmZalobyOstatni.DBGridTitleClick(Column: TColumn);
begin
  inherited;
  trideni(qrMaster,Column,qrMaster.SQL.Text,FMasterSort); //FMasterSQL
  //ShowMessage(qrMaster.SQL.Text);
end;

procedure TfrmZalobyOstatni.dsMasterDataChange(Sender: TObject; Field: TField);
begin
  inherited;
  info_zpravy;
  btEditace.Visible:=qrMaster.ReadOnly;
  if qrMaster.FieldByName('EXEKUTOR').AsString = 'BAYER' then
  begin
    cbExekutor.Color:=$00EFA5F1;
  end
  else
    if qrMaster.FieldByName('EXEKUTOR').AsString = 'TUNKL' then
    begin
      cbExekutor.Color:=$0079ECAA;
    end
    else
      cbExekutor.Color:=clDefault;

  if (not qrMaster.FieldByName('SKONCENO_DUVOD').IsNull) or (qrMaster.FieldByName('SKONCENO_DUVOD').AsInteger<>0) then
    cbSkoncenoDuvod.Color:=$00FEB7A5
  else
    cbSkoncenoDuvod.Color:=clDefault;

  if not qrMaster.FieldByName('PR_MOC').IsNull then
    DBEdit31.Color:=$00A99FFB
  else
    DBEdit31.Color:=clDefault;

  try
    if not (qrMaster.State in [dsInsert,dsEdit]) then
      cbSkoncenoDuvod.ItemIndex:=qrMasterSKONCENO_DUVOD.AsInteger;
  except
    cbSkoncenoDuvod.ItemIndex:=0;
  end;
end;

procedure TfrmZalobyOstatni.edFindKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
end;

procedure TfrmZalobyOstatni.FormActivate(Sender: TObject);
begin
  inherited;
end;

procedure TfrmZalobyOstatni.FormCreate(Sender: TObject);
begin
  inherited;
  //FActiveDBGrid:=TDBGrid.Create(nil);
  FMasterSQL:=qrMaster.SQL.Text;
  //qrImportZprav.Open;
  qrZpravy.Open;
  nastav_datumy;
  //RadioGroup1Click(nil);
  //ZQuery1.Open;
  initComboExekutor(cbExekutor);
  initZobrazit;
end;

procedure TfrmZalobyOstatni.FormDestroy(Sender: TObject);
begin
  //if Assigned(FActiveDBGrid) then
  //  FActiveDBGrid.free;
end;

procedure TfrmZalobyOstatni.MenuItem3Click(Sender: TObject);
var
  qrTemp : TSQLQuery;
  i : Integer;
  bID1,bID2,bID3,sql_text,temp : string;
  table : TDataSet;
begin
  inherited;

  if not Assigned(frmTiskZalob) then
    Application.CreateForm(TfrmTiskZalob,frmTiskZalob);

frmTiskZalob.FSelRows:=DBGrid.SelectedRows.Count;
frmTiskZalob.ShowModal;
if frmTiskZalob.ModalResult=mrOK then
begin
try

  if not Assigned(frmSOPOPP2) then
    Application.CreateForm(TfrmSOPOPP2,frmSOPOPP2);

  if frmTiskZalob.rbOznacene.Checked then
  begin
    if DBGrid.SelectedRows.CurrentRowSelected then
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
  end;

  //-- podminky tisku ---
  if frmTiskZalob.rbVse.Checked then
    sql_text:='SELECT '+
              '  ROWNUM AS RADEK,'+
              '  Z.*,'+
              '  L.KONTAKTNI_OSOBA||''/''||L.KONTAKTNI_OSOBA_TEL AS KONTAKTNI_OSOBA,'+
              '  L.UCET,'+
              '  L.KOD_BANKY,'+
              '  GET_PARAM(''ZALOBY_DATUM_PREDANI'') AS DATUM_PREDANI,'+
              '  ''ERP ''||Z.VAR_SYMB||'' - FEN'' AS VAR_SYMB_ERP,'+
              '  Z.ULICE||'' ''||Z.CISLO_DOMU AS ULICE_CP, '+
              '  Z.PSC||'' ''||Z.MESTO AS PSC_MESTO, '+
              '  Z.JMENO_CP||'', nar. ''||GET_DATUM_FROM_RC(Z.RODNE_CISLO) AS JMENO_NAR, '+
              '  CASE GET_POHLAVI_Z_RC(Z.RODNE_CISLO) '+
              '    WHEN 1 THEN ''Vážený pan'' '+
              '    WHEN 0 THEN ''Vážená paní'' '+
              '    WHEN NULL THEN ''Vážený pan/paní'' '+
              '  END AS OSLOVENI, '+
              '  GET_PARAM(''ZALOBY_OZNAMENI_UCET'') AS UCET_OZNAMENI '+
              'FROM '+
              '  ZALOBY_OSTATNI Z,'+
              '  LICENCE L '+
              'WHERE '+
              ' NVL(UZAMCENA,0)=0 '+
              'ORDER BY '+
              '  Z.VAR_SYMB';

  if frmTiskZalob.rbOznacene.Checked then
  begin
    if temp='' then temp:='0';
    sql_text:='SELECT '+
              '  ROWNUM AS RADEK,'+
              '  Z.*,'+
              '  L.KONTAKTNI_OSOBA||''/''||L.KONTAKTNI_OSOBA_TEL AS KONTAKTNI_OSOBA,'+
              '  L.UCET,'+
              '  L.KOD_BANKY,'+
              '  GET_PARAM(''ZALOBY_DATUM_PREDANI'') AS DATUM_PREDANI,'+
              '  ''ERP ''||Z.VAR_SYMB||'' - FEN'' AS VAR_SYMB_ERP,'+
              '  Z.ULICE||'' ''||Z.CISLO_DOMU AS ULICE_CP, '+
              '  Z.PSC||'' ''||Z.MESTO AS PSC_MESTO, '+
              '  Z.JMENO_CP||'', nar. ''||GET_DATUM_FROM_RC(Z.RODNE_CISLO) AS JMENO_NAR, '+
              '  CASE GET_POHLAVI_Z_RC(Z.RODNE_CISLO) '+
              '    WHEN 1 THEN ''Vážený pan'' '+
              '    WHEN 0 THEN ''Vážená paní'' '+
              '    WHEN NULL THEN ''Vážený pan/paní'' '+
              '  END AS OSLOVENI, '+
              '  GET_PARAM(''ZALOBY_OZNAMENI_UCET'') AS UCET_OZNAMENI '+
              'FROM '+
              '  ZALOBY_OSTATNI Z,'+
              '  LICENCE L '+
              'WHERE '+
              ' ID IN ('+temp+') '+
              'ORDER BY '+
              '  Z.VAR_SYMB';
  end;
  if frmTiskZalob.rbDatum.Checked then
    sql_text:='SELECT '+
              '  ROWNUM AS RADEK,'+
              '  Z.*,'+
              '  L.KONTAKTNI_OSOBA||''/''||L.KONTAKTNI_OSOBA_TEL AS KONTAKTNI_OSOBA,'+
              '  L.UCET,'+
              '  L.KOD_BANKY,'+
              '  GET_PARAM(''ZALOBY_DATUM_PREDANI'') AS DATUM_PREDANI,'+
              '  ''ERP ''||Z.VAR_SYMB||'' - FEN'' AS VAR_SYMB_ERP,'+
              '  Z.ULICE||'' ''||Z.CISLO_DOMU AS ULICE_CP, '+
              '  Z.PSC||'' ''||Z.MESTO AS PSC_MESTO, '+
              '  Z.JMENO_CP||'', nar. ''||GET_DATUM_FROM_RC(Z.RODNE_CISLO) AS JMENO_NAR, '+
              '  CASE GET_POHLAVI_Z_RC(Z.RODNE_CISLO) '+
              '    WHEN 1 THEN ''Vážený pan'' '+
              '    WHEN 0 THEN ''Vážená paní'' '+
              '    WHEN NULL THEN ''Vážený pan/paní'' '+
              '  END AS OSLOVENI, '+
              '  GET_PARAM(''ZALOBY_OZNAMENI_UCET'') AS UCET_OZNAMENI '+
              'FROM '+
              '  ZALOBY_OSTATNI Z,'+
              '  LICENCE L '+
              'WHERE '+
              '  NVL(Z.UZAMCENA,0)=0'+
              '  AND Z.DATUM_IMPORTU=TO_DATE('+Q(frmTiskZalob.edDatumImportu.Text)+',''DD.MM.YYYY'') '+
              'ORDER BY '+
              '  Z.VAR_SYMB';
  //---------------------

  {qrTemp.SQL.Text:=sql_text;
  qrTemp.Open;
  qrTemp.First;
  i:=0;
  while not(qrTemp.Eof) do
  begin
    qrTemp.Next;
    bID1:=qrTemp.fieldByName('ID').AsString;
    qrTemp.Next;
    i:=i+1;
    ExecSQL('INSERT INTO HROMADNE_TISKY(SESSIONID,PK1,PK2,PK3,SORT_ORDER) VALUES('+'999999'+','''+bID1+''','''+bID2+''','''+bID3+''','+IntToStr(i)+')');
  end;}

  //ShowMessage(sql_text);

  Close;
  //ShowMessage(sql_text);
  frmSOPOPP2.qrMaster.Close;
  frmSOPOPP2.qrMaster.SQL.Text:=sql_text;
  frmSOPOPP2.qrMaster.Open;
  frmSOPOPP2.frReport.LoadFromFile(Replace_Char(get_param('SESTAVY')+'\','\\','\')+'OPOPP2.lrf');
  frmSOPOPP2.frReport.PrepareReport;
  frmSOPOPP2.frReport.ModalPreview:=true;
  frmSOPOPP2.frReport.ShowProgress:=true;
  frmSOPOPP2.frReport.ShowReport;
  frmSOPOPP2.qrMaster.Close;

finally
end;
end;
end;

procedure TfrmZalobyOstatni.MenuItem4Click(Sender: TObject);
var
  qrTemp : TSQLQuery;
  i : Integer;
  bID1,bID2,bID3,sql_text,temp : string;
  table : TDataSet;
begin
  inherited;

  if not Assigned(frmTiskZalob) then
    Application.CreateForm(TfrmTiskZalob,frmTiskZalob);

frmTiskZalob.FSelRows:=DBGrid.SelectedRows.Count;
frmTiskZalob.ShowModal;
if frmTiskZalob.ModalResult=mrOK then
begin
try

  if not Assigned(frmSOPOPP3) then
    Application.CreateForm(TfrmSOPOPP3,frmSOPOPP3);

  if frmTiskZalob.rbOznacene.Checked then
  begin
    if DBGrid.SelectedRows.CurrentRowSelected then
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
  end;

  //-- podminky tisku ---
  if frmTiskZalob.rbVse.Checked then
    sql_text:='SELECT '+
              '  ROWNUM AS RADEK,'+
              '  Z.*,'+
              '  TO_CHAR(SYSDATE,''DD.MM.YYYY'') AS AKTUALNI_DATUM,'+
              '  TO_CHAR(SPLATNOST,''DD.MM.YYYY'') AS SPLATNOST_DATUM,'+
              '  TO_CHAR(PL_PRIKAZ,''DD.MM.YYYY'') AS PL_PRIKAZ_DATUM,'+
              '  TO_CHAR(PL_PRIKAZ+1,''DD.MM.YYYY'') AS PL_PRIKAZ_PLUS_DEN,'+
              '  TO_CHAR(PR_MOC,''DD.MM.YYYY'') AS PR_MOC_DATUM,'+
              '  L.KONTAKTNI_OSOBA||''/''||L.KONTAKTNI_OSOBA_TEL AS KONTAKTNI_OSOBA,'+
              '  L.UCET,'+
              '  L.KOD_BANKY,'+
              '  GET_PARAM(''ZALOBY_DATUM_PREDANI'') AS DATUM_PREDANI,'+
              '  ''ERP ''||Z.VAR_SYMB||'' - FEN'' AS VAR_SYMB_ERP,'+
              '  Z.ULICE||'' ''||Z.CISLO_DOMU AS ULICE_CP, '+
              '  Z.PSC||'' ''||Z.MESTO AS PSC_MESTO, '+
              '  Z.JMENO_CP||'', nar. ''||GET_DATUM_FROM_RC(Z.RODNE_CISLO) AS JMENO_NAR, '+
              '  CASE GET_POHLAVI_Z_RC(Z.RODNE_CISLO) '+
              '    WHEN 1 THEN ''Vážený pan'' '+
              '    WHEN 0 THEN ''Vážená paní'' '+
              '    WHEN NULL THEN ''Vážený pan/paní'' '+
              '  END AS OSLOVENI, '+
              '  GET_PARAM(''ZALOBY_OZNAMENI_UCET'') AS UCET_OZNAMENI '+
              'FROM '+
              '  ZALOBY_OSTATNI Z,'+
              '  LICENCE L '+
              'WHERE '+
              ' NVL(UZAMCENA,0)=0 '+
              'ORDER BY '+
              '  Z.VAR_SYMB';

  if frmTiskZalob.rbOznacene.Checked then
  begin
    if temp='' then temp:='0';
    sql_text:='SELECT '+
              '  ROWNUM AS RADEK,'+
              '  Z.*,'+
              '  TO_CHAR(SYSDATE,''DD.MM.YYYY'') AS AKTUALNI_DATUM,'+
              '  TO_CHAR(SPLATNOST,''DD.MM.YYYY'') AS SPLATNOST_DATUM,'+
              '  TO_CHAR(PL_PRIKAZ,''DD.MM.YYYY'') AS PL_PRIKAZ_DATUM,'+
              '  TO_CHAR(PL_PRIKAZ+1,''DD.MM.YYYY'') AS PL_PRIKAZ_PLUS_DEN,'+
              '  TO_CHAR(PR_MOC,''DD.MM.YYYY'') AS PR_MOC_DATUM,'+
              '  L.KONTAKTNI_OSOBA||''/''||L.KONTAKTNI_OSOBA_TEL AS KONTAKTNI_OSOBA,'+
              '  L.UCET,'+
              '  L.KOD_BANKY,'+
              '  GET_PARAM(''ZALOBY_DATUM_PREDANI'') AS DATUM_PREDANI,'+
              '  ''ERP ''||Z.VAR_SYMB||'' - FEN'' AS VAR_SYMB_ERP,'+
              '  Z.ULICE||'' ''||Z.CISLO_DOMU AS ULICE_CP, '+
              '  Z.PSC||'' ''||Z.MESTO AS PSC_MESTO, '+
              '  Z.JMENO_CP||'', nar. ''||GET_DATUM_FROM_RC(Z.RODNE_CISLO) AS JMENO_NAR, '+
              '  CASE GET_POHLAVI_Z_RC(Z.RODNE_CISLO) '+
              '    WHEN 1 THEN ''Vážený pan'' '+
              '    WHEN 0 THEN ''Vážená paní'' '+
              '    WHEN NULL THEN ''Vážený pan/paní'' '+
              '  END AS OSLOVENI, '+
              '  GET_PARAM(''ZALOBY_OZNAMENI_UCET'') AS UCET_OZNAMENI '+
              'FROM '+
              '  ZALOBY_OSTATNI Z,'+
              '  LICENCE L '+
              'WHERE '+
              ' ID IN ('+temp+') '+
              'ORDER BY '+
              '  Z.VAR_SYMB';
  end;
  if frmTiskZalob.rbDatum.Checked then
    sql_text:='SELECT '+
              '  ROWNUM AS RADEK,'+
              '  Z.*,'+
              '  TO_CHAR(SYSDATE,''DD.MM.YYYY'') AS AKTUALNI_DATUM,'+
              '  TO_CHAR(SPLATNOST,''DD.MM.YYYY'') AS SPLATNOST_DATUM,'+
              '  TO_CHAR(PL_PRIKAZ,''DD.MM.YYYY'') AS PL_PRIKAZ_DATUM,'+
              '  TO_CHAR(PL_PRIKAZ+1,''DD.MM.YYYY'') AS PL_PRIKAZ_PLUS_DEN,'+
              '  TO_CHAR(PR_MOC,''DD.MM.YYYY'') AS PR_MOC_DATUM,'+
              '  L.KONTAKTNI_OSOBA||''/''||L.KONTAKTNI_OSOBA_TEL AS KONTAKTNI_OSOBA,'+
              '  L.UCET,'+
              '  L.KOD_BANKY,'+
              '  GET_PARAM(''ZALOBY_DATUM_PREDANI'') AS DATUM_PREDANI,'+
              '  ''ERP ''||Z.VAR_SYMB||'' - FEN'' AS VAR_SYMB_ERP,'+
              '  Z.ULICE||'' ''||Z.CISLO_DOMU AS ULICE_CP, '+
              '  Z.PSC||'' ''||Z.MESTO AS PSC_MESTO, '+
              '  Z.JMENO_CP||'', nar. ''||GET_DATUM_FROM_RC(Z.RODNE_CISLO) AS JMENO_NAR, '+
              '  CASE GET_POHLAVI_Z_RC(Z.RODNE_CISLO) '+
              '    WHEN 1 THEN ''Vážený pan'' '+
              '    WHEN 0 THEN ''Vážená paní'' '+
              '    WHEN NULL THEN ''Vážený pan/paní'' '+
              '  END AS OSLOVENI, '+
              '  GET_PARAM(''ZALOBY_OZNAMENI_UCET'') AS UCET_OZNAMENI '+
              'FROM '+
              '  ZALOBY_OSTATNI Z,'+
              '  LICENCE L '+
              'WHERE '+
              '  NVL(Z.UZAMCENA,0)=0'+
              '  AND Z.DATUM_IMPORTU=TO_DATE('+Q(frmTiskZalob.edDatumImportu.Text)+',''DD.MM.YYYY'') '+
              'ORDER BY '+
              '  Z.VAR_SYMB';
  //---------------------

  {qrTemp.SQL.Text:=sql_text;
  qrTemp.Open;
  qrTemp.First;
  i:=0;
  while not(qrTemp.Eof) do
  begin
    qrTemp.Next;
    bID1:=qrTemp.fieldByName('ID').AsString;
    qrTemp.Next;
    i:=i+1;
    ExecSQL('INSERT INTO HROMADNE_TISKY(SESSIONID,PK1,PK2,PK3,SORT_ORDER) VALUES('+'999999'+','''+bID1+''','''+bID2+''','''+bID3+''','+IntToStr(i)+')');
  end;}

  //ShowMessage(sql_text);

  Close;
  //ShowMessage(sql_text);
  frmSOPOPP3.qrMaster.Close;
  frmSOPOPP3.qrMaster.SQL.Text:=sql_text;
  frmSOPOPP3.qrMaster.Open;
  frmSOPOPP3.frReport.LoadFromFile(Replace_Char(get_param('SESTAVY')+'\','\\','\')+'OPOPP3.lrf');
  frmSOPOPP3.frReport.PrepareReport;
  frmSOPOPP3.frReport.ModalPreview:=true;
  frmSOPOPP3.frReport.ShowProgress:=true;
  frmSOPOPP3.frReport.ShowReport;
  frmSOPOPP3.qrMaster.Close;

finally
end;
end;
end;

procedure TfrmZalobyOstatni.MenuItem5Click(Sender: TObject);
begin
  nastavitUHR_SOP(DBGrid, 'ZALOBY_OSTATNI', Navigator.DataSource.DataSet, qrMaster);
end;

procedure TfrmZalobyOstatni.miExekuceClick(Sender: TObject);
var
  qrTemp : TSQLQuery;
  i : Integer;
  bID1,bID2,bID3,sql_text,temp : string;
  table : TDataSet;
begin
  inherited;

  if not Assigned(frmTiskZalob) then
    Application.CreateForm(TfrmTiskZalob,frmTiskZalob);

frmTiskZalob.FSelRows:=DBGrid.SelectedRows.Count;
frmTiskZalob.ShowModal;
if frmTiskZalob.ModalResult=mrOK then
begin
try

  if not Assigned(frmSExekuce) then
    Application.CreateForm(TfrmSExekuce,frmSExekuce);

  if frmTiskZalob.rbOznacene.Checked then
  begin
    if DBGrid.SelectedRows.CurrentRowSelected then
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
  end;

  //-- podminky tisku ---
  if frmTiskZalob.rbVse.Checked then
    sql_text:='SELECT '+
              '  ROWNUM AS RADEK,'+
              '  Z.*,'+
              '  TO_CHAR(SYSDATE,''DD.MM.YYYY'') AS AKTUALNI_DATUM,'+
              '  L.KONTAKTNI_OSOBA||''/''||L.KONTAKTNI_OSOBA_TEL AS KONTAKTNI_OSOBA,'+
              '  L.UCET,'+
              '  L.KOD_BANKY,'+
              '  GET_PARAM(''ZALOBY_DATUM_PREDANI'') AS DATUM_PREDANI,'+
              '  ''ERP ''||Z.VAR_SYMB||'' - FEN'' AS VAR_SYMB_ERP,'+
              '  Z.ULICE||'' ''||Z.CISLO_DOMU AS ULICE_CP, '+
              '  Z.PSC||'' ''||Z.MESTO AS PSC_MESTO, '+
              '  Z.JMENO_CP||'', nar. ''||GET_DATUM_FROM_RC(Z.RODNE_CISLO)||'',bytem ''||Z.ULICE||'' ''||Z.CISLO_DOMU||'', ''||Z.PSC||'' ''||Z.MESTO AS JMENO_NAR, '+
              '  CASE GET_POHLAVI_Z_RC(Z.RODNE_CISLO) '+
              '    WHEN 1 THEN ''Vážený pan'' '+
              '    WHEN 0 THEN ''Vážená paní'' '+
              '    WHEN NULL THEN ''Vážený pan/paní'' '+
              '  END AS OSLOVENI, '+
              '  GET_PARAM(''ZALOBY_OZNAMENI_UCET'') AS UCET_OZNAMENI '+
              'FROM '+
              '  ZALOBY_OSTATNI Z,'+
              '  LICENCE L '+
              'WHERE '+
              ' NVL(UZAMCENA,0)=0 '+
              'ORDER BY '+
              '  Z.VAR_SYMB';

  if frmTiskZalob.rbOznacene.Checked then
  begin
    if temp='' then temp:='0';
    sql_text:='SELECT '+
              '  ROWNUM AS RADEK,'+
              '  Z.*,'+
              '  TO_CHAR(SYSDATE,''DD.MM.YYYY'') AS AKTUALNI_DATUM,'+
              '  L.KONTAKTNI_OSOBA||''/''||L.KONTAKTNI_OSOBA_TEL AS KONTAKTNI_OSOBA,'+
              '  L.UCET,'+
              '  L.KOD_BANKY,'+
              '  GET_PARAM(''ZALOBY_DATUM_PREDANI'') AS DATUM_PREDANI,'+
              '  ''ERP ''||Z.VAR_SYMB||'' - FEN'' AS VAR_SYMB_ERP,'+
              '  Z.ULICE||'' ''||Z.CISLO_DOMU AS ULICE_CP, '+
              '  Z.PSC||'' ''||Z.MESTO AS PSC_MESTO, '+
              '  Z.JMENO_CP||'', nar. ''||GET_DATUM_FROM_RC(Z.RODNE_CISLO)||'',bytem ''||Z.ULICE||'' ''||Z.CISLO_DOMU||'', ''||Z.PSC||'' ''||Z.MESTO AS JMENO_NAR, '+
              '  CASE GET_POHLAVI_Z_RC(Z.RODNE_CISLO) '+
              '    WHEN 1 THEN ''Vážený pan'' '+
              '    WHEN 0 THEN ''Vážená paní'' '+
              '    WHEN NULL THEN ''Vážený pan/paní'' '+
              '  END AS OSLOVENI, '+
              '  GET_PARAM(''ZALOBY_OZNAMENI_UCET'') AS UCET_OZNAMENI '+
              'FROM '+
              '  ZALOBY_OSTATNI Z,'+
              '  LICENCE L '+
              'WHERE '+
              ' ID IN ('+temp+') '+
              'ORDER BY '+
              '  Z.VAR_SYMB';
  end;
  if frmTiskZalob.rbDatum.Checked then
    sql_text:='SELECT '+
              '  ROWNUM AS RADEK,'+
              '  Z.*,'+
              '  TO_CHAR(SYSDATE,''DD.MM.YYYY'') AS AKTUALNI_DATUM,'+
              '  L.KONTAKTNI_OSOBA||''/''||L.KONTAKTNI_OSOBA_TEL AS KONTAKTNI_OSOBA,'+
              '  L.UCET,'+
              '  L.KOD_BANKY,'+
              '  GET_PARAM(''ZALOBY_DATUM_PREDANI'') AS DATUM_PREDANI,'+
              '  ''ERP ''||Z.VAR_SYMB||'' - FEN'' AS VAR_SYMB_ERP,'+
              '  Z.ULICE||'' ''||Z.CISLO_DOMU AS ULICE_CP, '+
              '  Z.PSC||'' ''||Z.MESTO AS PSC_MESTO, '+
              '  Z.JMENO_CP||'', nar. ''||GET_DATUM_FROM_RC(Z.RODNE_CISLO)||'',bytem ''||Z.ULICE||'' ''||Z.CISLO_DOMU||'', ''||Z.PSC||'' ''||Z.MESTO AS JMENO_NAR, '+
              '  CASE GET_POHLAVI_Z_RC(Z.RODNE_CISLO) '+
              '    WHEN 1 THEN ''Vážený pan'' '+
              '    WHEN 0 THEN ''Vážená paní'' '+
              '    WHEN NULL THEN ''Vážený pan/paní'' '+
              '  END AS OSLOVENI, '+
              '  GET_PARAM(''ZALOBY_OZNAMENI_UCET'') AS UCET_OZNAMENI '+
              'FROM '+
              '  ZALOBY_OSTATNI Z,'+
              '  LICENCE L '+
              'WHERE '+
              '  NVL(Z.UZAMCENA,0)=0'+
              '  AND Z.DATUM_IMPORTU=TO_DATE('+Q(frmTiskZalob.edDatumImportu.Text)+',''DD.MM.YYYY'') '+
              'ORDER BY '+
              '  Z.VAR_SYMB';
  //---------------------

  {qrTemp.SQL.Text:=sql_text;
  qrTemp.Open;
  qrTemp.First;
  i:=0;
  while not(qrTemp.Eof) do
  begin
    qrTemp.Next;
    bID1:=qrTemp.fieldByName('ID').AsString;
    qrTemp.Next;
    i:=i+1;
    ExecSQL('INSERT INTO HROMADNE_TISKY(SESSIONID,PK1,PK2,PK3,SORT_ORDER) VALUES('+'999999'+','''+bID1+''','''+bID2+''','''+bID3+''','+IntToStr(i)+')');
  end;}

  //ShowMessage(sql_text);

  Close;
  //ShowMessage(sql_text);
  frmSExekuce.qrMaster.Close;
  frmSExekuce.qrMaster.SQL.Text:=sql_text;
  frmSExekuce.qrMaster.Open;
  frmSExekuce.frReport.LoadFromFile(Replace_Char(get_param('SESTAVY')+'\','\\','\')+'Sexekuce.lrf');
  frmSExekuce.frReport.PrepareReport;
  frmSExekuce.frReport.ModalPreview:=true;
  frmSExekuce.frReport.ShowProgress:=true;
  frmSExekuce.frReport.ShowReport;
  frmSExekuce.qrMaster.Close;

finally
end;
end;
end;

procedure TfrmZalobyOstatni.miExportSpisClick(Sender: TObject);
begin
  ExportSpis(DBGrid, 'ZALOBY_OSTATNI', OpenDialog.FileName);
end;

procedure TfrmZalobyOstatni.miImportSpisClick(Sender: TObject);
begin
  ImportSpis('ZALOBY_OSTATNI');
  Refresh_DataSet(Navigator.DataSource.DataSet,qrMaster);
end;

procedure TfrmZalobyOstatni.miKontrolaPrijmuClick(Sender: TObject);
begin
  ExecSQL('UPDATE NASTAVENI_SYSTEMU SET ZALOBY_PRIJEM = 0');
  ShowMessage('Resetování stavu příjmu žalob bylo provedeno.');
end;

procedure TfrmZalobyOstatni.miPodaciList3Click(Sender: TObject);
var
  sql_text,temp: string;
  table : TDataSet;
  i : Integer;
begin
  if not Assigned(frmTiskZalob) then
    Application.CreateForm(TfrmTiskZalob,frmTiskZalob);

  frmTiskZalob.FSelRows:=DBGrid.SelectedRows.Count;
  frmTiskZalob.ShowModal;
  if frmTiskZalob.ModalResult=mrOK then
  begin

    if frmTiskZalob.rbOznacene.Checked then
    begin
      if DBGrid.SelectedRows.CurrentRowSelected then
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
    end;

    sql_text:='SELECT ROWNUM AS RADEK,Z.*,Z.ULICE||'' ''||Z.CISLO_DOMU AS ULICE_CP,Z.PSC||'' ''||Z.MESTO AS PSC_MESTO FROM ZALOBY_OSTATNI Z WHERE NVL(UZAMCENA,0)=0 ORDER BY Z.VAR_SYMB';
    if (frmTiskZalob.rbDatum.Checked) and (frmTiskZalob.edDatumImportu.Text<>'') then
      sql_text:='SELECT * FROM ('+sql_text+') WHERE DATUM_IMPORTU=TO_DATE('''+frmTiskZalob.edDatumImportu.Text+''')';
    if frmTiskZalob.rbOznacene.Checked then
    begin
      if temp='' then temp:='0';
      sql_text:='SELECT * FROM ('+sql_text+') WHERE ID IN ('+temp+')';
    end;

    if not Assigned(frmSOPOPPPodaciList3) then
      Application.CreateForm(TfrmSOPOPPPodaciList3,frmSOPOPPPodaciList3);
    frmSOPOPPPodaciList3.qrMaster.Close;
    frmSOPOPPPodaciList3.qrMaster.SQL.Text:=sql_text;
    frmSOPOPPPodaciList3.qrMaster.Open;
    frmSOPOPPPodaciList3.frReport.LoadFromFile(Replace(get_param('SESTAVY')+'\','\\','\')+'OPOPPPodaciList3.lrf');
    frmSOPOPPPodaciList3.frReport.PrepareReport;
    frmSOPOPPPodaciList3.frReport.ModalPreview:=true;
    frmSOPOPPPodaciList3.frReport.ShowProgress:=true;
    frmSOPOPPPodaciList3.frReport.ShowReport;
    frmSOPOPPPodaciList3.qrMaster.Close;
  end;
end;

procedure TfrmZalobyOstatni.miArchivovatClick(Sender: TObject);
begin
  if not Assigned(frmProces) then
    Application.CreateForm(TfrmProces,frmProces);
  if MessageDlg('Opravdu chcete všechny uzamknuté žaloby přesunout do archívu?',mtConfirmation,[mbYES,mbNO],0)=mrYES then
  begin
    frmProces.ShowOnTop;
    frmProces.lbProces.Caption:='Probíhá přesunutí žalob, čekejte...';
    frmProces.ProgressBar1.Step:=1;
    frmProces.ProgressBar1.Min:=1;
    frmProces.ProgressBar1.Max:=6;
    frmProces.ProgressBar1.Position:=1;
    frmProces.ProgressBar1.StepIt;
    frmProces.Repaint;
    frmProces.ShowOnTop;
    ExecSQL('insert into zaloby_zpravy_archiv /*(REF_KOD,DATUM_STAZENI,ID,TYP_ZPRAVY,PREDMET,DATUM_ODESLANI,ODESILATEL,ID_ZPRAVY,UCET,'+
            '                          VAR_SYMB,PODANI_DORUCENE_DATUM,BEZNE_CISLO,PODANI_OVERENO_DATUM,ZASLANYCH_PRILOH, '+
            '                          ZPUSOB_PODANI,PODPIS_CERTIF_PLATNY,SOUD,TYP_FORMULARE,SPISOVA_ZNACKA,KE_ZPRACOVANI,'+
            '                          TELO)*/'+
            '(select REF_KOD,DATUM_STAZENI,ID,TYP_ZPRAVY,PREDMET,DATUM_ODESLANI,ODESILATEL,ID_ZPRAVY,UCET,'+
            '        VAR_SYMB,PODANI_DORUCENE_DATUM,BEZNE_CISLO,PODANI_OVERENO_DATUM,ZASLANYCH_PRILOH,'+
            '        ZPUSOB_PODANI,PODPIS_CERTIF_PLATNY,SOUD,TYP_FORMULARE,SPISOVA_ZNACKA,KE_ZPRACOVANI,'+
            '        TELO from zaloby_zpravy where ref_kod in (select ref_kod from zaloby_ostatni where nvl(uzamcena,0)=1))');
    frmProces.ProgressBar1.StepIt;
    frmProces.Repaint;
    frmProces.ShowOnTop;
    ExecSQL('delete zaloby_zpravy where ref_kod in (select ref_kod from zaloby_ostatni where nvl(uzamcena,0)=1)');
    frmProces.ProgressBar1.StepIt;
    frmProces.Repaint;
    frmProces.ShowOnTop;
    ExecSQL('insert into zaloby_archiv_ostatni /*(ID,VAR_SYMB,JMENO_CP,DATUM_CAS,DLUZNA_CASTKA,JIZDNE,POKUTA,RODNE_CISLO,ULICE,CISLO_DOMU,MESTO,'+
            '                OBVOD,PSC,REF_KOD,UZAMCENA,DATUM_IMPORTU,DATUM_UZAMCENI,PL_PRIKAZ,UHRADA,SPLATNOST,SOUD,ZALOBA,NAROK,VS_SOUDU,CU_SOUDU,'+
            '                SPIS_ZNACKA,UHR_SOP,ODVOLANI,JEDNANI,ROZSUDEK,PR_MOC,NAVRH,PRIKAZ,CASTKA,SKONCENO,CISLO,DATUM_UHRADY,ZEMREL,ZAPLATIL_PRED_PODANIM,'+
            '                ZAPLATIL_CASTKA,USNESENI,EXEKUTOR,ZPRAVA_DORUCENI,ZPRAVA_OVERENI,ZPRAVA_PL_ROZKAZ,ZPRAVA_ZAPRACOVANI,VYMOZENO,SKONCENO_DUVOD,EXEKUCNI_PRIKAZ)*/ '+
            '(select ID,VAR_SYMB,JMENO_CP,DATUM_CAS,DLUZNA_CASTKA,JIZDNE,POKUTA,RODNE_CISLO,ULICE,CISLO_DOMU,MESTO,'+
            'OBVOD,PSC,REF_KOD,UZAMCENA,DATUM_IMPORTU,DATUM_UZAMCENI,PL_PRIKAZ,UHRADA,SPLATNOST,SOUD,ZALOBA,NAROK,VS_SOUDU,CU_SOUDU,SPIS_ZNACKA,'+
            'UHR_SOP,ODVOLANI,JEDNANI,ROZSUDEK,PR_MOC,NAVRH,PRIKAZ,CASTKA,SKONCENO,CISLO,DATUM_UHRADY,ZEMREL,ZAPLATIL_PRED_PODANIM,ZAPLATIL_CASTKA,'+
            'USNESENI,EXEKUTOR,ZPRAVA_DORUCENI,ZPRAVA_OVERENI,ZPRAVA_PL_ROZKAZ,ZPRAVA_ZAPRACOVANI,VYMOZENO,SKONCENO_DUVOD,EXEKUCNI_PRIKAZ from zaloby_ostatni where nvl(uzamcena,0)=1)');
    frmProces.ProgressBar1.StepIt;
    frmProces.Repaint;
    frmProces.ShowOnTop;
    ExecSQL('delete zaloby_ostatni where nvl(uzamcena,0)=1');
    frmProces.ProgressBar1.StepIt;
    frmProces.Repaint;
    frmProces.ShowOnTop;
    Refresh_DataSet(Navigator.DataSource.DataSet,qrMaster);
    frmProces.ProgressBar1.StepIt;
    frmProces.Repaint;
    frmProces.ShowOnTop;
    frmProces.Close;
    MessageDlg('Žaloby byly přesunuty do archívu.',mtInformation,[mbOK],0);
  end;
end;

procedure TfrmZalobyOstatni.miArchivZalobClick(Sender: TObject);
begin
  if not Assigned(frmZalobyArchiv) then
    Application.CreateForm(TfrmZalobyArchiv,frmZalobyArchiv);
  frmZalobyArchiv.qrMaster.Close;
  frmZalobyArchiv.qrMaster.SQL.Text:='SELECT * FROM ZALOBY_ARCHIV_OSTATNI ORDER BY ID DESC';
  frmZalobyArchiv.qrMaster.Open;
  frmZalobyArchiv.Show;
end;

procedure TfrmZalobyOstatni.miBezGuiduClick(Sender: TObject);
var
  sql_text,temp: string;
  table : TDataSet;
  i : Integer;
begin
  if not Assigned(frmTiskZalob) then
    Application.CreateForm(TfrmTiskZalob,frmTiskZalob);

  frmTiskZalob.FSelRows:=DBGrid.SelectedRows.Count;
  frmTiskZalob.ShowModal;
  if frmTiskZalob.ModalResult=mrOK then
  begin

    if frmTiskZalob.rbOznacene.Checked then
    begin
      if DBGrid.SelectedRows.CurrentRowSelected then
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
    end;

    sql_text:='SELECT '+
              '  ROWNUM AS RADEK,'+
              '  Z.*,'+
              '  SUBSTR(Z.JMENO_CP,1,INSTR(Z.JMENO_CP,'' '')) AS JMENO,'+
              '  SUBSTR(Z.JMENO_CP,INSTR(JMENO_CP,'' '')+1) AS PRIJMENI,'+
              '  ULICE||'' ''||CISLO_DOMU||'', ''||MESTO||'', ''||PSC AS ADRESA '+
              'FROM '+
              '  ZALOBY_OSTATNI Z '+
              'WHERE '+
              '  NVL(UZAMCENA,0)=0 '+
              '  AND REF_KOD IS NULL '+
              'ORDER BY '+
              '  Z.VAR_SYMB';

    if (frmTiskZalob.rbDatum.Checked) and (frmTiskZalob.edDatumImportu.Text<>'') then
      sql_text:='SELECT * FROM ('+sql_text+') WHERE DATUM_IMPORTU=TO_DATE('''+frmTiskZalob.edDatumImportu.Text+''')';
    if frmTiskZalob.rbOznacene.Checked then
    begin
      if temp='' then temp:='0';
      sql_text:='SELECT * FROM ('+sql_text+') WHERE ID IN ('+temp+')';
    end;

    if not Assigned(frmSZaplacene) then
      Application.CreateForm(TfrmSBezGuidu,frmSBezGuidu);
    frmSBezGuidu.qrMaster.Close;
    frmSBezGuidu.qrMaster.SQL.Text:=sql_text;
    frmSBezGuidu.qrMaster.Open;
    frmSBezGuidu.frReport.LoadFromFile(Replace(get_param('SESTAVY')+'\','\\','\')+'ZalobyBezGuidu.lrf');
    frmSBezGuidu.frReport.PrepareReport;
    frmSBezGuidu.frReport.ModalPreview:=true;
    frmSBezGuidu.frReport.ShowProgress:=true;
    frmSBezGuidu.frReport.ShowReport;
    frmSBezGuidu.qrMaster.Close;
  end;
end;

procedure TfrmZalobyOstatni.miBezUdajuPlatbyClick(Sender: TObject);
var
  sql_text,temp: string;
  table : TDataSet;
  i : Integer;
begin
  if not Assigned(frmTiskZalob) then
    Application.CreateForm(TfrmTiskZalob,frmTiskZalob);

  frmTiskZalob.FSelRows:=DBGrid.SelectedRows.Count;
  frmTiskZalob.ShowModal;
  if frmTiskZalob.ModalResult=mrOK then
  begin

    if frmTiskZalob.rbOznacene.Checked then
    begin
      if DBGrid.SelectedRows.CurrentRowSelected then
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
    end;

    sql_text:='SELECT '+
              '  ROWNUM AS RADEK,'+
              '  Z.*,'+
              '  SUBSTR(Z.JMENO_CP,1,INSTR(Z.JMENO_CP,'' '')) AS JMENO,'+
              '  SUBSTR(Z.JMENO_CP,INSTR(JMENO_CP,'' '')+1) AS PRIJMENI,'+
              '  ULICE||'' ''||CISLO_DOMU||'', ''||MESTO||'', ''||PSC AS ADRESA '+
              'FROM '+
              '  ZALOBY_OSTATNI Z '+
              'WHERE '+
              '  NVL(UZAMCENA,0)=0 '+
              '  AND UHR_SOP IS NULL '+
              '  AND (VS_SOUDU IS NULL OR CU_SOUDU IS NULL)'+
              '  ORDER BY Z.VAR_SYMB';

    if (frmTiskZalob.rbDatum.Checked) and (frmTiskZalob.edDatumImportu.Text<>'') then
      sql_text:='SELECT * FROM ('+sql_text+') WHERE DATUM_IMPORTU=TO_DATE('''+frmTiskZalob.edDatumImportu.Text+''')';
    if frmTiskZalob.rbOznacene.Checked then
    begin
      if temp='' then temp:='0';
      sql_text:='SELECT * FROM ('+sql_text+') WHERE ID IN ('+temp+')';
    end;

    if not Assigned(frmSZaplacene) then
      Application.CreateForm(TfrmSBezUdajuPlatby,frmSBezUdajuPlatby);
    frmSBezUdajuPlatby.qrMaster.Close;
    frmSBezUdajuPlatby.qrMaster.SQL.Text:=sql_text;
    frmSBezUdajuPlatby.qrMaster.Open;
    frmSBezUdajuPlatby.frReport.LoadFromFile(Replace(get_param('SESTAVY')+'\','\\','\')+'ZalobyBezUdajuPlatby.lrf');
    frmSBezUdajuPlatby.frReport.PrepareReport;
    frmSBezUdajuPlatby.frReport.ModalPreview:=true;
    frmSBezUdajuPlatby.frReport.ShowProgress:=true;
    frmSBezUdajuPlatby.frReport.ShowReport;
    frmSBezUdajuPlatby.qrMaster.Close;
  end;
end;

procedure TfrmZalobyOstatni.miDoplnitDatumPlatbyClick(Sender: TObject);
var
  sql_text,temp: string;
  table : TDataSet;
  i : Integer;
begin
  if not Assigned(frmTiskZalob) then
    Application.CreateForm(TfrmTiskZalob,frmTiskZalob);

  frmTiskZalob.FSelRows:=DBGrid.SelectedRows.Count;
  frmTiskZalob.ShowModal;
  if frmTiskZalob.ModalResult=mrOK then
  begin

    if frmTiskZalob.rbOznacene.Checked then
    begin
      if DBGrid.SelectedRows.CurrentRowSelected then
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
    end;

    sql_text:='UPDATE ZALOBY_OSTATNI SET UHR_SOP=SYSDATE WHERE NVL(UZAMCENA,0)=0 AND UHR_SOP IS NULL';
    if (frmTiskZalob.rbDatum.Checked) and (frmTiskZalob.edDatumImportu.Text<>'') then
      sql_text:=sql_text+' AND DATUM_IMPORTU=TO_DATE('''+frmTiskZalob.edDatumImportu.Text+''')';
    if frmTiskZalob.rbOznacene.Checked then
    begin
      if temp='' then temp:='0';
      sql_text:=sql_text+' AND ID IN ('+temp+')';
    end;
    ExecSQL(sql_text);
    Refresh_DataSet(Navigator.DataSource.DataSet,qrMaster);
    MessageDlg('Datum byl doplněn',mtInformation,[mbOK],0);
  end;
end;

procedure TfrmZalobyOstatni.miDoplnitUdajeClick(Sender: TObject);
begin
  if MessageDlg('Opravdu chcete doplnit údaje ze zpráv?',mtConfirmation,[mbYES,mbNO],0)=mrYES then
  begin
    doplnit_udaje_ze_zprav;
    Refresh_DataSet(Navigator.DataSource.DataSet,qrMaster);
    MessageDlg('Údaje byly doplněny',mtInformation,[mbOK],0);
  end;
end;

procedure TfrmZalobyOstatni.miExportPodaciListClick(Sender: TObject);
begin
  podaci_list_excel(DBGrid,'ZALOBY_OSTATNI');
end;

procedure TfrmZalobyOstatni.miExportPredavaciProtokolClick(Sender: TObject);
begin
  predavaci_protokol_excel(DBGrid,'ZALOBY_OSTATNI');
end;

procedure TfrmZalobyOstatni.miHistorieClick(Sender: TObject);
begin
  if not Assigned(frmZalobyHistorie) then
    Application.CreateForm(TfrmZalobyHistorie,frmZalobyHistorie);
  frmZalobyHistorie.ShowModal;
end;

procedure TfrmZalobyOstatni.miImportZalobClick(Sender: TObject);
begin
  //if OpenDialog.Execute then
  //  import_zalob(OpenDialog.FileName);
end;

procedure TfrmZalobyOstatni.miPrubehClick(Sender: TObject);
begin
  prubeh_davky(DBGrid, 'ZALOBY_OSTATNI');
end;

procedure TfrmZalobyOstatni.miVymazatDatumPlatbyClick(Sender: TObject);
var
  sql_text,temp: string;
  table : TDataSet;
  i : Integer;
begin
  if not Assigned(frmTiskZalob) then
    Application.CreateForm(TfrmTiskZalob,frmTiskZalob);

  frmTiskZalob.FSelRows:=DBGrid.SelectedRows.Count;
  frmTiskZalob.ShowModal;
  if frmTiskZalob.ModalResult=mrOK then
  begin

    if frmTiskZalob.rbOznacene.Checked then
    begin
      if DBGrid.SelectedRows.CurrentRowSelected then
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
    end;

    sql_text:='UPDATE ZALOBY_OSTATNI SET UHR_SOP=NULL WHERE NVL(UZAMCENA,0)=0';
    if (frmTiskZalob.rbDatum.Checked) and (frmTiskZalob.edDatumImportu.Text<>'') then
      sql_text:=sql_text+' AND DATUM_IMPORTU=TO_DATE('''+frmTiskZalob.edDatumImportu.Text+''')';
    if frmTiskZalob.rbOznacene.Checked then
    begin
      if temp='' then temp:='0';
      sql_text:=sql_text+' AND ID IN ('+temp+')';
    end;
    ExecSQL(sql_text);
    Refresh_DataSet(Navigator.DataSource.DataSet,qrMaster);
    MessageDlg('Datum byl smazán',mtInformation,[mbOK],0);
  end;
end;

procedure TfrmZalobyOstatni.miVytvoritPrikazClick(Sender: TObject);
begin
  //export_prikazu(DBGrid,'ZALOBY_OSTATNI');
  export_prikazu_KB_KM(DBGrid,'ZALOBY_OSTATNI');
  Refresh_DataSet(Navigator.DataSource.DataSet,qrMaster);
end;

procedure TfrmZalobyOstatni.miZaplaceneClick(Sender: TObject);
var
  sql_text,temp: string;
  table : TDataSet;
  i : Integer;
begin
  if not Assigned(frmTiskZalob) then
    Application.CreateForm(TfrmTiskZalob,frmTiskZalob);

  frmTiskZalob.FSelRows:=DBGrid.SelectedRows.Count;
  frmTiskZalob.ShowModal;
  if frmTiskZalob.ModalResult=mrOK then
  begin

    if frmTiskZalob.rbOznacene.Checked then
    begin
      if DBGrid.SelectedRows.CurrentRowSelected then
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
    end;

    sql_text:='SELECT ROWNUM AS RADEK,Z.*,SUBSTR(Z.JMENO_CP,1,INSTR(Z.JMENO_CP,'' '')) AS JMENO,SUBSTR(Z.JMENO_CP,INSTR(JMENO_CP,'' '')+1) AS PRIJMENI FROM ZALOBY_OSTATNI Z WHERE NVL(UZAMCENA,0)=0 AND UHR_SOP IS NOT NULL ORDER BY Z.VAR_SYMB';
    if (frmTiskZalob.rbDatum.Checked) and (frmTiskZalob.edDatumImportu.Text<>'') then
      sql_text:='SELECT * FROM ('+sql_text+') WHERE DATUM_IMPORTU=TO_DATE('''+frmTiskZalob.edDatumImportu.Text+''')';
    if frmTiskZalob.rbOznacene.Checked then
    begin
      if temp='' then temp:='0';
      sql_text:='SELECT * FROM ('+sql_text+') WHERE ID IN ('+temp+')';
    end;

    if not Assigned(frmSZaplacene) then
      Application.CreateForm(TfrmSNezaplacene,frmSZaplacene);
    frmSZaplacene.qrMaster.Close;
    frmSZaplacene.qrMaster.SQL.Text:=sql_text;
    frmSZaplacene.qrMaster.Open;
    frmSZaplacene.frReport.LoadFromFile(Replace(get_param('SESTAVY')+'\','\\','\')+'ZalobyZaplacene.lrf');
    frmSZaplacene.frReport.PrepareReport;
    frmSZaplacene.frReport.ModalPreview:=true;
    frmSZaplacene.frReport.ShowProgress:=true;
    frmSZaplacene.frReport.ShowReport;
    frmSZaplacene.qrMaster.Close;
  end;
end;

procedure TfrmZalobyOstatni.miNovyZaznamClick(Sender: TObject);
begin
  inherited;
end;

procedure TfrmZalobyOstatni.miOdemknoutClick(Sender: TObject);
var
  table : TDataSet;
  i: Integer;
begin
  try
    if MessageDlg('Opravdu chcete označené žaloby odemknout?',mtConfirmation,[mbYES,mbNO],0)=mrYES then
    begin
      if DBGrid.SelectedRows.CurrentRowSelected then
      begin
        Table:=DBGrid.DataSource.Dataset;
        for i:=0 to DBGrid.SelectedRows.Count-1 do
        begin
          Table.Bookmark:=DBGrid.SelectedRows[i];
          ExecSql('UPDATE ZALOBY_OSTATNI SET UZAMCENA=0,DATUM_UZAMCENI=NULL WHERE ID='+Table.FieldByName('ID').AsString);
        end;
        DBGrid.SelectedRows.Clear;
        Refresh_DataSet(Navigator.DataSource.DataSet,qrMaster);
        MessageDlg('Všechny označené žaloby byly odemknuté!',mtInformation,[mbOK],0);
      end
      else
      begin
        MessageDlg('Nebyly označeny žádné záznamy!',mtInformation,[mbOK],0);
      end;
    end;

  finally
    //table.Free;
  end;
end;

procedure TfrmZalobyOstatni.miOdemknoutDatumClick(Sender: TObject);
begin
  if not Assigned(dlgDatum) then
    Application.CreateForm(TdlgDatum,dlgDatum);

  if dlgDatum.ShowModal=mrOK then
  begin
    if dlgDatum.edDatum.Text<>'' then
    begin
      ExecSql('UPDATE ZALOBY_OSTATNI SET UZAMCENA=0,DATUM_UZAMCENI=NULL WHERE NVL(UZAMCENA,0)=1 AND DATUM_IMPORTU=TO_DATE('+Q(dlgDatum.edDatum.Text)+',''DD.MM.YYYY'')');
      Refresh_DataSet(Navigator.DataSource.DataSet,qrMaster);
      MessageDlg('Žaloby k datu '+dlgDatum.edDatum.text+' byly odemknuté!',mtInformation,[mbOK],0);
    end;
  end;
end;

procedure TfrmZalobyOstatni.miOdemknoutVseClick(Sender: TObject);
begin
  if MessageDlg('Opravdu chcete všechny žaloby odemknout?',mtConfirmation,[mbYES,mbNO],0)=mrYES then
  begin
    ExecSql('UPDATE ZALOBY_OSTATNI SET UZAMCENA=0,DATUM_UZAMCENI=NULL WHERE NVL(UZAMCENA,0)=1');
    Refresh_DataSet(Navigator.DataSource.DataSet,qrMaster);
    MessageDlg('Všechny žaloby byly odemknuty!',mtInformation,[mbOK],0);
  end;
end;

procedure TfrmZalobyOstatni.miPodaciList2Click(Sender: TObject);
var
  sql_text,temp: string;
  table : TDataSet;
  i : Integer;
begin
  if not Assigned(frmTiskZalob) then
    Application.CreateForm(TfrmTiskZalob,frmTiskZalob);

  frmTiskZalob.FSelRows:=DBGrid.SelectedRows.Count;
  frmTiskZalob.ShowModal;
  if frmTiskZalob.ModalResult=mrOK then
  begin

    if frmTiskZalob.rbOznacene.Checked then
    begin
      if DBGrid.SelectedRows.CurrentRowSelected then
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
    end;

    sql_text:='SELECT ROWNUM AS RADEK,Z.*,Z.ULICE||'' ''||Z.CISLO_DOMU AS ULICE_CP,Z.PSC||'' ''||Z.MESTO AS PSC_MESTO FROM ZALOBY_OSTATNI Z WHERE NVL(UZAMCENA,0)=0 ORDER BY Z.VAR_SYMB';
    if (frmTiskZalob.rbDatum.Checked) and (frmTiskZalob.edDatumImportu.Text<>'') then
      sql_text:='SELECT * FROM ('+sql_text+') WHERE DATUM_IMPORTU=TO_DATE('''+frmTiskZalob.edDatumImportu.Text+''')';
    if frmTiskZalob.rbOznacene.Checked then
    begin
      if temp='' then temp:='0';
      sql_text:='SELECT * FROM ('+sql_text+') WHERE ID IN ('+temp+')';
    end;

    if not Assigned(frmSOPOPPPodaciList2) then
      Application.CreateForm(TfrmSOPOPPPodaciList2,frmSOPOPPPodaciList2);
    frmSOPOPPPodaciList2.qrMaster.Close;
    frmSOPOPPPodaciList2.qrMaster.SQL.Text:=sql_text;
    frmSOPOPPPodaciList2.qrMaster.Open;
    frmSOPOPPPodaciList2.frReport.LoadFromFile(Replace(get_param('SESTAVY')+'\','\\','\')+'OPOPPPodaciList2.lrf');
    frmSOPOPPPodaciList2.frReport.PrepareReport;
    frmSOPOPPPodaciList2.frReport.ModalPreview:=true;
    frmSOPOPPPodaciList2.frReport.ShowProgress:=true;
    frmSOPOPPPodaciList2.frReport.ShowReport;
    frmSOPOPPPodaciList2.qrMaster.Close;
  end;
end;

procedure TfrmZalobyOstatni.miPodaciListClick(Sender: TObject);
var
  sql_text,temp: string;
  table : TDataSet;
  i : Integer;
begin
  if not Assigned(frmTiskZalob) then
    Application.CreateForm(TfrmTiskZalob,frmTiskZalob);

  frmTiskZalob.FSelRows:=DBGrid.SelectedRows.Count;
  frmTiskZalob.ShowModal;
  if frmTiskZalob.ModalResult=mrOK then
  begin

    if frmTiskZalob.rbOznacene.Checked then
    begin
      if DBGrid.SelectedRows.CurrentRowSelected then
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
    end;

    sql_text:='SELECT ROWNUM AS RADEK,Z.*,SUBSTR(Z.JMENO_CP,1,INSTR(Z.JMENO_CP,'' '')) AS JMENO,SUBSTR(Z.JMENO_CP,INSTR(JMENO_CP,'' '')+1) AS PRIJMENI FROM ZALOBY_OSTATNI Z WHERE NVL(UZAMCENA,0)=0 ORDER BY Z.VAR_SYMB';
    if (frmTiskZalob.rbDatum.Checked) and (frmTiskZalob.edDatumImportu.Text<>'') then
      sql_text:='SELECT * FROM ('+sql_text+') WHERE DATUM_IMPORTU=TO_DATE('''+frmTiskZalob.edDatumImportu.Text+''')';
    if frmTiskZalob.rbOznacene.Checked then
    begin
      if temp='' then temp:='0';
      sql_text:='SELECT * FROM ('+sql_text+') WHERE ID IN ('+temp+')';
    end;

    if not Assigned(frmSOPOPPPodaciList) then
      Application.CreateForm(TfrmSOPOPPPodaciList,frmSOPOPPPodaciList);
    frmSOPOPPPodaciList.qrMaster.Close;
    frmSOPOPPPodaciList.qrMaster.SQL.Text:=sql_text;
    frmSOPOPPPodaciList.qrMaster.Open;
    frmSOPOPPPodaciList.frReport.LoadFromFile(Replace(get_param('SESTAVY')+'\','\\','\')+'OPOPPPodaciList.lrf');
    frmSOPOPPPodaciList.frReport.PrepareReport;
    frmSOPOPPPodaciList.frReport.ModalPreview:=true;
    frmSOPOPPPodaciList.frReport.ShowProgress:=true;
    frmSOPOPPPodaciList.frReport.ShowReport;
    frmSOPOPPPodaciList.qrMaster.Close;
  end;
end;

procedure TfrmZalobyOstatni.miPredavaciProtokolClick(Sender: TObject);
var
  sql_text,temp: string;
  table : TDataSet;
  i : Integer;
begin
  if not Assigned(frmTiskZalob) then
    Application.CreateForm(TfrmTiskZalob,frmTiskZalob);

  frmTiskZalob.FSelRows:=DBGrid.SelectedRows.Count;
  frmTiskZalob.ShowModal;
  if frmTiskZalob.ModalResult=mrOK then
  begin

    if frmTiskZalob.rbOznacene.Checked then
    begin
      if DBGrid.SelectedRows.CurrentRowSelected then
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
    end;

    if frmTiskZalob.rbVse.Checked then
    begin
    sql_text:='SELECT '+
              '  ROWNUM AS RADEK,'+
              '  Z.*,'+
              '  GET_PARAM(''ZALOBY_DATUM_PREDANI'') AS DATUM_PREDANI,'+
              '  SUBSTR(Z.JMENO_CP,1,INSTR(Z.JMENO_CP,'' '')) AS JMENO,'+
              '  SUBSTR(Z.JMENO_CP,INSTR(JMENO_CP,'' '')+1) AS PRIJMENI,'+
              '  (SELECT COUNT(*) FROM ZALOBY_OSTATNI WHERE NVL(UZAMCENA,0)=0) AS R_POCET,'+
              '  FORMAT_MENA((SELECT SUM(JIZDNE) FROM ZALOBY_OSTATNI WHERE NVL(UZAMCENA,0)=0)+(SELECT SUM(POKUTA) FROM ZALOBY_OSTATNI WHERE NVL(UZAMCENA,0)=0),2) AS R_CELKEM, '+
              '  FORMAT_MENA((SELECT SUM(JIZDNE) FROM ZALOBY_OSTATNI WHERE NVL(UZAMCENA,0)=0),2) AS JIZDNE_CELKEM,'+
              '  FORMAT_MENA((SELECT SUM(POKUTA) FROM ZALOBY_OSTATNI WHERE NVL(UZAMCENA,0)=0),2) AS PRIRAZKA_CELKEM '+
              'FROM '+
              '  ZALOBY_OSTATNI Z '+
              'WHERE '+
              '  NVL(UZAMCENA,0)=0 '+
              'ORDER BY '+
              '  Z.VAR_SYMB';
    end;

    if (frmTiskZalob.rbDatum.Checked) and (frmTiskZalob.edDatumImportu.Text<>'') then
    begin
    sql_text:='SELECT '+
              '  ROWNUM AS RADEK,'+
              '  Z.*,'+
              '  GET_PARAM(''ZALOBY_DATUM_PREDANI'') AS DATUM_PREDANI,'+
              '  SUBSTR(Z.JMENO_CP,1,INSTR(Z.JMENO_CP,'' '')) AS JMENO,'+
              '  SUBSTR(Z.JMENO_CP,INSTR(JMENO_CP,'' '')+1) AS PRIJMENI,'+
              '  (SELECT COUNT(*) FROM ZALOBY_OSTATNI WHERE NVL(UZAMCENA,0)=0 AND DATUM_IMPORTU=TO_DATE('''+frmTiskZalob.edDatumImportu.Text+''')) AS R_POCET,'+
              '  FORMAT_MENA((SELECT SUM(JIZDNE) FROM ZALOBY_OSTATNI WHERE NVL(UZAMCENA,0)=0 AND DATUM_IMPORTU=TO_DATE('''+frmTiskZalob.edDatumImportu.Text+'''))+(SELECT SUM(POKUTA) FROM ZALOBY_OSTATNI WHERE NVL(UZAMCENA,0)=0 AND DATUM_IMPORTU=TO_DATE('''+frmTiskZalob.edDatumImportu.Text+''')),2) AS R_CELKEM, '+
              '  FORMAT_MENA((SELECT SUM(JIZDNE) FROM ZALOBY_OSTATNI WHERE NVL(UZAMCENA,0)=0 AND DATUM_IMPORTU=TO_DATE('''+frmTiskZalob.edDatumImportu.Text+''')),2) AS JIZDNE_CELKEM,'+
              '  FORMAT_MENA((SELECT SUM(POKUTA) FROM ZALOBY_OSTATNI WHERE NVL(UZAMCENA,0)=0 AND DATUM_IMPORTU=TO_DATE('''+frmTiskZalob.edDatumImportu.Text+''')),2) AS PRIRAZKA_CELKEM '+
              'FROM '+
              '  ZALOBY_OSTATNI Z '+
              'WHERE '+
              '  NVL(UZAMCENA,0)=0 '+
              '  AND DATUM_IMPORTU=TO_DATE('''+frmTiskZalob.edDatumImportu.Text+''')'+
              'ORDER BY '+
              '  Z.VAR_SYMB';
      //sql_text:='SELECT * FROM ('+sql_text+') WHERE DATUM_IMPORTU=TO_DATE('''+frmTiskZalob.edDatumImportu.Text+''')';
    end;
    if frmTiskZalob.rbOznacene.Checked then
    begin
      if temp='' then temp:='0';
    sql_text:='SELECT '+
              '  ROWNUM AS RADEK,'+
              '  Z.*,'+
              '  GET_PARAM(''ZALOBY_DATUM_PREDANI'') AS DATUM_PREDANI,'+
              '  SUBSTR(Z.JMENO_CP,1,INSTR(Z.JMENO_CP,'' '')) AS JMENO,'+
              '  SUBSTR(Z.JMENO_CP,INSTR(JMENO_CP,'' '')+1) AS PRIJMENI,'+
              '  (SELECT COUNT(*) FROM ZALOBY_OSTATNI WHERE ID IN ('+temp+')) AS R_POCET,'+
              '  FORMAT_MENA((SELECT SUM(JIZDNE) FROM ZALOBY_OSTATNI WHERE ID IN ('+temp+'))+(SELECT SUM(POKUTA) FROM ZALOBY_OSTATNI WHERE ID IN ('+temp+')),2) AS R_CELKEM, '+
              '  FORMAT_MENA((SELECT SUM(JIZDNE) FROM ZALOBY_OSTATNI WHERE ID IN ('+temp+')),2) AS JIZDNE_CELKEM,'+
              '  FORMAT_MENA((SELECT SUM(POKUTA) FROM ZALOBY_OSTATNI WHERE ID IN ('+temp+')),2) AS PRIRAZKA_CELKEM '+
              'FROM '+
              '  ZALOBY_OSTATNI Z '+
              'WHERE '+
              '  ID IN ('+temp+')'+
              'ORDER BY '+
              '  Z.VAR_SYMB';
      //sql_text:='SELECT * FROM ('+sql_text+') WHERE ID IN ('+temp+')';
    end;

    if not Assigned(frmSOPOPPPredavaciProtokol) then
      Application.CreateForm(TfrmSOPOPPPredavaciProtokol,frmSOPOPPPredavaciProtokol);
    frmSOPOPPPredavaciProtokol.qrMaster.Close;
    frmSOPOPPPredavaciProtokol.qrMaster.SQL.Text:=sql_text;
    frmSOPOPPPredavaciProtokol.qrMaster.Open;
    frmSOPOPPPredavaciProtokol.frReport.LoadFromFile(Replace(get_param('SESTAVY')+'\','\\','\')+'OPOPPPredavaciProtokol.lrf');
    frmSOPOPPPredavaciProtokol.frReport.PrepareReport;
    frmSOPOPPPredavaciProtokol.frReport.ModalPreview:=true;
    frmSOPOPPPredavaciProtokol.frReport.ShowProgress:=true;
    frmSOPOPPPredavaciProtokol.frReport.ShowReport;
    frmSOPOPPPredavaciProtokol.qrMaster.Close;
  end;
end;

procedure TfrmZalobyOstatni.miPresunoutZArchivuClick(Sender: TObject);
begin
  if not Assigned(dlgDatum) then
    Application.CreateForm(TdlgDatum,dlgDatum);
  if not Assigned(frmProces) then
    Application.CreateForm(TfrmProces,frmProces);
  dlgDatum.Label1.Caption:='Datum importu žalob';
  dlgDatum.edDatum.Clear;
  if dlgDatum.ShowModal and dlgDatum.ModalResult=mrOK then
  begin
    frmProces.ShowOnTop;
    frmProces.lbProces.Caption:='Probíhá přesunutí žalob, čekejte...';
    frmProces.ProgressBar1.Step:=1;
    frmProces.ProgressBar1.Min:=1;
    frmProces.ProgressBar1.Max:=6;
    frmProces.ProgressBar1.Position:=1;
    frmProces.ProgressBar1.StepIt;
    frmProces.Repaint;
    frmProces.ShowOnTop;
    ExecSQL('insert into zaloby_zpravy /*(REF_KOD,DATUM_STAZENI,ID,TYP_ZPRAVY,PREDMET,DATUM_ODESLANI,ODESILATEL,ID_ZPRAVY,UCET,'+
            '                          VAR_SYMB,PODANI_DORUCENE_DATUM,BEZNE_CISLO,PODANI_OVERENO_DATUM,ZASLANYCH_PRILOH,'+
            '                          ZPUSOB_PODANI,PODPIS_CERTIF_PLATNY,SOUD,TYP_FORMULARE,SPISOVA_ZNACKA,KE_ZPRACOVANI,'+
            '                          TELO)*/ '+
            '(select REF_KOD,DATUM_STAZENI,ID,TYP_ZPRAVY,PREDMET,DATUM_ODESLANI,ODESILATEL,ID_ZPRAVY,UCET,'+
            'VAR_SYMB,PODANI_DORUCENE_DATUM,BEZNE_CISLO,PODANI_OVERENO_DATUM,ZASLANYCH_PRILOH,'+
            'ZPUSOB_PODANI,PODPIS_CERTIF_PLATNY,SOUD,TYP_FORMULARE,SPISOVA_ZNACKA,KE_ZPRACOVANI,'+
            'TELO from zaloby_zpravy_archiv where ref_kod in (select ref_kod from zaloby_archiv_ostatni where datum_importu=to_date('+Q(dlgDatum.edDatum.Text)+',''DD.MM.YYYY'') or '+Q(dlgDatum.edDatum.Text)+' is null))');
    frmProces.ProgressBar1.StepIt;
    frmProces.Repaint;
    frmProces.ShowOnTop;
    ExecSQL('delete zaloby_zpravy_archiv where ref_kod in (select ref_kod from zaloby_archiv_ostatni where datum_importu=to_date('+Q(dlgDatum.edDatum.Text)+',''DD.MM.YYYY'') or '+Q(dlgDatum.edDatum.Text)+' is null)');
    frmProces.ProgressBar1.StepIt;
    frmProces.Repaint;
    frmProces.ShowOnTop;
    ExecSQL('insert into zaloby_Ostatni /*(ID,VAR_SYMB,JMENO_CP,DATUM_CAS,DLUZNA_CASTKA,JIZDNE,POKUTA,RODNE_CISLO,ULICE,CISLO_DOMU,MESTO,'+
            '                OBVOD,PSC,REF_KOD,UZAMCENA,DATUM_IMPORTU,DATUM_UZAMCENI,PL_PRIKAZ,UHRADA,SPLATNOST,SOUD,ZALOBA,NAROK,VS_SOUDU,'+
            '                CU_SOUDU,SPIS_ZNACKA,UHR_SOP,ODVOLANI,JEDNANI,ROZSUDEK,PR_MOC,NAVRH,PRIKAZ,CASTKA,SKONCENO,CISLO,DATUM_UHRADY,ZEMREL,'+
            '                ZAPLATIL_PRED_PODANIM,ZAPLATIL_CASTKA,USNESENI,EXEKUTOR,ZPRAVA_DORUCENI,ZPRAVA_OVERENI,ZPRAVA_PL_ROZKAZ,ZPRAVA_ZAPRACOVANI,VYMOZENO,SKONCENO_DUVOD,EXEKUCNI_PRIKAZ)*/ '+
            '(select ID,VAR_SYMB,JMENO_CP,DATUM_CAS,DLUZNA_CASTKA,JIZDNE,POKUTA,RODNE_CISLO,ULICE,CISLO_DOMU,MESTO,'+
            'OBVOD,PSC,REF_KOD,UZAMCENA,DATUM_IMPORTU,DATUM_UZAMCENI,PL_PRIKAZ,UHRADA,SPLATNOST,SOUD,ZALOBA,NAROK,VS_SOUDU,CU_SOUDU,SPIS_ZNACKA,'+
            'UHR_SOP,ODVOLANI,JEDNANI,ROZSUDEK,PR_MOC,NAVRH,PRIKAZ,CASTKA,SKONCENO,CISLO,DATUM_UHRADY,ZEMREL,ZAPLATIL_PRED_PODANIM,ZAPLATIL_CASTKA,'+
            'USNESENI,EXEKUTOR,ZPRAVA_DORUCENI,ZPRAVA_OVERENI,ZPRAVA_PL_ROZKAZ,ZPRAVA_ZAPRACOVANI,VYMOZENO,SKONCENO_DUVOD,EXEKUCNI_PRIKAZ from zaloby_archiv_ostatni where datum_importu=to_date('+Q(dlgDatum.edDatum.Text)+',''DD.MM.YYYY'') or '+Q(dlgDatum.edDatum.Text)+' is null)');
    frmProces.ProgressBar1.StepIt;
    frmProces.Repaint;
    frmProces.ShowOnTop;
    ExecSQL('delete zaloby_archiv_ostatni where datum_importu=to_date('+Q(dlgDatum.edDatum.Text)+',''DD.MM.YYYY'') or '+Q(dlgDatum.edDatum.Text)+' is null');
    frmProces.ProgressBar1.StepIt;
    frmProces.Repaint;
    frmProces.ShowOnTop;
    Refresh_DataSet(Navigator.DataSource.DataSet,qrMaster);
    frmProces.ProgressBar1.StepIt;
    frmProces.Repaint;
    frmProces.ShowOnTop;
    frmProces.Close;
    MessageDlg('Žaloby byly přesunuty z archívu.',mtInformation,[mbOK],0);
  end;
end;

procedure TfrmZalobyOstatni.miPrijmoutPostuClick(Sender: TObject);
begin
try
  if ExecSQL_old('SELECT NVL((SELECT MAX(ZALOBY_PRIJEM) FROM NASTAVENI_SYSTEMU),0) FROM DUAL')='0' then
  begin
    cursor:=crHourGlass;
    ExecSQL('UPDATE NASTAVENI_SYSTEMU SET ZALOBY_PRIJEM=1');
    prijmout_postu;
    ExecSQL('UPDATE NASTAVENI_SYSTEMU SET ZALOBY_PRIJEM=0');
    cursor:=crDefault;
  end
  else
    MessageDlg('Příjem zpráv právě probíhá z jiného počítače!',mtWarning,[mbOK],0);
  Refresh_DataSet(Navigator.DataSource.DataSet,qrMaster);

finally
  ExecSQL('UPDATE NASTAVENI_SYSTEMU SET ZALOBY_PRIJEM=0');
  cursor:=crDefault;
end;
end;

procedure TfrmZalobyOstatni.miProPrikazClick(Sender: TObject);
var
  sql_text,temp: string;
  table : TDataSet;
  i : Integer;
begin
  if not Assigned(frmTiskZalob) then
    Application.CreateForm(TfrmTiskZalob,frmTiskZalob);

  frmTiskZalob.FSelRows:=DBGrid.SelectedRows.Count;
  frmTiskZalob.ShowModal;
  if frmTiskZalob.ModalResult=mrOK then
  begin

    if frmTiskZalob.rbOznacene.Checked then
    begin
      if DBGrid.SelectedRows.CurrentRowSelected then
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
    end;

    sql_text:='SELECT ROWNUM AS RADEK,Z.*,SUBSTR(Z.JMENO_CP,1,INSTR(Z.JMENO_CP,'' '')) AS JMENO,SUBSTR(Z.JMENO_CP,INSTR(JMENO_CP,'' '')+1) AS PRIJMENI'+
              ' FROM ZALOBY_OSTATNI Z WHERE NVL(UZAMCENA,0)=0 AND UHR_SOP IS NULL AND (CU_SOUDU IS NOT NULL AND VS_SOUDU IS NOT NULL) ORDER BY Z.VAR_SYMB';
    if (frmTiskZalob.rbDatum.Checked) and (frmTiskZalob.edDatumImportu.Text<>'') then
      sql_text:='SELECT * FROM ('+sql_text+') WHERE DATUM_IMPORTU=TO_DATE('''+frmTiskZalob.edDatumImportu.Text+''') ORDER BY VAR_SYMB';
    if frmTiskZalob.rbOznacene.Checked then
    begin
      if temp='' then temp:='0';
      sql_text:='SELECT * FROM ('+sql_text+') WHERE ID IN ('+temp+') ORDER BY VAR_SYMB';
    end;

    if not Assigned(frmSKuhrade) then
      Application.CreateForm(TfrmSKuhrade,frmSKuhrade);
    frmSKuhrade.qrMaster.Close;
    frmSKuhrade.qrMaster.SQL.Text:=sql_text;
    frmSKuhrade.qrMaster.Open;
    frmSKuhrade.frReport.LoadFromFile(Replace(get_param('SESTAVY')+'\','\\','\')+'ZalobyKZaplaceni.lrf');
    frmSKuhrade.frReport.PrepareReport;
    frmSKuhrade.frReport.ModalPreview:=true;
    frmSKuhrade.frReport.ShowProgress:=true;
    frmSKuhrade.frReport.ShowReport;
    frmSKuhrade.qrMaster.Close;
  end;
end;

procedure TfrmZalobyOstatni.miSmazatZaznamClick(Sender: TObject);
begin
  inherited;
end;

procedure TfrmZalobyOstatni.miSmlouvaClick(Sender: TObject);
var
  qrTemp : TSQLQuery;
  i : Integer;
  bID1,bID2,bID3,sql_text,temp : string;
  table : TDataSet;
begin
  inherited;

  if not Assigned(frmTiskZalob) then
    Application.CreateForm(TfrmTiskZalob,frmTiskZalob);

frmTiskZalob.FSelRows:=DBGrid.SelectedRows.Count;
frmTiskZalob.ShowModal;
if frmTiskZalob.ModalResult=mrOK then
begin
try

  if not Assigned(frmSOznameniPostupiteleOPostoupeniPohledavky) then
    Application.CreateForm(TfrmSOznameniPostupiteleOPostoupeniPohledavky,frmSOznameniPostupiteleOPostoupeniPohledavky);

  if frmTiskZalob.rbOznacene.Checked then
  begin
    if DBGrid.SelectedRows.CurrentRowSelected then
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
  end;

  //-- podminky tisku ---
  if frmTiskZalob.rbVse.Checked then
    sql_text:='SELECT '+
              '  ROWNUM AS RADEK,'+
              '  Z.*,'+
              '  L.KONTAKTNI_OSOBA||''/''||L.KONTAKTNI_OSOBA_TEL AS KONTAKTNI_OSOBA,'+
              '  L.UCET,'+
              '  L.KOD_BANKY,'+
              '  GET_PARAM(''ZALOBY_DATUM_PREDANI'') AS DATUM_PREDANI,'+
              '  ''ERP ''||Z.VAR_SYMB||'' - FEN'' AS VAR_SYMB_ERP,'+
              '  Z.ULICE||'' ''||Z.CISLO_DOMU AS ULICE_CP, '+
              '  Z.PSC||'' ''||Z.MESTO AS PSC_MESTO, '+
              '  Z.JMENO_CP||'', nar. ''||GET_DATUM_FROM_RC(Z.RODNE_CISLO) AS JMENO_NAR, '+
              '  CASE GET_POHLAVI_Z_RC(Z.RODNE_CISLO) '+
              '    WHEN 1 THEN ''Vážený pan'' '+
              '    WHEN 0 THEN ''Vážená paní'' '+
              '    WHEN NULL THEN ''Vážený pan/paní'' '+
              '  END AS OSLOVENI, '+
              '  GET_PARAM(''ZALOBY_OZNAMENI_UCET'') AS UCET_OZNAMENI '+
              'FROM '+
              '  ZALOBY_OSTATNI Z,'+
              '  LICENCE L '+
              'WHERE '+
              ' NVL(UZAMCENA,0)=0 '+
              'ORDER BY '+
              '  Z.VAR_SYMB';

  if frmTiskZalob.rbOznacene.Checked then
  begin
    if temp='' then temp:='0';
    sql_text:='SELECT '+
              '  ROWNUM AS RADEK,'+
              '  Z.*,'+
              '  L.KONTAKTNI_OSOBA||''/''||L.KONTAKTNI_OSOBA_TEL AS KONTAKTNI_OSOBA,'+
              '  L.UCET,'+
              '  L.KOD_BANKY,'+
              '  GET_PARAM(''ZALOBY_DATUM_PREDANI'') AS DATUM_PREDANI,'+
              '  ''ERP ''||Z.VAR_SYMB||'' - FEN'' AS VAR_SYMB_ERP,'+
              '  Z.ULICE||'' ''||Z.CISLO_DOMU AS ULICE_CP, '+
              '  Z.PSC||'' ''||Z.MESTO AS PSC_MESTO, '+
              '  Z.JMENO_CP||'', nar. ''||GET_DATUM_FROM_RC(Z.RODNE_CISLO) AS JMENO_NAR, '+
              '  CASE GET_POHLAVI_Z_RC(Z.RODNE_CISLO) '+
              '    WHEN 1 THEN ''Vážený pan'' '+
              '    WHEN 0 THEN ''Vážená paní'' '+
              '    WHEN NULL THEN ''Vážený pan/paní'' '+
              '  END AS OSLOVENI, '+
              '  GET_PARAM(''ZALOBY_OZNAMENI_UCET'') AS UCET_OZNAMENI '+
              'FROM '+
              '  ZALOBY_OSTATNI Z,'+
              '  LICENCE L '+
              'WHERE '+
              ' ID IN ('+temp+') '+
              'ORDER BY '+
              '  Z.VAR_SYMB';
  end;
  if frmTiskZalob.rbDatum.Checked then
    sql_text:='SELECT '+
              '  ROWNUM AS RADEK,'+
              '  Z.*,'+
              '  L.KONTAKTNI_OSOBA||''/''||L.KONTAKTNI_OSOBA_TEL AS KONTAKTNI_OSOBA,'+
              '  L.UCET,'+
              '  L.KOD_BANKY,'+
              '  GET_PARAM(''ZALOBY_DATUM_PREDANI'') AS DATUM_PREDANI,'+
              '  ''ERP ''||Z.VAR_SYMB||'' - FEN'' AS VAR_SYMB_ERP,'+
              '  Z.ULICE||'' ''||Z.CISLO_DOMU AS ULICE_CP, '+
              '  Z.PSC||'' ''||Z.MESTO AS PSC_MESTO, '+
              '  Z.JMENO_CP||'', nar. ''||GET_DATUM_FROM_RC(Z.RODNE_CISLO) AS JMENO_NAR, '+
              '  CASE GET_POHLAVI_Z_RC(Z.RODNE_CISLO) '+
              '    WHEN 1 THEN ''Vážený pan'' '+
              '    WHEN 0 THEN ''Vážená paní'' '+
              '    WHEN NULL THEN ''Vážený pan/paní'' '+
              '  END AS OSLOVENI, '+
              '  GET_PARAM(''ZALOBY_OZNAMENI_UCET'') AS UCET_OZNAMENI '+
              'FROM '+
              '  ZALOBY_OSTATNI Z,'+
              '  LICENCE L '+
              'WHERE '+
              '  NVL(Z.UZAMCENA,0)=0'+
              '  AND Z.DATUM_IMPORTU=TO_DATE('+Q(frmTiskZalob.edDatumImportu.Text)+',''DD.MM.YYYY'') '+
              'ORDER BY '+
              '  Z.VAR_SYMB';
  //---------------------

  {qrTemp.SQL.Text:=sql_text;
  qrTemp.Open;
  qrTemp.First;
  i:=0;
  while not(qrTemp.Eof) do
  begin
    qrTemp.Next;
    bID1:=qrTemp.fieldByName('ID').AsString;
    qrTemp.Next;
    i:=i+1;
    ExecSQL('INSERT INTO HROMADNE_TISKY(SESSIONID,PK1,PK2,PK3,SORT_ORDER) VALUES('+'999999'+','''+bID1+''','''+bID2+''','''+bID3+''','+IntToStr(i)+')');
  end;}

  //ShowMessage(sql_text);

  Close;
  //ShowMessage(sql_text);
  frmSOznameniPostupiteleOPostoupeniPohledavky.qrMaster.Close;
  frmSOznameniPostupiteleOPostoupeniPohledavky.qrMaster.SQL.Text:=sql_text;
  frmSOznameniPostupiteleOPostoupeniPohledavky.qrMaster.Open;
  frmSOznameniPostupiteleOPostoupeniPohledavky.frReport.LoadFromFile(Replace(get_param('SESTAVY')+'\','\\','\')+'OznameniPostupiteleOPostoupeniPohledavky.lrf');
  frmSOznameniPostupiteleOPostoupeniPohledavky.frReport.PrepareReport;
  frmSOznameniPostupiteleOPostoupeniPohledavky.frReport.ModalPreview:=true;
  frmSOznameniPostupiteleOPostoupeniPohledavky.frReport.ShowProgress:=true;
  frmSOznameniPostupiteleOPostoupeniPohledavky.frReport.ShowReport;
  frmSOznameniPostupiteleOPostoupeniPohledavky.qrMaster.Close;

finally
end;
end;

end;

procedure TfrmZalobyOstatni.miTypyZpravClick(Sender: TObject);
begin
    if not Assigned(frmZalobyTypyZprav) then
      Application.CreateForm(TfrmZalobyTypyZprav,frmZalobyTypyZprav);
    frmZalobyTypyZprav.Show;
end;

procedure TfrmZalobyOstatni.miUpravitZaznamClick(Sender: TObject);
begin
  inherited;
end;

procedure TfrmZalobyOstatni.miUzamknoutClick(Sender: TObject);
var
  table : TDataSet;
  i: Integer;
begin
  //table:=TDataSet.Create(nil);
  try
    if MessageDlg('Opravdu chcete označené žaloby uzamknout?',mtConfirmation,[mbYES,mbNO],0)=mrYES then
    begin
      if DBGrid.SelectedRows.CurrentRowSelected then
      begin
        Table:=DBGrid.DataSource.Dataset;
        for i:=0 to DBGrid.SelectedRows.Count-1 do
        begin
          Table.Bookmark:=DBGrid.SelectedRows[i];
          ExecSql('UPDATE ZALOBY_OSTATNI SET UZAMCENA=1,DATUM_UZAMCENI=SYSDATE WHERE ID='+Table.FieldByName('ID').AsString);
        end;
        DBGrid.SelectedRows.Clear;
        Refresh_DataSet(Navigator.DataSource.DataSet,qrMaster);
        MessageDlg('Všechny označené žaloby byly uzamknuty!',mtInformation,[mbOK],0);
      end
      else
      begin
        MessageDlg('Nebyly označeny žádné záznamy!',mtInformation,[mbOK],0);
      end;
    end;

  finally
    //table.free;
  end;
end;

procedure TfrmZalobyOstatni.miUzamknoutDatumClick(Sender: TObject);
begin
    if not Assigned(dlgDatum) then
      Application.CreateForm(TdlgDatum,dlgDatum);

    if dlgDatum.ShowModal=mrOK then
    begin
      if dlgDatum.edDatum.Text<>'' then
      begin
        ExecSql('UPDATE ZALOBY_OSTATNI SET UZAMCENA=1,DATUM_UZAMCENI=SYSDATE WHERE NVL(UZAMCENA,0)=0 AND DATUM_IMPORTU=TO_DATE('+Q(dlgDatum.edDatum.Text)+',''DD.MM.YYYY'')');
        Refresh_DataSet(Navigator.DataSource.DataSet,qrMaster);
        MessageDlg('Žaloby k datu '+dlgDatum.edDatum.text+' byly uzamknuty!',mtInformation,[mbOK],0);
      end;
    end;
end;

procedure TfrmZalobyOstatni.miUzavritVseClick(Sender: TObject);
begin
  if MessageDlg('Opravdu chcete všechny žaloby uzamknout?',mtConfirmation,[mbYES,mbNO],0)=mrYES then
  begin
    ExecSql('UPDATE ZALOBY_OSTATNI SET UZAMCENA=1,DATUM_UZAMCENI=SYSDATE WHERE NVL(UZAMCENA,0)=0');
    Refresh_DataSet(Navigator.DataSource.DataSet,qrMaster);
    MessageDlg('Všechny žaloby byly uzamknuty!',mtInformation,[mbOK],0);
  end;
end;

procedure TfrmZalobyOstatni.miVychoziDotazClick(Sender: TObject);
begin
  inherited;
  RadioGroup1.ItemIndex:=0;
end;

procedure TfrmZalobyOstatni.miZavritClick(Sender: TObject);
begin
  inherited;
end;

procedure TfrmZalobyOstatni.miZrusOznaceniClick(Sender: TObject);
begin
  inherited;
end;

procedure TfrmZalobyOstatni.NavigatorBeforeAction(Sender: TObject;
  Button: TDBNavButtonType);
begin
  inherited;
end;

procedure TfrmZalobyOstatni.NavigatorClick(Sender: TObject; Button: TDBNavButtonType);
begin
  inherited;
end;

procedure TfrmZalobyOstatni.Panel1Click(Sender: TObject);
begin

end;

procedure TfrmZalobyOstatni.pcMainPageChanged(Sender: TObject);
begin
  if pcMain.ActivePage=tsSeznam then
    Navigator.DataSource:=dsMaster;
end;

procedure TfrmZalobyOstatni.qrMasterAfterApplyUpdates(Sender: TObject);
begin
  inherited;
end;

procedure TfrmZalobyOstatni.qrMasterAfterPost(DataSet: TDataSet);
begin
  inherited;
end;

procedure TfrmZalobyOstatni.qrMasterBeforeEdit(DataSet: TDataSet);
begin
  inherited;
end;

procedure TfrmZalobyOstatni.qrMasterBeforeInsert(DataSet: TDataSet);
begin
  inherited;
end;

procedure TfrmZalobyOstatni.qrMasterAfterOpen(DataSet: TDataSet);
begin
  info_zpravy;
end;

procedure TfrmZalobyOstatni.qrMasterAfterScroll(DataSet: TDataSet);
var
  s : string;
begin
  btEditace.Enabled:=qrMaster.ReadOnly;
end;

procedure TfrmZalobyOstatni.qrMasterBeforePost(DataSet: TDataSet);
begin
  if ExecSQL_old('SELECT NVL((SELECT 1 FROM ZALOBY_OSTATNI WHERE REF_KOD='+Q(qrMaster.FieldByName('REF_KOD').AsString)+' AND TO_CHAR(ID)<>NVL('+Q(qrMaster.FieldByName('ID').AsString)+',''0'')),0) FROM DUAL')='1' then
  begin
    DataSet.FieldByName('REF_KOD').AsString:='';
    MessageDlg('Zadaný referenční kód již existuje u jiného záznamu, nebude uložen!',mtWarning,[mbOK],0);
  end;
end;

procedure TfrmZalobyOstatni.qrMasterNewRecord(DataSet: TDataSet);
begin
  pcMain.ActivePage := tsZaznam;
  DBEdit12.SetFocus;
end;

procedure TfrmZalobyOstatni.qrZpravyAfterApplyUpdates(Sender: TObject);
begin
  qrZpravy.CommitUpdates;
end;

procedure TfrmZalobyOstatni.qrZpravyAfterPost(DataSet: TDataSet);
begin
  qrZpravy.ApplyUpdates;
end;

procedure TfrmZalobyOstatni.RadioGroup1Click(Sender: TObject);
var
  sql_puv: string;
begin
  qrMaster.Close;
  if RadioGroup1.ItemIndex=2 then
    qrMaster.ParamByName('UZAMCENA').AsInteger:=0;
  if RadioGroup1.ItemIndex=1 then
    qrMaster.ParamByName('UZAMCENA').AsInteger:=1;
  if RadioGroup1.ItemIndex=0 then
    qrMaster.ParamByName('UZAMCENA').AsInteger:=2;
  qrMaster.Open;
{
  try
    if pcMain.TabIndex=1 then
      pcMain.TabIndex:=0;
    if RadioGroup1.ItemIndex=0 then
    begin
      sql_puv:=qrMaster.SQL.Text;
      miVychoziDotaz.Click;
    end;
    if RadioGroup1.ItemIndex=1 then
    begin
      sql_puv:=qrMaster.SQL.Text;
      //qrMaster.DisableControls;
      qrMaster.Close;
      qrMaster.SQL.Text:='SELECT * FROM ZALOBY WHERE NVL(UZAMCENA,0)=1 ORDER BY ID';
      qrMaster.Open;
      //qrMaster.EnableControls;
    end;
    if RadioGroup1.ItemIndex=2 then
    begin
      sql_puv:=qrMaster.SQL.Text;
      //qrMaster.DisableControls;
      qrMaster.Close;
      qrMaster.SQL.Text:='SELECT * FROM ZALOBY WHERE NVL(UZAMCENA,0)=0 ORDER BY ID';
      qrMaster.Open;
      //qrMaster.EnableControls;
    end;
  except
    //qrMaster.DisableControls;
    qrMaster.Close;
    qrMaster.SQL.Text:=sql_puv;
    qrMaster.Open;
    //qrMaster.EnableControls;
  end; }
end;

procedure TfrmZalobyOstatni.ToolButton10Click(Sender: TObject);
begin
  inherited;
end;

procedure TfrmZalobyOstatni.ToolButton3Click(Sender: TObject);
begin
  inherited;
end;

procedure TfrmZalobyOstatni.UpdateMasterBeforeInsertSQL(Sender: TObject);
begin

end;

procedure TfrmZalobyOstatni.UpdateMasterBeforeInsertSQLStatement(
  const Sender: TObject; StatementIndex: Integer; out Execute: Boolean);
begin

end;

procedure TfrmZalobyOstatni.UpdateMasterBeforeModifySQLStatement(
  const Sender: TObject; StatementIndex: Integer; out Execute: Boolean);
begin

end;

procedure TfrmZalobyOstatni.ZQuery1REF_KODChange(Sender: TField);
begin

end;

{
procedure TfrmZalobyOstatni.import_zalob(f: string);
var
  s: TStringList;
  navesti,delimiter,tmp,radek : string;
  i,a,p,pocet: Integer;
  var_symbol,jmeno_cp,rodne_cislo,ulice,
  cislo_domu,mesto,obvod,psc,kontrola_oddelovacu: string;
  datum_cas: TDateTime;
  dluzna_castka,jizdne,pokuta: Double;
begin
  try
    pocet:=0;
    kontrola_oddelovacu:=get_param('ZALOBY_IMPORT_KONTROLA_ODDELOVACU');
    DateSeparator:= '.';
    LongDateFormat:= 'dddd d MMMM yyyy';
    TimeSeparator := ':';
    ShortDateFormat := 'dd.MM.yyyy';
    ShortTimeFormat := 'hh:mi';
    LongTimeFormat := 'hh:mi';

    delimiter:=';';
    s:=TStringList.Create;
    s.LoadFromFile(f);
    for a:=0 to s.count-1 do
      s[a]:=utf8encode(s[a]);
    navesti:='var_symbol;jmeno_cp;datum_cas;dluzna_castka;jizdne;pokuta;rodne_cislo;ulice;cislo_domu;mesto;obvod;psc';
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
        ExecSql('DELETE ZALOBY_IMPORT');
        for i:=1 to s.Count-1 do
        begin
          p:=0;
          frmProces.ProgressBar1.StepIt;
          frmProces.Repaint;
          frmProces.ShowOnTop;
          radek:=s.Strings[i];
          //ShowMessage(IntToStr(Pos(delimiter,radek)));
          // -- 1
          tmp:=Copy(Radek,1,Pos(delimiter,radek)-1);
          var_symbol:=tmp;
          if Pos(delimiter,radek)>0 then p:=p+1;
          radek:=Copy(Radek,Pos(delimiter,radek)+1,length(radek)-Pos(delimiter,radek));
          // -- 2
          tmp:=Copy(Radek,1,Pos(delimiter,radek)-1);
          jmeno_cp:=Copy(Radek,1,Pos(delimiter,radek)-1);
          if Pos(delimiter,radek)>0 then p:=p+1;
          radek:=Copy(Radek,Pos(delimiter,radek)+1,length(radek)-Pos(delimiter,radek));
          // -- 3
          tmp:=Copy(Radek,1,Pos(delimiter,radek)-1);
          if length(tmp)>0 then
            datum_cas:=StrToDateTime(tmp);
          if Pos(delimiter,radek)>0 then p:=p+1;
          radek:=Copy(Radek,Pos(delimiter,radek)+1,length(radek)-Pos(delimiter,radek));
          // -- 4
          tmp:=Copy(Radek,1,Pos(delimiter,radek)-1);
          if length(tmp)>0 then
            dluzna_castka:=StrToFloat(Replace_String(tmp,' ',''));
          if Pos(delimiter,radek)>0 then p:=p+1;
          radek:=Copy(Radek,Pos(delimiter,radek)+1,length(radek)-Pos(delimiter,radek));
          // -- 5
          tmp:=Copy(Radek,1,Pos(delimiter,radek)-1);
          if length(tmp)>0 then
            jizdne:=StrToFloat(Replace_String(tmp,' ',''));
          if Pos(delimiter,radek)>0 then p:=p+1;
          radek:=Copy(Radek,Pos(delimiter,radek)+1,length(radek)-Pos(delimiter,radek));
          // -- 6
          tmp:=Copy(Radek,1,Pos(delimiter,radek)-1);
          if length(tmp)>0 then
            pokuta:=StrToFloat(Replace_String(tmp,' ',''));
          if Pos(delimiter,radek)>0 then p:=p+1;
          radek:=Copy(Radek,Pos(delimiter,radek)+1,length(radek)-Pos(delimiter,radek));
          // -- 7
          tmp:=Copy(Radek,1,Pos(delimiter,radek)-1);
          rodne_cislo:=tmp;
          if Pos(delimiter,radek)>0 then p:=p+1;
          radek:=Copy(Radek,Pos(delimiter,radek)+1,length(radek)-Pos(delimiter,radek));
          // -- 8
          tmp:=Copy(Radek,1,Pos(delimiter,radek)-1);
          ulice:=tmp;
          if Pos(delimiter,radek)>0 then p:=p+1;
          radek:=Copy(Radek,Pos(delimiter,radek)+1,length(radek)-Pos(delimiter,radek));
          // -- 9
          tmp:=Copy(Radek,1,Pos(delimiter,radek)-1);
          cislo_domu:=tmp;
          if Pos(delimiter,radek)>0 then p:=p+1;
          radek:=Copy(Radek,Pos(delimiter,radek)+1,length(radek)-Pos(delimiter,radek));
          // -- 10
          tmp:=Copy(Radek,1,Pos(delimiter,radek)-1);
          mesto:=tmp;
          if Pos(delimiter,radek)>0 then p:=p+1;
          radek:=Copy(Radek,Pos(delimiter,radek)+1,length(radek)-Pos(delimiter,radek));
          // -- 11
          tmp:=Copy(Radek,1,Pos(delimiter,radek)-1);
          obvod:=tmp;
          if Pos(delimiter,radek)>0 then p:=p+1;
          radek:=Copy(Radek,Pos(delimiter,radek)+1,length(radek)-Pos(delimiter,radek));
          // -- 12
          tmp:=Copy(Radek,1,length(Radek));
          psc:=Replace_String(tmp,' ','');
          if length(psc)>10 then ShowMessage(psc);
          //radek:=Copy(Radek,Pos(delimiter,radek)+1,length(radek)-Pos(delimiter,radek));
          if (Pos(delimiter,psc)>0) and (kontrola_oddelovacu='1') then
          begin
            raise Exception.Create('Importní řádek obsahuje nesprávný počet oddělovačů, což způsobí chybný import dat. Informujte programátora: !');
          end;
          if not (qrImport.Active) then qrImport.Open;
          if p=11 then
          begin
            qrImport.Insert;
            qrImport.FieldByName('VAR_SYMB').AsString:=var_symbol;
            qrImport.FieldByName('JMENO_CP').AsString:=jmeno_cp;
            qrImport.FieldByName('DATUM_CAS').AsDateTime:=datum_cas;
            qrImport.FieldByName('DLUZNA_CASTKA').AsFloat:=dluzna_castka;
            qrImport.FieldByName('JIZDNE').AsFloat:=jizdne;
            qrImport.FieldByName('POKUTA').AsFloat:=pokuta;
            qrImport.FieldByName('RODNE_CISLO').AsString:=rodne_cislo;
            qrImport.FieldByName('ULICE').AsString:=ulice;
            qrImport.FieldByName('CISLO_DOMU').AsString:=cislo_domu;
            qrImport.FieldByName('MESTO').AsString:=copy(mesto,1,50);
            qrImport.FieldByName('OBVOD').AsString:=obvod;
            qrImport.FieldByName('PSC').AsString:=psc;
            qrImport.FieldByName('DATUM_IMPORTU').AsDateTime:=date();
            qrImport.Post;
            pocet:=pocet+1;
          end;
        end;

        if ExecSQL_old('SELECT NVL((SELECT COUNT(*) FROM ZALOBY_IMPORT I WHERE EXISTS(SELECT 1 FROM ZALOBY WHERE VAR_SYMB=I.VAR_SYMB)),0) FROM DUAL')<>'0' then
        begin
          frmProces.ProgressBar1.StepIt;
          frmProces.Repaint;
          frmProces.ShowOnTop;
          frmProces.Close;
          MessageDlg('Import nebyl proveden. Importovaný soubor obsahuje var. symb., který je již v databázi!',mtError,[mbOK],0);
        end
        else
        begin
          ExecSql('INSERT INTO ZALOBY(VAR_SYMB,JMENO_CP,DATUM_CAS,DLUZNA_CASTKA,JIZDNE,POKUTA,RODNE_CISLO,ULICE,CISLO_DOMU,MESTO,OBVOD,PSC,DATUM_IMPORTU)'+
                  ' SELECT VAR_SYMB,JMENO_CP,DATUM_CAS,DLUZNA_CASTKA,JIZDNE,POKUTA,RODNE_CISLO,ULICE,CISLO_DOMU,MESTO,OBVOD,PSC,DATUM_IMPORTU FROM ZALOBY_IMPORT');
          Refresh_DataSet(Navigator.DataSource.DataSet,qrMaster);
          frmProces.ProgressBar1.StepIt;
          frmProces.Repaint;
          frmProces.ShowOnTop;
          frmProces.Close;
          MessageDlg('Import skončil! ('+IntToStr(pocet)+')',mtInformation,[mbOK],0);
        end;

      except
        on E : Exception do
        begin
          MessageDlg('Import skončil chybou: '+E.Message+'!',mtError,[mbOK],0);
          frmProces.Close;
        end;
      end;
    end;
  finally
    s.Free;
  end;
end;
}

procedure TfrmZalobyOstatni.prijmout_postu_ssl;
var
  pop3: TPOP3Send;
  i: integer;
begin
  pop3 := TPOP3Send.Create();
  try
    pop3.AutoTLS := false;
    pop3.Username:='m.bohacc';
    pop3.Password:='mata553';
    pop3.TargetHost:='pop3.seznam.cz';
    pop3.TargetPort := '995';
    pop3.FullSSL := true;
    pop3.Sock.SSL.SSLType := LT_SSLv3;

    pop3.Sock.SSLDoConnect();
    if not pop3.Login() then
      raise EPOP3.Create('POP3 ERROR: Login');

    //AddToLog('POP3 Stat');
    if not pop3.Stat() then
      raise EPOP3.Create('POP3 ERROR: stat');
    //AddToLog('Stat: '+IntToStr(pop3.StatCount)+' msgs');
    for i := 1 to pop3.StatCount do begin
      //AddToLog('POP3 Retr(' + IntToStr(i) + ')');
      if not pop3.Retr(i) then
        raise EPOP3.Create('POP3 ERROR: retr(' + IntToStr(i) + ')');
      //Memo2.lines.Add(' ');
      //Memo2.lines.Add('*** POP3 Retr(' + IntToStr(i) + ') *******');
      //Memo2.lines.AddStrings(pop3.FullResult);
      pop3.FullResult.SaveToFile('mail_' + IntToStr(i) + '.msg');
      //if not pop3.Dele(i) then
      //  raise EPOP3.Create('POP3 ERROR: dele(' + IntToStr(i) + ')');
    end;

  finally
    pop3.Free;
  end;
end;

procedure TfrmZalobyOstatni.info_zpravy;
begin
  try
    //dbedit30.Text:='SELECT DECODE(POCET,0,(SELECT NVL(ZPRAVA_PL_ROZKAZ,0) FROM ZALOBY_OSTATNI WHERE REF_KOD='''+qrMaster.FieldByName('REF_KOD').AsString+'''),POCET) FROM (SELECT COUNT(*) AS POCET FROM ZALOBY_ZPRAVY Z WHERE REF_KOD='''+qrMaster.FieldByName('REF_KOD').AsString+''' AND TYP_ZPRAVY=''4'')';
    //s:=ExecSQL_old('SELECT 1 FROM DUAL'); //WHERE REF_KOD='''+qrMaster.FieldByName('REF_KOD').AsString+''' AND TYP_ZPRAVY=''1''');
    if qrMaster.FieldByName('REF_KOD').AsString<>'' then
    begin
      if StrToInt(ExecSQL_old('SELECT DECODE(POCET,0,NVL((SELECT NVL(ZPRAVA_DORUCENI,0) FROM ZALOBY_OSTATNI WHERE REF_KOD='''+qrMaster.FieldByName('REF_KOD').AsString+'''),0),POCET) FROM (SELECT COUNT(*) AS POCET FROM ZALOBY_ZPRAVY Z WHERE REF_KOD='''+qrMaster.FieldByName('REF_KOD').AsString+''' AND TYP_ZPRAVY=''1'')'))>0 then
      begin
        lbPotvrzeni.Caption:='Ano';
        lbPotvrzeni.Font.Color:=clGreen;
      end
      else
      begin
        lbPotvrzeni.Caption:='Ne';
        lbPotvrzeni.Font.Color:=clRed;
      end;
      if StrToInt(ExecSQL_old('SELECT DECODE(POCET,0,NVL((SELECT NVL(ZPRAVA_OVERENI,0) FROM ZALOBY_OSTATNI WHERE REF_KOD='''+qrMaster.FieldByName('REF_KOD').AsString+'''),0),POCET) FROM (SELECT COUNT(*) AS POCET FROM ZALOBY_ZPRAVY Z WHERE REF_KOD='''+qrMaster.FieldByName('REF_KOD').AsString+''' AND TYP_ZPRAVY=''2'')'))>0 then
      begin
        lbOvereni.Caption:='Ano';
        lbOvereni.Font.Color:=clGreen;
      end
      else
      begin
        lbOvereni.Caption:='Ne';
        lbOvereni.Font.Color:=clRed;
      end;
      if StrToInt(ExecSQL_old('SELECT DECODE(POCET,0,NVL((SELECT NVL(ZPRAVA_ZAPRACOVANI,0) FROM ZALOBY_OSTATNI WHERE REF_KOD='''+qrMaster.FieldByName('REF_KOD').AsString+'''),0),POCET) FROM (SELECT COUNT(*) AS POCET FROM ZALOBY_ZPRAVY Z WHERE REF_KOD='''+qrMaster.FieldByName('REF_KOD').AsString+''' AND TYP_ZPRAVY=''3'')'))>0 then
      begin
        lbZpracovani.Caption:='Ano';
        lbZpracovani.Font.Color:=clGreen;
      end
      else
      begin
        lbZpracovani.Caption:='Ne';
        lbZpracovani.Font.Color:=clRed;
      end;
      if StrToInt(ExecSQL_old('SELECT DECODE(POCET,0,NVL((SELECT NVL(ZPRAVA_PL_ROZKAZ,0) FROM ZALOBY_OSTATNI WHERE REF_KOD='''+qrMaster.FieldByName('REF_KOD').AsString+'''),0),POCET) FROM (SELECT COUNT(*) AS POCET FROM ZALOBY_ZPRAVY Z WHERE REF_KOD='''+qrMaster.FieldByName('REF_KOD').AsString+''' AND TYP_ZPRAVY=''4'')'))>0 then
      begin
        lbPlatba.Caption:='Ano';
        lbPlatba.Font.Color:=clGreen;
      end
      else
      begin
        lbPlatba.Caption:='Ne';
        lbPlatba.Font.Color:=clRed;
      end;
    end;
  finally
  end;
end;

procedure TfrmZalobyOstatni.otevri_zpravy;
begin
  {try

    qrZpravy.Close;
    qrZpravy.SQL.Text:='SELECT '+
                       '  REF_KOD,DATUM_STAZENI,ID,TYP_ZPRAVY,PREDMET,DATUM_ODESLANI,ODESILATEL,ID_ZPRAVY,'+
                       '  UCET,VAR_SYMB,PODANI_DORUCENE_DATUM,BEZNE_CISLO,PODANI_OVERENO_DATUM,ZASLANYCH_PRILOH,ZPUSOB_PODANI,'+
                       '  PODPIS_CERTIF_PLATNY,SOUD,TYP_FORMULARE,SPISOVA_ZNACKA,KE_ZPRACOVANI '+
                       'FROM ZALOBY_ZPRAVY '+
                       'WHERE REF_KOD='''+qrMaster.FieldByName('REF_KOD').AsString+'''';
    qrZpravy.Open;
  except
    qrZpravy.Close;
  end;
  }
end;

procedure TfrmZalobyOstatni.initZobrazit;
var
  tmp : string;
begin
  tmp := ExecSql_old('SELECT GET_ZOBRAZIT(1,2) FROM DUAL');
  if (tmp = '0') then
  begin
    Navigator.VisibleButtons:=[nbFirst,nbPrior,nbNext,nbLast];
    miZaloby.Enabled:=false;
    miUpravy.Enabled:=false;
    miSestavy.Enabled:=false;
    miCiselniky.Enabled:=false;
    miExporty.Enabled:=false;
    RadioGroup1.Enabled:=false;
    btPrijmoutPostu.Enabled:=false;
  end;
  tmp := ExecSql_old('SELECT GET_ZOBRAZIT(3,2) FROM DUAL');
  if (tmp = '0') then
  begin
    miImporty.Enabled:=false;
  end;
end;

initialization
  {$I fzaloby_ostatni.lrs}

end.

