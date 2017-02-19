unit FZaloby;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  fsablona, db, sqldb, DbCtrls, DBGrids, ComCtrls, StdCtrls, ExtCtrls, Menus,
  utils, blcksock, smtpsend, pop3send, synachar, synautil,
  mimemess, MimePart, ZDataset, ZSqlUpdate, Grids, Buttons, uProc;

type

  ESMTP = class (Exception);
  EPOP3 = class (Exception);

  { TfrmZaloby }

  TfrmZaloby = class(TfrmSablona)
    btEditace: TButton;
    btPrijmoutPostu: TButton;
    Button1: TButton;
    cbDatumy: TComboBox;
    cbExekutor: TDBComboBox;
    cbSkoncenoDuvod: TComboBox;
    cbInsolvence: TDBCheckBox;
    DBCheckBox2: TDBCheckBox;
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
    DBEdit37: TDBEdit;
    DBEdit38: TDBEdit;
    DBEdit39: TDBEdit;
    DBEdit40: TDBEdit;
    DBEdit41: TDBEdit;
    DBEdit42: TDBEdit;
    DBEdit43: TDBEdit;
    DBEdit44: TDBEdit;
    DBMemo1: TDBMemo;
    dsZpravy: TDatasource;
    DBEdit1: TDBEdit;
    DBEdit10: TDBEdit;
    DBEdit11: TDBEdit;
    DBEdit12: TDBEdit;
    DBEdit13: TDBEdit;
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
    Label42: TLabel;
    Label43: TLabel;
    Label44: TLabel;
    Label45: TLabel;
    Label46: TLabel;
    Label47: TLabel;
    Label48: TLabel;
    Label49: TLabel;
    Label50: TLabel;
    Label51: TLabel;
    lbSplatkKal: TLabel;
    lbInsolvence: TLabel;
    lbPotvrzeni: TLabel;
    lbOvereni: TLabel;
    lbPlatba: TLabel;
    lbZpracovani: TLabel;
    miKuhrade2: TMenuItem;
    miExekuceHanakOI: TMenuItem;
    miExekuceTunklOI: TMenuItem;
    miExekuceTunklDomifin: TMenuItem;
    miExekuceBayerOI: TMenuItem;
    miExekuceBayerDomifin: TMenuItem;
    miImporty: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    miImportZalob2: TMenuItem;
    miExportZalob: TMenuItem;
    miExekuceTunkl: TMenuItem;
    miExekuce: TMenuItem;
    miImportSpis: TMenuItem;
    miExportSpis: TMenuItem;
    miPrubeh: TMenuItem;
    miPodaciList3: TMenuItem;
    miPoslatPrikaz: TMenuItem;
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
    Label6: TLabel;
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
    qrMasterCASTKA: TFloatField;
    qrMasterCISLO: TLongintField;
    qrMasterCISLO_DOMU: TStringField;
    qrMasterCU_SOUDU: TStringField;
    qrMasterDATUM_CAS: TDateTimeField;
    qrMasterDATUM_IMPORTU: TDateTimeField;
    qrMasterDATUM_UHRADY: TDateTimeField;
    qrMasterDATUM_UZAMCENI: TDateTimeField;
    qrMasterDLUZNA_CASTKA: TFloatField;
    qrMasterEXEKUCNI_PRIKAZ: TDateTimeField;
    qrMasterEXEKUTOR: TStringField;
    qrMasterID: TLongintField;
    qrMasterINSOLVENCE: TSmallintField;
    qrMasterJEDNANI: TDateTimeField;
    qrMasterJIZDNE: TFloatField;
    qrMasterJMENO_CP: TStringField;
    qrMasterMESTO: TStringField;
    qrMasterNAROK: TFloatField;
    qrMasterNAVRH: TDateTimeField;
    qrMasterOBVOD: TStringField;
    qrMasterODVOLANI: TDateTimeField;
    qrMasterOPRAVNE_USNESENI_DATUM: TDateTimeField;
    qrMasterPL_PRIKAZ: TDateTimeField;
    qrMasterPOKUTA: TFloatField;
    qrMasterPRIKAZ: TDateTimeField;
    qrMasterPR_MOC: TDateTimeField;
    qrMasterPSC: TStringField;
    qrMasterREF_KOD: TStringField;
    qrMasterRODNE_CISLO: TStringField;
    qrMasterROZSUDEK: TDateTimeField;
    qrMasterSKONCENO: TDateTimeField;
    qrMasterSKONCENO_DUVOD: TSmallintField;
    qrMasterSOUD: TStringField;
    qrMasterSPIS_ZNACKA: TStringField;
    qrMasterSPLATKOVY_KALENDAR: TSmallintField;
    qrMasterSPLATNOST: TDateTimeField;
    qrMasterUHRADA: TFloatField;
    qrMasterUHR_SOP: TDateTimeField;
    qrMasterULICE: TStringField;
    qrMasterUSNESENI: TStringField;
    qrMasterUSNESENI_CJ: TStringField;
    qrMasterUSNESENI_DATUM: TDateTimeField;
    qrMasterUZAMCENA: TSmallintField;
    qrMasterVAR_SYMB: TStringField;
    qrMasterVS_SOUDU: TStringField;
    qrMasterVYMOZENO: TFloatField;
    qrMasterZALOBA: TDateTimeField;
    qrMasterZAPLATIL_CASTKA: TFloatField;
    qrMasterZAPLATIL_PRED_PODANIM: TDateTimeField;
    qrMasterZEMREL: TDateTimeField;
    qrMasterZPRAVA_DORUCENI: TSmallintField;
    qrMasterZPRAVA_OVERENI: TSmallintField;
    qrMasterZPRAVA_PL_ROZKAZ: TSmallintField;
    qrMasterZPRAVA_ZAPRACOVANI: TSmallintField;
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
    qrImport: TZQuery;
    //qrMaster: TZQuery;
    //UpdateMaster: TZUpdateSQL;
    qrZpravy: TZQuery;
    UpdateZpravy: TZUpdateSQL;
    qrDatumy: TZReadOnlyQuery;
    procedure btEditaceClick(Sender: TObject);
    procedure btPrijmoutPostuClick(Sender: TObject);
    procedure btRefreshClick(Sender: TObject);
    procedure btRefreshZpravyClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure cbDatumyChange(Sender: TObject);
    procedure cbSkoncenoDuvodChange(Sender: TObject);
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
    procedure Label50Click(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
    procedure MenuItem5Click(Sender: TObject);
    procedure miArchivovatClick(Sender: TObject);
    procedure miArchivZalobClick(Sender: TObject);
    procedure miBezGuiduClick(Sender: TObject);
    procedure miBezUdajuPlatbyClick(Sender: TObject);
    procedure miDoplnitDatumPlatbyClick(Sender: TObject);
    procedure miDoplnitUdajeClick(Sender: TObject);
    procedure miExekuceBayerDomifinClick(Sender: TObject);
    procedure miExekuceBayerOIClick(Sender: TObject);
    procedure miExekuceClick(Sender: TObject);
    procedure miExekuceHanakOIClick(Sender: TObject);
    procedure miExekuceTunklClick(Sender: TObject);
    procedure miExekuceTunklDomifinClick(Sender: TObject);
    procedure miExekuceTunklOIClick(Sender: TObject);
    procedure miExportPodaciListClick(Sender: TObject);
    procedure miExportPredavaciProtokolClick(Sender: TObject);
    procedure miExportSpisClick(Sender: TObject);
    procedure miExportZalobClick(Sender: TObject);
    procedure miHistorieClick(Sender: TObject);
    procedure miImportSpisClick(Sender: TObject);
    procedure miImportZalob2Click(Sender: TObject);
    procedure miImportZalobClick(Sender: TObject);
    procedure miKontrolaPrijmuClick(Sender: TObject);
    procedure miKuhrade2Click(Sender: TObject);
    procedure miPodaciList3Click(Sender: TObject);
    procedure miPoslatPrikazClick(Sender: TObject);
    procedure miPrubehClick(Sender: TObject);
    procedure miVymazatDatumPlatbyClick(Sender: TObject);
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
    procedure qrImportAfterApplyUpdates(Sender: TObject);
    procedure qrImportAfterPost(DataSet: TDataSet);
    procedure qrMaster2AfterOpen(DataSet: TDataSet);
    procedure qrMasterAfterApplyUpdates(Sender: TObject);
    procedure qrMasterAfterClose(DataSet: TDataSet);
    procedure qrMasterAfterPost(DataSet: TDataSet);
    procedure qrMasterBeforeEdit(DataSet: TDataSet);
    procedure qrMasterBeforeInsert(DataSet: TDataSet);
    procedure qrMasterAfterOpen(DataSet: TDataSet);
    procedure qrMasterAfterScroll(DataSet: TDataSet);
    procedure qrMasterBeforeOpen(DataSet: TDataSet);
    procedure qrMasterBeforePost(DataSet: TDataSet);
    procedure qrZpravyAfterApplyUpdates(Sender: TObject);
    procedure qrZpravyAfterPost(DataSet: TDataSet);
    procedure RadioGroup1Click(Sender: TObject);
    procedure ToolButton10Click(Sender: TObject);
    procedure ToolButton3Click(Sender: TObject);
  private
    FMasterSQL : String;
    FMasterSQL_filter : String;
    FMasterSort : Integer;
    procedure import_zalob(f: string);
    procedure prijmout_postu_ssl;
    procedure info_zpravy;
    procedure otevri_zpravy;
    procedure nastav_datumy;
    procedure initZobrazit;
    function getTiskExekuce:string;
  public
    { public declarations }
    //FActiveDBGrid : TDBGrid;
  end; 

var
  frmZaloby: TfrmZaloby;

implementation

{ TfrmZaloby }

uses DOznameniPostupiteleOPostoupeniPohledavky,DDatum,FSOPOPPPodaciList,
     FSopopppredavaciprotokol,DProces,FZalobyHistorie,DPOP3Pripojeni,FZalobyTypyZprav,
     DZpravyDetail,SSOPOPPPodaciList2,SProc,fzalobyarchiv,SOznameniPostupiteleOPostoupeniPohledavky,
     FSNezaplacene,FSKzaplaceni,fszaplacene,fsbez_guidu,fsbezudajuplatby,DProcesQuery,
     ssopopppodacilist3,dPoznamkaUsneseni,SOPOPP2,SExekuce,SOPOPP3,Data_module,
     fskzaplaceni_sumar;

procedure TfrmZaloby.btRefreshClick(Sender: TObject);
var
  b: TBookMarkStr;
begin
  inherited;
  //Refresh_DataSet(Navigator.DataSource.DataSet,qrMaster2);
  //Refresh_DataSet(Navigator.DataSource.DataSet,qrNeuzamcene);
  nastav_datumy;
end;

procedure TfrmZaloby.btRefreshZpravyClick(Sender: TObject);
begin
  Refresh_DataSet(NavigatorZpravy.DataSource.DataSet,qrZpravy);
end;

procedure TfrmZaloby.Button1Click(Sender: TObject);
begin
  if not Assigned(frmPoznamkaUsneseni) then
      Application.CreateForm(TfrmPoznamkaUsneseni,frmPoznamkaUsneseni);
  frmPoznamkaUsneseni.dsUsneseni.DataSet:=qrMaster;
  frmPoznamkaUsneseni.DBMemo1.DataField:='USNESENI';
  frmPoznamkaUsneseni.ShowModal;
end;

procedure TfrmZaloby.cbDatumyChange(Sender: TObject);
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
    qrMaster.ParamCheck:=false;
    qrMaster.ParamCheck:=true;
    if cbDatumy.ItemIndex=0 then
    begin
      qrMaster.ParamByName('DATUM_IMPORTU').Clear
    end
    else
    begin
      qrMaster.ParamByName('DATUM_IMPORTU').DataType := ftDate;
      qrMaster.ParamByName('DATUM_IMPORTU').AsDate := StrToDate(cbDatumy.text);
    end;
    qrMaster.Open;

end;

procedure TfrmZaloby.cbSkoncenoDuvodChange(Sender: TObject);
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

procedure TfrmZaloby.DBGrid1DblClick(Sender: TObject);
begin
  if not Assigned(frmZpravyDetail) then
    Application.CreateForm(TfrmZpravyDetail,frmZpravyDetail);
  frmZpravyDetail.dsDetail.DataSet:=qrZpravy;
  frmZpravyDetail.ShowModal;
end;

procedure TfrmZaloby.DBGrid1PrepareCanvas(sender: TObject; DataCol: Integer;
  Column: TColumn; AState: TGridDrawState);
begin

  if qrZpravy.FieldByName('TYP_ZPRAVY').AsString='5' then
  begin
    if TDBGrid(Sender).Canvas.Brush.Color<>TDBGrid(Sender).SelectedColor then
      TDBGrid(Sender).Canvas.Brush.Color:=clRed;
  end;
end;

procedure TfrmZaloby.nastav_datumy;
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

procedure TfrmZaloby.btEditaceClick(Sender: TObject);
var
  sql_text,aID: string;
begin
  //try
    if qrMaster.ReadOnly then
    begin
      sql_text:=qrMaster.SQL.Text;
      aID:=qrMaster.FieldByName('ID').AsString;
      qrMaster.Close;
      qrMaster.SQL.Text:='SELECT * FROM ZALOBY WHERE ID = '+aID;
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

procedure TfrmZaloby.btPrijmoutPostuClick(Sender: TObject);
begin
  miPrijmoutPostu.Click;
end;

procedure TfrmZaloby.DBGridDblClick(Sender: TObject);
begin
  inherited;
end;

procedure TfrmZaloby.DBGridDrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  {if (Column.Field.FieldName='INSOLVENCE') and (qrMasterINSOLVENCE.AsInteger=1) then
  begin
    //DBGrid.Canvas.Brush.Color:=clGreen;
    Column.Color:=clRed;
    //DBGrid.Canvas.Font.Color:=clGreen;
  end
  else
  begin
    DBGrid.Canvas.Brush.Color:=clRed;
    //DBGrid.Canvas.Font.Color:=clRed;
  end;
  DBGrid.DefaultDrawColumnCell(Rect,DataCol,Column,State);}
end;

procedure TfrmZaloby.DBGridEnter(Sender: TObject);
begin
  //FActiveDBGrid:=TDBGrid(Sender);
end;

procedure TfrmZaloby.DBGridPrepareCanvas(sender: TObject; DataCol: Integer;
  Column: TColumn; AState: TGridDrawState);
var
  ColCol : TColor;
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

  ColCol:=Column.Color;
  if ((Column.Field.FieldName='INSOLVENCE') and (qrMasterINSOLVENCE.AsInteger=1)) or ((Column.Field.FieldName='SPLATKOVY_KALENDAR') and (qrMasterSPLATKOVY_KALENDAR.AsInteger=1)) then
  begin
    TDBGrid(Sender).Canvas.Brush.Color :=$000683FF;
    //ShowMessage(Column.Field.FieldName);
  end;
  if (((qrMasterINSOLVENCE.AsInteger=1) or (qrMasterSPLATKOVY_KALENDAR.AsInteger=1)) {and (Column.Field.FieldName='JMENO_CP')}) then
  begin
    TDBGrid(Sender).Canvas.Font.Color :=$000048DF; //$000683FF;
    TDBGrid(Sender).Canvas.Font.Style := [fsBold];
  end;
end;

procedure TfrmZaloby.DBGridTitleClick(Column: TColumn);
begin
  inherited;
  trideni(qrMaster,Column,qrMaster.SQL.Text,FMasterSort); //FMasterSQL
  //ShowMessage(qrMaster.SQL.Text);
end;

procedure TfrmZaloby.dsMasterDataChange(Sender: TObject; Field: TField);
begin
  inherited;
  //otevri_zpravy;
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
      if qrMaster.FieldByName('EXEKUTOR').AsString = 'HANAK' then
      begin
        cbExekutor.Color:=$00CDA7B4;
      end
      else
        cbExekutor.Color:=clDefault;

  if (not qrMaster.FieldByName('SKONCENO_DUVOD').IsNull) or (qrMaster.FieldByName('SKONCENO_DUVOD').AsInteger<>0) then  // puvodne ZAPLATIL_CASTKA
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
  if qrMasterINSOLVENCE.AsInteger = 1 then
    lbInsolvence.Color:=$000683FF
  else
    lbInsolvence.Color:=clDefault;
  if qrMasterSPLATKOVY_KALENDAR.AsInteger = 1 then
    lbSplatkKal.Color:=$000683FF
  else
    lbSplatkKal.Color:=clDefault;
end;

procedure TfrmZaloby.edFindKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
end;

procedure TfrmZaloby.FormActivate(Sender: TObject);
begin
  inherited;
end;

procedure TfrmZaloby.FormCreate(Sender: TObject);
begin
  inherited;
  //FActiveDBGrid:=TDBGrid.Create(nil);
  FMasterSQL:=qrMaster.SQL.Text;
  //qrImportZprav.Open;
  qrZpravy.Open;
  nastav_datumy;
  //RadioGroup1Click(nil);
  initComboExekutor(cbExekutor);
  initZobrazit;
end;

procedure TfrmZaloby.FormDestroy(Sender: TObject);
begin
  //if Assigned(FActiveDBGrid) then
  //  FActiveDBGrid.free;
end;

procedure TfrmZaloby.Label50Click(Sender: TObject);
begin

end;

procedure TfrmZaloby.MenuItem3Click(Sender: TObject);
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
              '  TO_CHAR(SYSDATE,''DD.MM.YYYY'') AS AKTUALNI_DATUM,'+
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
              '  ZALOBY Z,'+
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
              '  Z.JMENO_CP||'', nar. ''||GET_DATUM_FROM_RC(Z.RODNE_CISLO) AS JMENO_NAR, '+
              '  CASE GET_POHLAVI_Z_RC(Z.RODNE_CISLO) '+
              '    WHEN 1 THEN ''Vážený pan'' '+
              '    WHEN 0 THEN ''Vážená paní'' '+
              '    WHEN NULL THEN ''Vážený pan/paní'' '+
              '  END AS OSLOVENI, '+
              '  GET_PARAM(''ZALOBY_OZNAMENI_UCET'') AS UCET_OZNAMENI '+
              'FROM '+
              '  ZALOBY Z,'+
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
              '  Z.JMENO_CP||'', nar. ''||GET_DATUM_FROM_RC(Z.RODNE_CISLO) AS JMENO_NAR, '+
              '  CASE GET_POHLAVI_Z_RC(Z.RODNE_CISLO) '+
              '    WHEN 1 THEN ''Vážený pan'' '+
              '    WHEN 0 THEN ''Vážená paní'' '+
              '    WHEN NULL THEN ''Vážený pan/paní'' '+
              '  END AS OSLOVENI, '+
              '  GET_PARAM(''ZALOBY_OZNAMENI_UCET'') AS UCET_OZNAMENI '+
              'FROM '+
              '  ZALOBY Z,'+
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

procedure TfrmZaloby.MenuItem4Click(Sender: TObject);
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
              '  ZALOBY Z,'+
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
              '  ZALOBY Z,'+
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
              '  ZALOBY Z,'+
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

procedure TfrmZaloby.MenuItem5Click(Sender: TObject);
begin
  nastavitUHR_SOP(DBGrid, 'ZALOBY', Navigator.DataSource.DataSet, qrMaster);
end;

procedure TfrmZaloby.miArchivovatClick(Sender: TObject);
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
            '        TELO from zaloby_zpravy where ref_kod in (select ref_kod from zaloby where nvl(uzamcena,0)=1))');
    frmProces.ProgressBar1.StepIt;
    frmProces.Repaint;
    frmProces.ShowOnTop;
    ExecSQL('delete zaloby_zpravy where ref_kod in (select ref_kod from zaloby where nvl(uzamcena,0)=1)');
    frmProces.ProgressBar1.StepIt;
    frmProces.Repaint;
    frmProces.ShowOnTop;
    ExecSQL('insert into zaloby_archiv /*(ID,VAR_SYMB,JMENO_CP,DATUM_CAS,DLUZNA_CASTKA,JIZDNE,POKUTA,RODNE_CISLO,ULICE,CISLO_DOMU,MESTO,'+
            '                OBVOD,PSC,REF_KOD,UZAMCENA,DATUM_IMPORTU,DATUM_UZAMCENI,PL_PRIKAZ,UHRADA,SPLATNOST,SOUD,ZALOBA,NAROK,VS_SOUDU,'+
            '                CU_SOUDU,SPIS_ZNACKA,UHR_SOP,ODVOLANI,JEDNANI,ROZSUDEK,PR_MOC,NAVRH,PRIKAZ,CASTKA,SKONCENO,CISLO,DATUM_UHRADY,'+
            '                ZEMREL,ZAPLATIL_PRED_PODANIM,ZAPLATIL_CASTKA,USNESENI,EXEKUTOR,ZPRAVA_DORUCENI,ZPRAVA_OVERENI,ZPRAVA_PL_ROZKAZ,'+
            '                ZPRAVA_ZAPRACOVANI,VYMOZENO,SKONCENO_DUVOD,INSOLVENCE,SPLATKOVY_KALENDAR,USNESENI_DATUM,OPRAVNE_USNESENI_DATUM,'+
            '                USNESENI_CJ,EXEKUCNI_PRIKAZ)*/ '+
            '(select ID,VAR_SYMB,JMENO_CP,DATUM_CAS,DLUZNA_CASTKA,JIZDNE,POKUTA,RODNE_CISLO,ULICE,CISLO_DOMU,MESTO,'+
            'OBVOD,PSC,REF_KOD,UZAMCENA,DATUM_IMPORTU,DATUM_UZAMCENI,PL_PRIKAZ,UHRADA,SPLATNOST,SOUD,ZALOBA,NAROK,VS_SOUDU,CU_SOUDU,'+
            'SPIS_ZNACKA,UHR_SOP,ODVOLANI,JEDNANI,ROZSUDEK,PR_MOC,NAVRH,PRIKAZ,CASTKA,SKONCENO,CISLO,DATUM_UHRADY,ZEMREL,ZAPLATIL_PRED_PODANIM,'+
            'ZAPLATIL_CASTKA,USNESENI,EXEKUTOR,ZPRAVA_DORUCENI,ZPRAVA_OVERENI,ZPRAVA_PL_ROZKAZ,ZPRAVA_ZAPRACOVANI,VYMOZENO,SKONCENO_DUVOD,'+
            'INSOLVENCE,SPLATKOVY_KALENDAR,USNESENI_DATUM,OPRAVNE_USNESENI_DATUM,USNESENI_CJ,EXEKUCNI_PRIKAZ from zaloby where nvl(uzamcena,0)=1)');
    frmProces.ProgressBar1.StepIt;
    frmProces.Repaint;
    frmProces.ShowOnTop;
    ExecSQL('delete zaloby where nvl(uzamcena,0)=1');
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

