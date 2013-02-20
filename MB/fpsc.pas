unit fpsc; 

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  ComCtrls, StdCtrls, DbCtrls, DBGrids, ExtCtrls, Menus, FSablona, db, sqldb;

type

  { TfrmPsc }

  TfrmPsc = class(TfrmSablona)
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    Label1: TLabel;
    Label2: TLabel;
    qrMasterKOD: TStringField;
    qrMasterOBEC: TStringField;
    procedure NavigatorClick(Sender: TObject; Button: TDBNavButtonType);
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
  frmPsc: TfrmPsc;

implementation

{ TfrmPsc }


procedure TfrmPsc.qrMaster0AfterApplyUpdates(Sender: TObject);
begin
  inherited;
end;

procedure TfrmPsc.NavigatorClick(Sender: TObject; Button: TDBNavButtonType);
begin
  inherited;
end;

procedure TfrmPsc.qrMaster0AfterPost(DataSet: TDataSet);
begin
  inherited;
end;

procedure TfrmPsc.qrMaster0BeforeEdit(DataSet: TDataSet);
begin
  inherited;
end;

procedure TfrmPsc.qrMaster0BeforeInsert(DataSet: TDataSet);
begin
  inherited;
end;

initialization
  {$I fpsc.lrs}

end.

