unit fakcie;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  ComCtrls, StdCtrls, DbCtrls, DBGrids, ExtCtrls, Menus, ZDataset, ZSqlUpdate,
  fsablona, db, sqldb;

type

  { TfrmAkcie }

  TfrmAkcie = class(TfrmSablona)
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    DBEdit6: TDBEdit;
    DBEdit7: TDBEdit;
    DBMemo1: TDBMemo;
    DBMemo2: TDBMemo;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    qrMasterCISLO: TLongintField;
    qrMasterCISLO_AKCIE: TLargeIntField;
    qrMasterDATUM: TDateField;
    qrMasterHODNOTA: TFloatField;
    qrMasterID: TLongintField;
    qrMasterPOZNAMKA: TMemoField;
    qrMasterSERIE: TStringField;
    qrMasterTEXT: TBlobField;
    qrMasterTYP: TStringField;
    procedure qrMasterAfterApplyUpdates(Sender: TObject);
    procedure qrMasterAfterPost(DataSet: TDataSet);
    procedure qrMasterBeforeEdit(DataSet: TDataSet);
    procedure qrMasterBeforeInsert(DataSet: TDataSet);
    procedure qrMasterNewRecord(DataSet: TDataSet);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  frmAkcie: TfrmAkcie;

implementation

{ TfrmAkcie }


procedure TfrmAkcie.qrMasterAfterApplyUpdates(Sender: TObject);
begin
  inherited;
end;

procedure TfrmAkcie.qrMasterAfterPost(DataSet: TDataSet);
begin
  inherited;
end;

procedure TfrmAkcie.qrMasterBeforeEdit(DataSet: TDataSet);
begin
  inherited;
end;

procedure TfrmAkcie.qrMasterBeforeInsert(DataSet: TDataSet);
begin
  inherited;
end;

procedure TfrmAkcie.qrMasterNewRecord(DataSet: TDataSet);
begin
  inherited;
end;

initialization
  {$I fakcie.lrs}

end.

