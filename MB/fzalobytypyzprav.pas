unit FZalobyTypyZprav;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  fsablona, db, sqldb, DbCtrls, DBGrids, ComCtrls, StdCtrls, ExtCtrls, Menus,
  Grids, ZDataset, ZSqlUpdate;

type

  { TfrmZalobyTypyZprav }

  TfrmZalobyTypyZprav = class(TfrmSablona)
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    qrMaster0ID: TLongintField;
    qrMaster0NAZEV: TStringField;
    qrMaster0POPIS: TStringField;
    qrMaster0PREDMET: TStringField;
    qrMasterID: TLongintField;
    qrMasterNAZEV: TStringField;
    qrMasterPOPIS: TStringField;
    qrMasterPREDMET: TStringField;
    qrMasterTYP: TSmallintField;
    //qrMaster: TZQuery;
    //UpdateMaster: TZUpdateSQL;
    procedure btRefreshClick(Sender: TObject);
    procedure DBGridDblClick(Sender: TObject);
    procedure DBGridPrepareCanvas(sender: TObject; DataCol: Integer;
      Column: TColumn; AState: TGridDrawState);
    procedure DBGridTitleClick(Column: TColumn);
    procedure dsMasterDataChange(Sender: TObject; Field: TField);
    procedure edFindKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure miNovyZaznamClick(Sender: TObject);
    procedure miSmazatZaznamClick(Sender: TObject);
    procedure miUpravitZaznamClick(Sender: TObject);
    procedure miVychoziDotazClick(Sender: TObject);
    procedure miZavritClick(Sender: TObject);
    procedure NavigatorBeforeAction(Sender: TObject; Button: TDBNavButtonType);
    procedure NavigatorClick(Sender: TObject; Button: TDBNavButtonType);
    procedure qrMaster0AfterPost(DataSet: TDataSet);
    procedure qrMaster0BeforeEdit(DataSet: TDataSet);
    procedure qrMaster0BeforeInsert(DataSet: TDataSet);
    procedure qrMasterAfterApplyUpdates(Sender: TObject);
    procedure qrMasterAfterOpen(DataSet: TDataSet);
    procedure qrMasterAfterPost(DataSet: TDataSet);
    procedure qrMasterBeforeEdit(DataSet: TDataSet);
    procedure qrMasterBeforeInsert(DataSet: TDataSet);
    procedure qrMasterBeforePost(DataSet: TDataSet);
    procedure ToolButton10Click(Sender: TObject);
    //procedure qrMasterPREDMETGetText(Sender: TField; var aText: string;
    //  DisplayText: Boolean);
    //procedure qrMasterPREDMETSetText(Sender: TField; const aText: string);
    procedure ToolButton3Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  frmZalobyTypyZprav: TfrmZalobyTypyZprav;

implementation

{ TfrmZalobyTypyZprav }

procedure TfrmZalobyTypyZprav.btRefreshClick(Sender: TObject);
begin
  inherited;
end;

procedure TfrmZalobyTypyZprav.DBGridDblClick(Sender: TObject);
begin
  inherited;
end;

procedure TfrmZalobyTypyZprav.DBGridPrepareCanvas(sender: TObject;
  DataCol: Integer; Column: TColumn; AState: TGridDrawState);
begin
end;

procedure TfrmZalobyTypyZprav.DBGridTitleClick(Column: TColumn);
begin
  inherited;
end;

procedure TfrmZalobyTypyZprav.dsMasterDataChange(Sender: TObject; Field: TField
  );
begin
  inherited;
end;

procedure TfrmZalobyTypyZprav.edFindKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
end;

procedure TfrmZalobyTypyZprav.FormActivate(Sender: TObject);
begin
  inherited;
end;

procedure TfrmZalobyTypyZprav.FormCreate(Sender: TObject);
begin
  inherited;
end;

procedure TfrmZalobyTypyZprav.miNovyZaznamClick(Sender: TObject);
begin
  inherited;
end;

procedure TfrmZalobyTypyZprav.miSmazatZaznamClick(Sender: TObject);
begin
  inherited;
end;

procedure TfrmZalobyTypyZprav.miUpravitZaznamClick(Sender: TObject);
begin
  inherited;
end;

procedure TfrmZalobyTypyZprav.miVychoziDotazClick(Sender: TObject);
begin
  inherited;
end;

procedure TfrmZalobyTypyZprav.miZavritClick(Sender: TObject);
begin
  inherited;
end;

procedure TfrmZalobyTypyZprav.NavigatorBeforeAction(Sender: TObject;
  Button: TDBNavButtonType);
begin
  inherited;
end;

procedure TfrmZalobyTypyZprav.NavigatorClick(Sender: TObject;
  Button: TDBNavButtonType);
begin
  inherited;
end;

procedure TfrmZalobyTypyZprav.qrMaster0AfterPost(DataSet: TDataSet);
begin
  inherited;
end;

procedure TfrmZalobyTypyZprav.qrMaster0BeforeEdit(DataSet: TDataSet);
begin
  inherited;
end;

procedure TfrmZalobyTypyZprav.qrMaster0BeforeInsert(DataSet: TDataSet);
begin
  inherited;
end;

procedure TfrmZalobyTypyZprav.qrMasterAfterApplyUpdates(Sender: TObject);
begin
  inherited;
end;

procedure TfrmZalobyTypyZprav.qrMasterAfterOpen(DataSet: TDataSet);
begin
  inherited;
end;

procedure TfrmZalobyTypyZprav.qrMasterAfterPost(DataSet: TDataSet);
begin
  inherited;
end;

procedure TfrmZalobyTypyZprav.qrMasterBeforeEdit(DataSet: TDataSet);
begin
  inherited;
end;

procedure TfrmZalobyTypyZprav.qrMasterBeforeInsert(DataSet: TDataSet);
begin
  inherited;
end;

procedure TfrmZalobyTypyZprav.qrMasterBeforePost(DataSet: TDataSet);
begin
  inherited;
end;

procedure TfrmZalobyTypyZprav.ToolButton10Click(Sender: TObject);
begin
  inherited;
end;

{
procedure TfrmZalobyTypyZprav.qrMasterPREDMETGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  //aText := AnsiToUTF8(Sender.AsString);
end;
}

{
procedure TfrmZalobyTypyZprav.qrMasterPREDMETSetText(Sender: TField;
  const aText: string);
begin
  //if Sender<>nil then
  //  Sender.AsString:= UTF8ToAnsi(aText);
end;
}

procedure TfrmZalobyTypyZprav.ToolButton3Click(Sender: TObject);
begin
  inherited;
end;

initialization
  {$I fzalobytypyzprav.lrs}

end.