procedure TfrmZaloby.miArchivZalobClick(Sender: TObject);
begin
  if not Assigned(frmZalobyArchiv) then
    Application.CreateForm(TfrmZalobyArchiv,frmZalobyArchiv);
  frmZalobyArchiv.qrMaster.Close;
  frmZalobyArchiv.qrMaster.SQL.Text:='SELECT * FROM ZALOBY_ARCHIV ORDER BY ID DESC';
  frmZalobyArchiv.qrMaster.Open;
  frmZalobyArchiv.Show;
end;

procedure TfrmZaloby.miBezGuiduClick(Sender: TObject);
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
              '  ZALOBY Z '+
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
    frmSBezGuidu.frReport.LoadFromFile(Replace_Char(get_param('SESTAVY')+'\','\\','\')+'ZalobyBezGuidu.lrf');
    frmSBezGuidu.frReport.PrepareReport;
    frmSBezGuidu.frReport.ModalPreview:=true;
    frmSBezGuidu.frReport.ShowProgress:=true;
    frmSBezGuidu.frReport.ShowReport;
    frmSBezGuidu.qrMaster.Close;
  end;
end;

procedure TfrmZaloby.miBezUdajuPlatbyClick(Sender: TObject);
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
              '  ZALOBY Z '+
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
    frmSBezUdajuPlatby.frReport.LoadFromFile(Replace_Char(get_param('SESTAVY')+'\','\\','\')+'ZalobyBezUdajuPlatby.lrf');
    frmSBezUdajuPlatby.frReport.PrepareReport;
    frmSBezUdajuPlatby.frReport.ModalPreview:=true;
    frmSBezUdajuPlatby.frReport.ShowProgress:=true;
    frmSBezUdajuPlatby.frReport.ShowReport;
    frmSBezUdajuPlatby.qrMaster.Close;
  end;
end;

procedure TfrmZaloby.miDoplnitDatumPlatbyClick(Sender: TObject);
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

    sql_text:='UPDATE ZALOBY SET UHR_SOP=SYSDATE WHERE NVL(UZAMCENA,0)=0 AND UHR_SOP IS NULL';
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

procedure TfrmZaloby.miDoplnitUdajeClick(Sender: TObject);
begin
  if MessageDlg('Opravdu chcete doplnit údaje ze zpráv?',mtConfirmation,[mbYES,mbNO],0)=mrYES then
  begin
    doplnit_udaje_ze_zprav;
    Refresh_DataSet(Navigator.DataSource.DataSet,qrMaster);
    MessageDlg('Údaje byly doplněny',mtInformation,[mbOK],0);
  end;
end;

procedure TfrmZaloby.miExekuceBayerDomifinClick(Sender: TObject);
var
  sql_text:string;
begin
try
    sql_text:=getTiskExekuce;
    frmSExekuce.qrMaster.Close;
    frmSExekuce.qrMaster.SQL.Text:=sql_text;
    frmSExekuce.qrMaster.Open;
    frmSExekuce.frReport.LoadFromFile(Replace_Char(get_param('SESTAVY')+'\','\\','\')+'SexekuceBayerDomifin.lrf');
    frmSExekuce.frReport.PrepareReport;
    frmSExekuce.frReport.ModalPreview:=true;
    frmSExekuce.frReport.ShowProgress:=true;
    frmSExekuce.frReport.ShowReport;
    frmSExekuce.qrMaster.Close;

  finally
  end;
end;

procedure TfrmZaloby.miExekuceBayerOIClick(Sender: TObject);
var
  sql_text:string;
begin
try
    sql_text:=getTiskExekuce;
    frmSExekuce.qrMaster.Close;
    frmSExekuce.qrMaster.SQL.Text:=sql_text;
    frmSExekuce.qrMaster.Open;
    frmSExekuce.frReport.LoadFromFile(Replace_Char(get_param('SESTAVY')+'\','\\','\')+'SexekuceBayerOI.lrf');
    frmSExekuce.frReport.PrepareReport;
    frmSExekuce.frReport.ModalPreview:=true;
    frmSExekuce.frReport.ShowProgress:=true;
    frmSExekuce.frReport.ShowReport;
    frmSExekuce.qrMaster.Close;

  finally
  end;
end;

procedure TfrmZaloby.miExekuceClick(Sender: TObject);
var
  sql_text:string;
begin
try
  sql_text:=getTiskExekuce;
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

procedure TfrmZaloby.miExekuceHanakOIClick(Sender: TObject);
var
  sql_text:string;
begin
try
  sql_text:=getTiskExekuce;
  frmSExekuce.qrMaster.Close;
  frmSExekuce.qrMaster.SQL.Text:=sql_text;
  frmSExekuce.qrMaster.Open;
  frmSExekuce.frReport.LoadFromFile(Replace_Char(get_param('SESTAVY')+'\','\\','\')+'SexekuceHanakOI.lrf');
  frmSExekuce.frReport.PrepareReport;
  frmSExekuce.frReport.ModalPreview:=true;
  frmSExekuce.frReport.ShowProgress:=true;
  frmSExekuce.frReport.ShowReport;
  frmSExekuce.qrMaster.Close;

finally
end;
end;

function TfrmZaloby.getTiskExekuce: string;
var
  qrTemp : TSQLQuery;
  i : Integer;
  bID1,bID2,bID3,sql_text,temp : string;
  table : TDataSet;
begin

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
              '  DECODE( FLOOR(NVL(Z.NAROK,0)-NVL(DLUZNA_CASTKA,0)), (NVL(Z.NAROK,0)-NVL(DLUZNA_CASTKA,0)), FORMAT_MENA(NVL(Z.NAROK,0)-NVL(DLUZNA_CASTKA,0),0)||'',-'', FORMAT_MENA(NVL(Z.NAROK,0)-NVL(DLUZNA_CASTKA,0),2) ) AS NAKLADY,'+
              '  CEIL((SELECT MAX(SAZBA) FROM EXEKUTORI_SAZBY_ODMEN WHERE CASTKA_OD <= (NVL(Z.NAROK,0)) AND CASTKA_DO >= (NVL(Z.NAROK,0)))) AS SAZBA,'+
              '  CEIL((SELECT MAX(SAZBA) FROM EXEKUTORI_SAZBY_ODMEN WHERE CASTKA_OD <= (NVL(Z.NAROK,0)) AND CASTKA_DO >= (NVL(Z.NAROK,0)))/2) AS PUL_SAZBA,'+
              '  CEIL((((SELECT MAX(SAZBA) FROM EXEKUTORI_SAZBY_ODMEN WHERE CASTKA_OD <= (NVL(Z.NAROK,0)) AND CASTKA_DO >= (NVL(Z.NAROK,0)))/2)+600)*(1.21)) AS ODMENA,'+
              '  DECODE(TRIM(ROZSUDEK),NULL,''vykonatelného elektronického platebního rozkazu č.j. '',''vykonatelného rozsudku č.j. ''||SPIS_ZNACKA||'','') AS ROZROZ,'+

              '  ''Na základě exekučního titulu - ''||DECODE(TRIM(ROZSUDEK),NULL,''vykonatelného elektronického platebního rozkazu č.j. '',''vykonatelného rozsudku č.j. ''||SPIS_ZNACKA||'', '') AS ROZROZ_PAGE0,'+
              '  DECODE(TRIM(ROZSUDEK),NULL,SPIS_ZNACKA,NULL)||'' ze dne ''||TO_CHAR(NVL(ROZSUDEK,PL_PRIKAZ),''DD.MM.YYYY'')||'', ''||'+
              '  DECODE(OPRAVNE_USNESENI_DATUM,null,'''',''ve znění opravného usnesení č.j. ''||USNESENI_CJ||'' ze dne ''||to_char(OPRAVNE_USNESENI_DATUM,''DD.MM.YYYY'')||'', '')||'+
              '  DECODE(OPRAVNE_USNESENI_DATUM,null,''který'',''které'')||'' vydal ''||SOUD||'',''||'+
              '  '' právní moc dne ''||TO_CHAR(PR_MOC,''DD.MM.YYYY'')||'', bylo povinné/mu uloženo zaplatit oprávněné:'' AS ROZROZ_PAGE1,'+

              '  DECODE(TRIM(ROZSUDEK),NULL,SPIS_ZNACKA,NULL)||'' ze dne ''||TO_CHAR(NVL(ROZSUDEK,PL_PRIKAZ),''DD.MM.YYYY'')||'+
              '    DECODE(OPRAVNE_USNESENI_DATUM,null,'''','' ve znění opravného usnesení č.j. ''||USNESENI_CJ) AS ROZROZ_ROW2,'+
              '  DECODE(OPRAVNE_USNESENI_DATUM,null,'''',''ze dne ''||to_char(OPRAVNE_USNESENI_DATUM,''DD.MM.YYYY''))||'+
              '    '', který vydal ''||SOUD||'', právní moc dne ''||TO_CHAR(PR_MOC,''DD.MM.YYYY'')||'', exekuci pro:'' AS ROZROZ_ROW3,'+
              '    DECODE(TRIM(ROZSUDEK),NULL,''vykonatelného elektronického platebního rozkazu č.j. '',''vykonatelného rozsudku č.j.'')||'+
              '    SPIS_ZNACKA||'' ze dne ''||TO_CHAR(NVL(ROZSUDEK,PL_PRIKAZ),''DD.MM.YYYY'')||'', ''||'+
              '    DECODE(OPRAVNE_USNESENI_DATUM,null,'''',''ve znění opravného usnesení č.j. ''||USNESENI_CJ||'' ze dne ''||to_char(OPRAVNE_USNESENI_DATUM,''DD.MM.YYYY'')||'', '')||'+
              '    DECODE(OPRAVNE_USNESENI_DATUM,null,''který'',''které'')||'' vydal ''||SOUD||'',''||'+
              '    '' právní moc dne ''||TO_CHAR(PR_MOC,''DD.MM.YYYY'')||'', k vymožení:'' AS ROZROZ_ROW,'+
              '  TO_CHAR(SYSDATE,''DD.MM.YYYY'') AS AKTUALNI_DATUM,'+
              '  CEIL(DLUZNA_CASTKA) AS DLUZNA_CASTKA_KC, '+
              '  TO_CHAR(SPLATNOST,''DD.MM.YYYY'') AS SPLATNOST_DATUM,'+
              '  TO_CHAR(NVL(ROZSUDEK,PL_PRIKAZ),''DD.MM.YYYY'') AS PL_PRIKAZ_DATUM,'+
              '  TO_CHAR(NVL(ROZSUDEK,PL_PRIKAZ)+1,''DD.MM.YYYY'') AS PL_PRIKAZ_PLUS_DEN,'+
              '  TO_CHAR(PR_MOC,''DD.MM.YYYY'') AS PR_MOC_DATUM,'+
              '  L.KONTAKTNI_OSOBA||''/''||L.KONTAKTNI_OSOBA_TEL AS KONTAKTNI_OSOBA,'+
              '  L.UCET,'+
              '  SOUD||'','' AS SOUD_CARKA,'+
              '  (SELECT UCET_POHLEDAVKA FROM ZALOBY_DAVKY_UCTY WHERE DAVKA = DATUM_IMPORTU) AS UCET_POHLEDAVKA,'+
              '  (SELECT UCET_NAKLADY FROM ZALOBY_DAVKY_UCTY WHERE DAVKA = DATUM_IMPORTU) AS UCET_NAKLADY,'+
              '  L.KOD_BANKY,'+
              '  GET_PARAM(''ZALOBY_DATUM_PREDANI'') AS DATUM_PREDANI,'+
              '  ''ERP ''||Z.VAR_SYMB||'' - FEN'' AS VAR_SYMB_ERP,'+
              '  Z.ULICE||'' ''||Z.CISLO_DOMU AS ULICE_CP, '+
              '  Z.PSC||'' ''||Z.MESTO AS PSC_MESTO, '+
              '  Z.JMENO_CP||'', nar. ''||GET_DATUM_FROM_RC(Z.RODNE_CISLO)||'',bytem ''||Z.ULICE||'' ''||Z.CISLO_DOMU||'', ''||Z.PSC||'' ''||Z.MESTO||'', r.č.: ''||Z.RODNE_CISLO AS JMENO_NAR, '+
              '  CASE GET_POHLAVI_Z_RC(Z.RODNE_CISLO) '+
              '    WHEN 1 THEN ''Vážený pan'' '+
              '    WHEN 0 THEN ''Vážená paní'' '+
              '    WHEN NULL THEN ''Vážený pan/paní'' '+
              '  END AS OSLOVENI, '+
              '  GET_PARAM(''ZALOBY_OZNAMENI_UCET'') AS UCET_OZNAMENI, '+
              'DECODE((SELECT 1 FROM DUAL WHERE Z.SPLATNOST >= to_date(''1.1.2006'',''DD.MM.YYYY'') AND Z.SPLATNOST <= to_date(''30.6.2006'',''DD.MM.YYYY'') AND NVL(ROZSUDEK,PL_PRIKAZ) >= to_date(''1.1.2006'',''DD.MM.YYYY'')), '+
	      '       1, '+
	      '       ''- 9% ročně od ''||to_char(SPLATNOST,''DD.MM.YYYY'')||'' do ''||DECODE((SELECT 1 FROM DUAL WHERE NVL(ROZSUDEK,PL_PRIKAZ) <= to_date(''30.6.2006'',''DD.MM.YYYY'')), 1, to_char(NVL(ROZSUDEK,PL_PRIKAZ),''DD.MM.YYYY''), ''30.6.2006'')||'' z částky'', '+
	      '       DECODE((SELECT 1 FROM DUAL WHERE Z.SPLATNOST <= to_date(''30.6.2006'',''DD.MM.YYYY'') AND NVL(ROZSUDEK,PL_PRIKAZ) >= to_date(''1.1.2006'',''DD.MM.YYYY'')), '+
	      '              1, '+
	      '              ''- 9% ročně od 1.1.2006 do ''||DECODE((SELECT 1 FROM DUAL WHERE NVL(ROZSUDEK,PL_PRIKAZ) <= to_date(''30.6.2006'',''DD.MM.YYYY'')), 1, to_char(NVL(ROZSUDEK,PL_PRIKAZ),''DD.MM.YYYY''), ''30.6.2006'')||'' z částky'', '+
	      '              NULL) '+
	      '       ) AS UROK1, '+
	      'DECODE((SELECT 1 FROM DUAL WHERE Z.SPLATNOST <= to_date(''30.6.2006'',''DD.MM.YYYY'') AND NVL(ROZSUDEK,PL_PRIKAZ) >= to_date(''1.1.2006'',''DD.MM.YYYY'')),1,DLUZNA_CASTKA,NULL) AS CASTKA1, '+
	      'DECODE((SELECT 1 FROM DUAL WHERE Z.SPLATNOST <= to_date(''30.6.2006'',''DD.MM.YYYY'') AND NVL(ROZSUDEK,PL_PRIKAZ) >= to_date(''1.1.2006'',''DD.MM.YYYY'')),1,''Kč'',NULL) AS MENA1, '+
	      ' '+
	      'DECODE((SELECT 1 FROM DUAL WHERE Z.SPLATNOST >= to_date(''1.7.2006'',''DD.MM.YYYY'') AND Z.SPLATNOST <= to_date(''31.12.2006'',''DD.MM.YYYY'') AND NVL(ROZSUDEK,PL_PRIKAZ) >= to_date(''1.7.2006'',''DD.MM.YYYY'')), '+
	      '       1, '+
	      '       ''- 9% ročně od ''||to_char(SPLATNOST,''DD.MM.YYYY'')||'' do ''||DECODE((SELECT 1 FROM DUAL WHERE NVL(ROZSUDEK,PL_PRIKAZ) <= to_date(''31.12.2006'',''DD.MM.YYYY'')), 1, to_char(NVL(ROZSUDEK,PL_PRIKAZ),''DD.MM.YYYY''), ''31.12.2006'')||'' z částky'', '+
	      '       DECODE((SELECT 1 FROM DUAL WHERE Z.SPLATNOST <= to_date(''31.12.2006'',''DD.MM.YYYY'') AND NVL(ROZSUDEK,PL_PRIKAZ) >= to_date(''1.7.2006'',''DD.MM.YYYY'')), '+
	      '              1, '+
	      '              ''- 9% ročně od 1.7.2006 do ''||DECODE((SELECT 1 FROM DUAL WHERE NVL(ROZSUDEK,PL_PRIKAZ) <= to_date(''31.12.2006'',''DD.MM.YYYY'')), 1, to_char(NVL(ROZSUDEK,PL_PRIKAZ),''DD.MM.YYYY''), ''31.12.2006'')||'' z částky'', '+
	      '              NULL) '+
	      '       ) AS UROK2, '+
	      'DECODE((SELECT 1 FROM DUAL WHERE Z.SPLATNOST <= to_date(''31.12.2006'',''DD.MM.YYYY'') AND NVL(ROZSUDEK,PL_PRIKAZ) >= to_date(''1.7.2006'',''DD.MM.YYYY'')),1,DLUZNA_CASTKA,NULL) AS CASTKA2, '+
	      'DECODE((SELECT 1 FROM DUAL WHERE Z.SPLATNOST <= to_date(''31.12.2006'',''DD.MM.YYYY'') AND NVL(ROZSUDEK,PL_PRIKAZ) >= to_date(''1.7.2006'',''DD.MM.YYYY'')),1,''Kč'',NULL) AS MENA2, '+
	      ' '+
	      'DECODE((SELECT 1 FROM DUAL WHERE Z.SPLATNOST >= to_date(''1.1.2007'',''DD.MM.YYYY'') AND Z.SPLATNOST <= to_date(''30.6.2007'',''DD.MM.YYYY'') AND NVL(ROZSUDEK,PL_PRIKAZ) >= to_date(''1.1.2007'',''DD.MM.YYYY'')), '+
	      '       1, '+
	      '       ''- 9,5% ročně od ''||to_char(SPLATNOST,''DD.MM.YYYY'')||'' do ''||DECODE((SELECT 1 FROM DUAL WHERE NVL(ROZSUDEK,PL_PRIKAZ) <= to_date(''30.6.2007'',''DD.MM.YYYY'')), 1, to_char(NVL(ROZSUDEK,PL_PRIKAZ),''DD.MM.YYYY''), ''30.6.2007'')||'' z částky'', '+
	      '       DECODE((SELECT 1 FROM DUAL WHERE Z.SPLATNOST <= to_date(''30.6.2007'',''DD.MM.YYYY'') AND NVL(ROZSUDEK,PL_PRIKAZ) >= to_date(''1.1.2007'',''DD.MM.YYYY'')), '+
	      '              1, '+
	      '              ''- 9,5% ročně od 1.1.2007 do ''||DECODE((SELECT 1 FROM DUAL WHERE NVL(ROZSUDEK,PL_PRIKAZ) <= to_date(''30.6.2007'',''DD.MM.YYYY'')), 1, to_char(NVL(ROZSUDEK,PL_PRIKAZ),''DD.MM.YYYY''), ''30.6.2007'')||'' z částky'', '+
	      '              NULL) '+
	      '       ) AS UROK3, '+
	      'DECODE((SELECT 1 FROM DUAL WHERE Z.SPLATNOST <= to_date(''30.6.2007'',''DD.MM.YYYY'') AND NVL(ROZSUDEK,PL_PRIKAZ) >= to_date(''1.1.2007'',''DD.MM.YYYY'')),1,DLUZNA_CASTKA,NULL) AS CASTKA3, '+
	      'DECODE((SELECT 1 FROM DUAL WHERE Z.SPLATNOST <= to_date(''30.6.2007'',''DD.MM.YYYY'') AND NVL(ROZSUDEK,PL_PRIKAZ) >= to_date(''1.1.2007'',''DD.MM.YYYY'')),1,''Kč'',NULL) AS MENA3, '+
	      ' '+
	      'DECODE((SELECT 1 FROM DUAL WHERE Z.SPLATNOST >= to_date(''1.7.2007'',''DD.MM.YYYY'') AND Z.SPLATNOST <= to_date(''31.12.2007'',''DD.MM.YYYY'') AND NVL(ROZSUDEK,PL_PRIKAZ) >= to_date(''1.7.2007'',''DD.MM.YYYY'')), '+
	      '       1, '+
	      '       ''- 9,75% ročně od ''||to_char(SPLATNOST,''DD.MM.YYYY'')||'' do ''||DECODE((SELECT 1 FROM DUAL WHERE NVL(ROZSUDEK,PL_PRIKAZ) <= to_date(''31.12.2007'',''DD.MM.YYYY'')), 1, to_char(NVL(ROZSUDEK,PL_PRIKAZ),''DD.MM.YYYY''), ''31.12.2007'')||'' z částky'', '+
	      '       DECODE((SELECT 1 FROM DUAL WHERE Z.SPLATNOST <= to_date(''31.12.2007'',''DD.MM.YYYY'') AND NVL(ROZSUDEK,PL_PRIKAZ) >= to_date(''1.7.2007'',''DD.MM.YYYY'')), '+
	      '              1, '+
	      '              ''- 9,75% ročně od 1.7.2007 do ''||DECODE((SELECT 1 FROM DUAL WHERE NVL(ROZSUDEK,PL_PRIKAZ) <= to_date(''31.12.2007'',''DD.MM.YYYY'')), 1, to_char(NVL(ROZSUDEK,PL_PRIKAZ),''DD.MM.YYYY''), ''31.12.2007'')||'' z částky'', '+
	      '              NULL) '+
	      '       ) AS UROK4, '+
	      'DECODE((SELECT 1 FROM DUAL WHERE Z.SPLATNOST <= to_date(''31.12.2007'',''DD.MM.YYYY'') AND NVL(ROZSUDEK,PL_PRIKAZ) >= to_date(''1.7.2007'',''DD.MM.YYYY'')),1,DLUZNA_CASTKA,NULL) AS CASTKA4, '+
	      'DECODE((SELECT 1 FROM DUAL WHERE Z.SPLATNOST <= to_date(''31.12.2007'',''DD.MM.YYYY'') AND NVL(ROZSUDEK,PL_PRIKAZ) >= to_date(''1.7.2007'',''DD.MM.YYYY'')),1,''Kč'',NULL) AS MENA4, '+
	      ' '+
	      'DECODE((SELECT 1 FROM DUAL WHERE Z.SPLATNOST >= to_date(''1.1.2008'',''DD.MM.YYYY'') AND Z.SPLATNOST <= to_date(''30.6.2008'',''DD.MM.YYYY'') AND NVL(ROZSUDEK,PL_PRIKAZ) >= to_date(''1.1.2008'',''DD.MM.YYYY'')), '+
	      '       1, '+
	      '       ''- 10,5% ročně od ''||to_char(SPLATNOST,''DD.MM.YYYY'')||'' do ''||DECODE((SELECT 1 FROM DUAL WHERE NVL(ROZSUDEK,PL_PRIKAZ) <= to_date(''30.6.2008'',''DD.MM.YYYY'')), 1, to_char(NVL(ROZSUDEK,PL_PRIKAZ),''DD.MM.YYYY''), ''30.6.2008'')||'' z částky'', '+
	      '       DECODE((SELECT 1 FROM DUAL WHERE Z.SPLATNOST <= to_date(''30.6.2008'',''DD.MM.YYYY'') AND NVL(ROZSUDEK,PL_PRIKAZ) >= to_date(''1.1.2008'',''DD.MM.YYYY'')), '+
	      '              1, '+
	      '              ''- 10,5% ročně od 1.1.2008 do ''||DECODE((SELECT 1 FROM DUAL WHERE NVL(ROZSUDEK,PL_PRIKAZ) <= to_date(''30.6.2008'',''DD.MM.YYYY'')), 1, to_char(NVL(ROZSUDEK,PL_PRIKAZ),''DD.MM.YYYY''), ''30.6.2008'')||'' z částky'', '+
	      '              NULL) '+
	      '       ) AS UROK5, '+
	      'DECODE((SELECT 1 FROM DUAL WHERE Z.SPLATNOST <= to_date(''30.6.2008'',''DD.MM.YYYY'') AND NVL(ROZSUDEK,PL_PRIKAZ) >= to_date(''1.1.2008'',''DD.MM.YYYY'')),1,DLUZNA_CASTKA,NULL) AS CASTKA5, '+
	      'DECODE((SELECT 1 FROM DUAL WHERE Z.SPLATNOST <= to_date(''30.6.2008'',''DD.MM.YYYY'') AND NVL(ROZSUDEK,PL_PRIKAZ) >= to_date(''1.1.2008'',''DD.MM.YYYY'')),1,''Kč'',NULL) AS MENA5, '+
	      ' '+
	      'DECODE((SELECT 1 FROM DUAL WHERE Z.SPLATNOST >= to_date(''1.7.2008'',''DD.MM.YYYY'') AND Z.SPLATNOST <= to_date(''31.12.2008'',''DD.MM.YYYY'') AND NVL(ROZSUDEK,PL_PRIKAZ) >= to_date(''1.7.2008'',''DD.MM.YYYY'')), '+
	      '       1, '+
	      '       ''- 10,75% ročně od ''||to_char(SPLATNOST,''DD.MM.YYYY'')||'' do ''||DECODE((SELECT 1 FROM DUAL WHERE NVL(ROZSUDEK,PL_PRIKAZ) <= to_date(''31.12.2008'',''DD.MM.YYYY'')), 1, to_char(NVL(ROZSUDEK,PL_PRIKAZ),''DD.MM.YYYY''), ''31.12.2008'')||'' z částky'', '+
	      '       DECODE((SELECT 1 FROM DUAL WHERE Z.SPLATNOST <= to_date(''31.12.2008'',''DD.MM.YYYY'') AND NVL(ROZSUDEK,PL_PRIKAZ) >= to_date(''1.7.2008'',''DD.MM.YYYY'')), '+
	      '              1, '+
	      '              ''- 10,75% ročně od 1.7.2008 do ''||DECODE((SELECT 1 FROM DUAL WHERE NVL(ROZSUDEK,PL_PRIKAZ) <= to_date(''31.12.2008'',''DD.MM.YYYY'')), 1, to_char(NVL(ROZSUDEK,PL_PRIKAZ),''DD.MM.YYYY''), ''31.12.2008'')||'' z částky'', '+
	      '              NULL) '+
	      '       ) AS UROK6, '+
	      'DECODE((SELECT 1 FROM DUAL WHERE Z.SPLATNOST <= to_date(''31.12.2008'',''DD.MM.YYYY'') AND NVL(ROZSUDEK,PL_PRIKAZ) >= to_date(''1.7.2008'',''DD.MM.YYYY'')),1,DLUZNA_CASTKA,NULL) AS CASTKA6, '+
	      'DECODE((SELECT 1 FROM DUAL WHERE Z.SPLATNOST <= to_date(''31.12.2008'',''DD.MM.YYYY'') AND NVL(ROZSUDEK,PL_PRIKAZ) >= to_date(''1.7.2008'',''DD.MM.YYYY'')),1,''Kč'',NULL) AS MENA6, '+
	      ' '+
	      'DECODE((SELECT 1 FROM DUAL WHERE Z.SPLATNOST >= to_date(''1.1.2009'',''DD.MM.YYYY'') AND Z.SPLATNOST <= to_date(''30.6.2009'',''DD.MM.YYYY'') AND NVL(ROZSUDEK,PL_PRIKAZ) >= to_date(''1.1.2009'',''DD.MM.YYYY'')), '+
	      '       1, '+
	      '       ''- 9,25% ročně od ''||to_char(SPLATNOST,''DD.MM.YYYY'')||'' do ''||DECODE((SELECT 1 FROM DUAL WHERE NVL(ROZSUDEK,PL_PRIKAZ) <= to_date(''30.6.2009'',''DD.MM.YYYY'')), 1, to_char(NVL(ROZSUDEK,PL_PRIKAZ),''DD.MM.YYYY''), ''30.6.2009'')||'' z částky'', '+
	      '       DECODE((SELECT 1 FROM DUAL WHERE Z.SPLATNOST <= to_date(''30.6.2009'',''DD.MM.YYYY'') AND NVL(ROZSUDEK,PL_PRIKAZ) >= to_date(''1.1.2009'',''DD.MM.YYYY'')), '+
	      '              1, '+
	      '              ''- 9,25% ročně od 1.1.2009 do ''||DECODE((SELECT 1 FROM DUAL WHERE NVL(ROZSUDEK,PL_PRIKAZ) <= to_date(''30.6.2009'',''DD.MM.YYYY'')), 1, to_char(NVL(ROZSUDEK,PL_PRIKAZ),''DD.MM.YYYY''), ''30.6.2009'')||'' z částky'', '+
	      '              NULL) '+
	      '       ) AS UROK7, '+
	      'DECODE((SELECT 1 FROM DUAL WHERE Z.SPLATNOST <= to_date(''30.6.2009'',''DD.MM.YYYY'') AND NVL(ROZSUDEK,PL_PRIKAZ) >= to_date(''1.1.2009'',''DD.MM.YYYY'')),1,DLUZNA_CASTKA,NULL) AS CASTKA7, '+
	      'DECODE((SELECT 1 FROM DUAL WHERE Z.SPLATNOST <= to_date(''30.6.2009'',''DD.MM.YYYY'') AND NVL(ROZSUDEK,PL_PRIKAZ) >= to_date(''1.1.2009'',''DD.MM.YYYY'')),1,''Kč'',NULL) AS MENA7, '+
	      ' '+
	      'DECODE((SELECT 1 FROM DUAL WHERE Z.SPLATNOST >= to_date(''1.7.2009'',''DD.MM.YYYY'') AND Z.SPLATNOST <= to_date(''31.12.2009'',''DD.MM.YYYY'') AND NVL(ROZSUDEK,PL_PRIKAZ) >= to_date(''1.7.2009'',''DD.MM.YYYY'')), '+
	      '       1, '+
	      '       ''- 8,5% ročně od ''||to_char(SPLATNOST,''DD.MM.YYYY'')||'' do ''||DECODE((SELECT 1 FROM DUAL WHERE NVL(ROZSUDEK,PL_PRIKAZ) <= to_date(''31.12.2009'',''DD.MM.YYYY'')), 1, to_char(NVL(ROZSUDEK,PL_PRIKAZ),''DD.MM.YYYY''), ''31.12.2009'')||'' z částky'', '+
	      '       DECODE((SELECT 1 FROM DUAL WHERE Z.SPLATNOST <= to_date(''31.12.2009'',''DD.MM.YYYY'') AND NVL(ROZSUDEK,PL_PRIKAZ) >= to_date(''1.7.2009'',''DD.MM.YYYY'')), '+
	      '              1, '+
	      '              ''- 8,5% ročně od 1.7.2009 do ''||DECODE((SELECT 1 FROM DUAL WHERE NVL(ROZSUDEK,PL_PRIKAZ) <= to_date(''31.12.2009'',''DD.MM.YYYY'')), 1, to_char(NVL(ROZSUDEK,PL_PRIKAZ),''DD.MM.YYYY''), ''31.12.2009'')||'' z částky'', '+
	      '              NULL) '+
	      '       ) AS UROK8, '+
	      'DECODE((SELECT 1 FROM DUAL WHERE Z.SPLATNOST <= to_date(''31.12.2009'',''DD.MM.YYYY'') AND NVL(ROZSUDEK,PL_PRIKAZ) >= to_date(''1.7.2009'',''DD.MM.YYYY'')),1,DLUZNA_CASTKA,NULL) AS CASTKA8, '+
	      'DECODE((SELECT 1 FROM DUAL WHERE Z.SPLATNOST <= to_date(''31.12.2009'',''DD.MM.YYYY'') AND NVL(ROZSUDEK,PL_PRIKAZ) >= to_date(''1.7.2009'',''DD.MM.YYYY'')),1,''Kč'',NULL) AS MENA8, '+
	      ' '+
	      'DECODE((SELECT 1 FROM DUAL WHERE Z.SPLATNOST >= to_date(''1.1.2010'',''DD.MM.YYYY'') AND Z.SPLATNOST <= to_date(''30.6.2010'',''DD.MM.YYYY'') AND NVL(ROZSUDEK,PL_PRIKAZ) >= to_date(''1.1.2010'',''DD.MM.YYYY'')), '+
	      '       1, '+
	      '       ''- 8% ročně od ''||to_char(SPLATNOST,''DD.MM.YYYY'')||'' do ''||DECODE((SELECT 1 FROM DUAL WHERE NVL(ROZSUDEK,PL_PRIKAZ) <= to_date(''30.6.2010'',''DD.MM.YYYY'')), 1, to_char(NVL(ROZSUDEK,PL_PRIKAZ),''DD.MM.YYYY''), ''30.6.2010'')||'' z částky'', '+
	      '       DECODE((SELECT 1 FROM DUAL WHERE Z.SPLATNOST <= to_date(''30.6.2010'',''DD.MM.YYYY'') AND NVL(ROZSUDEK,PL_PRIKAZ) >= to_date(''1.1.2010'',''DD.MM.YYYY'')), '+
	      '              1, '+
	      '              ''- 8% ročně od 1.1.2010 do ''||DECODE((SELECT 1 FROM DUAL WHERE NVL(ROZSUDEK,PL_PRIKAZ) <= to_date(''30.6.2010'',''DD.MM.YYYY'')), 1, to_char(NVL(ROZSUDEK,PL_PRIKAZ),''DD.MM.YYYY''), ''30.6.2010'')||'' z částky'', '+
	      '              NULL) '+
	      '       ) AS UROK9, '+
	      'DECODE((SELECT 1 FROM DUAL WHERE Z.SPLATNOST <= to_date(''30.6.2010'',''DD.MM.YYYY'') AND NVL(ROZSUDEK,PL_PRIKAZ) >= to_date(''1.1.2010'',''DD.MM.YYYY'')),1,DLUZNA_CASTKA,NULL) AS CASTKA9, '+
	      'DECODE((SELECT 1 FROM DUAL WHERE Z.SPLATNOST <= to_date(''30.6.2010'',''DD.MM.YYYY'') AND NVL(ROZSUDEK,PL_PRIKAZ) >= to_date(''1.1.2010'',''DD.MM.YYYY'')),1,''Kč'',NULL) AS MENA9, '+
	      ' '+
	      'DECODE((SELECT 1 FROM DUAL WHERE Z.SPLATNOST >= to_date(''1.7.2010'',''DD.MM.YYYY'') AND Z.SPLATNOST <= to_date(''30.6.2012'',''DD.MM.YYYY'') AND NVL(ROZSUDEK,PL_PRIKAZ) >= to_date(''1.7.2010'',''DD.MM.YYYY'')), '+
	      '       1, '+
	      '       ''- 7,75% ročně od ''||to_char(SPLATNOST,''DD.MM.YYYY'')||'' do ''||DECODE((SELECT 1 FROM DUAL WHERE NVL(ROZSUDEK,PL_PRIKAZ) <= to_date(''30.6.2012'',''DD.MM.YYYY'')), 1, to_char(NVL(ROZSUDEK,PL_PRIKAZ),''DD.MM.YYYY''), ''30.6.2012'')||'' z částky'', '+
	      '       DECODE((SELECT 1 FROM DUAL WHERE Z.SPLATNOST <= to_date(''30.6.2012'',''DD.MM.YYYY'') AND NVL(ROZSUDEK,PL_PRIKAZ) >= to_date(''1.7.2010'',''DD.MM.YYYY'')), '+
	      '              1, '+
	      '              ''- 7,75% ročně od 1.7.2010 do ''||DECODE((SELECT 1 FROM DUAL WHERE NVL(ROZSUDEK,PL_PRIKAZ) <= to_date(''30.6.2012'',''DD.MM.YYYY'')), 1, to_char(NVL(ROZSUDEK,PL_PRIKAZ),''DD.MM.YYYY''), ''30.6.2012'')||'' z částky'', '+
	      '              NULL) '+
	      '       ) AS UROK10, '+
	      'DECODE((SELECT 1 FROM DUAL WHERE Z.SPLATNOST <= to_date(''30.6.2012'',''DD.MM.YYYY'') AND NVL(ROZSUDEK,PL_PRIKAZ) >= to_date(''1.7.2010'',''DD.MM.YYYY'')),1,DLUZNA_CASTKA,NULL) AS CASTKA10, '+
	      'DECODE((SELECT 1 FROM DUAL WHERE Z.SPLATNOST <= to_date(''30.6.2012'',''DD.MM.YYYY'') AND NVL(ROZSUDEK,PL_PRIKAZ) >= to_date(''1.7.2010'',''DD.MM.YYYY'')),1,''Kč'',NULL) AS MENA10, '+
	      ' '+
	      'DECODE((SELECT 1 FROM DUAL WHERE Z.SPLATNOST >= to_date(''1.7.2012'',''DD.MM.YYYY'') AND Z.SPLATNOST <= to_date(''31.12.2012'',''DD.MM.YYYY'') AND NVL(ROZSUDEK,PL_PRIKAZ) >= to_date(''1.7.2012'',''DD.MM.YYYY'')), '+
	      '       1, '+
	      '       ''- 7,5% ročně od ''||to_char(SPLATNOST,''DD.MM.YYYY'')||'' do ''||DECODE((SELECT 1 FROM DUAL WHERE NVL(ROZSUDEK,PL_PRIKAZ) <= to_date(''31.12.2012'',''DD.MM.YYYY'')), 1, to_char(NVL(ROZSUDEK,PL_PRIKAZ),''DD.MM.YYYY''), ''31.12.2012'')||'' z částky'', '+
	      '       DECODE((SELECT 1 FROM DUAL WHERE Z.SPLATNOST <= to_date(''31.12.2012'',''DD.MM.YYYY'') AND NVL(ROZSUDEK,PL_PRIKAZ) >= to_date(''1.7.2012'',''DD.MM.YYYY'')), '+
	      '              1, '+
	      '              ''- 7,5% ročně od 1.7.2012 do ''||DECODE((SELECT 1 FROM DUAL WHERE NVL(ROZSUDEK,PL_PRIKAZ) <= to_date(''31.12.2012'',''DD.MM.YYYY'')), 1, to_char(NVL(ROZSUDEK,PL_PRIKAZ),''DD.MM.YYYY''), ''31.12.2012'')||'' z částky'', '+
	      '              NULL) '+
	      '       ) AS UROK11, '+
	      'DECODE((SELECT 1 FROM DUAL WHERE Z.SPLATNOST <= to_date(''31.12.2012'',''DD.MM.YYYY'') AND NVL(ROZSUDEK,PL_PRIKAZ) >= to_date(''1.7.2012'',''DD.MM.YYYY'')),1,DLUZNA_CASTKA,NULL) AS CASTKA11, '+
	      'DECODE((SELECT 1 FROM DUAL WHERE Z.SPLATNOST <= to_date(''31.12.2012'',''DD.MM.YYYY'') AND NVL(ROZSUDEK,PL_PRIKAZ) >= to_date(''1.7.2012'',''DD.MM.YYYY'')),1,''Kč'',NULL) AS MENA11, '+
	      ' '+
	      'DECODE((SELECT 1 FROM DUAL WHERE Z.SPLATNOST >= to_date(''1.1.2013'',''DD.MM.YYYY'') AND NVL(ROZSUDEK,PL_PRIKAZ) >= to_date(''1.1.2013'',''DD.MM.YYYY'')), '+
	      '       1, '+
	      '       ''- 7,05% ročně od ''||to_char(SPLATNOST,''DD.MM.YYYY'')||'' do ''||to_char(NVL(ROZSUDEK,PL_PRIKAZ),''DD.MM.YYYY'')||'' z částky'', '+
	      '       DECODE((SELECT 1 FROM DUAL WHERE Z.SPLATNOST < to_date(''1.1.2013'',''DD.MM.YYYY'') AND NVL(ROZSUDEK,PL_PRIKAZ) >= to_date(''1.1.2013'',''DD.MM.YYYY'')), '+
	      '              1, '+
	      '              ''- 7,05% ročně od 1.1.2013 do ''||to_char(NVL(ROZSUDEK,PL_PRIKAZ),''DD.MM.YYYY'')||'' z částky'', '+
	      '              NULL) '+
	      '       ) AS UROK12, '+
	      'DECODE((SELECT 1 FROM DUAL WHERE NVL(ROZSUDEK,PL_PRIKAZ) >= to_date(''1.1.2013'',''DD.MM.YYYY'')), 1, DLUZNA_CASTKA, NULL) AS CASTKA12, '+
	      'DECODE((SELECT 1 FROM DUAL WHERE NVL(ROZSUDEK,PL_PRIKAZ) >= to_date(''1.1.2013'',''DD.MM.YYYY'')), 1, ''Kč'', NULL) AS MENA12 '+
              'FROM '+
              '  ZALOBY Z,'+
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
              '  DECODE( FLOOR(NVL(Z.NAROK,0)-NVL(DLUZNA_CASTKA,0)), (NVL(Z.NAROK,0)-NVL(DLUZNA_CASTKA,0)), FORMAT_MENA(NVL(Z.NAROK,0)-NVL(DLUZNA_CASTKA,0),0)||'',-'', FORMAT_MENA(NVL(Z.NAROK,0)-NVL(DLUZNA_CASTKA,0),2) ) AS NAKLADY,'+
              '  CEIL((SELECT MAX(SAZBA) FROM EXEKUTORI_SAZBY_ODMEN WHERE CASTKA_OD <= (NVL(Z.NAROK,0)) AND CASTKA_DO >= (NVL(Z.NAROK,0)))) AS SAZBA,'+
              '  CEIL((SELECT MAX(SAZBA) FROM EXEKUTORI_SAZBY_ODMEN WHERE CASTKA_OD <= (NVL(Z.NAROK,0)) AND CASTKA_DO >= (NVL(Z.NAROK,0)))/2) AS PUL_SAZBA,'+
              '  CEIL((((SELECT MAX(SAZBA) FROM EXEKUTORI_SAZBY_ODMEN WHERE CASTKA_OD <= (NVL(Z.NAROK,0)) AND CASTKA_DO >= (NVL(Z.NAROK,0)))/2)+600)*(1.21)) AS ODMENA,'+
              '  DECODE(TRIM(ROZSUDEK),NULL,''vykonatelného elektronického platebního rozkazu č.j. '',''vykonatelného rozsudku č.j. ''||SPIS_ZNACKA||'','') AS ROZROZ,'+

              '  ''Na základě exekučního titulu - ''||DECODE(TRIM(ROZSUDEK),NULL,''vykonatelného elektronického platebního rozkazu č.j. '',''vykonatelného rozsudku č.j. ''||SPIS_ZNACKA||'', '') AS ROZROZ_PAGE0,'+
              '  DECODE(TRIM(ROZSUDEK),NULL,SPIS_ZNACKA,NULL)||'' ze dne ''||TO_CHAR(NVL(ROZSUDEK,PL_PRIKAZ),''DD.MM.YYYY'')||'', ''||'+
              '  DECODE(OPRAVNE_USNESENI_DATUM,null,'''',''ve znění opravného usnesení č.j. ''||USNESENI_CJ||'' ze dne ''||to_char(OPRAVNE_USNESENI_DATUM,''DD.MM.YYYY'')||'', '')||'+
              '  DECODE(OPRAVNE_USNESENI_DATUM,null,''který'',''které'')||'' vydal ''||SOUD||'',''||'+
              '  '' právní moc dne ''||TO_CHAR(PR_MOC,''DD.MM.YYYY'')||'', bylo povinné/mu uloženo zaplatit oprávněné:'' AS ROZROZ_PAGE1,'+

              '  DECODE(TRIM(ROZSUDEK),NULL,SPIS_ZNACKA,NULL)||'' ze dne ''||TO_CHAR(NVL(ROZSUDEK,PL_PRIKAZ),''DD.MM.YYYY'')||'+
              '    DECODE(OPRAVNE_USNESENI_DATUM,null,'''','' ve znění opravného usnesení č.j. ''||USNESENI_CJ) AS ROZROZ_ROW2,'+
              '  DECODE(OPRAVNE_USNESENI_DATUM,null,'''',''ze dne ''||to_char(OPRAVNE_USNESENI_DATUM,''DD.MM.YYYY''))||'+
              '    '', který vydal ''||SOUD||'', právní moc dne ''||TO_CHAR(PR_MOC,''DD.MM.YYYY'')||'', exekuci pro:'' AS ROZROZ_ROW3,'+
              '    DECODE(TRIM(ROZSUDEK),NULL,''vykonatelného elektronického platebního rozkazu č.j. '',''vykonatelného rozsudku č.j.'')||'+
              '    SPIS_ZNACKA||'' ze dne ''||TO_CHAR(NVL(ROZSUDEK,PL_PRIKAZ),''DD.MM.YYYY'')||'', ''||'+
              '    DECODE(OPRAVNE_USNESENI_DATUM,null,'''',''ve znění opravného usnesení č.j. ''||USNESENI_CJ||'' ze dne ''||to_char(OPRAVNE_USNESENI_DATUM,''DD.MM.YYYY'')||'', '')||'+
              '    DECODE(OPRAVNE_USNESENI_DATUM,null,''který'',''které'')||'' vydal ''||SOUD||'',''||'+
              '    '' právní moc dne ''||TO_CHAR(PR_MOC,''DD.MM.YYYY'')||'', k vymožení:'' AS ROZROZ_ROW,'+
              '  TO_CHAR(SYSDATE,''DD.MM.YYYY'') AS AKTUALNI_DATUM,'+
              '  CEIL(DLUZNA_CASTKA) AS DLUZNA_CASTKA_KC, '+
              '  TO_CHAR(SPLATNOST,''DD.MM.YYYY'') AS SPLATNOST_DATUM,'+
              '  TO_CHAR(NVL(ROZSUDEK,PL_PRIKAZ),''DD.MM.YYYY'') AS PL_PRIKAZ_DATUM,'+
              '  TO_CHAR(NVL(ROZSUDEK,PL_PRIKAZ)+1,''DD.MM.YYYY'') AS PL_PRIKAZ_PLUS_DEN,'+
              '  TO_CHAR(PR_MOC,''DD.MM.YYYY'') AS PR_MOC_DATUM,'+
              '  L.KONTAKTNI_OSOBA||''/''||L.KONTAKTNI_OSOBA_TEL AS KONTAKTNI_OSOBA,'+
              '  L.UCET,'+
              '  SOUD||'','' AS SOUD_CARKA,'+
              '  (SELECT UCET_POHLEDAVKA FROM ZALOBY_DAVKY_UCTY WHERE DAVKA = DATUM_IMPORTU) AS UCET_POHLEDAVKA,'+
              '  (SELECT UCET_NAKLADY FROM ZALOBY_DAVKY_UCTY WHERE DAVKA = DATUM_IMPORTU) AS UCET_NAKLADY,'+
              '  L.KOD_BANKY,'+
              '  GET_PARAM(''ZALOBY_DATUM_PREDANI'') AS DATUM_PREDANI,'+
              '  ''ERP ''||Z.VAR_SYMB||'' - FEN'' AS VAR_SYMB_ERP,'+
              '  Z.ULICE||'' ''||Z.CISLO_DOMU AS ULICE_CP, '+
              '  Z.PSC||'' ''||Z.MESTO AS PSC_MESTO, '+
              '  Z.JMENO_CP||'', nar. ''||GET_DATUM_FROM_RC(Z.RODNE_CISLO)||'',bytem ''||Z.ULICE||'' ''||Z.CISLO_DOMU||'', ''||Z.PSC||'' ''||Z.MESTO||'', r.č.: ''||Z.RODNE_CISLO AS JMENO_NAR, '+
              '  CASE GET_POHLAVI_Z_RC(Z.RODNE_CISLO) '+
              '    WHEN 1 THEN ''Vážený pan'' '+
              '    WHEN 0 THEN ''Vážená paní'' '+
              '    WHEN NULL THEN ''Vážený pan/paní'' '+
              '  END AS OSLOVENI, '+
              '  GET_PARAM(''ZALOBY_OZNAMENI_UCET'') AS UCET_OZNAMENI, '+
              'DECODE((SELECT 1 FROM DUAL WHERE Z.SPLATNOST >= to_date(''1.1.2006'',''DD.MM.YYYY'') AND Z.SPLATNOST <= to_date(''30.6.2006'',''DD.MM.YYYY'') AND NVL(ROZSUDEK,PL_PRIKAZ) >= to_date(''1.1.2006'',''DD.MM.YYYY'')), '+
	      '       1, '+
	      '       ''- 9% ročně od ''||to_char(SPLATNOST,''DD.MM.YYYY'')||'' do ''||DECODE((SELECT 1 FROM DUAL WHERE NVL(ROZSUDEK,PL_PRIKAZ) <= to_date(''30.6.2006'',''DD.MM.YYYY'')), 1, to_char(NVL(ROZSUDEK,PL_PRIKAZ),''DD.MM.YYYY''), ''30.6.2006'')||'' z částky'', '+
	      '       DECODE((SELECT 1 FROM DUAL WHERE Z.SPLATNOST <= to_date(''30.6.2006'',''DD.MM.YYYY'') AND NVL(ROZSUDEK,PL_PRIKAZ) >= to_date(''1.1.2006'',''DD.MM.YYYY'')), '+
	      '              1, '+
	      '              ''- 9% ročně od 1.1.2006 do ''||DECODE((SELECT 1 FROM DUAL WHERE NVL(ROZSUDEK,PL_PRIKAZ) <= to_date(''30.6.2006'',''DD.MM.YYYY'')), 1, to_char(NVL(ROZSUDEK,PL_PRIKAZ),''DD.MM.YYYY''), ''30.6.2006'')||'' z částky'', '+
	      '              NULL) '+
	      '       ) AS UROK1, '+
	      'DECODE((SELECT 1 FROM DUAL WHERE Z.SPLATNOST <= to_date(''30.6.2006'',''DD.MM.YYYY'') AND NVL(ROZSUDEK,PL_PRIKAZ) >= to_date(''1.1.2006'',''DD.MM.YYYY'')),1,DLUZNA_CASTKA,NULL) AS CASTKA1, '+
	      'DECODE((SELECT 1 FROM DUAL WHERE Z.SPLATNOST <= to_date(''30.6.2006'',''DD.MM.YYYY'') AND NVL(ROZSUDEK,PL_PRIKAZ) >= to_date(''1.1.2006'',''DD.MM.YYYY'')),1,''Kč'',NULL) AS MENA1, '+
	      ' '+
	      'DECODE((SELECT 1 FROM DUAL WHERE Z.SPLATNOST >= to_date(''1.7.2006'',''DD.MM.YYYY'') AND Z.SPLATNOST <= to_date(''31.12.2006'',''DD.MM.YYYY'') AND NVL(ROZSUDEK,PL_PRIKAZ) >= to_date(''1.7.2006'',''DD.MM.YYYY'')), '+
	      '       1, '+
	      '       ''- 9% ročně od ''||to_char(SPLATNOST,''DD.MM.YYYY'')||'' do ''||DECODE((SELECT 1 FROM DUAL WHERE NVL(ROZSUDEK,PL_PRIKAZ) <= to_date(''31.12.2006'',''DD.MM.YYYY'')), 1, to_char(NVL(ROZSUDEK,PL_PRIKAZ),''DD.MM.YYYY''), ''31.12.2006'')||'' z částky'', '+
	      '       DECODE((SELECT 1 FROM DUAL WHERE Z.SPLATNOST <= to_date(''31.12.2006'',''DD.MM.YYYY'') AND NVL(ROZSUDEK,PL_PRIKAZ) >= to_date(''1.7.2006'',''DD.MM.YYYY'')), '+
	      '              1, '+
	      '              ''- 9% ročně od 1.7.2006 do ''||DECODE((SELECT 1 FROM DUAL WHERE NVL(ROZSUDEK,PL_PRIKAZ) <= to_date(''31.12.2006'',''DD.MM.YYYY'')), 1, to_char(NVL(ROZSUDEK,PL_PRIKAZ),''DD.MM.YYYY''), ''31.12.2006'')||'' z částky'', '+
	      '              NULL) '+
	      '       ) AS UROK2, '+
	      'DECODE((SELECT 1 FROM DUAL WHERE Z.SPLATNOST <= to_date(''31.12.2006'',''DD.MM.YYYY'') AND NVL(ROZSUDEK,PL_PRIKAZ) >= to_date(''1.7.2006'',''DD.MM.YYYY'')),1,DLUZNA_CASTKA,NULL) AS CASTKA2, '+
	      'DECODE((SELECT 1 FROM DUAL WHERE Z.SPLATNOST <= to_date(''31.12.2006'',''DD.MM.YYYY'') AND NVL(ROZSUDEK,PL_PRIKAZ) >= to_date(''1.7.2006'',''DD.MM.YYYY'')),1,''Kč'',NULL) AS MENA2, '+
	      ' '+
	      'DECODE((SELECT 1 FROM DUAL WHERE Z.SPLATNOST >= to_date(''1.1.2007'',''DD.MM.YYYY'') AND Z.SPLATNOST <= to_date(''30.6.2007'',''DD.MM.YYYY'') AND NVL(ROZSUDEK,PL_PRIKAZ) >= to_date(''1.1.2007'',''DD.MM.YYYY'')), '+
	      '       1, '+
	      '       ''- 9,5% ročně od ''||to_char(SPLATNOST,''DD.MM.YYYY'')||'' do ''||DECODE((SELECT 1 FROM DUAL WHERE NVL(ROZSUDEK,PL_PRIKAZ) <= to_date(''30.6.2007'',''DD.MM.YYYY'')), 1, to_char(NVL(ROZSUDEK,PL_PRIKAZ),''DD.MM.YYYY''), ''30.6.2007'')||'' z částky'', '+
	      '       DECODE((SELECT 1 FROM DUAL WHERE Z.SPLATNOST <= to_date(''30.6.2007'',''DD.MM.YYYY'') AND NVL(ROZSUDEK,PL_PRIKAZ) >= to_date(''1.1.2007'',''DD.MM.YYYY'')), '+
	      '              1, '+
	      '              ''- 9,5% ročně od 1.1.2007 do ''||DECODE((SELECT 1 FROM DUAL WHERE NVL(ROZSUDEK,PL_PRIKAZ) <= to_date(''30.6.2007'',''DD.MM.YYYY'')), 1, to_char(NVL(ROZSUDEK,PL_PRIKAZ),''DD.MM.YYYY''), ''30.6.2007'')||'' z částky'', '+
	      '              NULL) '+
	      '       ) AS UROK3, '+
	      'DECODE((SELECT 1 FROM DUAL WHERE Z.SPLATNOST <= to_date(''30.6.2007'',''DD.MM.YYYY'') AND NVL(ROZSUDEK,PL_PRIKAZ) >= to_date(''1.1.2007'',''DD.MM.YYYY'')),1,DLUZNA_CASTKA,NULL) AS CASTKA3, '+
	      'DECODE((SELECT 1 FROM DUAL WHERE Z.SPLATNOST <= to_date(''30.6.2007'',''DD.MM.YYYY'') AND NVL(ROZSUDEK,PL_PRIKAZ) >= to_date(''1.1.2007'',''DD.MM.YYYY'')),1,''Kč'',NULL) AS MENA3, '+
	      ' '+
	      'DECODE((SELECT 1 FROM DUAL WHERE Z.SPLATNOST >= to_date(''1.7.2007'',''DD.MM.YYYY'') AND Z.SPLATNOST <= to_date(''31.12.2007'',''DD.MM.YYYY'') AND NVL(ROZSUDEK,PL_PRIKAZ) >= to_date(''1.7.2007'',''DD.MM.YYYY'')), '+
	      '       1, '+
	      '       ''- 9,75% ročně od ''||to_char(SPLATNOST,''DD.MM.YYYY'')||'' do ''||DECODE((SELECT 1 FROM DUAL WHERE NVL(ROZSUDEK,PL_PRIKAZ) <= to_date(''31.12.2007'',''DD.MM.YYYY'')), 1, to_char(NVL(ROZSUDEK,PL_PRIKAZ),''DD.MM.YYYY''), ''31.12.2007'')||'' z částky'', '+
	      '       DECODE((SELECT 1 FROM DUAL WHERE Z.SPLATNOST <= to_date(''31.12.2007'',''DD.MM.YYYY'') AND NVL(ROZSUDEK,PL_PRIKAZ) >= to_date(''1.7.2007'',''DD.MM.YYYY'')), '+
	      '              1, '+
	      '              ''- 9,75% ročně od 1.7.2007 do ''||DECODE((SELECT 1 FROM DUAL WHERE NVL(ROZSUDEK,PL_PRIKAZ) <= to_date(''31.12.2007'',''DD.MM.YYYY'')), 1, to_char(NVL(ROZSUDEK,PL_PRIKAZ),''DD.MM.YYYY''), ''31.12.2007'')||'' z částky'', '+
	      '              NULL) '+
	      '       ) AS UROK4, '+
	      'DECODE((SELECT 1 FROM DUAL WHERE Z.SPLATNOST <= to_date(''31.12.2007'',''DD.MM.YYYY'') AND NVL(ROZSUDEK,PL_PRIKAZ) >= to_date(''1.7.2007'',''DD.MM.YYYY'')),1,DLUZNA_CASTKA,NULL) AS CASTKA4, '+
	      'DECODE((SELECT 1 FROM DUAL WHERE Z.SPLATNOST <= to_date(''31.12.2007'',''DD.MM.YYYY'') AND NVL(ROZSUDEK,PL_PRIKAZ) >= to_date(''1.7.2007'',''DD.MM.YYYY'')),1,''Kč'',NULL) AS MENA4, '+
	      ' '+
	      'DECODE((SELECT 1 FROM DUAL WHERE Z.SPLATNOST >= to_date(''1.1.2008'',''DD.MM.YYYY'') AND Z.SPLATNOST <= to_date(''30.6.2008'',''DD.MM.YYYY'') AND NVL(ROZSUDEK,PL_PRIKAZ) >= to_date(''1.1.2008'',''DD.MM.YYYY'')), '+
	      '       1, '+
	      '       ''- 10,5% ročně od ''||to_char(SPLATNOST,''DD.MM.YYYY'')||'' do ''||DECODE((SELECT 1 FROM DUAL WHERE NVL(ROZSUDEK,PL_PRIKAZ) <= to_date(''30.6.2008'',''DD.MM.YYYY'')), 1, to_char(NVL(ROZSUDEK,PL_PRIKAZ),''DD.MM.YYYY''), ''30.6.2008'')||'' z částky'', '+
	      '       DECODE((SELECT 1 FROM DUAL WHERE Z.SPLATNOST <= to_date(''30.6.2008'',''DD.MM.YYYY'') AND NVL(ROZSUDEK,PL_PRIKAZ) >= to_date(''1.1.2008'',''DD.MM.YYYY'')), '+
	      '              1, '+
	      '              ''- 10,5% ročně od 1.1.2008 do ''||DECODE((SELECT 1 FROM DUAL WHERE NVL(ROZSUDEK,PL_PRIKAZ) <= to_date(''30.6.2008'',''DD.MM.YYYY'')), 1, to_char(NVL(ROZSUDEK,PL_PRIKAZ),''DD.MM.YYYY''), ''30.6.2008'')||'' z částky'', '+
	      '              NULL) '+
	      '       ) AS UROK5, '+
	      'DECODE((SELECT 1 FROM DUAL WHERE Z.SPLATNOST <= to_date(''30.6.2008'',''DD.MM.YYYY'') AND NVL(ROZSUDEK,PL_PRIKAZ) >= to_date(''1.1.2008'',''DD.MM.YYYY'')),1,DLUZNA_CASTKA,NULL) AS CASTKA5, '+
	      'DECODE((SELECT 1 FROM DUAL WHERE Z.SPLATNOST <= to_date(''30.6.2008'',''DD.MM.YYYY'') AND NVL(ROZSUDEK,PL_PRIKAZ) >= to_date(''1.1.2008'',''DD.MM.YYYY'')),1,''Kč'',NULL) AS MENA5, '+
	      ' '+
	      'DECODE((SELECT 1 FROM DUAL WHERE Z.SPLATNOST >= to_date(''1.7.2008'',''DD.MM.YYYY'') AND Z.SPLATNOST <= to_date(''31.12.2008'',''DD.MM.YYYY'') AND NVL(ROZSUDEK,PL_PRIKAZ) >= to_date(''1.7.2008'',''DD.MM.YYYY'')), '+
	      '       1, '+
	      '       ''- 10,75% ročně od ''||to_char(SPLATNOST,''DD.MM.YYYY'')||'' do ''||DECODE((SELECT 1 FROM DUAL WHERE NVL(ROZSUDEK,PL_PRIKAZ) <= to_date(''31.12.2008'',''DD.MM.YYYY'')), 1, to_char(NVL(ROZSUDEK,PL_PRIKAZ),''DD.MM.YYYY''), ''31.12.2008'')||'' z částky'', '+
	      '       DECODE((SELECT 1 FROM DUAL WHERE Z.SPLATNOST <= to_date(''31.12.2008'',''DD.MM.YYYY'') AND NVL(ROZSUDEK,PL_PRIKAZ) >= to_date(''1.7.2008'',''DD.MM.YYYY'')), '+
	      '              1, '+
	      '              ''- 10,75% ročně od 1.7.2008 do ''||DECODE((SELECT 1 FROM DUAL WHERE NVL(ROZSUDEK,PL_PRIKAZ) <= to_date(''31.12.2008'',''DD.MM.YYYY'')), 1, to_char(NVL(ROZSUDEK,PL_PRIKAZ),''DD.MM.YYYY''), ''31.12.2008'')||'' z částky'', '+
	      '              NULL) '+
	      '       ) AS UROK6, '+
	      'DECODE((SELECT 1 FROM DUAL WHERE Z.SPLATNOST <= to_date(''31.12.2008'',''DD.MM.YYYY'') AND NVL(ROZSUDEK,PL_PRIKAZ) >= to_date(''1.7.2008'',''DD.MM.YYYY'')),1,DLUZNA_CASTKA,NULL) AS CASTKA6, '+
	      'DECODE((SELECT 1 FROM DUAL WHERE Z.SPLATNOST <= to_date(''31.12.2008'',''DD.MM.YYYY'') AND NVL(ROZSUDEK,PL_PRIKAZ) >= to_date(''1.7.2008'',''DD.MM.YYYY'')),1,''Kč'',NULL) AS MENA6, '+
	      ' '+
	      'DECODE((SELECT 1 FROM DUAL WHERE Z.SPLATNOST >= to_date(''1.1.2009'',''DD.MM.YYYY'') AND Z.SPLATNOST <= to_date(''30.6.2009'',''DD.MM.YYYY'') AND NVL(ROZSUDEK,PL_PRIKAZ) >= to_date(''1.1.2009'',''DD.MM.YYYY'')), '+
	      '       1, '+
	      '       ''- 9,25% ročně od ''||to_char(SPLATNOST,''DD.MM.YYYY'')||'' do ''||DECODE((SELECT 1 FROM DUAL WHERE NVL(ROZSUDEK,PL_PRIKAZ) <= to_date(''30.6.2009'',''DD.MM.YYYY'')), 1, to_char(NVL(ROZSUDEK,PL_PRIKAZ),''DD.MM.YYYY''), ''30.6.2009'')||'' z částky'', '+
	      '       DECODE((SELECT 1 FROM DUAL WHERE Z.SPLATNOST <= to_date(''30.6.2009'',''DD.MM.YYYY'') AND NVL(ROZSUDEK,PL_PRIKAZ) >= to_date(''1.1.2009'',''DD.MM.YYYY'')), '+
	      '              1, '+
	      '              ''- 9,25% ročně od 1.1.2009 do ''||DECODE((SELECT 1 FROM DUAL WHERE NVL(ROZSUDEK,PL_PRIKAZ) <= to_date(''30.6.2009'',''DD.MM.YYYY'')), 1, to_char(NVL(ROZSUDEK,PL_PRIKAZ),''DD.MM.YYYY''), ''30.6.2009'')||'' z částky'', '+
	      '              NULL) '+
	      '       ) AS UROK7, '+
	      'DECODE((SELECT 1 FROM DUAL WHERE Z.SPLATNOST <= to_date(''30.6.2009'',''DD.MM.YYYY'') AND NVL(ROZSUDEK,PL_PRIKAZ) >= to_date(''1.1.2009'',''DD.MM.YYYY'')),1,DLUZNA_CASTKA,NULL) AS CASTKA7, '+
	      'DECODE((SELECT 1 FROM DUAL WHERE Z.SPLATNOST <= to_date(''30.6.2009'',''DD.MM.YYYY'') AND NVL(ROZSUDEK,PL_PRIKAZ) >= to_date(''1.1.2009'',''DD.MM.YYYY'')),1,''Kč'',NULL) AS MENA7, '+
	      ' '+
	      'DECODE((SELECT 1 FROM DUAL WHERE Z.SPLATNOST >= to_date(''1.7.2009'',''DD.MM.YYYY'') AND Z.SPLATNOST <= to_date(''31.12.2009'',''DD.MM.YYYY'') AND NVL(ROZSUDEK,PL_PRIKAZ) >= to_date(''1.7.2009'',''DD.MM.YYYY'')), '+
	      '       1, '+
	      '       ''- 8,5% ročně od ''||to_char(SPLATNOST,''DD.MM.YYYY'')||'' do ''||DECODE((SELECT 1 FROM DUAL WHERE NVL(ROZSUDEK,PL_PRIKAZ) <= to_date(''31.12.2009'',''DD.MM.YYYY'')), 1, to_char(NVL(ROZSUDEK,PL_PRIKAZ),''DD.MM.YYYY''), ''31.12.2009'')||'' z částky'', '+
	      '       DECODE((SELECT 1 FROM DUAL WHERE Z.SPLATNOST <= to_date(''31.12.2009'',''DD.MM.YYYY'') AND NVL(ROZSUDEK,PL_PRIKAZ) >= to_date(''1.7.2009'',''DD.MM.YYYY'')), '+
	      '              1, '+
	      '              ''- 8,5% ročně od 1.7.2009 do ''||DECODE((SELECT 1 FROM DUAL WHERE NVL(ROZSUDEK,PL_PRIKAZ) <= to_date(''31.12.2009'',''DD.MM.YYYY'')), 1, to_char(NVL(ROZSUDEK,PL_PRIKAZ),''DD.MM.YYYY''), ''31.12.2009'')||'' z částky'', '+
	      '              NULL) '+
	      '       ) AS UROK8, '+
	      'DECODE((SELECT 1 FROM DUAL WHERE Z.SPLATNOST <= to_date(''31.12.2009'',''DD.MM.YYYY'') AND NVL(ROZSUDEK,PL_PRIKAZ) >= to_date(''1.7.2009'',''DD.MM.YYYY'')),1,DLUZNA_CASTKA,NULL) AS CASTKA8, '+
	      'DECODE((SELECT 1 FROM DUAL WHERE Z.SPLATNOST <= to_date(''31.12.2009'',''DD.MM.YYYY'') AND NVL(ROZSUDEK,PL_PRIKAZ) >= to_date(''1.7.2009'',''DD.MM.YYYY'')),1,''Kč'',NULL) AS MENA8, '+
	      ' '+
	      'DECODE((SELECT 1 FROM DUAL WHERE Z.SPLATNOST >= to_date(''1.1.2010'',''DD.MM.YYYY'') AND Z.SPLATNOST <= to_date(''30.6.2010'',''DD.MM.YYYY'') AND NVL(ROZSUDEK,PL_PRIKAZ) >= to_date(''1.1.2010'',''DD.MM.YYYY'')), '+
	      '       1, '+
	      '       ''- 8% ročně od ''||to_char(SPLATNOST,''DD.MM.YYYY'')||'' do ''||DECODE((SELECT 1 FROM DUAL WHERE NVL(ROZSUDEK,PL_PRIKAZ) <= to_date(''30.6.2010'',''DD.MM.YYYY'')), 1, to_char(NVL(ROZSUDEK,PL_PRIKAZ),''DD.MM.YYYY''), ''30.6.2010'')||'' z částky'', '+
	      '       DECODE((SELECT 1 FROM DUAL WHERE Z.SPLATNOST <= to_date(''30.6.2010'',''DD.MM.YYYY'') AND NVL(ROZSUDEK,PL_PRIKAZ) >= to_date(''1.1.2010'',''DD.MM.YYYY'')), '+
	      '              1, '+
	      '              ''- 8% ročně od 1.1.2010 do ''||DECODE((SELECT 1 FROM DUAL WHERE NVL(ROZSUDEK,PL_PRIKAZ) <= to_date(''30.6.2010'',''DD.MM.YYYY'')), 1, to_char(NVL(ROZSUDEK,PL_PRIKAZ),''DD.MM.YYYY''), ''30.6.2010'')||'' z částky'', '+
	      '              NULL) '+
	      '       ) AS UROK9, '+
	      'DECODE((SELECT 1 FROM DUAL WHERE Z.SPLATNOST <= to_date(''30.6.2010'',''DD.MM.YYYY'') AND NVL(ROZSUDEK,PL_PRIKAZ) >= to_date(''1.1.2010'',''DD.MM.YYYY'')),1,DLUZNA_CASTKA,NULL) AS CASTKA9, '+
	      'DECODE((SELECT 1 FROM DUAL WHERE Z.SPLATNOST <= to_date(''30.6.2010'',''DD.MM.YYYY'') AND NVL(ROZSUDEK,PL_PRIKAZ) >= to_date(''1.1.2010'',''DD.MM.YYYY'')),1,''Kč'',NULL) AS MENA9, '+
	      ' '+
	      'DECODE((SELECT 1 FROM DUAL WHERE Z.SPLATNOST >= to_date(''1.7.2010'',''DD.MM.YYYY'') AND Z.SPLATNOST <= to_date(''30.6.2012'',''DD.MM.YYYY'') AND NVL(ROZSUDEK,PL_PRIKAZ) >= to_date(''1.7.2010'',''DD.MM.YYYY'')), '+
	      '       1, '+
	      '       ''- 7,75% ročně od ''||to_char(SPLATNOST,''DD.MM.YYYY'')||'' do ''||DECODE((SELECT 1 FROM DUAL WHERE NVL(ROZSUDEK,PL_PRIKAZ) <= to_date(''30.6.2012'',''DD.MM.YYYY'')), 1, to_char(NVL(ROZSUDEK,PL_PRIKAZ),''DD.MM.YYYY''), ''30.6.2012'')||'' z částky'', '+
	      '       DECODE((SELECT 1 FROM DUAL WHERE Z.SPLATNOST <= to_date(''30.6.2012'',''DD.MM.YYYY'') AND NVL(ROZSUDEK,PL_PRIKAZ) >= to_date(''1.7.2010'',''DD.MM.YYYY'')), '+
	      '              1, '+
	      '              ''- 7,75% ročně od 1.7.2010 do ''||DECODE((SELECT 1 FROM DUAL WHERE NVL(ROZSUDEK,PL_PRIKAZ) <= to_date(''30.6.2012'',''DD.MM.YYYY'')), 1, to_char(NVL(ROZSUDEK,PL_PRIKAZ),''DD.MM.YYYY''), ''30.6.2012'')||'' z částky'', '+
	      '              NULL) '+
	      '       ) AS UROK10, '+
	      'DECODE((SELECT 1 FROM DUAL WHERE Z.SPLATNOST <= to_date(''30.6.2012'',''DD.MM.YYYY'') AND NVL(ROZSUDEK,PL_PRIKAZ) >= to_date(''1.7.2010'',''DD.MM.YYYY'')),1,DLUZNA_CASTKA,NULL) AS CASTKA10, '+
	      'DECODE((SELECT 1 FROM DUAL WHERE Z.SPLATNOST <= to_date(''30.6.2012'',''DD.MM.YYYY'') AND NVL(ROZSUDEK,PL_PRIKAZ) >= to_date(''1.7.2010'',''DD.MM.YYYY'')),1,''Kč'',NULL) AS MENA10, '+
	      ' '+
	      'DECODE((SELECT 1 FROM DUAL WHERE Z.SPLATNOST >= to_date(''1.7.2012'',''DD.MM.YYYY'') AND Z.SPLATNOST <= to_date(''31.12.2012'',''DD.MM.YYYY'') AND NVL(ROZSUDEK,PL_PRIKAZ) >= to_date(''1.7.2012'',''DD.MM.YYYY'')), '+
	      '       1, '+
	      '       ''- 7,5% ročně od ''||to_char(SPLATNOST,''DD.MM.YYYY'')||'' do ''||DECODE((SELECT 1 FROM DUAL WHERE NVL(ROZSUDEK,PL_PRIKAZ) <= to_date(''31.12.2012'',''DD.MM.YYYY'')), 1, to_char(NVL(ROZSUDEK,PL_PRIKAZ),''DD.MM.YYYY''), ''31.12.2012'')||'' z částky'', '+
	      '       DECODE((SELECT 1 FROM DUAL WHERE Z.SPLATNOST <= to_date(''31.12.2012'',''DD.MM.YYYY'') AND NVL(ROZSUDEK,PL_PRIKAZ) >= to_date(''1.7.2012'',''DD.MM.YYYY'')), '+
	      '              1, '+
	      '              ''- 7,5% ročně od 1.7.2012 do ''||DECODE((SELECT 1 FROM DUAL WHERE NVL(ROZSUDEK,PL_PRIKAZ) <= to_date(''31.12.2012'',''DD.MM.YYYY'')), 1, to_char(NVL(ROZSUDEK,PL_PRIKAZ),''DD.MM.YYYY''), ''31.12.2012'')||'' z částky'', '+
	      '              NULL) '+
	      '       ) AS UROK11, '+
	      'DECODE((SELECT 1 FROM DUAL WHERE Z.SPLATNOST <= to_date(''31.12.2012'',''DD.MM.YYYY'') AND NVL(ROZSUDEK,PL_PRIKAZ) >= to_date(''1.7.2012'',''DD.MM.YYYY'')),1,DLUZNA_CASTKA,NULL) AS CASTKA11, '+
	      'DECODE((SELECT 1 FROM DUAL WHERE Z.SPLATNOST <= to_date(''31.12.2012'',''DD.MM.YYYY'') AND NVL(ROZSUDEK,PL_PRIKAZ) >= to_date(''1.7.2012'',''DD.MM.YYYY'')),1,''Kč'',NULL) AS MENA11, '+
	      ' '+
	      'DECODE((SELECT 1 FROM DUAL WHERE Z.SPLATNOST >= to_date(''1.1.2013'',''DD.MM.YYYY'') AND NVL(ROZSUDEK,PL_PRIKAZ) >= to_date(''1.1.2013'',''DD.MM.YYYY'')), '+
	      '       1, '+
	      '       ''- 7,05% ročně od ''||to_char(SPLATNOST,''DD.MM.YYYY'')||'' do ''||to_char(NVL(ROZSUDEK,PL_PRIKAZ),''DD.MM.YYYY'')||'' z částky'', '+
	      '       DECODE((SELECT 1 FROM DUAL WHERE Z.SPLATNOST < to_date(''1.1.2013'',''DD.MM.YYYY'') AND NVL(ROZSUDEK,PL_PRIKAZ) >= to_date(''1.1.2013'',''DD.MM.YYYY'')), '+
	      '              1, '+
	      '              ''- 7,05% ročně od 1.1.2013 do ''||to_char(NVL(ROZSUDEK,PL_PRIKAZ),''DD.MM.YYYY'')||'' z částky'', '+
	      '              NULL) '+
	      '       ) AS UROK12, '+
	      'DECODE((SELECT 1 FROM DUAL WHERE NVL(ROZSUDEK,PL_PRIKAZ) >= to_date(''1.1.2013'',''DD.MM.YYYY'')), 1, DLUZNA_CASTKA, NULL) AS CASTKA12, '+
	      'DECODE((SELECT 1 FROM DUAL WHERE NVL(ROZSUDEK,PL_PRIKAZ) >= to_date(''1.1.2013'',''DD.MM.YYYY'')), 1, ''Kč'', NULL) AS MENA12 '+
              'FROM '+
              '  ZALOBY Z,'+
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
              '  DECODE( FLOOR(NVL(Z.NAROK,0)-NVL(DLUZNA_CASTKA,0)), (NVL(Z.NAROK,0)-NVL(DLUZNA_CASTKA,0)), FORMAT_MENA(NVL(Z.NAROK,0)-NVL(DLUZNA_CASTKA,0),0)||'',-'', FORMAT_MENA(NVL(Z.NAROK,0)-NVL(DLUZNA_CASTKA,0),2) ) AS NAKLADY,'+
              '  CEIL((SELECT MAX(SAZBA) FROM EXEKUTORI_SAZBY_ODMEN WHERE CASTKA_OD <= (NVL(Z.NAROK,0)) AND CASTKA_DO >= (NVL(Z.NAROK,0)))) AS SAZBA,'+
              '  CEIL((SELECT MAX(SAZBA) FROM EXEKUTORI_SAZBY_ODMEN WHERE CASTKA_OD <= (NVL(Z.NAROK,0)) AND CASTKA_DO >= (NVL(Z.NAROK,0)))/2) AS PUL_SAZBA,'+
              '  CEIL((((SELECT MAX(SAZBA) FROM EXEKUTORI_SAZBY_ODMEN WHERE CASTKA_OD <= (NVL(Z.NAROK,0)) AND CASTKA_DO >= (NVL(Z.NAROK,0)))/2)+600)*(1.21)) AS ODMENA,'+
              '  DECODE(TRIM(ROZSUDEK),NULL,''vykonatelného elektronického platebního rozkazu č.j. '',''vykonatelného rozsudku č.j. ''||SPIS_ZNACKA||'','') AS ROZROZ,'+

              '  ''Na základě exekučního titulu - ''||DECODE(TRIM(ROZSUDEK),NULL,''vykonatelného elektronického platebního rozkazu č.j. '',''vykonatelného rozsudku č.j. ''||SPIS_ZNACKA||'', '') AS ROZROZ_PAGE0,'+
              '  DECODE(TRIM(ROZSUDEK),NULL,SPIS_ZNACKA,NULL)||'' ze dne ''||TO_CHAR(NVL(ROZSUDEK,PL_PRIKAZ),''DD.MM.YYYY'')||'', ''||'+
              '  DECODE(OPRAVNE_USNESENI_DATUM,null,'''',''ve znění opravného usnesení č.j. ''||USNESENI_CJ||'' ze dne ''||to_char(OPRAVNE_USNESENI_DATUM,''DD.MM.YYYY'')||'', '')||'+
              '  DECODE(OPRAVNE_USNESENI_DATUM,null,''který'',''které'')||'' vydal ''||SOUD||'',''||'+
              '  '' právní moc dne ''||TO_CHAR(PR_MOC,''DD.MM.YYYY'')||'', bylo povinné/mu uloženo zaplatit oprávněné:'' AS ROZROZ_PAGE1,'+

              '  DECODE(TRIM(ROZSUDEK),NULL,SPIS_ZNACKA,NULL)||'' ze dne ''||TO_CHAR(NVL(ROZSUDEK,PL_PRIKAZ),''DD.MM.YYYY'')||'+
              '    DECODE(OPRAVNE_USNESENI_DATUM,null,'''','' ve znění opravného usnesení č.j. ''||USNESENI_CJ) AS ROZROZ_ROW2,'+
              '  DECODE(OPRAVNE_USNESENI_DATUM,null,'''',''ze dne ''||to_char(OPRAVNE_USNESENI_DATUM,''DD.MM.YYYY''))||'+
              '    '', který vydal ''||SOUD||'', právní moc dne ''||TO_CHAR(PR_MOC,''DD.MM.YYYY'')||'', exekuci pro:'' AS ROZROZ_ROW3,'+
              '    DECODE(TRIM(ROZSUDEK),NULL,''vykonatelného elektronického platebního rozkazu č.j. '',''vykonatelného rozsudku č.j.'')||'+
              '    SPIS_ZNACKA||'' ze dne ''||TO_CHAR(NVL(ROZSUDEK,PL_PRIKAZ),''DD.MM.YYYY'')||'', ''||'+
              '    DECODE(OPRAVNE_USNESENI_DATUM,null,'''',''ve znění opravného usnesení č.j. ''||USNESENI_CJ||'' ze dne ''||to_char(OPRAVNE_USNESENI_DATUM,''DD.MM.YYYY'')||'', '')||'+
              '    DECODE(OPRAVNE_USNESENI_DATUM,null,''který'',''které'')||'' vydal ''||SOUD||'',''||'+
              '    '' právní moc dne ''||TO_CHAR(PR_MOC,''DD.MM.YYYY'')||'', k vymožení:'' AS ROZROZ_ROW,'+
              '  TO_CHAR(SYSDATE,''DD.MM.YYYY'') AS AKTUALNI_DATUM,'+
              '  CEIL(DLUZNA_CASTKA) AS DLUZNA_CASTKA_KC, '+
              '  TO_CHAR(SPLATNOST,''DD.MM.YYYY'') AS SPLATNOST_DATUM,'+
              '  TO_CHAR(NVL(ROZSUDEK,PL_PRIKAZ),''DD.MM.YYYY'') AS PL_PRIKAZ_DATUM,'+
              '  TO_CHAR(NVL(ROZSUDEK,PL_PRIKAZ)+1,''DD.MM.YYYY'') AS PL_PRIKAZ_PLUS_DEN,'+
              '  TO_CHAR(PR_MOC,''DD.MM.YYYY'') AS PR_MOC_DATUM,'+
              '  L.KONTAKTNI_OSOBA||''/''||L.KONTAKTNI_OSOBA_TEL AS KONTAKTNI_OSOBA,'+
              '  L.UCET,'+
              '  SOUD||'','' AS SOUD_CARKA,'+
              '  (SELECT UCET_POHLEDAVKA FROM ZALOBY_DAVKY_UCTY WHERE DAVKA = DATUM_IMPORTU) AS UCET_POHLEDAVKA,'+
              '  (SELECT UCET_NAKLADY FROM ZALOBY_DAVKY_UCTY WHERE DAVKA = DATUM_IMPORTU) AS UCET_NAKLADY,'+
              '  L.KOD_BANKY,'+
              '  GET_PARAM(''ZALOBY_DATUM_PREDANI'') AS DATUM_PREDANI,'+
              '  ''ERP ''||Z.VAR_SYMB||'' - FEN'' AS VAR_SYMB_ERP,'+
              '  Z.ULICE||'' ''||Z.CISLO_DOMU AS ULICE_CP, '+
              '  Z.PSC||'' ''||Z.MESTO AS PSC_MESTO, '+
              '  Z.JMENO_CP||'', nar. ''||GET_DATUM_FROM_RC(Z.RODNE_CISLO)||'',bytem ''||Z.ULICE||'' ''||Z.CISLO_DOMU||'', ''||Z.PSC||'' ''||Z.MESTO||'', r.č.: ''||Z.RODNE_CISLO AS JMENO_NAR, '+
              '  CASE GET_POHLAVI_Z_RC(Z.RODNE_CISLO) '+
              '    WHEN 1 THEN ''Vážený pan'' '+
              '    WHEN 0 THEN ''Vážená paní'' '+
              '    WHEN NULL THEN ''Vážený pan/paní'' '+
              '  END AS OSLOVENI, '+
              '  GET_PARAM(''ZALOBY_OZNAMENI_UCET'') AS UCET_OZNAMENI, '+
              'DECODE((SELECT 1 FROM DUAL WHERE Z.SPLATNOST >= to_date(''1.1.2006'',''DD.MM.YYYY'') AND Z.SPLATNOST <= to_date(''30.6.2006'',''DD.MM.YYYY'') AND NVL(ROZSUDEK,PL_PRIKAZ) >= to_date(''1.1.2006'',''DD.MM.YYYY'')), '+
	      '       1, '+
	      '       ''- 9% ročně od ''||to_char(SPLATNOST,''DD.MM.YYYY'')||'' do ''||DECODE((SELECT 1 FROM DUAL WHERE NVL(ROZSUDEK,PL_PRIKAZ) <= to_date(''30.6.2006'',''DD.MM.YYYY'')), 1, to_char(NVL(ROZSUDEK,PL_PRIKAZ),''DD.MM.YYYY''), ''30.6.2006'')||'' z částky'', '+
	      '       DECODE((SELECT 1 FROM DUAL WHERE Z.SPLATNOST <= to_date(''30.6.2006'',''DD.MM.YYYY'') AND NVL(ROZSUDEK,PL_PRIKAZ) >= to_date(''1.1.2006'',''DD.MM.YYYY'')), '+
	      '              1, '+
	      '              ''- 9% ročně od 1.1.2006 do ''||DECODE((SELECT 1 FROM DUAL WHERE NVL(ROZSUDEK,PL_PRIKAZ) <= to_date(''30.6.2006'',''DD.MM.YYYY'')), 1, to_char(NVL(ROZSUDEK,PL_PRIKAZ),''DD.MM.YYYY''), ''30.6.2006'')||'' z částky'', '+
	      '              NULL) '+
	      '       ) AS UROK1, '+
	      'DECODE((SELECT 1 FROM DUAL WHERE Z.SPLATNOST <= to_date(''30.6.2006'',''DD.MM.YYYY'') AND NVL(ROZSUDEK,PL_PRIKAZ) >= to_date(''1.1.2006'',''DD.MM.YYYY'')),1,DLUZNA_CASTKA,NULL) AS CASTKA1, '+
	      'DECODE((SELECT 1 FROM DUAL WHERE Z.SPLATNOST <= to_date(''30.6.2006'',''DD.MM.YYYY'') AND NVL(ROZSUDEK,PL_PRIKAZ) >= to_date(''1.1.2006'',''DD.MM.YYYY'')),1,''Kč'',NULL) AS MENA1, '+
	      ' '+
	      'DECODE((SELECT 1 FROM DUAL WHERE Z.SPLATNOST >= to_date(''1.7.2006'',''DD.MM.YYYY'') AND Z.SPLATNOST <= to_date(''31.12.2006'',''DD.MM.YYYY'') AND NVL(ROZSUDEK,PL_PRIKAZ) >= to_date(''1.7.2006'',''DD.MM.YYYY'')), '+
	      '       1, '+
	      '       ''- 9% ročně od ''||to_char(SPLATNOST,''DD.MM.YYYY'')||'' do ''||DECODE((SELECT 1 FROM DUAL WHERE NVL(ROZSUDEK,PL_PRIKAZ) <= to_date(''31.12.2006'',''DD.MM.YYYY'')), 1, to_char(NVL(ROZSUDEK,PL_PRIKAZ),''DD.MM.YYYY''), ''31.12.2006'')||'' z částky'', '+
	      '       DECODE((SELECT 1 FROM DUAL WHERE Z.SPLATNOST <= to_date(''31.12.2006'',''DD.MM.YYYY'') AND NVL(ROZSUDEK,PL_PRIKAZ) >= to_date(''1.7.2006'',''DD.MM.YYYY'')), '+
	      '              1, '+
	      '              ''- 9% ročně od 1.7.2006 do ''||DECODE((SELECT 1 FROM DUAL WHERE NVL(ROZSUDEK,PL_PRIKAZ) <= to_date(''31.12.2006'',''DD.MM.YYYY'')), 1, to_char(NVL(ROZSUDEK,PL_PRIKAZ),''DD.MM.YYYY''), ''31.12.2006'')||'' z částky'', '+
	      '              NULL) '+
	      '       ) AS UROK2, '+
	      'DECODE((SELECT 1 FROM DUAL WHERE Z.SPLATNOST <= to_date(''31.12.2006'',''DD.MM.YYYY'') AND NVL(ROZSUDEK,PL_PRIKAZ) >= to_date(''1.7.2006'',''DD.MM.YYYY'')),1,DLUZNA_CASTKA,NULL) AS CASTKA2, '+
	      'DECODE((SELECT 1 FROM DUAL WHERE Z.SPLATNOST <= to_date(''31.12.2006'',''DD.MM.YYYY'') AND NVL(ROZSUDEK,PL_PRIKAZ) >= to_date(''1.7.2006'',''DD.MM.YYYY'')),1,''Kč'',NULL) AS MENA2, '+
	      ' '+
	      'DECODE((SELECT 1 FROM DUAL WHERE Z.SPLATNOST >= to_date(''1.1.2007'',''DD.MM.YYYY'') AND Z.SPLATNOST <= to_date(''30.6.2007'',''DD.MM.YYYY'') AND NVL(ROZSUDEK,PL_PRIKAZ) >= to_date(''1.1.2007'',''DD.MM.YYYY'')), '+
	      '       1, '+
	      '       ''- 9,5% ročně od ''||to_char(SPLATNOST,''DD.MM.YYYY'')||'' do ''||DECODE((SELECT 1 FROM DUAL WHERE NVL(ROZSUDEK,PL_PRIKAZ) <= to_date(''30.6.2007'',''DD.MM.YYYY'')), 1, to_char(NVL(ROZSUDEK,PL_PRIKAZ),''DD.MM.YYYY''), ''30.6.2007'')||'' z částky'', '+
	      '       DECODE((SELECT 1 FROM DUAL WHERE Z.SPLATNOST <= to_date(''30.6.2007'',''DD.MM.YYYY'') AND NVL(ROZSUDEK,PL_PRIKAZ) >= to_date(''1.1.2007'',''DD.MM.YYYY'')), '+
	      '              1, '+
	      '              ''- 9,5% ročně od 1.1.2007 do ''||DECODE((SELECT 1 FROM DUAL WHERE NVL(ROZSUDEK,PL_PRIKAZ) <= to_date(''30.6.2007'',''DD.MM.YYYY'')), 1, to_char(NVL(ROZSUDEK,PL_PRIKAZ),''DD.MM.YYYY''), ''30.6.2007'')||'' z částky'', '+
	      '              NULL) '+
	      '       ) AS UROK3, '+
	      'DECODE((SELECT 1 FROM DUAL WHERE Z.SPLATNOST <= to_date(''30.6.2007'',''DD.MM.YYYY'') AND NVL(ROZSUDEK,PL_PRIKAZ) >= to_date(''1.1.2007'',''DD.MM.YYYY'')),1,DLUZNA_CASTKA,NULL) AS CASTKA3, '+
	      'DECODE((SELECT 1 FROM DUAL WHERE Z.SPLATNOST <= to_date(''30.6.2007'',''DD.MM.YYYY'') AND NVL(ROZSUDEK,PL_PRIKAZ) >= to_date(''1.1.2007'',''DD.MM.YYYY'')),1,''Kč'',NULL) AS MENA3, '+
	      ' '+
	      'DECODE((SELECT 1 FROM DUAL WHERE Z.SPLATNOST >= to_date(''1.7.2007'',''DD.MM.YYYY'') AND Z.SPLATNOST <= to_date(''31.12.2007'',''DD.MM.YYYY'') AND NVL(ROZSUDEK,PL_PRIKAZ) >= to_date(''1.7.2007'',''DD.MM.YYYY'')), '+
	      '       1, '+
	      '       ''- 9,75% ročně od ''||to_char(SPLATNOST,''DD.MM.YYYY'')||'' do ''||DECODE((SELECT 1 FROM DUAL WHERE NVL(ROZSUDEK,PL_PRIKAZ) <= to_date(''31.12.2007'',''DD.MM.YYYY'')), 1, to_char(NVL(ROZSUDEK,PL_PRIKAZ),''DD.MM.YYYY''), ''31.12.2007'')||'' z částky'', '+
	      '       DECODE((SELECT 1 FROM DUAL WHERE Z.SPLATNOST <= to_date(''31.12.2007'',''DD.MM.YYYY'') AND NVL(ROZSUDEK,PL_PRIKAZ) >= to_date(''1.7.2007'',''DD.MM.YYYY'')), '+
	      '              1, '+
	      '              ''- 9,75% ročně od 1.7.2007 do ''||DECODE((SELECT 1 FROM DUAL WHERE NVL(ROZSUDEK,PL_PRIKAZ) <= to_date(''31.12.2007'',''DD.MM.YYYY'')), 1, to_char(NVL(ROZSUDEK,PL_PRIKAZ),''DD.MM.YYYY''), ''31.12.2007'')||'' z částky'', '+
	      '              NULL) '+
	      '       ) AS UROK4, '+
	      'DECODE((SELECT 1 FROM DUAL WHERE Z.SPLATNOST <= to_date(''31.12.2007'',''DD.MM.YYYY'') AND NVL(ROZSUDEK,PL_PRIKAZ) >= to_date(''1.7.2007'',''DD.MM.YYYY'')),1,DLUZNA_CASTKA,NULL) AS CASTKA4, '+
	      'DECODE((SELECT 1 FROM DUAL WHERE Z.SPLATNOST <= to_date(''31.12.2007'',''DD.MM.YYYY'') AND NVL(ROZSUDEK,PL_PRIKAZ) >= to_date(''1.7.2007'',''DD.MM.YYYY'')),1,''Kč'',NULL) AS MENA4, '+
	      ' '+
	      'DECODE((SELECT 1 FROM DUAL WHERE Z.SPLATNOST >= to_date(''1.1.2008'',''DD.MM.YYYY'') AND Z.SPLATNOST <= to_date(''30.6.2008'',''DD.MM.YYYY'') AND NVL(ROZSUDEK,PL_PRIKAZ) >= to_date(''1.1.2008'',''DD.MM.YYYY'')), '+
	      '       1, '+
	      '       ''- 10,5% ročně od ''||to_char(SPLATNOST,''DD.MM.YYYY'')||'' do ''||DECODE((SELECT 1 FROM DUAL WHERE NVL(ROZSUDEK,PL_PRIKAZ) <= to_date(''30.6.2008'',''DD.MM.YYYY'')), 1, to_char(NVL(ROZSUDEK,PL_PRIKAZ),''DD.MM.YYYY''), ''30.6.2008'')||'' z částky'', '+
	      '       DECODE((SELECT 1 FROM DUAL WHERE Z.SPLATNOST <= to_date(''30.6.2008'',''DD.MM.YYYY'') AND NVL(ROZSUDEK,PL_PRIKAZ) >= to_date(''1.1.2008'',''DD.MM.YYYY'')), '+
	      '              1, '+
	      '              ''- 10,5% ročně od 1.1.2008 do ''||DECODE((SELECT 1 FROM DUAL WHERE NVL(ROZSUDEK,PL_PRIKAZ) <= to_date(''30.6.2008'',''DD.MM.YYYY'')), 1, to_char(NVL(ROZSUDEK,PL_PRIKAZ),''DD.MM.YYYY''), ''30.6.2008'')||'' z částky'', '+
	      '              NULL) '+
	      '       ) AS UROK5, '+
	      'DECODE((SELECT 1 FROM DUAL WHERE Z.SPLATNOST <= to_date(''30.6.2008'',''DD.MM.YYYY'') AND NVL(ROZSUDEK,PL_PRIKAZ) >= to_date(''1.1.2008'',''DD.MM.YYYY'')),1,DLUZNA_CASTKA,NULL) AS CASTKA5, '+
	      'DECODE((SELECT 1 FROM DUAL WHERE Z.SPLATNOST <= to_date(''30.6.2008'',''DD.MM.YYYY'') AND NVL(ROZSUDEK,PL_PRIKAZ) >= to_date(''1.1.2008'',''DD.MM.YYYY'')),1,''Kč'',NULL) AS MENA5, '+
	      ' '+
	      'DECODE((SELECT 1 FROM DUAL WHERE Z.SPLATNOST >= to_date(''1.7.2008'',''DD.MM.YYYY'') AND Z.SPLATNOST <= to_date(''31.12.2008'',''DD.MM.YYYY'') AND NVL(ROZSUDEK,PL_PRIKAZ) >= to_date(''1.7.2008'',''DD.MM.YYYY'')), '+
	      '       1, '+
	      '       ''- 10,75% ročně od ''||to_char(SPLATNOST,''DD.MM.YYYY'')||'' do ''||DECODE((SELECT 1 FROM DUAL WHERE NVL(ROZSUDEK,PL_PRIKAZ) <= to_date(''31.12.2008'',''DD.MM.YYYY'')), 1, to_char(NVL(ROZSUDEK,PL_PRIKAZ),''DD.MM.YYYY''), ''31.12.2008'')||'' z částky'', '+
	      '       DECODE((SELECT 1 FROM DUAL WHERE Z.SPLATNOST <= to_date(''31.12.2008'',''DD.MM.YYYY'') AND NVL(ROZSUDEK,PL_PRIKAZ) >= to_date(''1.7.2008'',''DD.MM.YYYY'')), '+
	      '              1, '+
	      '              ''- 10,75% ročně od 1.7.2008 do ''||DECODE((SELECT 1 FROM DUAL WHERE NVL(ROZSUDEK,PL_PRIKAZ) <= to_date(''31.12.2008'',''DD.MM.YYYY'')), 1, to_char(NVL(ROZSUDEK,PL_PRIKAZ),''DD.MM.YYYY''), ''31.12.2008'')||'' z částky'', '+
	      '              NULL) '+
	      '       ) AS UROK6, '+
	      'DECODE((SELECT 1 FROM DUAL WHERE Z.SPLATNOST <= to_date(''31.12.2008'',''DD.MM.YYYY'') AND NVL(ROZSUDEK,PL_PRIKAZ) >= to_date(''1.7.2008'',''DD.MM.YYYY'')),1,DLUZNA_CASTKA,NULL) AS CASTKA6, '+
	      'DECODE((SELECT 1 FROM DUAL WHERE Z.SPLATNOST <= to_date(''31.12.2008'',''DD.MM.YYYY'') AND NVL(ROZSUDEK,PL_PRIKAZ) >= to_date(''1.7.2008'',''DD.MM.YYYY'')),1,''Kč'',NULL) AS MENA6, '+
	      ' '+
	      'DECODE((SELECT 1 FROM DUAL WHERE Z.SPLATNOST >= to_date(''1.1.2009'',''DD.MM.YYYY'') AND Z.SPLATNOST <= to_date(''30.6.2009'',''DD.MM.YYYY'') AND NVL(ROZSUDEK,PL_PRIKAZ) >= to_date(''1.1.2009'',''DD.MM.YYYY'')), '+
	      '       1, '+
	      '       ''- 9,25% ročně od ''||to_char(SPLATNOST,''DD.MM.YYYY'')||'' do ''||DECODE((SELECT 1 FROM DUAL WHERE NVL(ROZSUDEK,PL_PRIKAZ) <= to_date(''30.6.2009'',''DD.MM.YYYY'')), 1, to_char(NVL(ROZSUDEK,PL_PRIKAZ),''DD.MM.YYYY''), ''30.6.2009'')||'' z částky'', '+
	      '       DECODE((SELECT 1 FROM DUAL WHERE Z.SPLATNOST <= to_date(''30.6.2009'',''DD.MM.YYYY'') AND NVL(ROZSUDEK,PL_PRIKAZ) >= to_date(''1.1.2009'',''DD.MM.YYYY'')), '+
	      '              1, '+
	      '              ''- 9,25% ročně od 1.1.2009 do ''||DECODE((SELECT 1 FROM DUAL WHERE NVL(ROZSUDEK,PL_PRIKAZ) <= to_date(''30.6.2009'',''DD.MM.YYYY'')), 1, to_char(NVL(ROZSUDEK,PL_PRIKAZ),''DD.MM.YYYY''), ''30.6.2009'')||'' z částky'', '+
	      '              NULL) '+
	      '       ) AS UROK7, '+
	      'DECODE((SELECT 1 FROM DUAL WHERE Z.SPLATNOST <= to_date(''30.6.2009'',''DD.MM.YYYY'') AND NVL(ROZSUDEK,PL_PRIKAZ) >= to_date(''1.1.2009'',''DD.MM.YYYY'')),1,DLUZNA_CASTKA,NULL) AS CASTKA7, '+
	      'DECODE((SELECT 1 FROM DUAL WHERE Z.SPLATNOST <= to_date(''30.6.2009'',''DD.MM.YYYY'') AND NVL(ROZSUDEK,PL_PRIKAZ) >= to_date(''1.1.2009'',''DD.MM.YYYY'')),1,''Kč'',NULL) AS MENA7, '+
	      ' '+
	      'DECODE((SELECT 1 FROM DUAL WHERE Z.SPLATNOST >= to_date(''1.7.2009'',''DD.MM.YYYY'') AND Z.SPLATNOST <= to_date(''31.12.2009'',''DD.MM.YYYY'') AND NVL(ROZSUDEK,PL_PRIKAZ) >= to_date(''1.7.2009'',''DD.MM.YYYY'')), '+
	      '       1, '+
	      '       ''- 8,5% ročně od ''||to_char(SPLATNOST,''DD.MM.YYYY'')||'' do ''||DECODE((SELECT 1 FROM DUAL WHERE NVL(ROZSUDEK,PL_PRIKAZ) <= to_date(''31.12.2009'',''DD.MM.YYYY'')), 1, to_char(NVL(ROZSUDEK,PL_PRIKAZ),''DD.MM.YYYY''), ''31.12.2009'')||'' z částky'', '+
	      '       DECODE((SELECT 1 FROM DUAL WHERE Z.SPLATNOST <= to_date(''31.12.2009'',''DD.MM.YYYY'') AND NVL(ROZSUDEK,PL_PRIKAZ) >= to_date(''1.7.2009'',''DD.MM.YYYY'')), '+
	      '              1, '+
	      '              ''- 8,5% ročně od 1.7.2009 do ''||DECODE((SELECT 1 FROM DUAL WHERE NVL(ROZSUDEK,PL_PRIKAZ) <= to_date(''31.12.2009'',''DD.MM.YYYY'')), 1, to_char(NVL(ROZSUDEK,PL_PRIKAZ),''DD.MM.YYYY''), ''31.12.2009'')||'' z částky'', '+
	      '              NULL) '+
	      '       ) AS UROK8, '+
	      'DECODE((SELECT 1 FROM DUAL WHERE Z.SPLATNOST <= to_date(''31.12.2009'',''DD.MM.YYYY'') AND NVL(ROZSUDEK,PL_PRIKAZ) >= to_date(''1.7.2009'',''DD.MM.YYYY'')),1,DLUZNA_CASTKA,NULL) AS CASTKA8, '+
	      'DECODE((SELECT 1 FROM DUAL WHERE Z.SPLATNOST <= to_date(''31.12.2009'',''DD.MM.YYYY'') AND NVL(ROZSUDEK,PL_PRIKAZ) >= to_date(''1.7.2009'',''DD.MM.YYYY'')),1,''Kč'',NULL) AS MENA8, '+
	      ' '+
	      'DECODE((SELECT 1 FROM DUAL WHERE Z.SPLATNOST >= to_date(''1.1.2010'',''DD.MM.YYYY'') AND Z.SPLATNOST <= to_date(''30.6.2010'',''DD.MM.YYYY'') AND NVL(ROZSUDEK,PL_PRIKAZ) >= to_date(''1.1.2010'',''DD.MM.YYYY'')), '+
	      '       1, '+
	      '       ''- 8% ročně od ''||to_char(SPLATNOST,''DD.MM.YYYY'')||'' do ''||DECODE((SELECT 1 FROM DUAL WHERE NVL(ROZSUDEK,PL_PRIKAZ) <= to_date(''30.6.2010'',''DD.MM.YYYY'')), 1, to_char(NVL(ROZSUDEK,PL_PRIKAZ),''DD.MM.YYYY''), ''30.6.2010'')||'' z částky'', '+
	      '       DECODE((SELECT 1 FROM DUAL WHERE Z.SPLATNOST <= to_date(''30.6.2010'',''DD.MM.YYYY'') AND NVL(ROZSUDEK,PL_PRIKAZ) >= to_date(''1.1.2010'',''DD.MM.YYYY'')), '+
	      '              1, '+
	      '              ''- 8% ročně od 1.1.2010 do ''||DECODE((SELECT 1 FROM DUAL WHERE NVL(ROZSUDEK,PL_PRIKAZ) <= to_date(''30.6.2010'',''DD.MM.YYYY'')), 1, to_char(NVL(ROZSUDEK,PL_PRIKAZ),''DD.MM.YYYY''), ''30.6.2010'')||'' z částky'', '+
	      '              NULL) '+
	      '       ) AS UROK9, '+
	      'DECODE((SELECT 1 FROM DUAL WHERE Z.SPLATNOST <= to_date(''30.6.2010'',''DD.MM.YYYY'') AND NVL(ROZSUDEK,PL_PRIKAZ) >= to_date(''1.1.2010'',''DD.MM.YYYY'')),1,DLUZNA_CASTKA,NULL) AS CASTKA9, '+
	      'DECODE((SELECT 1 FROM DUAL WHERE Z.SPLATNOST <= to_date(''30.6.2010'',''DD.MM.YYYY'') AND NVL(ROZSUDEK,PL_PRIKAZ) >= to_date(''1.1.2010'',''DD.MM.YYYY'')),1,''Kč'',NULL) AS MENA9, '+
	      ' '+
	      'DECODE((SELECT 1 FROM DUAL WHERE Z.SPLATNOST >= to_date(''1.7.2010'',''DD.MM.YYYY'') AND Z.SPLATNOST <= to_date(''30.6.2012'',''DD.MM.YYYY'') AND NVL(ROZSUDEK,PL_PRIKAZ) >= to_date(''1.7.2010'',''DD.MM.YYYY'')), '+
	      '       1, '+
	      '       ''- 7,75% ročně od ''||to_char(SPLATNOST,''DD.MM.YYYY'')||'' do ''||DECODE((SELECT 1 FROM DUAL WHERE NVL(ROZSUDEK,PL_PRIKAZ) <= to_date(''30.6.2012'',''DD.MM.YYYY'')), 1, to_char(NVL(ROZSUDEK,PL_PRIKAZ),''DD.MM.YYYY''), ''30.6.2012'')||'' z částky'', '+
	      '       DECODE((SELECT 1 FROM DUAL WHERE Z.SPLATNOST <= to_date(''30.6.2012'',''DD.MM.YYYY'') AND NVL(ROZSUDEK,PL_PRIKAZ) >= to_date(''1.7.2010'',''DD.MM.YYYY'')), '+
	      '              1, '+
	      '              ''- 7,75% ročně od 1.7.2010 do ''||DECODE((SELECT 1 FROM DUAL WHERE NVL(ROZSUDEK,PL_PRIKAZ) <= to_date(''30.6.2012'',''DD.MM.YYYY'')), 1, to_char(NVL(ROZSUDEK,PL_PRIKAZ),''DD.MM.YYYY''), ''30.6.2012'')||'' z částky'', '+
	      '              NULL) '+
	      '       ) AS UROK10, '+
	      'DECODE((SELECT 1 FROM DUAL WHERE Z.SPLATNOST <= to_date(''30.6.2012'',''DD.MM.YYYY'') AND NVL(ROZSUDEK,PL_PRIKAZ) >= to_date(''1.7.2010'',''DD.MM.YYYY'')),1,DLUZNA_CASTKA,NULL) AS CASTKA10, '+
	      'DECODE((SELECT 1 FROM DUAL WHERE Z.SPLATNOST <= to_date(''30.6.2012'',''DD.MM.YYYY'') AND NVL(ROZSUDEK,PL_PRIKAZ) >= to_date(''1.7.2010'',''DD.MM.YYYY'')),1,''Kč'',NULL) AS MENA10, '+
	      ' '+
	      'DECODE((SELECT 1 FROM DUAL WHERE Z.SPLATNOST >= to_date(''1.7.2012'',''DD.MM.YYYY'') AND Z.SPLATNOST <= to_date(''31.12.2012'',''DD.MM.YYYY'') AND NVL(ROZSUDEK,PL_PRIKAZ) >= to_date(''1.7.2012'',''DD.MM.YYYY'')), '+
	      '       1, '+
	      '       ''- 7,5% ročně od ''||to_char(SPLATNOST,''DD.MM.YYYY'')||'' do ''||DECODE((SELECT 1 FROM DUAL WHERE NVL(ROZSUDEK,PL_PRIKAZ) <= to_date(''31.12.2012'',''DD.MM.YYYY'')), 1, to_char(NVL(ROZSUDEK,PL_PRIKAZ),''DD.MM.YYYY''), ''31.12.2012'')||'' z částky'', '+
	      '       DECODE((SELECT 1 FROM DUAL WHERE Z.SPLATNOST <= to_date(''31.12.2012'',''DD.MM.YYYY'') AND NVL(ROZSUDEK,PL_PRIKAZ) >= to_date(''1.7.2012'',''DD.MM.YYYY'')), '+
	      '              1, '+
	      '              ''- 7,5% ročně od 1.7.2012 do ''||DECODE((SELECT 1 FROM DUAL WHERE NVL(ROZSUDEK,PL_PRIKAZ) <= to_date(''31.12.2012'',''DD.MM.YYYY'')), 1, to_char(NVL(ROZSUDEK,PL_PRIKAZ),''DD.MM.YYYY''), ''31.12.2012'')||'' z částky'', '+
	      '              NULL) '+
	      '       ) AS UROK11, '+
	      'DECODE((SELECT 1 FROM DUAL WHERE Z.SPLATNOST <= to_date(''31.12.2012'',''DD.MM.YYYY'') AND NVL(ROZSUDEK,PL_PRIKAZ) >= to_date(''1.7.2012'',''DD.MM.YYYY'')),1,DLUZNA_CASTKA,NULL) AS CASTKA11, '+
	      'DECODE((SELECT 1 FROM DUAL WHERE Z.SPLATNOST <= to_date(''31.12.2012'',''DD.MM.YYYY'') AND NVL(ROZSUDEK,PL_PRIKAZ) >= to_date(''1.7.2012'',''DD.MM.YYYY'')),1,''Kč'',NULL) AS MENA11, '+
	      ' '+
	      'DECODE((SELECT 1 FROM DUAL WHERE Z.SPLATNOST >= to_date(''1.1.2013'',''DD.MM.YYYY'') AND NVL(ROZSUDEK,PL_PRIKAZ) >= to_date(''1.1.2013'',''DD.MM.YYYY'')), '+
	      '       1, '+
	      '       ''- 7,05% ročně od ''||to_char(SPLATNOST,''DD.MM.YYYY'')||'' do ''||to_char(NVL(ROZSUDEK,PL_PRIKAZ),''DD.MM.YYYY'')||'' z částky'', '+
	      '       DECODE((SELECT 1 FROM DUAL WHERE Z.SPLATNOST < to_date(''1.1.2013'',''DD.MM.YYYY'') AND NVL(ROZSUDEK,PL_PRIKAZ) >= to_date(''1.1.2013'',''DD.MM.YYYY'')), '+
	      '              1, '+
	      '              ''- 7,05% ročně od 1.1.2013 do ''||to_char(NVL(ROZSUDEK,PL_PRIKAZ),''DD.MM.YYYY'')||'' z částky'', '+
	      '              NULL) '+
	      '       ) AS UROK12, '+
	      'DECODE((SELECT 1 FROM DUAL WHERE NVL(ROZSUDEK,PL_PRIKAZ) >= to_date(''1.1.2013'',''DD.MM.YYYY'')), 1, DLUZNA_CASTKA, NULL) AS CASTKA12, '+
	      'DECODE((SELECT 1 FROM DUAL WHERE NVL(ROZSUDEK,PL_PRIKAZ) >= to_date(''1.1.2013'',''DD.MM.YYYY'')), 1, ''Kč'', NULL) AS MENA12 '+
              'FROM '+
              '  ZALOBY Z,'+
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

  result:=sql_text;
finally
end;
end;

end;

procedure TfrmZaloby.miExekuceTunklClick(Sender: TObject);
var
  sql_text:string;
begin
try
  sql_text:=getTiskExekuce;
  frmSExekuce.qrMaster.Close;
  frmSExekuce.qrMaster.SQL.Text:=sql_text;
  frmSExekuce.qrMaster.Open;
  frmSExekuce.frReport.LoadFromFile(Replace_Char(get_param('SESTAVY')+'\','\\','\')+'SexekuceTunkl.lrf');
  frmSExekuce.frReport.PrepareReport;
  frmSExekuce.frReport.ModalPreview:=true;
  frmSExekuce.frReport.ShowProgress:=true;
  frmSExekuce.frReport.ShowReport;
  frmSExekuce.qrMaster.Close;

finally
end;
end;

procedure TfrmZaloby.miExekuceTunklDomifinClick(Sender: TObject);
var
  sql_text:string;
begin
try
    sql_text:=getTiskExekuce;
    frmSExekuce.qrMaster.Close;
    frmSExekuce.qrMaster.SQL.Text:=sql_text;
    frmSExekuce.qrMaster.Open;
    frmSExekuce.frReport.LoadFromFile(Replace_Char(get_param('SESTAVY')+'\','\\','\')+'SexekuceTunklDomifin.lrf');
    frmSExekuce.frReport.PrepareReport;
    frmSExekuce.frReport.ModalPreview:=true;
    frmSExekuce.frReport.ShowProgress:=true;
    frmSExekuce.frReport.ShowReport;
    frmSExekuce.qrMaster.Close;

  finally
  end;
end;

procedure TfrmZaloby.miExekuceTunklOIClick(Sender: TObject);
var
  sql_text:string;
begin
try
    sql_text:=getTiskExekuce;
    frmSExekuce.qrMaster.Close;
    frmSExekuce.qrMaster.SQL.Text:=sql_text;
    frmSExekuce.qrMaster.Open;
    frmSExekuce.frReport.LoadFromFile(Replace_Char(get_param('SESTAVY')+'\','\\','\')+'SexekuceTunklOI.lrf');
    frmSExekuce.frReport.PrepareReport;
    frmSExekuce.frReport.ModalPreview:=true;
    frmSExekuce.frReport.ShowProgress:=true;
    frmSExekuce.frReport.ShowReport;
    frmSExekuce.qrMaster.Close;

  finally
  end;
end;

procedure TfrmZaloby.miExportPodaciListClick(Sender: TObject);
begin
  podaci_list_excel(DBGrid,'ZALOBY');
end;

procedure TfrmZaloby.miExportPredavaciProtokolClick(Sender: TObject);
begin
  predavaci_protokol_excel(DBGrid,'ZALOBY');
end;

procedure TfrmZaloby.miExportSpisClick(Sender: TObject);
begin
  ExportSpis(DBGrid, 'ZALOBY', OpenDialog.FileName);
end;

procedure TfrmZaloby.miExportZalobClick(Sender: TObject);
begin
  exportZalob(DBGrid, 'ZALOBY');
end;

procedure TfrmZaloby.miHistorieClick(Sender: TObject);
begin
  if not Assigned(frmZalobyHistorie) then
    Application.CreateForm(TfrmZalobyHistorie,frmZalobyHistorie);
  frmZalobyHistorie.ShowModal;
end;

procedure TfrmZaloby.miImportSpisClick(Sender: TObject);
begin
  ImportSpis('ZALOBY');
  Refresh_DataSet(Navigator.DataSource.DataSet,qrMaster);
end;

procedure TfrmZaloby.miImportZalob2Click(Sender: TObject);
begin
  importZalob(DBGrid, 'ZALOBY');
  Refresh_DataSet(Navigator.DataSource.DataSet,qrMaster);
end;

procedure TfrmZaloby.miImportZalobClick(Sender: TObject);
begin
  if OpenDialog.Execute then
  begin
    import_zalob(UTF8Decode(OpenDialog.FileName));
    Refresh_DataSet(Navigator.DataSource.DataSet,qrMaster);
  end;
end;

procedure TfrmZaloby.miKontrolaPrijmuClick(Sender: TObject);
begin
  ExecSQL('UPDATE NASTAVENI_SYSTEMU SET ZALOBY_PRIJEM = 0');
  ShowMessage('Resetování stavu příjmu žalob bylo provedeno.');
end;

procedure TfrmZaloby.miKuhrade2Click(Sender: TObject);
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

    sql_text:=
      'SELECT S.*, ROWNUM AS CISLO FROM ( ' +
      'SELECT ' +
      '  Z.DATUM_IMPORTU AS DATUM, ' +
      '  SUM(Z.NAROK) AS KUHRADE, ' +
      '  SUM(Z.ZAPLATIL_CASTKA) AS ZAPLACENO, ' +
      '  SUM(Z.NAROK) - SUM(Z.ZAPLATIL_CASTKA) AS ROZDIL ' +
      'FROM ' +
      '  ZALOBY Z ' +
      'GROUP BY ' +
      '  Z.DATUM_IMPORTU ' +
      'ORDER BY ' +
      '  Z.DATUM_IMPORTU ASC) S';

    if (frmTiskZalob.rbDatum.Checked) and (frmTiskZalob.edDatumImportu.Text<>'') then
      sql_text:='SELECT * FROM ('+sql_text+') WHERE DATUM=TO_DATE('''+frmTiskZalob.edDatumImportu.Text+''') ORDER BY DATUM DESC';
    if frmTiskZalob.rbOznacene.Checked then
    begin
      if temp='' then temp:='0';
         sql_text:=
           'SELECT S.*, ROWNUM AS CISLO FROM ( ' +
           'SELECT ' +
           '  Z.DATUM_IMPORTU AS DATUM, ' +
           '  SUM(Z.NAROK) AS KUHRADE, ' +
           '  SUM(Z.ZAPLATIL_CASTKA) AS ZAPLACENO, ' +
           '  SUM(Z.NAROK) - SUM(Z.ZAPLATIL_CASTKA) AS ROZDIL ' +
           'FROM ' +
           '  ZALOBY Z ' +
           'WHERE ' +
           '  ID IN ('+temp+')' +
           'GROUP BY ' +
           '  Z.DATUM_IMPORTU ' +
           'ORDER BY ' +
           '  Z.DATUM_IMPORTU ASC) S ';
      //sql_text:='SELECT * FROM ('+sql_text+') WHERE ID IN ('+temp+') ORDER BY DATUM DESC';
    end;

    if not Assigned(frmSKuhradeSumar) then
      Application.CreateForm(TfrmSKuhradeSumar,frmSKuhradeSumar);
    frmSKuhradeSumar.qrMaster.Close;
    frmSKuhradeSumar.qrMaster.SQL.Text:=sql_text;
    frmSKuhradeSumar.qrMaster.Open;
    frmSKuhradeSumar.frReport.LoadFromFile(Replace(get_param('SESTAVY')+'\','\\','\')+'ZalobyKZaplaceniSumar.lrf');
    frmSKuhradeSumar.frReport.PrepareReport;
    frmSKuhradeSumar.frReport.ModalPreview:=true;
    frmSKuhradeSumar.frReport.ShowProgress:=true;
    frmSKuhradeSumar.frReport.ShowReport;
    frmSKuhradeSumar.qrMaster.Close;
  end;
end;

procedure TfrmZaloby.miPodaciList3Click(Sender: TObject);
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

    sql_text:='SELECT ROWNUM AS RADEK,Z.*,Z.ULICE||'' ''||Z.CISLO_DOMU AS ULICE_CP,Z.PSC||'' ''||Z.MESTO AS PSC_MESTO FROM ZALOBY Z WHERE NVL(UZAMCENA,0)=0 ORDER BY Z.VAR_SYMB';
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
    frmSOPOPPPodaciList3.frReport.LoadFromFile(Replace_Char(get_param('SESTAVY')+'\','\\','\')+'OPOPPPodaciList3.lrf');
    frmSOPOPPPodaciList3.frReport.PrepareReport;
    frmSOPOPPPodaciList3.frReport.ModalPreview:=true;
    frmSOPOPPPodaciList3.frReport.ShowProgress:=true;
    frmSOPOPPPodaciList3.frReport.ShowReport;
    frmSOPOPPPodaciList3.qrMaster.Close;
  end;
end;

procedure TfrmZaloby.miPoslatPrikazClick(Sender: TObject);
begin
  //export_prikazu(DBGrid,'ZALOBY');
  export_prikazu_KB_KM(DBGrid,'ZALOBY');
  Refresh_DataSet(Navigator.DataSource.DataSet,qrMaster);
end;

procedure TfrmZaloby.miPrubehClick(Sender: TObject);
begin
  prubeh_davky(DBGrid, 'ZALOBY');
end;

procedure TfrmZaloby.miVymazatDatumPlatbyClick(Sender: TObject);
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

    sql_text:='UPDATE ZALOBY SET UHR_SOP=NULL WHERE NVL(UZAMCENA,0)=0';
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

procedure TfrmZaloby.miZaplaceneClick(Sender: TObject);
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

    sql_text:='SELECT ROWNUM AS RADEK,Z.*,SUBSTR(Z.JMENO_CP,1,INSTR(Z.JMENO_CP,'' '')) AS JMENO,SUBSTR(Z.JMENO_CP,INSTR(JMENO_CP,'' '')+1) AS PRIJMENI FROM ZALOBY Z WHERE NVL(UZAMCENA,0)=0 AND UHR_SOP IS NOT NULL ORDER BY Z.VAR_SYMB';
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
    //ShowMessage('STOP');
    frmSZaplacene.frReport.LoadFromFile(Replace_Char(get_param('SESTAVY')+'\','\\','\')+'ZalobyZaplacene.lrf');
    frmSZaplacene.frReport.PrepareReport;
    frmSZaplacene.frReport.ModalPreview:=true;
    frmSZaplacene.frReport.ShowProgress:=true;
    frmSZaplacene.frReport.ShowReport;
    frmSZaplacene.qrMaster.Close;
  end;
end;

procedure TfrmZaloby.miNovyZaznamClick(Sender: TObject);
begin
  inherited;
end;

procedure TfrmZaloby.miOdemknoutClick(Sender: TObject);
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
          ExecSql('UPDATE ZALOBY SET UZAMCENA=0,DATUM_UZAMCENI=NULL WHERE ID='+Table.FieldByName('ID').AsString);
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

procedure TfrmZaloby.miOdemknoutDatumClick(Sender: TObject);
begin
  if not Assigned(dlgDatum) then
    Application.CreateForm(TdlgDatum,dlgDatum);

  if dlgDatum.ShowModal=mrOK then
  begin
    if dlgDatum.edDatum.Text<>'' then
    begin
      ExecSql('UPDATE ZALOBY SET UZAMCENA=0,DATUM_UZAMCENI=NULL WHERE NVL(UZAMCENA,0)=1 AND DATUM_IMPORTU=TO_DATE('+Q(dlgDatum.edDatum.Text)+',''DD.MM.YYYY'')');
      Refresh_DataSet(Navigator.DataSource.DataSet,qrMaster);
      MessageDlg('Žaloby k datu '+dlgDatum.edDatum.text+' byly odemknuté!',mtInformation,[mbOK],0);
    end;
  end;
end;

procedure TfrmZaloby.miOdemknoutVseClick(Sender: TObject);
begin
  if MessageDlg('Opravdu chcete všechny žaloby odemknout?',mtConfirmation,[mbYES,mbNO],0)=mrYES then
  begin
    ExecSql('UPDATE ZALOBY SET UZAMCENA=0,DATUM_UZAMCENI=NULL WHERE NVL(UZAMCENA,0)=1');
    Refresh_DataSet(Navigator.DataSource.DataSet,qrMaster);
    MessageDlg('Všechny žaloby byly odemknuty!',mtInformation,[mbOK],0);
  end;
end;

procedure TfrmZaloby.miPodaciList2Click(Sender: TObject);
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

    sql_text:='SELECT ROWNUM AS RADEK,Z.*,Z.ULICE||'' ''||Z.CISLO_DOMU AS ULICE_CP,Z.PSC||'' ''||Z.MESTO AS PSC_MESTO FROM ZALOBY Z WHERE NVL(UZAMCENA,0)=0 ORDER BY Z.VAR_SYMB';
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
    frmSOPOPPPodaciList2.frReport.LoadFromFile(Replace_Char(get_param('SESTAVY')+'\','\\','\')+'OPOPPPodaciList2.lrf');
    frmSOPOPPPodaciList2.frReport.PrepareReport;
    frmSOPOPPPodaciList2.frReport.ModalPreview:=true;
    frmSOPOPPPodaciList2.frReport.ShowProgress:=true;
    frmSOPOPPPodaciList2.frReport.ShowReport;
    frmSOPOPPPodaciList2.qrMaster.Close;
  end;
end;

procedure TfrmZaloby.miPodaciListClick(Sender: TObject);
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

    sql_text:='SELECT ROWNUM AS RADEK,Z.*,SUBSTR(Z.JMENO_CP,1,INSTR(Z.JMENO_CP,'' '')) AS JMENO,SUBSTR(Z.JMENO_CP,INSTR(JMENO_CP,'' '')+1) AS PRIJMENI FROM ZALOBY Z WHERE NVL(UZAMCENA,0)=0 ORDER BY Z.VAR_SYMB';
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

procedure TfrmZaloby.miPredavaciProtokolClick(Sender: TObject);
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
              '  (SELECT COUNT(*) FROM ZALOBY WHERE NVL(UZAMCENA,0)=0) AS R_POCET,'+
              '  FORMAT_MENA((SELECT SUM(JIZDNE) FROM ZALOBY WHERE NVL(UZAMCENA,0)=0)+(SELECT SUM(POKUTA) FROM ZALOBY WHERE NVL(UZAMCENA,0)=0),2) AS R_CELKEM, '+
              '  FORMAT_MENA((SELECT SUM(JIZDNE) FROM ZALOBY WHERE NVL(UZAMCENA,0)=0),2) AS JIZDNE_CELKEM,'+
              '  FORMAT_MENA((SELECT SUM(POKUTA) FROM ZALOBY WHERE NVL(UZAMCENA,0)=0),2) AS PRIRAZKA_CELKEM '+
              'FROM '+
              '  ZALOBY Z '+
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
              '  (SELECT COUNT(*) FROM ZALOBY WHERE NVL(UZAMCENA,0)=0 AND DATUM_IMPORTU=TO_DATE('''+frmTiskZalob.edDatumImportu.Text+''')) AS R_POCET,'+
              '  FORMAT_MENA((SELECT SUM(JIZDNE) FROM ZALOBY WHERE NVL(UZAMCENA,0)=0 AND DATUM_IMPORTU=TO_DATE('''+frmTiskZalob.edDatumImportu.Text+'''))+(SELECT SUM(POKUTA) FROM ZALOBY WHERE NVL(UZAMCENA,0)=0 AND DATUM_IMPORTU=TO_DATE('''+frmTiskZalob.edDatumImportu.Text+''')),2) AS R_CELKEM, '+
              '  FORMAT_MENA((SELECT SUM(JIZDNE) FROM ZALOBY WHERE NVL(UZAMCENA,0)=0 AND DATUM_IMPORTU=TO_DATE('''+frmTiskZalob.edDatumImportu.Text+''')),2) AS JIZDNE_CELKEM,'+
              '  FORMAT_MENA((SELECT SUM(POKUTA) FROM ZALOBY WHERE NVL(UZAMCENA,0)=0 AND DATUM_IMPORTU=TO_DATE('''+frmTiskZalob.edDatumImportu.Text+''')),2) AS PRIRAZKA_CELKEM '+
              'FROM '+
              '  ZALOBY Z '+
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
              '  (SELECT COUNT(*) FROM ZALOBY WHERE ID IN ('+temp+')) AS R_POCET,'+
              '  FORMAT_MENA((SELECT SUM(JIZDNE) FROM ZALOBY WHERE ID IN ('+temp+'))+(SELECT SUM(POKUTA) FROM ZALOBY WHERE ID IN ('+temp+')),2) AS R_CELKEM, '+
              '  FORMAT_MENA((SELECT SUM(JIZDNE) FROM ZALOBY WHERE ID IN ('+temp+')),2) AS JIZDNE_CELKEM,'+
              '  FORMAT_MENA((SELECT SUM(POKUTA) FROM ZALOBY WHERE ID IN ('+temp+')),2) AS PRIRAZKA_CELKEM '+
              'FROM '+
              '  ZALOBY Z '+
              'WHERE '+
              '  ID IN ('+temp+')'+
              'ORDER BY '+
              '  Z.VAR_SYMB';
      //sql_text:='SELECT * FROM ('+sql_text+') WHERE ID IN ('+temp+')';
    end;


{
    sql_text:='SELECT '+
              '  ROWNUM AS RADEK,'+
              '  Z.*,'+
              '  GET_PARAM(''ZALOBY_DATUM_PREDANI'') AS DATUM_PREDANI,'+
              '  SUBSTR(Z.JMENO_CP,1,INSTR(Z.JMENO_CP,'' '')) AS JMENO,'+
              '  SUBSTR(Z.JMENO_CP,INSTR(JMENO_CP,'' '')+1) AS PRIJMENI,'+
              '  (SELECT COUNT(*) FROM ZALOBY WHERE NVL(UZAMCENA,0)=0) AS R_POCET,'+
              '  FORMAT_MENA((SELECT SUM(JIZDNE) FROM ZALOBY WHERE NVL(UZAMCENA,0)=0)+(SELECT SUM(DLUZNA_CASTKA) FROM ZALOBY WHERE NVL(UZAMCENA,0)=0),2) AS R_CELKEM, '+
              '  FORMAT_MENA((SELECT SUM(JIZDNE) FROM ZALOBY WHERE NVL(UZAMCENA,0)=0),2) AS JIZDNE_CELKEM,'+
              '  FORMAT_MENA((SELECT SUM(DLUZNA_CASTKA) FROM ZALOBY WHERE NVL(UZAMCENA,0)=0),2) AS PRIRAZKA_CELKEM '+
              'FROM '+
              '  ZALOBY Z '+
              'WHERE '+
              '  NVL(UZAMCENA,0)=0 '+
              'ORDER BY '+
              '  ID';
    if (frmTiskZalob.rbDatum.Checked) and (frmTiskZalob.edDatumImportu.Text<>'') then
      sql_text:='SELECT * FROM ('+sql_text+') WHERE DATUM_IMPORTU=TO_DATE('''+frmTiskZalob.edDatumImportu.Text+''')';
    if frmTiskZalob.rbOznacene.Checked then
    begin
      if temp='' then temp:='0';
      sql_text:='SELECT * FROM ('+sql_text+') WHERE ID IN ('+temp+')';
    end;
}

    if not Assigned(frmSOPOPPPredavaciProtokol) then
      Application.CreateForm(TfrmSOPOPPPredavaciProtokol,frmSOPOPPPredavaciProtokol);
    frmSOPOPPPredavaciProtokol.qrMaster.Close;
    frmSOPOPPPredavaciProtokol.qrMaster.SQL.Text:=sql_text;
    frmSOPOPPPredavaciProtokol.qrMaster.Open;
    frmSOPOPPPredavaciProtokol.frReport.LoadFromFile(Replace_Char(get_param('SESTAVY')+'\','\\','\')+'OPOPPPredavaciProtokol.lrf');
    frmSOPOPPPredavaciProtokol.frReport.PrepareReport;
    frmSOPOPPPredavaciProtokol.frReport.ModalPreview:=true;
    frmSOPOPPPredavaciProtokol.frReport.ShowProgress:=true;
    frmSOPOPPPredavaciProtokol.frReport.ShowReport;
    frmSOPOPPPredavaciProtokol.qrMaster.Close;
  end;
end;

procedure TfrmZaloby.miPresunoutZArchivuClick(Sender: TObject);
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
            'TELO from zaloby_zpravy_archiv where ref_kod in (select ref_kod from zaloby_archiv where datum_importu=to_date('+Q(dlgDatum.edDatum.Text)+',''DD.MM.YYYY'') or '+Q(dlgDatum.edDatum.Text)+' is null))');
    frmProces.ProgressBar1.StepIt;
    frmProces.Repaint;
    frmProces.ShowOnTop;
    ExecSQL('delete zaloby_zpravy_archiv where ref_kod in (select ref_kod from zaloby_archiv where datum_importu=to_date('+Q(dlgDatum.edDatum.Text)+',''DD.MM.YYYY'') or '+Q(dlgDatum.edDatum.Text)+' is null)');
    frmProces.ProgressBar1.StepIt;
    frmProces.Repaint;
    frmProces.ShowOnTop;
    ExecSQL('insert into zaloby /*(ID,VAR_SYMB,JMENO_CP,DATUM_CAS,DLUZNA_CASTKA,JIZDNE,POKUTA,RODNE_CISLO,ULICE,CISLO_DOMU,MESTO,'+
            '                OBVOD,PSC,REF_KOD,UZAMCENA,DATUM_IMPORTU,DATUM_UZAMCENI,PL_PRIKAZ,UHRADA,SPLATNOST,SOUD,ZALOBA,NAROK,'+
            '                VS_SOUDU,CU_SOUDU,SPIS_ZNACKA,UHR_SOP,ODVOLANI,JEDNANI,ROZSUDEK,PR_MOC,NAVRH,PRIKAZ,CASTKA,SKONCENO,CISLO,'+
            '                DATUM_UHRADY,ZEMREL,ZAPLATIL_PRED_PODANIM,ZAPLATIL_CASTKA,USNESENI,EXEKUTOR,ZPRAVA_DORUCENI,ZPRAVA_OVERENI,'+
            '                ZPRAVA_PL_ROZKAZ,ZPRAVA_ZAPRACOVANI,VYMOZENO,SKONCENO_DUVOD,INSOLVENCE,SPLATKOVY_KALENDAR,USNESENI_DATUM,'+
            '                OPRAVNE_USNESENI_DATUM,USNESENI_CJ,EXEKUCNI_PRIKAZ)*/ '+
            '(select ID,VAR_SYMB,JMENO_CP,DATUM_CAS,DLUZNA_CASTKA,JIZDNE,POKUTA,RODNE_CISLO,ULICE,CISLO_DOMU,MESTO,'+
            'OBVOD,PSC,REF_KOD,UZAMCENA,DATUM_IMPORTU,DATUM_UZAMCENI,PL_PRIKAZ,UHRADA,SPLATNOST,SOUD,ZALOBA,NAROK,VS_SOUDU,CU_SOUDU,'+
            'SPIS_ZNACKA,UHR_SOP,ODVOLANI,JEDNANI,ROZSUDEK,PR_MOC,NAVRH,PRIKAZ,CASTKA,SKONCENO,CISLO,DATUM_UHRADY,ZEMREL,ZAPLATIL_PRED_PODANIM,'+
            'ZAPLATIL_CASTKA,USNESENI,EXEKUTOR,ZPRAVA_DORUCENI,ZPRAVA_OVERENI,ZPRAVA_PL_ROZKAZ,ZPRAVA_ZAPRACOVANI,VYMOZENO,SKONCENO_DUVOD,'+
            'INSOLVENCE,SPLATKOVY_KALENDAR,USNESENI_DATUM,OPRAVNE_USNESENI_DATUM,USNESENI_CJ,EXEKUCNI_PRIKAZ from zaloby_archiv where datum_importu=to_date('+Q(dlgDatum.edDatum.Text)+',''DD.MM.YYYY'') or '+Q(dlgDatum.edDatum.Text)+' is null)');
    frmProces.ProgressBar1.StepIt;
    frmProces.Repaint;
    frmProces.ShowOnTop;
    ExecSQL('delete zaloby_archiv where datum_importu=to_date('+Q(dlgDatum.edDatum.Text)+',''DD.MM.YYYY'') or '+Q(dlgDatum.edDatum.Text)+' is null');
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

procedure TfrmZaloby.miPrijmoutPostuClick(Sender: TObject);
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

procedure TfrmZaloby.miProPrikazClick(Sender: TObject);
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
              ' FROM ZALOBY Z WHERE NVL(UZAMCENA,0)=0 AND UHR_SOP IS NULL AND (CU_SOUDU IS NOT NULL AND VS_SOUDU IS NOT NULL) ORDER BY Z.VAR_SYMB';
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
    frmSKuhrade.frReport.LoadFromFile(Replace_Char(get_param('SESTAVY')+'\','\\','\')+'ZalobyKZaplaceni.lrf');
    frmSKuhrade.frReport.PrepareReport;
    frmSKuhrade.frReport.ModalPreview:=true;
    frmSKuhrade.frReport.ShowProgress:=true;
    frmSKuhrade.frReport.ShowReport;
    frmSKuhrade.qrMaster.Close;
  end;
end;

procedure TfrmZaloby.miSmazatZaznamClick(Sender: TObject);
begin
  inherited;
end;

procedure TfrmZaloby.miSmlouvaClick(Sender: TObject);
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
              '  ZALOBY Z,'+
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
              '  ZALOBY Z,'+
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
              '  ZALOBY Z,'+
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
  frmSOznameniPostupiteleOPostoupeniPohledavky.frReport.LoadFromFile(Replace_Char(get_param('SESTAVY')+'\','\\','\')+'OznameniPostupiteleOPostoupeniPohledavky.lrf');
  frmSOznameniPostupiteleOPostoupeniPohledavky.frReport.PrepareReport;
  frmSOznameniPostupiteleOPostoupeniPohledavky.frReport.ModalPreview:=true;
  frmSOznameniPostupiteleOPostoupeniPohledavky.frReport.ShowProgress:=true;
  frmSOznameniPostupiteleOPostoupeniPohledavky.frReport.ShowReport;
  frmSOznameniPostupiteleOPostoupeniPohledavky.qrMaster.Close;

finally
end;
end;

end;

procedure TfrmZaloby.miTypyZpravClick(Sender: TObject);
begin
    if not Assigned(frmZalobyTypyZprav) then
      Application.CreateForm(TfrmZalobyTypyZprav,frmZalobyTypyZprav);
    frmZalobyTypyZprav.Show;
end;

procedure TfrmZaloby.miUpravitZaznamClick(Sender: TObject);
begin
  inherited;
end;

procedure TfrmZaloby.miUzamknoutClick(Sender: TObject);
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
          ExecSql('UPDATE ZALOBY SET UZAMCENA=1,DATUM_UZAMCENI=SYSDATE WHERE ID='+Table.FieldByName('ID').AsString);
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

procedure TfrmZaloby.miUzamknoutDatumClick(Sender: TObject);
begin
    if not Assigned(dlgDatum) then
      Application.CreateForm(TdlgDatum,dlgDatum);

    if dlgDatum.ShowModal=mrOK then
    begin
      if dlgDatum.edDatum.Text<>'' then
      begin
        ExecSql('UPDATE ZALOBY SET UZAMCENA=1,DATUM_UZAMCENI=SYSDATE WHERE NVL(UZAMCENA,0)=0 AND DATUM_IMPORTU=TO_DATE('+Q(dlgDatum.edDatum.Text)+',''DD.MM.YYYY'')');
        Refresh_DataSet(Navigator.DataSource.DataSet,qrMaster);
        MessageDlg('Žaloby k datu '+dlgDatum.edDatum.text+' byly uzamknuty!',mtInformation,[mbOK],0);
      end;
    end;
end;

procedure TfrmZaloby.miUzavritVseClick(Sender: TObject);
begin
  if MessageDlg('Opravdu chcete všechny žaloby uzamknout?',mtConfirmation,[mbYES,mbNO],0)=mrYES then
  begin
    ExecSql('UPDATE ZALOBY SET UZAMCENA=1,DATUM_UZAMCENI=SYSDATE WHERE NVL(UZAMCENA,0)=0');
    Refresh_DataSet(Navigator.DataSource.DataSet,qrMaster);
    MessageDlg('Všechny žaloby byly uzamknuty!',mtInformation,[mbOK],0);
  end;
end;

procedure TfrmZaloby.miVychoziDotazClick(Sender: TObject);
begin
  inherited;
  RadioGroup1.ItemIndex:=0;
end;

procedure TfrmZaloby.miZavritClick(Sender: TObject);
begin
  inherited;
end;

procedure TfrmZaloby.miZrusOznaceniClick(Sender: TObject);
begin
  inherited;
end;

procedure TfrmZaloby.NavigatorBeforeAction(Sender: TObject;
  Button: TDBNavButtonType);
begin
  inherited;
end;

procedure TfrmZaloby.NavigatorClick(Sender: TObject; Button: TDBNavButtonType);
begin
  inherited;
end;

procedure TfrmZaloby.Panel1Click(Sender: TObject);
begin

end;

procedure TfrmZaloby.pcMainPageChanged(Sender: TObject);
begin
  if pcMain.ActivePage=tsSeznam then
    Navigator.DataSource:=dsMaster;
end;

procedure TfrmZaloby.qrImportAfterApplyUpdates(Sender: TObject);
begin
  qrImport.CommitUpdates;
end;

procedure TfrmZaloby.qrImportAfterPost(DataSet: TDataSet);
begin
  qrImport.ApplyUpdates;
end;

procedure TfrmZaloby.qrMaster2AfterOpen(DataSet: TDataSet);
begin

end;

procedure TfrmZaloby.qrMasterAfterApplyUpdates(Sender: TObject);
begin
  inherited;
end;

procedure TfrmZaloby.qrMasterAfterClose(DataSet: TDataSet);
begin
  //if not Assigned(frmProcesQuery) then
  //  Application.CreateForm(TfrmProcesQuery,frmProcesQuery);
  //frmProcesQuery.ShowOnTop;
end;

procedure TfrmZaloby.qrMasterAfterPost(DataSet: TDataSet);
begin
  inherited;
end;

procedure TfrmZaloby.qrMasterBeforeEdit(DataSet: TDataSet);
begin
  inherited;
end;

procedure TfrmZaloby.qrMasterBeforeInsert(DataSet: TDataSet);
begin
  inherited;
end;

procedure TfrmZaloby.qrMasterAfterOpen(DataSet: TDataSet);
begin
  //otevri_zpravy;
  info_zpravy;
  //if Assigned(frmProcesQuery) then
  //  frmProcesQuery.Close;
end;

procedure TfrmZaloby.qrMasterAfterScroll(DataSet: TDataSet);
var
  s : string;
begin
  btEditace.Enabled:=qrMaster.ReadOnly;
end;

procedure TfrmZaloby.qrMasterBeforeOpen(DataSet: TDataSet);
begin

end;

procedure TfrmZaloby.qrMasterBeforePost(DataSet: TDataSet);
begin
  if ExecSQL_old('SELECT NVL((SELECT 1 FROM ZALOBY WHERE REF_KOD='+Q(qrMaster.FieldByName('REF_KOD').AsString)+' AND TO_CHAR(ID)<>NVL('+Q(qrMaster.FieldByName('ID').AsString)+',''0'')),0) FROM DUAL')='1' then
  begin
    DataSet.FieldByName('REF_KOD').AsString:='';
    MessageDlg('Zadaný referenční kód již existuje u jiného záznamu, nebude uložen!',mtWarning,[mbOK],0);
  end;
end;

procedure TfrmZaloby.qrZpravyAfterApplyUpdates(Sender: TObject);
begin
  qrZpravy.CommitUpdates;
end;

procedure TfrmZaloby.qrZpravyAfterPost(DataSet: TDataSet);
begin
  qrZpravy.ApplyUpdates;
end;

procedure TfrmZaloby.RadioGroup1Click(Sender: TObject);
var
  sql_puv: string;
  i: integer;
begin
  qrMaster.Close;
  qrMaster.ParamCheck:=false;
  qrMaster.ParamCheck:=true;
  qrMaster.ParamByName('UZAMCENA').DataType := ftSmallInt;
  if RadioGroup1.ItemIndex=2 then
    qrMaster.ParamByName('UZAMCENA').AsSmallInt := 0;
  if RadioGroup1.ItemIndex=1 then
    qrMaster.ParamByName('UZAMCENA').AsSmallInt := 1;
  if RadioGroup1.ItemIndex=0 then
    qrMaster.ParamByName('UZAMCENA').AsSmallInt := 2;
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

procedure TfrmZaloby.ToolButton10Click(Sender: TObject);
begin
  inherited;
end;

procedure TfrmZaloby.ToolButton3Click(Sender: TObject);
begin
  inherited;
end;

procedure TfrmZaloby.import_zalob(f: string);
var
  s: TStringList;
  navesti,delimiter,tmp,radek,c,ci,splatnost,cislo : string;
  i,a,p,pocet: Integer;
  var_symbol,jmeno_cp,rodne_cislo,ulice,soud,
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
    //ShowMessage(f);
    s.LoadFromFile(f);
    for a:=0 to s.count-1 do
      s[a]:=utf8encode(s[a]);
    navesti:='c;var_symbol;jmeno_cp;datum_cas;dluzna_castka;jizdne;pokuta;rodne_cislo;ulice;cislo_domu;mesto;obvod;psc;soud';
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
          // -- 0
          tmp:=Copy(Radek,1,Pos(delimiter,radek)-1);
          cislo:=tmp;
          if Pos(delimiter,radek)>0 then p:=p+1;
          radek:=Copy(Radek,Pos(delimiter,radek)+1,length(radek)-Pos(delimiter,radek));
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
          datum_cas:=StrToDateTime('1.1.1899');
          if length(tmp)>0 then
            datum_cas:=StrToDateTime(tmp);
          if Pos(delimiter,radek)>0 then p:=p+1;
          radek:=Copy(Radek,Pos(delimiter,radek)+1,length(radek)-Pos(delimiter,radek));
          // -- 4
          tmp:=Copy(Radek,1,Pos(delimiter,radek)-1);
          dluzna_castka:=0;
          if length(tmp)>0 then
            dluzna_castka:=StrToFloat(Replace(tmp,' ',''));
          if Pos(delimiter,radek)>0 then p:=p+1;
          radek:=Copy(Radek,Pos(delimiter,radek)+1,length(radek)-Pos(delimiter,radek));
          // -- 5
          tmp:=Copy(Radek,1,Pos(delimiter,radek)-1);
          jizdne:=0;
          if length(tmp)>0 then
            jizdne:=StrToFloat(Replace(tmp,' ',''));
          if Pos(delimiter,radek)>0 then p:=p+1;
          radek:=Copy(Radek,Pos(delimiter,radek)+1,length(radek)-Pos(delimiter,radek));
          // -- 6
          tmp:=Copy(Radek,1,Pos(delimiter,radek)-1);
          pokuta:=0;
          if length(tmp)>0 then
            pokuta:=StrToFloat(Replace(tmp,' ',''));
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
          tmp:=Copy(Radek,1,Pos(delimiter,radek)-1);
          psc:=tmp;
          if Pos(delimiter,radek)>0 then p:=p+1;
          radek:=Copy(Radek,Pos(delimiter,radek)+1,length(radek)-Pos(delimiter,radek));
          // -- 13
          tmp:=Copy(Radek,1,length(Radek));
          soud:=tmp;

          //if length(psc)>10 then ShowMessage(psc);
          //radek:=Copy(Radek,Pos(delimiter,radek)+1,length(radek)-Pos(delimiter,radek));
          if (Pos(delimiter,soud)>0) and (kontrola_oddelovacu='1') then
          begin
            raise Exception.Create('Importní řádek obsahuje nesprávný počet oddělovačů, což způsobí chybný import dat. Informujte programátora: !');
          end;
          if not (qrImport.Active) then qrImport.Open;
          if p=13 then
          begin
            qrImport.Insert;
            qrImport.FieldByName('CISLO').AsFloat:=StrToInt(cislo);
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
            qrImport.FieldByName('SOUD').AsString:=soud;
            qrImport.FieldByName('DATUM_IMPORTU').AsDateTime:=date();
            splatnost:=get_param('ZALOBY_SPLATNOST');
            if length(splatnost)=0 then splatnost:='0';
            qrImport.FieldByName('SPLATNOST').AsDateTime:=qrImport.FieldByName('DATUM_CAS').AsDateTime+StrToInt(splatnost);
            qrImport.Post;
            pocet:=pocet+1;
          end;
        end;

        {if ExecSQL_old('SELECT NVL((SELECT COUNT(*) FROM ZALOBY_IMPORT I WHERE EXISTS(SELECT 1 FROM ZALOBY WHERE VAR_SYMB=I.VAR_SYMB)),0) FROM DUAL')<>'0' then
        begin
          frmProces.ProgressBar1.StepIt;
          frmProces.Repaint;
          frmProces.ShowOnTop;
          frmProces.Close;
          MessageDlg('Import nebyl proveden. Importovaný soubor obsahuje var. symb., který je již v databázi!',mtError,[mbOK],0);
        end
        else}
        begin
          c:=ExecSQL_old('SELECT NVL((SELECT COUNT(*) FROM ZALOBY_IMPORT I WHERE EXISTS(SELECT 1 FROM ZALOBY WHERE VAR_SYMB=I.VAR_SYMB)),0) FROM DUAL');
          ci:=ExecSQL_old('SELECT NVL((SELECT COUNT(*) FROM ZALOBY_IMPORT I WHERE NOT EXISTS(SELECT 1 FROM ZALOBY WHERE VAR_SYMB=I.VAR_SYMB)),0) FROM DUAL');
          ExecSql('INSERT INTO ZALOBY(CISLO,VAR_SYMB,JMENO_CP,DATUM_CAS,DLUZNA_CASTKA,JIZDNE,POKUTA,RODNE_CISLO,ULICE,CISLO_DOMU,MESTO,OBVOD,PSC,DATUM_IMPORTU,SOUD,SPLATNOST)'+
                  ' SELECT CISLO,VAR_SYMB,JMENO_CP,DATUM_CAS,DLUZNA_CASTKA,JIZDNE,POKUTA,RODNE_CISLO,ULICE,CISLO_DOMU,MESTO,OBVOD,PSC,DATUM_IMPORTU,SOUD,SPLATNOST FROM ZALOBY_IMPORT I '+
                  ' WHERE NOT EXISTS(SELECT 1 FROM ZALOBY WHERE VAR_SYMB=I.VAR_SYMB)');
          Refresh_DataSet(Navigator.DataSource.DataSet,qrMaster);
          frmProces.ProgressBar1.StepIt;
          frmProces.Repaint;
          frmProces.ShowOnTop;
          frmProces.Close;
          MessageDlg('Import skončil! (Celkem k importu: '+IntToStr(pocet)+', s duplicitním VS: '+c+', naimportováno: '+ci+')',mtInformation,[mbOK],0);
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

procedure TfrmZaloby.prijmout_postu_ssl;
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

procedure TfrmZaloby.info_zpravy;
begin
  try
    //s:=ExecSQL_old('SELECT 1 FROM DUAL'); //WHERE REF_KOD='''+qrMaster.FieldByName('REF_KOD').AsString+''' AND TYP_ZPRAVY=''1''');
    if qrMaster.FieldByName('REF_KOD').AsString<>'' then
    begin
      if StrToInt(ExecSQL_old('SELECT DECODE(POCET,0,NVL((SELECT NVL(ZPRAVA_DORUCENI,0) FROM ZALOBY WHERE REF_KOD='''+qrMaster.FieldByName('REF_KOD').AsString+'''),0),POCET) FROM (SELECT COUNT(*) AS POCET FROM ZALOBY_ZPRAVY Z WHERE REF_KOD='''+qrMaster.FieldByName('REF_KOD').AsString+''' AND TYP_ZPRAVY=''1'')'))>0 then
      begin
        lbPotvrzeni.Caption:='Ano';
        lbPotvrzeni.Font.Color:=clGreen;
      end
      else
      begin
        lbPotvrzeni.Caption:='Ne';
        lbPotvrzeni.Font.Color:=clRed;
      end;
      if StrToInt(ExecSQL_old('SELECT DECODE(POCET,0,NVL((SELECT NVL(ZPRAVA_OVERENI,0) FROM ZALOBY WHERE REF_KOD='''+qrMaster.FieldByName('REF_KOD').AsString+'''),0),POCET) FROM (SELECT COUNT(*) AS POCET FROM ZALOBY_ZPRAVY Z WHERE REF_KOD='''+qrMaster.FieldByName('REF_KOD').AsString+''' AND TYP_ZPRAVY=''2'')'))>0 then
      begin
        lbOvereni.Caption:='Ano';
        lbOvereni.Font.Color:=clGreen;
      end
      else
      begin
        lbOvereni.Caption:='Ne';
        lbOvereni.Font.Color:=clRed;
      end;
      if StrToInt(ExecSQL_old('SELECT DECODE(POCET,0,NVL((SELECT NVL(ZPRAVA_ZAPRACOVANI,0) FROM ZALOBY WHERE REF_KOD='''+qrMaster.FieldByName('REF_KOD').AsString+'''),0),POCET) FROM (SELECT COUNT(*) AS POCET FROM ZALOBY_ZPRAVY Z WHERE REF_KOD='''+qrMaster.FieldByName('REF_KOD').AsString+''' AND TYP_ZPRAVY=''3'')'))>0 then
      begin
        lbZpracovani.Caption:='Ano';
        lbZpracovani.Font.Color:=clGreen;
      end
      else
      begin
        lbZpracovani.Caption:='Ne';
        lbZpracovani.Font.Color:=clRed;
      end;
      if StrToInt(ExecSQL_old('SELECT DECODE(POCET,0,NVL((SELECT NVL(ZPRAVA_PL_ROZKAZ,0) FROM ZALOBY WHERE REF_KOD='''+qrMaster.FieldByName('REF_KOD').AsString+'''),0),POCET) FROM (SELECT COUNT(*) AS POCET FROM ZALOBY_ZPRAVY Z WHERE REF_KOD='''+qrMaster.FieldByName('REF_KOD').AsString+''' AND TYP_ZPRAVY=''4'')'))>0 then
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

procedure TfrmZaloby.otevri_zpravy;
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

procedure TfrmZaloby.initZobrazit;
var
  tmp : string;
begin
  tmp := ExecSql_old('SELECT GET_ZOBRAZIT(1,1) FROM DUAL');
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
  tmp := ExecSql_old('SELECT GET_ZOBRAZIT(3,1) FROM DUAL');
  if (tmp = '0') then
  begin
    miImporty.Enabled:=false;
  end;
end;

initialization
  {$I fzaloby.lrs}

end.

