unit fpartnerispojeni;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, sqldb, db, FileUtil, LResources, Forms, Controls, Graphics,
  Dialogs, ComCtrls, StdCtrls, DbCtrls, DBGrids, ExtCtrls, Menus, fsablona;

type

  { TfrmPartneriSpojeni }

  TfrmPartneriSpojeni = class(TfrmSablona)
    Button1: TButton;
    DBComboBox1: TDBComboBox;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit4: TDBEdit;
    Edit1: TEdit;
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    qrMasterHODNOTA: TStringField;
    qrMasterID: TLongintField;
    qrMasterID_PARTNERA: TLongintField;
    qrMasterTYP: TStringField;
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
  frmPartneriSpojeni: TfrmPartneriSpojeni;

implementation

{ TfrmPartneriSpojeni }

procedure TfrmPartneriSpojeni.qrMaster0AfterApplyUpdates(Sender: TObject);
begin
  inherited;
end;

procedure TfrmPartneriSpojeni.qrMaster0AfterPost(DataSet: TDataSet);
begin
  inherited;
end;

procedure TfrmPartneriSpojeni.qrMaster0BeforeEdit(DataSet: TDataSet);
begin
  inherited;
end;

procedure TfrmPartneriSpojeni.qrMaster0BeforeInsert(DataSet: TDataSet);
begin
  inherited;
end;

initialization
  {$I fpartnerispojeni.lrs}

end.

