unit FNastDiv; 

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, sqldb, FileUtil, LResources, Forms, Controls, Graphics,
  Dialogs, StdCtrls, Buttons, DbCtrls;

type

  { TfrmNastDiv }

  TfrmNastDiv = class(TForm)
    BitBtn1: TBitBtn;
    dsProcDanDiv: TDatasource;
    dsProcDiv: TDatasource;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    Label1: TLabel;
    Label2: TLabel;
    qrProcDiv: TSQLQuery;
    qrProcDanDiv: TSQLQuery;
    procedure BitBtn1Click(Sender: TObject);
    procedure qrProcDanDivAfterPost(DataSet: TDataSet);
    procedure qrProcDivAfterPost(DataSet: TDataSet);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  frmNastDiv: TfrmNastDiv;

implementation

{ TfrmNastDiv }

procedure TfrmNastDiv.qrProcDivAfterPost(DataSet: TDataSet);
begin
  qrProcDiv.ApplyUpdates;
end;

procedure TfrmNastDiv.BitBtn1Click(Sender: TObject);
begin
  try
    if qrProcDiv.Modified then
      qrProcDiv.Post;
    if qrProcDanDiv.Modified then
      qrProcDanDiv.Post;
    //qrProcDiv.Database.Commit;
    //qrProcDanDiv.Database.Commit;
    //ExecSql('UPDATE PARAMETRY SET HODNOTA='''+edProcDiv.Text+''' WHERE KOD=''PROCENTO_DIVIDENDY''');
    //ExecSql('UPDATE PARAMETRY SET HODNOTA='''+edProcDan.Text+''' WHERE KOD=''PROCENTO_DANE_DIVIDENDY''');
  except

  end;
end;

procedure TfrmNastDiv.qrProcDanDivAfterPost(DataSet: TDataSet);
begin
  qrProcDanDiv.ApplyUpdates;
end;

initialization
  {$I fnastdiv.lrs}

end.

