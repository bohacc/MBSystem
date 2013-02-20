unit fprodukty;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, sqldb, db, FileUtil, LResources, Forms, Controls, Graphics,
  Dialogs, ComCtrls, StdCtrls, DbCtrls, DBGrids, ExtCtrls, Menus, fsablona;

type

  { TfrmProdukty }

  TfrmProdukty = class(TfrmSablona)
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    DBEdit6: TDBEdit;
    DBEdit7: TDBEdit;
    DBMemo1: TDBMemo;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    qrMasterCAROVY_KOD: TStringField;
    qrMasterKOD: TStringField;
    qrMasterNAKUPNI_CENA: TBCDField;
    qrMasterNAZEV: TStringField;
    qrMasterPOPIS: TStringField;
    qrMasterPRODEJNI_CENA: TBCDField;
    qrMasterSAZBA_DANE: TStringField;
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
  frmProdukty: TfrmProdukty;

implementation

{ TfrmProdukty }

procedure TfrmProdukty.qrMaster0AfterApplyUpdates(Sender: TObject);
begin
  inherited;
end;

procedure TfrmProdukty.qrMaster0AfterPost(DataSet: TDataSet);
begin
  inherited;
end;

procedure TfrmProdukty.qrMaster0BeforeEdit(DataSet: TDataSet);
begin
  inherited;
end;

procedure TfrmProdukty.qrMaster0BeforeInsert(DataSet: TDataSet);
begin
  inherited;
end;

initialization
  {$I fprodukty.lrs}

end.

