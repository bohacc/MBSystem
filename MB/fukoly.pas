unit fukoly;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, sqldb, db, FileUtil, LResources, Forms, Controls, Graphics,
  Dialogs, ComCtrls, StdCtrls, DbCtrls, DBGrids, ExtCtrls, Menus, ZDataset,
  ZSqlUpdate, fsablona;

type

  { TfrmUkoly }

  TfrmUkoly = class(TfrmSablona)
    btRefresh1: TToolButton;
    dsPolozky: TDatasource;
    DBCalendar1: TDBCalendar;
    DBCheckBox1: TDBCheckBox;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    DBGrid1: TDBGrid;
    DBMemo1: TDBMemo;
    edFind1: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Navigator1: TDBNavigator;
    PageControl1: TPageControl;
    Panel1: TPanel;
    qrMasterCAS: TDateField;
    qrMasterDATUM: TDateField;
    qrMasterID: TLongintField;
    qrMasterNAZEV: TStringField;
    qrMasterPOPIS: TStringField;
    qrMasterSPLNENO: TLongintField;
    qrMasterTYP: TStringField;
    qrPolozky: TSQLQuery;
    qrPolozkyCISLO: TLongintField;
    qrPolozkyID_ADRESY: TLongintField;
    qrPolozkyID_OSOBY: TLongintField;
    qrPolozkyID_PARTNERA: TLongintField;
    qrPolozkyID_SPOJENI: TLongintField;
    qrPolozkyID_UKOL: TLongintField;
    TabSheet1: TTabSheet;
    ToolBar2: TToolBar;
    ToolButton6: TToolButton;
    qrPolozky0: TZQuery;
    UpdatePolozky: TZUpdateSQL;
    procedure edFindKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure qrMaster0AfterApplyUpdates(Sender: TObject);
    procedure qrMaster0AfterPost(DataSet: TDataSet);
    procedure qrMaster0BeforeEdit(DataSet: TDataSet);
    procedure qrMaster0BeforeInsert(DataSet: TDataSet);
    procedure qrMasterAfterApplyUpdates(Sender: TObject);
    procedure qrMasterAfterPost(DataSet: TDataSet);
    procedure qrMasterBeforeEdit(DataSet: TDataSet);
    procedure qrMasterBeforeInsert(DataSet: TDataSet);
    procedure qrPolozky0AfterApplyUpdates(Sender: TObject);
    procedure qrPolozky0AfterPost(DataSet: TDataSet);
    procedure qrPolozkyAfterPost(DataSet: TDataSet);
    procedure ToolButton10Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  frmUkoly: TfrmUkoly;

implementation

{ TfrmUkoly }

procedure TfrmUkoly.qrPolozkyAfterPost(DataSet: TDataSet);
begin
  inherited;
  qrPolozky.ApplyUpdates;
end;

procedure TfrmUkoly.ToolButton10Click(Sender: TObject);
begin
  inherited;
end;

procedure TfrmUkoly.FormCreate(Sender: TObject);
begin
  inherited;
  qrPolozky.Open;
end;

procedure TfrmUkoly.qrMaster0AfterApplyUpdates(Sender: TObject);
begin
  inherited;
end;

procedure TfrmUkoly.qrMaster0AfterPost(DataSet: TDataSet);
begin
  inherited;
end;

procedure TfrmUkoly.qrMaster0BeforeEdit(DataSet: TDataSet);
begin
  inherited;
end;

procedure TfrmUkoly.qrMaster0BeforeInsert(DataSet: TDataSet);
begin
  inherited;
end;

procedure TfrmUkoly.qrMasterAfterApplyUpdates(Sender: TObject);
begin
  inherited;
end;

procedure TfrmUkoly.qrMasterAfterPost(DataSet: TDataSet);
begin
  inherited;
end;

procedure TfrmUkoly.qrMasterBeforeEdit(DataSet: TDataSet);
begin
  inherited;
end;

procedure TfrmUkoly.qrMasterBeforeInsert(DataSet: TDataSet);
begin
  inherited;
end;

procedure TfrmUkoly.qrPolozky0AfterApplyUpdates(Sender: TObject);
begin
  qrPolozky0.CommitUpdates;
end;

procedure TfrmUkoly.qrPolozky0AfterPost(DataSet: TDataSet);
begin
  qrPolozky0.ApplyUpdates;
end;

procedure TfrmUkoly.edFindKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

end;

initialization
  {$I fukoly.lrs}

end.

