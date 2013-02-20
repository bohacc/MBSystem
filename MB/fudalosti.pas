unit fudalosti;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, sqldb, db, FileUtil, LResources, Forms, Controls, Graphics,
  Dialogs, ComCtrls, StdCtrls, DbCtrls, DBGrids, ExtCtrls, Menus, ZDataset,
  ZSqlUpdate, fsablona;

type

  { TfrmUdalosti }

  TfrmUdalosti = class(TfrmSablona)
    btRefresh1: TToolButton;
    dsPolozky: TDatasource;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    DBEdit6: TDBEdit;
    DBEdit7: TDBEdit;
    DBEdit8: TDBEdit;
    DBGrid1: TDBGrid;
    DBMemo1: TDBMemo;
    edFind1: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Navigator1: TDBNavigator;
    PageControl1: TPageControl;
    Panel1: TPanel;
    qrMasterCAS_DO: TDateField;
    qrMasterCAS_OD: TDateField;
    qrMasterDATUM_DO: TDateField;
    qrMasterDATUM_OD: TDateField;
    qrMasterID: TLongintField;
    qrMasterNAZEV: TStringField;
    qrMasterPOPIS: TStringField;
    qrMasterTYP: TStringField;
    TabSheet1: TTabSheet;
    ToolBar2: TToolBar;
    ToolButton6: TToolButton;
    qrPolozky: TZQuery;
    UpdatePolozky: TZUpdateSQL;
    procedure edFindKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure qrMasterAfterApplyUpdates(Sender: TObject);
    procedure qrMasterAfterPost(DataSet: TDataSet);
    procedure qrMasterBeforeEdit(DataSet: TDataSet);
    procedure qrMasterBeforeInsert(DataSet: TDataSet);
    procedure qrPolozkyAfterApplyUpdates(Sender: TObject);
    procedure qrPolozkyAfterPost(DataSet: TDataSet);
    procedure ToolButton10Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  frmUdalosti: TfrmUdalosti;

implementation

{ TfrmUdalosti }

procedure TfrmUdalosti.qrPolozkyAfterPost(DataSet: TDataSet);
begin
  inherited;
  qrPolozky.ApplyUpdates;
end;

procedure TfrmUdalosti.ToolButton10Click(Sender: TObject);
begin
  inherited;
end;

procedure TfrmUdalosti.FormCreate(Sender: TObject);
begin
  inherited;
  qrPolozky.Open;
end;

procedure TfrmUdalosti.qrMasterAfterApplyUpdates(Sender: TObject);
begin
  inherited;
end;

procedure TfrmUdalosti.qrMasterAfterPost(DataSet: TDataSet);
begin
  inherited;
end;

procedure TfrmUdalosti.qrMasterBeforeEdit(DataSet: TDataSet);
begin
  inherited;
end;

procedure TfrmUdalosti.qrMasterBeforeInsert(DataSet: TDataSet);
begin
  inherited;
end;

procedure TfrmUdalosti.qrPolozkyAfterApplyUpdates(Sender: TObject);
begin
  qrPolozky.CommitUpdates;
end;

procedure TfrmUdalosti.edFindKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

end;


initialization
  {$I fudalosti.lrs}

end.

