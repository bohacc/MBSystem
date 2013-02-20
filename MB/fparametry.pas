unit FParametry;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, sqldb, FileUtil, LResources, Forms, Controls, Graphics,
  Dialogs, StdCtrls, Buttons, DbCtrls, DBGrids, ExtCtrls, ComCtrls, ZDataset,
  ZSqlUpdate, cestina, Utils;

type

  { TfrmParametry }

  TfrmParametry = class(TForm)
    BitBtn1: TBitBtn;
    DBGrid1: TDBGrid;
    DBNavigator1: TDBNavigator;
    dsParametry: TDatasource;
    Panel1: TPanel;
    qrParametryHODNOTA: TStringField;
    qrParametryKOD: TStringField;
    qrParametryPOPIS: TStringField;
    ToolBar1: TToolBar;
    qrParametry: TZQuery;
    UpdateParametry: TZUpdateSQL;
    procedure BitBtn1Click(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure dsParametryDataChange(Sender: TObject; Field: TField);
    procedure FormCreate(Sender: TObject);
    procedure qrParametryAfterApplyUpdates(Sender: TObject);
    procedure qrParametryAfterPost(DataSet: TDataSet);
    procedure qrParametryHODNOTAGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure qrParametryHODNOTASetText(Sender: TField; const aText: string);
    procedure qrParametryPOPISGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
    procedure qrParametryPOPISSetText(Sender: TField; const aText: string);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  frmParametry: TfrmParametry;

implementation

{ TfrmParametry }

uses Data_module;

procedure TfrmParametry.qrParametryAfterPost(DataSet: TDataSet);
begin
  if qrParametry.Modified then
  begin
    qrParametry.ApplyUpdates;
  end;
end;

procedure TfrmParametry.qrParametryHODNOTAGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  aText:=Utf2Win(Sender.AsString);
end;

procedure TfrmParametry.qrParametryHODNOTASetText(Sender: TField;
  const aText: string);
begin
  if Sender<>nil then
    Sender.AsString:= Win2Utf(aText);
end;

procedure TfrmParametry.qrParametryPOPISGetText(Sender: TField;
  var aText: string; DisplayText: Boolean);
begin
  aText:=Utf2Win(Sender.AsString);
end;

procedure TfrmParametry.qrParametryPOPISSetText(Sender: TField;
  const aText: string);
begin
  if Sender<>nil then
    Sender.AsString:= Win2Utf(aText);
end;

procedure TfrmParametry.BitBtn1Click(Sender: TObject);
begin
  Close;
  //try
    //if qrParametry.Modified then
    //  qrParametry.Post;
    //if qrProcDanDiv.Modified then
    //  qrProcDanDiv.Post;
    //qrParametry.Database.Commit;
    //qrProcDanDiv.Database.Commit;
    //ExecSql('UPDATE PARAMETRY SET HODNOTA='''+edProcDiv.Text+''' WHERE KOD=''PROCENTO_DIVIDENDY''');
    //ExecSql('UPDATE PARAMETRY SET HODNOTA='''+edProcDan.Text+''' WHERE KOD=''PROCENTO_DANE_DIVIDENDY''');
  //except

  //end;
end;

procedure TfrmParametry.DBGrid1DblClick(Sender: TObject);
begin

end;

procedure TfrmParametry.dsParametryDataChange(Sender: TObject; Field: TField);
begin
  //Field.AsString:=UTF8ToAnsi(Field.Text);
end;

procedure TfrmParametry.FormCreate(Sender: TObject);
begin
  qrParametry.Open;
end;

procedure TfrmParametry.qrParametryAfterApplyUpdates(Sender: TObject);
begin
  qrParametry.CommitUpdates;
end;


initialization
  {$I fparametry.lrs}

end.

