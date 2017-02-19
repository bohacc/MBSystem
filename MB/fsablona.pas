unit fsablona;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  sqldb, db, Data_module, Menus, ComCtrls, ExtCtrls, StdCtrls, DbCtrls,
  ButtonPanel, DBGrids, ZDataset, ZSqlUpdate, ZGroupedConnection, Utils,
  OracleConnection, Types;

type

  { TfrmSablona }

  TfrmSablona = class(TForm)
    btStorno: TButton;
    btOK: TButton;
    dsMaster: TDatasource;
    DBGrid: TDBGrid;
    miZrusOznaceni: TMenuItem;
    Navigator: TDBNavigator;
    edFind: TEdit;
    MainMenu: TMainMenu;
    miOkno: TMenuItem;
    miVychoziDotaz: TMenuItem;
    miSmazatZaznam: TMenuItem;
    miUpravitZaznam: TMenuItem;
    miNovyZaznam: TMenuItem;
    miSoubor: TMenuItem;
    miUpravy: TMenuItem;
    miZavrit: TMenuItem;
    pcMain: TPageControl;
    pOK: TPanel;
    StatusBar1: TStatusBar;
    btRefresh: TToolButton;
    ToolButton10: TToolButton;
    ToolButton5: TToolButton;
    tsSeznam: TTabSheet;
    tsZaznam: TTabSheet;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    qrMaster: TZQuery;
    UpdateMaster: TZUpdateSQL;
    procedure btRefreshClick(Sender: TObject);
    procedure DBGridDblClick(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure DBGridTitleClick(Column: TColumn);
    procedure dsMasterDataChange(Sender: TObject; Field: TField);
    procedure edFindKeyPress(Sender: TObject; var Key: char);
    procedure edFindKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure miNovyZaznamClick(Sender: TObject);
    procedure miSmazatZaznamClick(Sender: TObject);
    procedure miUpravitZaznamClick(Sender: TObject);
    procedure miVychoziDotazClick(Sender: TObject);
    procedure miZavritClick(Sender: TObject);
    procedure miZrusOznaceniClick(Sender: TObject);
    procedure NavigatorBeforeAction(Sender: TObject; Button: TDBNavButtonType);
    procedure NavigatorClick(Sender: TObject; Button: TDBNavButtonType);
    procedure qrMasterAfterApplyUpdates(Sender: TObject);
    procedure qrMasterAfterOpen(DataSet: TDataSet);
    procedure qrMasterAfterPost(DataSet: TDataSet);
    procedure qrMasterBeforeEdit(DataSet: TDataSet);
    procedure qrMasterBeforeInsert(DataSet: TDataSet);
    procedure qrMasterBeforePost(DataSet: TDataSet);
    procedure qrMasterNewRecord(DataSet: TDataSet);
    procedure ToolButton10Click(Sender: TObject);
    procedure tsZaznamContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
    procedure ZGroupedConnection1AfterConnect(Sender: TObject);
  private
    sql_dotaz: string;
    FTitleClick : integer;
    procedure FillForms (Sender : TObject);
    procedure Menu_Show_Form_OnClick(Sender : TObject);
    procedure najdi(s: string);
  public
    { public declarations }
  end; 

var
  frmSablona: TfrmSablona;

implementation

uses
  FDataModule, DProcesQuery;

procedure TfrmSablona.qrMasterBeforeInsert(DataSet: TDataSet);
begin
  if Navigator.DataSource.DataSet=dsMaster.DataSet then
  begin
   pcMain.TabIndex:=1;
  end;
  //qrMaster.Database.StartTransaction;
  //_savebookmark:=qrMaster.Bookmark;
end;

procedure TfrmSablona.qrMasterBeforePost(DataSet: TDataSet);
begin
  //if not Assigned(frmProcesQuery) then
  //  Application.CreateForm(TfrmProcesQuery,frmProcesQuery);
  //frmProcesQuery.ShowOnTop;
end;

procedure TfrmSablona.qrMasterNewRecord(DataSet: TDataSet);
begin

end;

procedure TfrmSablona.ToolButton10Click(Sender: TObject);
begin
  najdi(edFind.Text);
end;

procedure TfrmSablona.tsZaznamContextPopup(Sender: TObject; MousePos: TPoint;
  var Handled: Boolean);
begin

end;

procedure TfrmSablona.ZGroupedConnection1AfterConnect(Sender: TObject);
begin

end;

procedure TfrmSablona.btRefreshClick(Sender: TObject);
begin
  Refresh_DataSet(Navigator.DataSource.DataSet,qrMaster);
end;

procedure TfrmSablona.DBGrid1DblClick(Sender: TObject);
begin
 if pOK.Visible then
   btOK.Click
 else
   pcMain.TabIndex:=1;
end;

procedure TfrmSablona.FormCreate(Sender: TObject);
begin
  sql_dotaz:=qrMaster.SQL.Text;
  if Assigned(qrMaster) then qrMaster.Open;
  pcMain.ActivePage:=tsSeznam;
  pcMain.TabIndex:=0;
//VerticalLabel1.Caption:=Copy(TForm(Sender).Caption,11,100);
end;

procedure TfrmSablona.qrMasterBeforeEdit(DataSet: TDataSet);
begin
  if Navigator.DataSource.DataSet=dsMaster.DataSet then
  begin
    pcMain.TabIndex:=1;
  end;
end;

procedure TfrmSablona.FormActivate(Sender: TObject);
begin
  FillForms(Sender);
end;
{
procedure TfrmSablona.miZmenBarvuTextuClick(Sender: TObject);
begin
if ColorDialog.Execute then
  VerticalLabel1.Font.Color:=ColorDialog.Color;
end;

procedure TfrmSablona.miZmenBarvuPozClick(Sender: TObject);
begin
if ColorDialog.Execute then
  VerticalLabel1.Color:=ColorDialog.Color;
end;
}

procedure TfrmSablona.Menu_Show_Form_OnClick(Sender : TObject);
begin
 try
   TForm(Application.FindComponent(TMenuItem(Sender).Name)).Show;
 finally
 end;
end;

procedure TfrmSablona.FillForms (Sender : TObject);
var
i : integer;
_MenuItem : TMenuItem;
_MenuItemOkno : TMenuItem;
begin
_MenuItem:=nil;
_MenuItemOkno:=nil;

 try
  if Assigned(MainMenu.Items.Find('Okno')) then
   begin
       MainMenu.Items.Find('Okno').Clear;
       if Assigned(_MenuItem) then
       begin
        _MenuItem.Free;
        _MenuItem:=nil;
       end;
   end
  else
   begin
     i:=0;
     with frmSablona do
     begin
       for i :=0 to ComponentCount-1 do
       begin
         if (Components[i].Name='miOkno') then
              Components[i].Free;
       end;
     end;
     _MenuItemOkno:=TMenuItem.Create(self);
     _MenuItemOkno.Name:='miOkno';
     _MenuItemOkno.Caption:='Okno';
     MainMenu.Items.Add(_MenuItemOkno);
   end;

  for i := 0 to Screen.FormCount-1 do
  begin
   if (Screen.Forms[i].Visible) and (not Screen.Forms[i].Active) then
   begin
     _MenuItem:=TMenuItem.Create(self);
     _MenuItem.Name:=Screen.Forms[i].Name;
     _MenuItem.Caption:=Screen.Forms[i].Caption;
     //_MenuItem.OnClick:=Menu_Show_Form_OnClick;
     MainMenu.Items.Find('Okno').Add(_MenuItem);
   end;
  end;

  try
   if MainMenu.Items.Find('Okno').Count = 0 then
   begin
    MainMenu.Items.Delete(MainMenu.Items.IndexOf(MainMenu.Items.Find('Okno')));
    MainMenu.Items.Find('Okno').Free;
    if Assigned(_MenuItem) then
    begin
     _MenuItem.Free;
     _MenuItem:=nil;
    end;
    if Assigned(_MenuItemOkno) then
    begin
     _MenuItemOkno.Free;
     _MenuItemOkno:=nil;
    end;
   end;

  except
  end;

 finally
 end;

end;

procedure TfrmSablona.DBGridDblClick(Sender: TObject);
begin
  if FTitleClick=0 then
    pcMain.TabIndex:=1;
  FTitleClick:=0;
end;

procedure TfrmSablona.miNovyZaznamClick(Sender: TObject);
begin
  qrMaster.Insert;
end;

procedure TfrmSablona.miSmazatZaznamClick(Sender: TObject);
begin
  qrMaster.Delete;
end;

procedure TfrmSablona.miUpravitZaznamClick(Sender: TObject);
begin
  qrMaster.Edit;
end;

procedure TfrmSablona.miZavritClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmSablona.miZrusOznaceniClick(Sender: TObject);
begin
  DBGrid.SelectedRows.Clear;
end;

procedure TfrmSablona.NavigatorBeforeAction(Sender: TObject;
  Button: TDBNavButtonType);
var
  Book : TBookmarkStr;
  aID,SQL,aKOD : String;
  i,i2 : Integer;
begin
  {try
    if Button=nbEdit then
    begin
      i:=qrMaster.FieldDefs.IndexOf('ID');
      i2:=qrMaster.FieldDefs.IndexOf('KOD');
      if i=0 then
      begin
        aID:=qrMaster.FieldByName('ID').AsString;
        SQL:=sql_dotaz+' WHERE ID='+aID;
      end;
      if i2=0 then
      begin
        aKOD:=qrMaster.FieldByName('KOD').AsString;
        SQL:=sql_dotaz+' WHERE KOD='''+aKOD+'''';
      end;
      pcMain.TabIndex:=1;
      FTitleClick:=0;
      //Book:=qrMaster.Bookmark;
      qrMaster.DisableControls;
      qrMaster.Close;
      qrMaster.SQL.Text:=sql;
      qrMaster.ReadOnly:=false;
      qrMaster.Open;
      //qrMaster.Bookmark:=Book;
      qrMaster.EnableControls;
      //qrMaster.Edit;
    end;
  except
    //qrMaster.DisableControls;
    qrMaster.Close;
    qrMaster.SQL.Text:=sql_dotaz;
    qrMaster.ReadOnly:=false;
    qrMaster.Open;
    //qrMaster.EnableControls;
  end; }
end;

procedure TfrmSablona.NavigatorClick(Sender: TObject; Button: TDBNavButtonType);
begin

end;

procedure TfrmSablona.qrMasterAfterApplyUpdates(Sender: TObject);
begin
  qrMaster.CommitUpdates;
end;

procedure TfrmSablona.qrMasterAfterOpen(DataSet: TDataSet);
begin
  //if Assigned(frmProcesQuery) then
  //  frmProcesQuery.Close;
end;

procedure TfrmSablona.qrMasterAfterPost(DataSet: TDataSet);
begin
  qrMaster.ApplyUpdates;
end;

procedure TfrmSablona.najdi(s: string);
var
  sql_puv,sql_find,podminka: string;
  i: integer;
  //Book : TBookmarkStr;
begin

try
  //qrMaster.DisableControls;
  sql_puv:=sql_dotaz;
  qrMaster.Close;
  qrMaster.ParamCheck:=false;
  qrMaster.ParamCheck:=true;
  for i:=0 to qrMaster.Params.Count-1 do
  begin
    if copy(qrMaster.Params.Items[i].Name,1,7)='HLEDAT_' then
    begin
       qrMaster.Params.Items[i].DataType := ftMemo;
       //qrMaster.Params.Items[i].ParamType := ptinput;
       qrMaster.Params.Items[i].AsString := s;
    end;
  end;
  qrMaster.ParamByName('UZAMCENA').DataType := ftSmallInt;
  qrMaster.ParamByName('DATUM_IMPORTU').DataType := ftDate;
  qrMaster.Open;
  {
  qrMaster.Open;
  for i:=0 to qrMaster.FieldCount-1 do
  begin
    if i=0 then
      podminka:='UPPER('+qrMaster.Fields[i].FieldName+') LIKE ''%''||UPPER('''+s+''')||''%'''
    else
      podminka:=podminka+' OR UPPER('+qrMaster.Fields[i].FieldName+') LIKE ''%''||UPPER('''+s+''')||''%''';
  end;
  sql_find:='SELECT * FROM ('+sql_puv+') WHERE '+podminka;
  qrMaster.Close;
  if s='' then
  begin
    qrMaster.ReadOnly:=False;
    qrMaster.SQL.Text:=sql_puv;
  end
  else
  begin
    qrMaster.ReadOnly:=True;
    qrMaster.SQL.Text:=sql_find;
  end;
  qrMaster.Open;
  }
  //qrMaster.EnableControls;

  {Book:=qrMaster.Bookmark;
  qrMaster.DisableControls;
  qrMaster.Close;
  qrMaster.SQL.Text:=sql_dotaz;
  qrMaster.RequestLive:=true;
  qrMaster.Open;
  qrMaster.EnableControls;}

except
  qrMaster.Close;
  qrMaster.ReadOnly:=False;
  qrMaster.SQL.Text:=sql_puv;
  qrMaster.Open;
end;

end;

procedure TfrmSablona.edFindKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
{  if Key=#13 then
    najdi(edFind.Text);}
end;

procedure TfrmSablona.DBGridTitleClick(Column: TColumn);
begin
  FTitleClick:=1;
end;

procedure TfrmSablona.dsMasterDataChange(Sender: TObject; Field: TField);
begin
  //Field.AsString:=AnstiToUTF8(Field.AsSring);
end;

procedure TfrmSablona.edFindKeyPress(Sender: TObject; var Key: char);
begin
  if Key=#13 then
    najdi(edFind.Text);
end;

procedure TfrmSablona.miVychoziDotazClick(Sender: TObject);
begin
  try
    //qrMaster.DisableControls;
    qrMaster.Close;
    //qrMaster.SQL.Text:=sql_dotaz;
    //qrMaster.ReadOnly:=False;
    qrMaster.Open;
    //qrMaster.EnableControls;
  except
  end;
end;


initialization
  {$I fsablona.lrs}

end.

