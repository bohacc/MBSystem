unit FChybneObjekty;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, LResources, Forms, Controls, Graphics,
  Dialogs, ComCtrls, DBGrids, DbCtrls, StdCtrls, ZDataset, Utils;

type

  { TfrmChybneObjekty }

  TfrmChybneObjekty = class(TForm)
    Button1: TButton;
    Navigator: TDBNavigator;
    dsMaster: TDatasource;
    DBGrid1: TDBGrid;
    qrMasterCREATED: TDateField;
    qrMasterDATA_OBJECT_ID: TLargeintField;
    qrMasterGENERATED: TStringField;
    qrMasterLAST_DDL_TIME: TDateField;
    qrMasterOBJECT_ID: TLargeintField;
    qrMasterOBJECT_NAME: TStringField;
    qrMasterOBJECT_TYPE: TStringField;
    qrMasterSECONDARY: TStringField;
    qrMasterSTATUS: TStringField;
    qrMasterSUBOBJECT_NAME: TStringField;
    qrMasterTEMPORARY: TStringField;
    qrMasterTIMESTAMP: TStringField;
    StatusBar1: TStatusBar;
    ToolBar1: TToolBar;
    qrMaster: TZQuery;
    tbRefresh: TToolButton;
    ToolButton2: TToolButton;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure tbRefreshClick(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  frmChybneObjekty: TfrmChybneObjekty;

implementation

{ TfrmChybneObjekty }

uses Data_module;

procedure TfrmChybneObjekty.tbRefreshClick(Sender: TObject);
begin
  Refresh_DataSet(Navigator.DataSource.DataSet,qrMaster);
end;

procedure TfrmChybneObjekty.FormCreate(Sender: TObject);
begin
  qrMaster.Open;
end;

procedure TfrmChybneObjekty.Button1Click(Sender: TObject);
begin
  ExecSQL('exec dbms_utility.compile_schema('''+DM.OracleConnection.User+''')');
end;

initialization
  {$I fchybneobjekty.lrs}

end.

