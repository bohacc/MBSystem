unit fnabidky;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, sqldb, db, FileUtil, LResources, Forms, Controls, Graphics,
  Dialogs, ComCtrls, StdCtrls, DbCtrls, DBGrids, ExtCtrls, Menus, ZDataset,
  ZSqlUpdate, fsablona;

type

  { TfrmNabidky }

  TfrmNabidky = class(TfrmSablona)
    btRefresh1: TToolButton;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    DBEdit1: TDBEdit;
    DBEdit10: TDBEdit;
    DBEdit11: TDBEdit;
    DBEdit12: TDBEdit;
    DBEdit13: TDBEdit;
    DBEdit14: TDBEdit;
    DBEdit15: TDBEdit;
    DBEdit16: TDBEdit;
    DBEdit17: TDBEdit;
    DBEdit5: TDBEdit;
    DBEdit6: TDBEdit;
    DBEdit7: TDBEdit;
    DBEdit8: TDBEdit;
    DBEdit9: TDBEdit;
    DBGrid1: TDBGrid;
    edFind1: TEdit;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Navigator1: TDBNavigator;
    PageControl1: TPageControl;
    Panel1: TPanel;
    qrMaster0ID: TLongintField;
    qrMaster0ID_ADRESY: TLongintField;
    qrMaster0ID_OSOBY: TLongintField;
    qrMaster0ID_PARTNERA: TLongintField;
    qrMaster0PARTNER_DIC: TStringField;
    qrMaster0PARTNER_EMAIL: TStringField;
    qrMaster0PARTNER_ICO: TStringField;
    qrMaster0PARTNER_JMENO: TStringField;
    qrMaster0PARTNER_MESTO: TStringField;
    qrMaster0PARTNER_NAZEV: TStringField;
    qrMaster0PARTNER_PRIJMENI: TStringField;
    qrMaster0PARTNER_PSC: TStringField;
    qrMaster0PARTNER_STAT: TStringField;
    qrMaster0PARTNER_TEL: TStringField;
    qrMaster0PARTNER_TITUL_PRED: TStringField;
    qrMaster0PARTNER_TITUL_ZA: TStringField;
    qrMaster0PARTNER_ULICE: TStringField;
    qrMasterID: TLongintField;
    qrMasterID_ADRESY: TLongintField;
    qrMasterID_OSOBY: TLongintField;
    qrMasterID_PARTNERA: TLongintField;
    qrMasterPARTNER_DIC: TStringField;
    qrMasterPARTNER_EMAIL: TStringField;
    qrMasterPARTNER_ICO: TStringField;
    qrMasterPARTNER_JMENO: TStringField;
    qrMasterPARTNER_MESTO: TStringField;
    qrMasterPARTNER_NAZEV: TStringField;
    qrMasterPARTNER_PRIJMENI: TStringField;
    qrMasterPARTNER_PSC: TStringField;
    qrMasterPARTNER_STAT: TStringField;
    qrMasterPARTNER_TEL: TStringField;
    qrMasterPARTNER_TITUL_PRED: TStringField;
    qrMasterPARTNER_TITUL_ZA: TStringField;
    qrMasterPARTNER_ULICE: TStringField;
    TabSheet1: TTabSheet;
    ToolBar2: TToolBar;
    ToolButton6: TToolButton;
    qrPolozky: TZQuery;
    UpdatePolozky: TZUpdateSQL;
    procedure Button6Click(Sender: TObject);
    procedure edFindKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure Navigator1Click(Sender: TObject; Button: TDBNavButtonType);
    procedure qrMaster0AfterApplyUpdates(Sender: TObject);
    procedure qrMaster0AfterPost(DataSet: TDataSet);
    procedure qrMaster0BeforeEdit(DataSet: TDataSet);
    procedure qrMaster0BeforeInsert(DataSet: TDataSet);
    procedure qrMasterAfterApplyUpdates(Sender: TObject);
    procedure qrMasterAfterPost(DataSet: TDataSet);
    procedure qrMasterBeforeEdit(DataSet: TDataSet);
    procedure qrMasterBeforeInsert(DataSet: TDataSet);
    procedure qrPolozkyAfterPost(DataSet: TDataSet);
    procedure ToolButton10Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  frmNabidky: TfrmNabidky;

implementation

{ TfrmNabidky }

procedure TfrmNabidky.FormCreate(Sender: TObject);
begin
  inherited;
  qrPolozky.Open;
end;

procedure TfrmNabidky.Navigator1Click(Sender: TObject; Button: TDBNavButtonType
  );
begin

end;

procedure TfrmNabidky.qrMaster0AfterApplyUpdates(Sender: TObject);
begin
  inherited;
end;

procedure TfrmNabidky.qrMaster0AfterPost(DataSet: TDataSet);
begin
  inherited;
end;

procedure TfrmNabidky.qrMaster0BeforeEdit(DataSet: TDataSet);
begin
  inherited;
end;

procedure TfrmNabidky.qrMaster0BeforeInsert(DataSet: TDataSet);
begin
  inherited;
end;

procedure TfrmNabidky.qrMasterAfterApplyUpdates(Sender: TObject);
begin
  inherited;
end;

procedure TfrmNabidky.qrMasterAfterPost(DataSet: TDataSet);
begin
  inherited;
end;

procedure TfrmNabidky.qrMasterBeforeEdit(DataSet: TDataSet);
begin
  inherited;
end;

procedure TfrmNabidky.qrMasterBeforeInsert(DataSet: TDataSet);
begin
  inherited;
end;

procedure TfrmNabidky.edFindKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

end;

procedure TfrmNabidky.Button6Click(Sender: TObject);
begin
  qrPolozky.Open;
end;

procedure TfrmNabidky.qrPolozkyAfterPost(DataSet: TDataSet);
begin
  inherited;
  qrPolozky.ApplyUpdates;
end;

procedure TfrmNabidky.ToolButton10Click(Sender: TObject);
begin
  inherited;
end;

initialization
  {$I fnabidky.lrs}

end.

