unit fzalobyarchiv;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  fsablona, DbCtrls, DBGrids, ComCtrls, StdCtrls, ExtCtrls, Menus, ZDataset,
  ZSqlUpdate, db, sqldb;

type

  { TfrmZalobyArchiv }

  TfrmZalobyArchiv = class(TfrmSablona)
    btRefresh1: TToolButton;
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
    dsZpravy: TDatasource;
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
    Navigator1: TDBNavigator;
    Panel1: TPanel;
    Panel2: TPanel;
    qrMasterCISLO_DOMU: TStringField;
    qrMasterDATUM_CAS: TDateField;
    qrMasterDATUM_IMPORTU: TDateField;
    qrMasterDATUM_UZAMCENI: TDateField;
    qrMasterDLUZNA_CASTKA: TLongintField;
    qrMasterID: TLongintField;
    qrMasterJIZDNE: TLongintField;
    qrMasterJMENO_CP: TStringField;
    qrMasterMESTO: TStringField;
    qrMasterOBVOD: TStringField;
    qrMasterPOKUTA: TLongintField;
    qrMasterPSC: TStringField;
    qrMasterREF_KOD: TStringField;
    qrMasterRODNE_CISLO: TStringField;
    qrMasterULICE: TStringField;
    qrMasterUZAMCENA: TLongintField;
    qrMasterVAR_SYMB: TStringField;
    qrZpravy: TZQuery;
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
    ToolBar2: TToolBar;
    ToolButton2: TToolButton;
    ToolButton8: TToolButton;
    procedure btRefreshClick(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure DBGridDblClick(Sender: TObject);
    procedure DBGridTitleClick(Column: TColumn);
    procedure dsMasterDataChange(Sender: TObject; Field: TField);
    procedure edFindKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure miNovyZaznamClick(Sender: TObject);
    procedure miSmazatZaznamClick(Sender: TObject);
    procedure miUpravitZaznamClick(Sender: TObject);
    procedure miVychoziDotazClick(Sender: TObject);
    procedure miZavritClick(Sender: TObject);
    procedure miZrusOznaceniClick(Sender: TObject);
    procedure NavigatorBeforeAction(Sender: TObject; Button: TDBNavButtonType);
    procedure NavigatorClick(Sender: TObject; Button: TDBNavButtonType);
    procedure qrMasterAfterApplyUpdates(Sender: TObject);
    procedure qrMasterAfterOpen(DataSet: TDataSet);
    procedure qrMasterAfterPost(DataSet: TDataSet);
    procedure qrMasterBeforeEdit(DataSet: TDataSet);
    procedure qrMasterBeforeInsert(DataSet: TDataSet);
    procedure qrMasterBeforePost(DataSet: TDataSet);
    procedure ToolButton10Click(Sender: TObject);
  private
    procedure otevri_zpravy;
  public
    { public declarations }
  end; 

var
  frmZalobyArchiv: TfrmZalobyArchiv;

implementation

uses DZpravyDetail,data_module;
{ TfrmZalobyArchiv }

procedure TfrmZalobyArchiv.otevri_zpravy;
begin
  try

    qrZpravy.Close;
    qrZpravy.SQL.Text:='SELECT '+
                       '  REF_KOD,DATUM_STAZENI,ID,TYP_ZPRAVY,PREDMET,DATUM_ODESLANI,ODESILATEL,ID_ZPRAVY,'+
                       '  UCET,VAR_SYMB,PODANI_DORUCENE_DATUM,BEZNE_CISLO,PODANI_OVERENO_DATUM,ZASLANYCH_PRILOH,ZPUSOB_PODANI,'+
                       '  PODPIS_CERTIF_PLATNY,SOUD,TYP_FORMULARE,SPISOVA_ZNACKA,KE_ZPRACOVANI '+
                       'FROM ZALOBY_ZPRAVY_ARCHIV '+
                       'WHERE REF_KOD='''+qrMaster.FieldByName('REF_KOD').AsString+'''';
    qrZpravy.Open;
  except
    qrZpravy.Close;
  end;
end;

procedure TfrmZalobyArchiv.btRefreshClick(Sender: TObject);
begin
  inherited;
end;

procedure TfrmZalobyArchiv.DBGrid1DblClick(Sender: TObject);
begin
  if not Assigned(frmZpravyDetail) then
    Application.CreateForm(TfrmZpravyDetail,frmZpravyDetail);
  frmZpravyDetail.dsDetail.DataSet:=qrZpravy;
  frmZpravyDetail.ShowModal;
end;

procedure TfrmZalobyArchiv.DBGridDblClick(Sender: TObject);
begin
  inherited;
end;

procedure TfrmZalobyArchiv.DBGridTitleClick(Column: TColumn);
begin
  inherited;
end;

procedure TfrmZalobyArchiv.dsMasterDataChange(Sender: TObject; Field: TField);
begin
  otevri_zpravy;
end;

procedure TfrmZalobyArchiv.edFindKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
end;

procedure TfrmZalobyArchiv.FormActivate(Sender: TObject);
begin
  inherited;
end;

procedure TfrmZalobyArchiv.FormCreate(Sender: TObject);
begin
  inherited;
  qrZpravy.Open;
end;

procedure TfrmZalobyArchiv.miNovyZaznamClick(Sender: TObject);
begin
  inherited;
end;

procedure TfrmZalobyArchiv.miSmazatZaznamClick(Sender: TObject);
begin
  inherited;
end;

procedure TfrmZalobyArchiv.miUpravitZaznamClick(Sender: TObject);
begin
  inherited;
end;

procedure TfrmZalobyArchiv.miVychoziDotazClick(Sender: TObject);
begin
  inherited;
end;

procedure TfrmZalobyArchiv.miZavritClick(Sender: TObject);
begin
  inherited;
end;

procedure TfrmZalobyArchiv.miZrusOznaceniClick(Sender: TObject);
begin

end;

procedure TfrmZalobyArchiv.NavigatorBeforeAction(Sender: TObject;
  Button: TDBNavButtonType);
begin
  inherited;
end;

procedure TfrmZalobyArchiv.NavigatorClick(Sender: TObject;
  Button: TDBNavButtonType);
begin
  inherited;
end;

procedure TfrmZalobyArchiv.qrMasterAfterApplyUpdates(Sender: TObject);
begin
  inherited;
end;

procedure TfrmZalobyArchiv.qrMasterAfterOpen(DataSet: TDataSet);
begin
  otevri_zpravy;
end;

procedure TfrmZalobyArchiv.qrMasterAfterPost(DataSet: TDataSet);
begin
  inherited;
end;

procedure TfrmZalobyArchiv.qrMasterBeforeEdit(DataSet: TDataSet);
begin
  inherited;
end;

procedure TfrmZalobyArchiv.qrMasterBeforeInsert(DataSet: TDataSet);
begin
  inherited;
end;

procedure TfrmZalobyArchiv.qrMasterBeforePost(DataSet: TDataSet);
begin

end;

procedure TfrmZalobyArchiv.ToolButton10Click(Sender: TObject);
begin
  inherited;
end;

initialization
  {$I fzalobyarchiv.lrs}

end.

