unit fprilohy;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, sqldb, db, FileUtil, LResources, Forms, Controls, Graphics,
  Dialogs, ComCtrls, StdCtrls, DbCtrls, DBGrids, ExtCtrls, Menus, fsablona;

type

  { TfrmPrilohy }

  TfrmPrilohy = class(TfrmSablona)
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBMemo1: TDBMemo;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    qrMasterID: TLongintField;
    qrMasterNAZEV: TStringField;
    qrMasterPOPIS: TStringField;
    procedure qrMaster0AfterApplyUpdates(Sender: TObject);
    procedure qrMaster0AfterPost(DataSet: TDataSet);
    procedure qrMaster0BeforeEdit(DataSet: TDataSet);
    procedure qrMaster0BeforeInsert(DataSet: TDataSet);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  frmPrilohy: TfrmPrilohy;

implementation

{ TfrmPrilohy }


procedure TfrmPrilohy.qrMaster0AfterApplyUpdates(Sender: TObject);
begin
  inherited;
end;

procedure TfrmPrilohy.qrMaster0AfterPost(DataSet: TDataSet);
begin
  inherited;
end;

procedure TfrmPrilohy.qrMaster0BeforeEdit(DataSet: TDataSet);
begin
  inherited;
end;

procedure TfrmPrilohy.qrMaster0BeforeInsert(DataSet: TDataSet);
begin
  inherited;
end;

initialization
  {$I fprilohy.lrs}

end.

