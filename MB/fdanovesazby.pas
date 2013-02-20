unit fdanovesazby;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, sqldb, db, FileUtil, LResources, Forms, Controls, Graphics,
  Dialogs, ComCtrls, StdCtrls, DbCtrls, DBGrids, ExtCtrls, Menus, fsablona;

type

  { TfrmDanoveSazby }

  TfrmDanoveSazby = class(TfrmSablona)
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    qrMasterKOD: TStringField;
    qrMasterNAZEV: TStringField;
    qrMasterPROCENT: TLongintField;
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
  frmDanoveSazby: TfrmDanoveSazby;

implementation

{ TfrmDanoveSazby }


procedure TfrmDanoveSazby.qrMaster0AfterApplyUpdates(Sender: TObject);
begin
  inherited;
end;

procedure TfrmDanoveSazby.qrMaster0AfterPost(DataSet: TDataSet);
begin
  inherited;
end;

procedure TfrmDanoveSazby.qrMaster0BeforeEdit(DataSet: TDataSet);
begin
  inherited;
end;

procedure TfrmDanoveSazby.qrMaster0BeforeInsert(DataSet: TDataSet);
begin
  inherited;
end;

initialization
  {$I fdanovesazby.lrs}

end.

