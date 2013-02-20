unit fpartneriadresy;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, sqldb, db, FileUtil, LResources, Forms, Controls, Graphics,
  Dialogs, ComCtrls, StdCtrls, DbCtrls, DBGrids, ExtCtrls, Menus, fsablona;

type

  { TfrmPartneriAdresy }

  TfrmPartneriAdresy = class(TfrmSablona)
    Button1: TButton;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit5: TDBEdit;
    DBEdit6: TDBEdit;
    DBEdit7: TDBEdit;
    DBEdit8: TDBEdit;
    DBMemo1: TDBMemo;
    Edit1: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    qrMasterID: TLongintField;
    qrMasterID_PARTNERA: TLongintField;
    qrMasterMESTO: TStringField;
    qrMasterNAZEV: TStringField;
    qrMasterPOPIS: TStringField;
    qrMasterPSC: TStringField;
    qrMasterSTAT: TStringField;
    qrMasterULICE: TStringField;
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
  frmPartneriAdresy: TfrmPartneriAdresy;

implementation

{ TfrmPartneriAdresy }


procedure TfrmPartneriAdresy.qrMaster0AfterApplyUpdates(Sender: TObject);
begin
  inherited;
end;

procedure TfrmPartneriAdresy.qrMaster0AfterPost(DataSet: TDataSet);
begin
  inherited;
end;

procedure TfrmPartneriAdresy.qrMaster0BeforeEdit(DataSet: TDataSet);
begin
  inherited;
end;

procedure TfrmPartneriAdresy.qrMaster0BeforeInsert(DataSet: TDataSet);
begin
  inherited;
end;

initialization
  {$I fpartneriadresy.lrs}

end.

