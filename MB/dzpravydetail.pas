unit DZpravyDetail;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, sqldb, memds, FileUtil, LResources, Forms, Controls,
  Graphics, Dialogs, DbCtrls, StdCtrls, ExtCtrls, ComCtrls, Buttons, DBGrids,
  ZConnection, ZDataset, ZSqlMetadata, ZSequence, ZSqlUpdate;

type

  { TfrmZpravyDetail }

  TfrmZpravyDetail = class(TForm)
    Bevel1: TBevel;
    BitBtn1: TBitBtn;
    dsTelo: TDatasource;
    DBEdit1: TDBEdit;
    DBEdit10: TDBEdit;
    DBEdit11: TDBEdit;
    DBEdit12: TDBEdit;
    DBEdit13: TDBEdit;
    DBEdit14: TDBEdit;
    DBEdit15: TDBEdit;
    DBEdit16: TDBEdit;
    DBEdit17: TDBEdit;
    DBEdit18: TDBEdit;
    DBEdit19: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit20: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    DBEdit6: TDBEdit;
    DBEdit7: TDBEdit;
    DBEdit8: TDBEdit;
    DBEdit9: TDBEdit;
    DBMemo1: TDBMemo;
    DBNavigator1: TDBNavigator;
    dsDetail: TDatasource;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label2: TLabel;
    Label20: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    qrTeloID: TLongintField;
    qrTeloTELO: TMemoField;
    ToolBar1: TToolBar;
    qrTelo: TZQuery;
    procedure BitBtn1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure DBNavigator2Click(Sender: TObject; Button: TDBNavButtonType);
    procedure dsDetailDataChange(Sender: TObject; Field: TField);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure qrTeloAfterApplyUpdates(Sender: TObject);
    procedure qrTeloAfterPost(DataSet: TDataSet);
    procedure UpdateTeloAfterModifySQLStatement(const Sender: TObject;
      StatementIndex: Integer);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  frmZpravyDetail: TfrmZpravyDetail;

implementation

{ TfrmZpravyDetail }
uses Data_module,FZaloby;

procedure TfrmZpravyDetail.Button1Click(Sender: TObject);
begin

end;

procedure TfrmZpravyDetail.BitBtn1Click(Sender: TObject);
begin
  //if qrTelo.Modified then qrTelo.Post;
end;

procedure TfrmZpravyDetail.DBNavigator2Click(Sender: TObject;
  Button: TDBNavButtonType);
begin

end;

procedure TfrmZpravyDetail.dsDetailDataChange(Sender: TObject; Field: TField);
begin
  qrTelo.Close;
  if Assigned(dsDetail.DataSet) then
  begin
    qrTelo.ParamByName('ID').AsInteger:=dsDetail.DataSet.FieldByName('ID').AsInteger;  //frmZaloby.qrZpravy.FieldByName('ID').AsInteger;
    qrTelo.Open;
  end;
end;

procedure TfrmZpravyDetail.FormCreate(Sender: TObject);
begin

end;

procedure TfrmZpravyDetail.FormShow(Sender: TObject);
begin
  if Assigned(dsDetail.DataSet) then
  begin
    qrTelo.ParamByName('ID').AsInteger:=dsDetail.DataSet.FieldByName('ID').AsInteger;  //frmZaloby.qrZpravy.FieldByName('ID').AsInteger;
    qrTelo.Open;
  end;
end;

procedure TfrmZpravyDetail.qrTeloAfterApplyUpdates(Sender: TObject);
begin
  qrTelo.CommitUpdates;
end;

procedure TfrmZpravyDetail.qrTeloAfterPost(DataSet: TDataSet);
begin
  qrTelo.ApplyUpdates;
end;

procedure TfrmZpravyDetail.UpdateTeloAfterModifySQLStatement(
  const Sender: TObject; StatementIndex: Integer);
begin
  //qrTelo.ApplyUpdates;
end;


initialization
  {$I dzpravydetail.lrs}

end.

