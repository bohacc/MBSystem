unit ftypy_akcii; 

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  ComCtrls, StdCtrls, DbCtrls, DBGrids, ExtCtrls, Menus, ZDataset, ZSqlUpdate,
  FSablona, db, sqldb;

type

  { TfrmTypyAkcii }

  TfrmTypyAkcii = class(TfrmSablona)
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBMemo1: TDBMemo;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    qrMasterHODNOTA: TFloatField;
    qrMasterKROK: TSmallIntField;
    qrMasterPOZNAMKA: TStringField;
    qrMasterTYP: TStringField;
    procedure qrMasterAfterApplyUpdates(Sender: TObject);
    procedure qrMasterAfterOpen(DataSet: TDataSet);
    procedure qrMasterAfterPost(DataSet: TDataSet);
    procedure qrMasterBeforeEdit(DataSet: TDataSet);
    procedure qrMasterBeforeInsert(DataSet: TDataSet);
    procedure qrMasterBeforePost(DataSet: TDataSet);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  frmTypyAkcii: TfrmTypyAkcii;

implementation

{ TfrmTypyAkcii }


procedure TfrmTypyAkcii.qrMasterAfterApplyUpdates(Sender: TObject);
begin
  inherited;
end;

procedure TfrmTypyAkcii.qrMasterAfterOpen(DataSet: TDataSet);
begin

end;

procedure TfrmTypyAkcii.qrMasterAfterPost(DataSet: TDataSet);
begin
  inherited;
end;

procedure TfrmTypyAkcii.qrMasterBeforeEdit(DataSet: TDataSet);
begin
  inherited;
end;

procedure TfrmTypyAkcii.qrMasterBeforeInsert(DataSet: TDataSet);
begin
  inherited;
end;

procedure TfrmTypyAkcii.qrMasterBeforePost(DataSet: TDataSet);
begin

end;

initialization
  {$I ftypy_akcii.lrs}

end.

