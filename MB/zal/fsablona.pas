unit fsablona;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  sqldb, db, Data_module, Menus, ComCtrls, ExtCtrls, StdCtrls, DbCtrls,
  ButtonPanel, DBGrids, Utils, OracleConnection;

type

  { TfrmSablona }

  TfrmSablona = class(TForm)
    btStorno: TButton;
    btOK: TButton;
    DBGrid: TDBGrid;
    Navigator: TDBNavigator;
    dsMaster: TDatasource;
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
    qrMaster: TSQLQuery;
    StatusBar1: TStatusBar;
    btRefresh: TToolButton;
    tsSeznam: TTabSheet;
    tsZaznam: TTabSheet;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    procedure btRefreshClick(Sender: TObject);
    procedure DBGridDblClick(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure DBGridTitleClick(Column: TColumn);
    procedure edFindKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure miNovyZaznamClick(Sender: TObject);
    procedure miSmazatZaznamClick(Sender: TObject);
    procedure miUpravitZaznamClick(Sender: TObject);
    procedure miVychoziDotazClick(Sender: TObject);
    procedure miZavritClick(Sender: TObject);
    procedure NavigatorBeforeAction(Sender: TObject; Button: TDBNavButtonType);
    procedure qrMasterAfterPost(DataSet: TDataSet);
    procedure qrMasterBeforeEdit(DataSet: TDataSet);
    procedure qrMasterBeforeInsert(DataSet: TDataSet);
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
FDataModule;

procedure TfrmSablona.qrMasterBeforeInsert(DataSet: TDataSet);
begin
  if Navigator.DataSource.DataSet=dsMaster.DataSet then
  begin
   pcMain.TabIndex:=0;
   //if pnMain.ActivePage=tsZaznam then edKod.SetFocus;
  end;
  //qrMaster.Database.StartTransaction;
  _savebookmark:=qrMaster.Bookmark;
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
   pcMain.TabIndex:=0;
end;

procedure TfrmSablona.FormCreate(Sender: TObject);
begin
  //qrMaster.DataBase:=DM.OracleConnection;
  sql_dotaz:=qrMaster.SQL.Text;
  //if Assigned(qrMaster) then qrMaster.Open;
  pcMain.ActivePage:=tsSeznam;
  pcMain.TabIndex:=1;
//VerticalLabel1.Caption:=Copy(TForm(Sender).Caption,11,100);
end;

procedure TfrmSablona.qrMasterBeforeEdit(DataSet: TDataSet);
begin
 if Navigator.DataSource.DataSet=dsMaster.DataSet then
 begin
  pcMain.TabIndex:=0;
  //if pnMain.ActivePage=tsZaznam then edKod.SetFocus;
 end;
 //qrMaster.Database.StartTransaction;
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
  //if FTitleClick=0 then
  pcMain.TabIndex:=0;
  FTitleClick:=0;
end;

procedure TfrmSablona.qrMasterAfterPost(DataSet: TDataSet);
begin
  //qrMaster.Database.Commit;
  //Refresh_DataSet(Navigator.DataSource.DataSet,qrMaster);
  //qrMaster.Close;
  //qrMaster.Open;
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

procedure TfrmSablona.NavigatorBeforeAction(Sender: TObject;
  Button: TDBNavButtonType);
var
  Book : TBookmarkStr;
  aID,SQL,aKOD : String;
  i,i2 : Integer;
begin
  try
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
      pcMain.TabIndex:=0;
      FTitleClick:=0;
      //Book:=qrMaster.Bookmark;
      qrMaster.DisableControls;
      qrMaster.Close;
      qrMaster.SQL.Text:=sql;
      qrMaster.ReadOnly:=false;
      qrMaster.Open;
      //qrMaster.Bookmark:=Book;
      qrMaster.EnableControls;
      qrMaster.Edit;
    end;
  except
    qrMaster.DisableControls;
    qrMaster.Close;
    qrMaster.SQL.Text:=sql_dotaz;
    qrMaster.ReadOnly:=false;
    qrMaster.Open;
    qrMaster.EnableControls;
  end;
end;

procedure TfrmSablona.najdi(s: string);
var
  sql_puv,sql_find,podminka: string;
  i: integer;
  Book : TBookmarkStr;
begin

try
  qrMaster.DisableControls;
  sql_puv:=sql_dotaz;
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
  qrMaster.EnableControls;

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
  if Key<>$F2 then
    najdi(edFind.Text);
end;

procedure TfrmSablona.DBGridTitleClick(Column: TColumn);
begin
  FTitleClick:=1;
end;

procedure TfrmSablona.miVychoziDotazClick(Sender: TObject);
begin
  try
    qrMaster.DisableControls;
    qrMaster.Close;
    qrMaster.SQL.Text:=sql_dotaz;
    qrMaster.ReadOnly:=False;
    qrMaster.Open;
    qrMaster.EnableControls;
  except
  end;
end;


initialization
  {$I fsablona.lrs}

end.

