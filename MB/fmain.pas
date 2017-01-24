unit FMain;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  StdCtrls, uConstsMenu, Utils, Menus, sqldb, uConsts, ExtCtrls, ComCtrls,
  ShellCtrls, DbCtrls, Windows, DB, OracleConnection;

type

  { TfrmMain }

  TfrmMain = class(TForm)
    DBCalendar1: TDBCalendar;
    ImageList: TImageList;
    Label1: TLabel;
    Label2: TLabel;
    lbUzivatel: TLabel;
    lbVerze: TLabel;
    MainMenu: TMainMenu;
    MenuItem1: TMenuItem;
    miImportTxt: TMenuItem;
    miZalohaTxt: TMenuItem;
    miZiskatDataZeZprav: TMenuItem;
    miServis: TMenuItem;
    miNenalezene: TMenuItem;
    miSestavy: TMenuItem;
    miZalobyMlcoch: TMenuItem;
    miChybneObjekty: TMenuItem;
    miPrelozit: TMenuItem;
    miOProgramu: TMenuItem;
    miZalohaDat: TMenuItem;
    miZalobyOstatni: TMenuItem;
    miZaloby: TMenuItem;
    miPrilohy: TMenuItem;
    miPartnerispojeni: TMenuItem;
    miPartneriAdresy: TMenuItem;
    miPartneriosoby: TMenuItem;
    miDanovesazby: TMenuItem;
    miProdukty: TMenuItem;
    miUdalosti: TMenuItem;
    miUkoly: TMenuItem;
    miPartneri: TMenuItem;
    miNabidky: TMenuItem;
    miPsc: TMenuItem;
    miTypyAkcii: TMenuItem;
    miAkcionari: TMenuItem;
    miAkcie: TMenuItem;
    miParametry: TMenuItem;
    miClose: TMenuItem;
    miAgendy1: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    miLicence: TMenuItem;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    SaveDialog: TSaveDialog;
    StatusBar1: TStatusBar;
    Timer: TTimer;
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure miAgendy1Click(Sender: TObject);
    procedure miChybneObjektyClick(Sender: TObject);
    procedure miCloseClick(Sender: TObject);
    procedure miImportTxtClick(Sender: TObject);
    procedure miLicenceClick(Sender: TObject);
    procedure miMainMenuClick(Sender : TObject);
    procedure FormCreate(Sender: TObject);
    procedure ListViewDblClick(Sender: TObject);
    procedure ListViewDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure ListViewDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure ListViewStartDrag(Sender: TObject; var DragObject: TDragObject);
    procedure miNenalezeneClick(Sender: TObject);
    procedure miOProgramuClick(Sender: TObject);
    procedure miParametryClick(Sender: TObject);
    procedure miPrelozitClick(Sender: TObject);
    procedure miZalohaDatClick(Sender: TObject);
    procedure miZalohaTxtClick(Sender: TObject);
    procedure miZiskatDataZeZpravClick(Sender: TObject);
    procedure PopupClick(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
  private
    FDragStartPoint : TPoint;
    procedure create_menu;
    procedure load_icon;
    function InitIcon(_Name : String ; _Index : Integer ; _Image : Integer):boolean;
    procedure start_application;
    procedure nastav_status;
    procedure Create_Popup;
    //procedure FillForms (Sender : TObject);
    //procedure Menu_Show_Form_OnClick(Sender : TObject);
  public
    platna_licence : Boolean;
  end; 

var
  frmMain: TfrmMain;

implementation

uses FAkcionari,FTypy_akcii,fAkcie,FPsc,FFirma,Data_Module,
     FPartneri,FPartneriOsoby,FPartneriAdresy,FPartneriSpojeni,FUkoly,
     FUdalosti,FPrilohy,FDanovesazby,FProdukty,FNabidky,FZaloby,FParametry,
     FZaloby_ostatni,{DProcesQuery,}{DProces,}Dprogram,FChybneObjekty,
     FZalobyMlcoch,snesparovane_zpravy, ZDataset;

{ TfrmMain }

procedure TfrmMain.start_application;
begin
 try
  // jméno aplikace
  frmMain.Caption:=Name_application;
  // vytvoří menu
  //create_menu;
  // vytvoří popup menu
  Create_Popup;
  // číslo verze
  lbVerze.Caption:=AppVerze(Application.ExeName);
  // uživatel
  //lbUzivatel.Caption:=DM.OracleConnection.UserName;  //ExecSQL_old('SELECT USER FROM DUAL'); //frmConnect.edUser.Text;//DM.Database.Params.Values['user name'];
  // nahraje ikony
  load_icon;
  // nastaví status bar
  nastav_status;
 finally

 end;
end;


procedure TfrmMain.FormCreate(Sender: TObject);
begin

  start_application;
  //if not Assigned(frmProcesQuery) then
    //Application.CreateForm(TfrmProcesQuery,frmProcesQuery);
  //if not Assigned(frmProces) then
    //Application.CreateForm(TfrmProces,frmProces);
end;

procedure TfrmMain.create_menu;
begin
    InitMenu(MainMenu,QmiSoubor,QmiSouborC); // Sort 0
    InitMenu(MainMenu,QmiAgendy,QmiAgendyC); // Sort 1
    InitMenu(MainMenu,QmiCiselniky,QmiCiselnikyC);  // Sort 2
// Items  ******
    InitMenu(MainMenu,QmiAdministrator,QmiAdministratorC,0);

//    InitMenu(MainMenu,QmiSklady,QmiSkladyC,1);    // Sort1 Item
//    InitMenu(MainMenu,QmiPohledavky,QmiPohledavkyC,1);    // Sort1 Item
//    InitMenu(MainMenu,QmiZavazky,QmiZavazkyC,1);    // Sort1 Item

end;

procedure TfrmMain.load_icon;
begin
    //InitIcon(QPohledavky,0,0);
    //InitIcon(QZavazky,1,0);
    //InitIcon(QSklady,2,0);
    //InitIcon(QAkcie,0,0);
    //InitIcon(QAkcionari,1,0);
    //InitIcon(QTypyAkcii,2,0);
    //InitIcon(QPsc,3,0);
end;

function TfrmMain.InitIcon(_Name : String ; _Index : Integer ; _Image : Integer):boolean;
begin
 try
   //ListView.Items.Add;
   //ListView.Items.Item[ListView.Items.Count-1].Caption:=_Name;
   //ListView.Items.Item[ListView.Items.Count-1].ImageIndex:=_Image;

   Result:=true;
 finally
 end;

end;

procedure TfrmMain.ListViewDragOver(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
begin
 Accept := (Source is TListView);
end;

procedure TfrmMain.PopupClick(Sender: TObject);
var _MenuItem : String;
begin
 try
    { _MenuItem:=TMenuItem(Sender).Name;
     case _MenuItem of
       QmiRaditAuto: Click;
     end;
     }

     {
     if TMenuItem(Sender).Name = QmiRaditAuto then
      begin
         ListView.IconOptions.AutoArrange:=not ListView.IconOptions.AutoArrange;
         TMenuItem(Sender).Checked:=ListView.IconOptions.AutoArrange;
         if not ListView.IconOptions.AutoArrange then ListView.SortType:=stNone;
         ListView.Arrange(TListArrangement(arDefault));
      end;

     if TMenuItem(Sender).Name = QmiSortName then
      begin
        ListView.IconOptions.AutoArrange:=true;
        ListView.SortType:=stText;
        ListView.IconOptions.AutoArrange:=PopupMenu.Items.Find(QmiRaditAutoC).Checked;
        ListView.Arrange(arSnapToGrid);
        //if Assigned(PopupMenu.Items.Find(QmiRaditAutoC)) then
        //            PopupMenu.Items.Find(QmiRaditAutoC).Checked:=ListView.IconOptions.AutoArrange;
      end;
     }
     if TMenuItem(Sender).Name = QmiZmenIco then
      begin

      end;

     if TMenuItem(Sender).Name = QmiPrepVelIco then
      begin

      end;
     {
     if TMenuItem(Sender).Name = QmiWrapText then
      begin
       ListView.IconOptions.WrapText:=not ListView.IconOptions.WrapText;
       TMenuItem(Sender).Checked:=ListView.IconOptions.WrapText;
       if ListView.IconOptions.AutoArrange then ListView.Arrange(TListArrangement(arDefault));
      end;
     }
     {
     if TMenuItem(Sender).Name = QmiZarMr then
      begin
       ListView.Arrange(arSnapToGrid);
      end;
     }
     {
     if TMenuItem(Sender).Name = QmiSortActual then
      begin
       ListView.Arrange(TListArrangement(arDefault));
      end;
     }
  finally

  end;
end;

procedure TfrmMain.nastav_status;
begin
  StatusBar1.Panels.Items[0].Text:=' Dnes má svátek :';
  StatusBar1.Panels.Items[1].Text:=DateToStr(Date)+'  '+TimeToStr(Time);
  DBCalendar1.Date:=DateToStr(Date());
  DBCalendar1.DateTime:=Date();
end;

procedure TfrmMain.TimerTimer(Sender: TObject);
begin
  StatusBar1.Panels.Items[1].Text:=DateToStr(Date)+'  '+TimeToStr(Time);
end;

procedure TfrmMain.Create_Popup;
begin
   ///InitPopup(PopupMenu,QmiSortName,QmiSortNameC,PopupClick,false);
   //InitPopup(PopupMenu,QmiSortActual,QmiSortActualC,PopupClick,false);
   ///InitPopup(PopupMenu,QmiRaditAuto,QmiRaditAutoC,PopupClick,ListView.IconOptions.AutoArrange);
   ///InitPopup(PopupMenu,QmiZarMr,QmiZarMrC,PopupClick,false);
   //InitPopup(PopupMenu,'mi1','-',nil);
   //InitPopup(PopupMenu,QmiZmenIco,QmiZmenIcoC,PopupClick,false,false);
   //InitPopup(PopupMenu,QmiPrepVelIco,QmiPrepVelIcoC,PopupClick,false,false);
   //InitPopup(PopupMenu,QmiWrapText,QmiWrapTextC,PopupClick,ListView.IconOptions.WrapText);
end;

procedure TfrmMain.ListViewDragDrop(Sender, Source: TObject; X,
  Y: Integer);
begin
  //TListView(Sender).Selected.SetPosition(Point(X-FDragStartPoint.X,Y-FDragStartPoint.Y));
end;

procedure TfrmMain.ListViewStartDrag(Sender: TObject;
  var DragObject: TDragObject);
begin
    GetCursorPos(FDragStartPoint);
    FDragStartPoint := TListView(Sender).ScreenToClient(FDragStartPoint);
    FDragStartPoint.X := FDragStartPoint.X - TListView(Sender).Selected.Position.X;
    FDragStartPoint.Y := FDragStartPoint.Y - TListView(Sender).Selected.Position.Y;
end;

procedure TfrmMain.miNenalezeneClick(Sender: TObject);
var
  qrMaster : TZQuery;
  sql_text,veta : String;
  sl : TStringList;
begin
   sql_text := 'SELECT '+
               '  REF_KOD,'+
               '  VAR_SYMB,'+
               '  SPISOVA_ZNACKA AS SPIS_ZNACKA,'+
               '  DATUM_ODESLANI,'+
               '  BEZNE_CISLO,'+
               '  UCET,'+
               '  VAR_SYMB,'+
               '  SOUD,'+
               '  PODANI_DORUCENE_DATUM AS DORUCENO,'+
               '  ODESILATEL'+
               '  FROM'+
               '    ZALOBY_ZPRAVY Z'+
               ' WHERE'+
               '  NOT EXISTS(SELECT 1 FROM ZALOBY WHERE REF_KOD=Z.REF_KOD)'+
               '  AND NOT EXISTS(SELECT 1 FROM ZALOBY_OSTATNI WHERE REF_KOD=Z.REF_KOD)'+
               '  AND NOT EXISTS(SELECT 1 FROM ZALOBY_MLCOCH WHERE REF_KOD=Z.REF_KOD)'+
               '  AND DBMS_LOB.INSTR(TELO,''odání ke spisové'') = 0 '+
               '  AND DBMS_LOB.INSTR(TELO,''nĂ­ ke spisovĂ©'') = 0'+
               ' ORDER BY '+
               '  REF_KOD';

try
  sl := TStringList.create;

  qrMaster := TZQuery.create(nil);
  qrMaster.Connection := DM.OracleConnection;
  qrMaster.SQL.Text:=sql_text;
  qrMaster.Open;

  while not qrMaster.EOF do
  begin
    veta := '';
    veta := qrMaster.FieldByName('REF_KOD').AsString;
    veta := veta + ';';
    veta := veta + qrMaster.FieldByName('SPIS_ZNACKA').AsString;
    veta := veta + ';';
    veta := veta + qrMaster.FieldByName('SOUD').AsString;
    veta := veta + ';';
    veta := veta + qrMaster.FieldByName('DATUM_ODESLANI').AsString;
    veta := veta + ';';
    veta := veta + qrMaster.FieldByName('DORUCENO').AsString;
    //veta := veta + ';';
    sl.Add(veta);
    qrMaster.Next;
  end;

  if SaveDialog.Execute then
    sl.SaveToFile(SaveDialog.FileName);

  ShowMessage('Sestava byla uložena do souboru: '+SaveDialog.FileName);

 finally
   qrMaster.Free;
   sl.Free;
 end;

 {
  if not Assigned(frmNesparovaneZpravy) then
    Application.CreateForm(TfrmNesparovaneZpravy,frmNesparovaneZpravy);
  frmNesparovaneZpravy.qrMaster.Close;
  //frmNesparovaneZpravy.qrMaster.SQL.Text:=sql_text;
  frmNesparovaneZpravy.qrMaster.Open;
  //ShowMessage('Error');
  frmNesparovaneZpravy.frReport.LoadFromFile(Replace_Char(get_param('SESTAVY')+'\','\\','\')+'snesparovane_zpravy.lrf');
  frmNesparovaneZpravy.frReport.PrepareReport;
  frmNesparovaneZpravy.frReport.ModalPreview:=true;
  frmNesparovaneZpravy.frReport.ShowProgress:=true;
  frmNesparovaneZpravy.frReport.ShowReport;
  frmNesparovaneZpravy.qrMaster.Close;}
end;

procedure TfrmMain.miOProgramuClick(Sender: TObject);
begin
  if not Assigned(dlgProgram) then
    Application.CreateForm(TdlgProgram,dlgProgram);
  dlgProgram.ShowModal;
end;

procedure TfrmMain.ListViewDblClick(Sender: TObject);
var
   _MenuItem : TMenuItem;
begin
{
   case TListView(Sender).ItemIndex of
    0 : begin
         if Assigned(miPohledavky) then
             miPohledavky.Click;
        end;
    1 : begin
         if Assigned(miZavazky) then
             miZavazky.Click;
        end;
    2 : begin
         if Assigned(miSklady) then
             miSklady.Click;
        end;
   end;
}
{
   if TListView(Sender).Items.Item[TListView(Sender).ItemIndex].Caption=QAkcie then
   begin
     if Assigned(miAkcie) then
       miAkcie.Click;
   end;

   if TListView(Sender).Items.Item[TListView(Sender).ItemIndex].Caption=QAkcionari then
   begin
     if Assigned(miAkcionari) then
       miAkcionari.Click;
   end;

   if TListView(Sender).Items.Item[TListView(Sender).ItemIndex].Caption=QTypyAkcii then
   begin
     if Assigned(miTypyAkcii) then
       miTypyAkcii.Click;
   end;

   if TListView(Sender).Items.Item[TListView(Sender).ItemIndex].Caption=QPsc then
   begin
     if Assigned(miPsc) then
       miPsc.Click;
   end;
}
   {

   case TListView(Sender).Column[TListView(Sender).ItemIndex].Caption of
    QAkcie : begin
         if Assigned(miAkcie) then
             miAkcie.Click;
        end;
    QAkcionari : begin
         if Assigned(miAkcionari) then
             miAkcionari.Click;
        end;
    QTypyAkcii : begin
         if Assigned(miTypyAkcii) then
             miTypyAkcii.Click;
        end;
    QPsc : begin
         if Assigned(miPsc) then
             miPsc.Click;
        end;
   end;

   }

end;

procedure TFrmMain.miMainMenuClick(Sender : TObject);
begin

//  if (Date()>StrToDate('30.8.2008')) and (MessageDlg('Vypršela platnost licence.',mtWarning,[mbOK],0)=mrOK) then
//    Application.Terminate;

if platna_licence then
begin
  if TMenuItem(Sender).Name = 'miAkcionari' then
  begin
    if not(Assigned(frmAkcionari)) then
      Application.CreateForm(TfrmAkcionari,frmAkcionari);
    frmAkcionari.ShowModal;
  end;
  if TMenuItem(Sender).Name = 'miTypyAkcii' then
  begin
    if not(Assigned(frmTypyAkcii)) then
      Application.CreateForm(TfrmTypyAkcii,frmTypyAkcii);
    frmTypyAkcii.ShowModal;
  end;
  if TMenuItem(Sender).Name = 'miAkcie' then
  begin
    if not(Assigned(frmAkcie)) then
      Application.CreateForm(TfrmAkcie,frmAkcie);
    frmAkcie.ShowModal;
  end;
  if TMenuItem(Sender).Name = 'miPsc' then
  begin
    if not(Assigned(frmPsc)) then
      Application.CreateForm(TfrmPsc,frmPsc);
    frmPsc.ShowModal;
  end;

  if TMenuItem(Sender).Name = 'miPartneri' then
  begin
    if not(Assigned(frmPartneri)) then
      Application.CreateForm(TfrmPartneri,frmPartneri);
    frmPartneri.ShowModal;
  end;
  if TMenuItem(Sender).Name = 'miUdalosti' then
  begin
    if not(Assigned(frmUdalosti)) then
      Application.CreateForm(TfrmUdalosti,frmUdalosti);
    frmUdalosti.ShowModal;
  end;
  if TMenuItem(Sender).Name = 'miUkoly' then
  begin
    if not(Assigned(frmUkoly)) then
      Application.CreateForm(TfrmUkoly,frmUkoly);
    frmUkoly.ShowModal;
  end;
  if TMenuItem(Sender).Name = 'miNabidky' then
  begin
    if not(Assigned(frmNabidky)) then
      Application.CreateForm(TfrmNabidky,frmNabidky);
    frmNabidky.ShowModal;
  end;

  if TMenuItem(Sender).Name = 'miProdukty' then
  begin
    if not(Assigned(frmProdukty)) then
      Application.CreateForm(TfrmProdukty,frmProdukty);
    frmProdukty.ShowModal;
  end;
  if TMenuItem(Sender).Name = 'miDanovesazby' then
  begin
    if not(Assigned(frmDanovesazby)) then
      Application.CreateForm(TfrmDanovesazby,frmDanovesazby);
    frmDanovesazby.ShowModal;
  end;
  if TMenuItem(Sender).Name = 'miPrilohy' then
  begin
    if not(Assigned(frmPrilohy)) then
      Application.CreateForm(TfrmPrilohy,frmPrilohy);
    frmPrilohy.ShowModal;
  end;
  if TMenuItem(Sender).Name = 'miPartneriosoby' then
  begin
    if not(Assigned(frmPartneriosoby)) then
      Application.CreateForm(TfrmPartneriOsoby,frmPartneriOsoby);
    frmPartneriOsoby.ShowModal;
  end;
  if TMenuItem(Sender).Name = 'miPartneriAdresy' then
  begin
    if not(Assigned(frmPartneriAdresy)) then
      Application.CreateForm(TfrmPartneriAdresy,frmPartneriAdresy);
    frmPartneriAdresy.ShowModal;
  end;
  if TMenuItem(Sender).Name = 'miPartnerispojeni' then
  begin
    if not(Assigned(frmPartnerispojeni)) then
      Application.CreateForm(TfrmPartnerispojeni,frmPartnerispojeni);
    frmPartnerispojeni.ShowModal;
  end;
  if TMenuItem(Sender).Name = 'miZaloby' then
  begin
    if not(Assigned(frmZaloby)) then
      Application.CreateForm(TfrmZaloby,frmZaloby);
    frmZaloby.ShowModal;
  end;
  if TMenuItem(Sender).Name = 'miZalobyOstatni' then
  begin
    if not(Assigned(frmZalobyOstatni)) then
      Application.CreateForm(TfrmZalobyOstatni,frmZalobyOstatni);
    frmZalobyOstatni.ShowModal;
  end;
  if TMenuItem(Sender).Name = 'miZalobyMlcoch' then
  begin
    if not(Assigned(frmZalobyMlcoch)) then
      Application.CreateForm(TfrmZalobyMlcoch,frmZalobyMlcoch);
    frmZalobyMlcoch.ShowModal;
  end;
end;

end;

{
procedure TFrmMain.FillForms (Sender : TObject);
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
     with frmMain do
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
     _MenuItem.OnClick:=Menu_Show_Form_OnClick;
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
}

procedure TfrmMain.FormActivate(Sender: TObject);
begin
//FillForms(Sender);
end;

procedure TfrmMain.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  if MessageDlg('Opravdu chcete ukončit aplikaci?',mtConfirmation,[mbYes, mbNo],0)=mrYes then
  begin
    //DM.SQLTransaction.Active:=False;
    DM.OracleConnection.Disconnect;
    Application.Terminate;
    //CloseAction:=caHide;
  end
  else
    begin
      Application.Run;
    end;
end;

{
procedure TfrmMain.Menu_Show_Form_OnClick(Sender : TObject);
begin
 try
   TForm(Application.FindComponent(TMenuItem(Sender).Name)).Show;
 finally

 end;
end;
}

procedure TfrmMain.miLicenceClick(Sender: TObject);
begin
  if not Assigned(frmFirma) then
    Application.CreateForm(TfrmFirma,frmFirma);

  frmFirma.ShowModal;
end;

procedure TfrmMain.FormShow(Sender: TObject);
begin
// if (Date()>StrToDate('31.12.2007')) and (MessageDlg('Vypršela platnost licence?',mtConfirmation,[mbOK],0)=mrOK) then
//   Application.Terminate;
end;

procedure TfrmMain.miAgendy1Click(Sender: TObject);
begin
// if (Date()>StrToDate('30.6.2008')) and (MessageDlg('Vypršela platnost licence.',mtWarning,[mbOK],0)=mrOK) then
//   Application.Terminate;
end;

procedure TfrmMain.miChybneObjektyClick(Sender: TObject);
begin
  if not Assigned(frmChybneObjekty) then
    Application.CreateForm(TfrmChybneObjekty,frmChybneObjekty);

  frmChybneObjekty.ShowModal;
end;

procedure TfrmMain.miCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmMain.miImportTxtClick(Sender: TObject);
begin
  //importZalobyZpravyTypyTxt('ZPRAVY_TYPY');
  importZalobyTxt('ZALOBY');
  //importZalobyTxt('ZALOBY_OSTATNI');
  //importZalobyTxt('ZALOBY_MLCOCH');
  //importZalobyZpravyTxt('ZALOBY_ZPRAVY','ZALOBY');
  ShowMessage('Import skončil');
end;

procedure TfrmMain.miParametryClick(Sender: TObject);
begin
  if not Assigned(frmParametry) then
    Application.CreateForm(TfrmParametry,frmParametry);

  frmParametry.ShowModal;
end;

procedure TfrmMain.miPrelozitClick(Sender: TObject);
begin
  ExecSQL('exec dbms_utility.compile_schema('''+DM.OracleConnection.User+''')');
  ShowMessage('Příkaz na přeložení nepřeložených objektů byl proveden');
end;

procedure TfrmMain.miZalohaDatClick(Sender: TObject);
var
  s: TStringList;
  c,n : String;
begin
try
  try
    c:=Replace(get_param('ZALOHA_DAT_CESTA')+'\','\\','\');
    //ShowMessage(c);
    n:='Zaloha_dat_mbsystem_'+DateToStr(Date())+'.dmp';
    s:=TStringList.Create;
    s.Text:='exp userid='+DM.OracleConnection.User+'/'+DM.OracleConnection.Password+' buffer=4096 file='+c+n+' owner='+DM.OracleConnection.User+' grants=n rows=y compress=y log='+Application.Location+'export.log';
    s.SaveToFile(Application.Location+'Zaloha_dat.bat');
    if (DirectoryIsWritable(c)) and (length(c)>0) then
    begin
      ExecuteProcess(Application.Location+'Zaloha_dat.bat','');
      MessageDlg('Záloha byla provedena: '+c+n,mtInformation,[mbOK],0);
    end
    else
    begin
      MessageDlg('Adresář pro zálohu nebyl nalezen nebo není pro zápis: '+c,mtError,[mbOK],0);
    end;
  finally
    s.Free;
  end;

except
on E : Exception do
  begin
    MessageDlg('Záloha dat skončila chybou: '+E.Message+'!',mtError,[mbOK],0);
  end;
end;
end;

procedure TfrmMain.miZalohaTxtClick(Sender: TObject);
begin
  exportZalobyTxt('ZALOBY');
  exportZalobyTxt('ZALOBY_OSTATNI');
  exportZalobyTxt('ZALOBY_MLCOCH');
  exportZalobyZpravyTxt('ZALOBY_ZPRAVY');
  exportZalobyZpravyTypyTxt('ZPRAVY_TYPY');
  ShowMessage('Export skončil');
end;

procedure TfrmMain.miZiskatDataZeZpravClick(Sender: TObject);
var
  qrMaster : TZQuery;
  var_symb,ucet,sql_text,telo : String;
begin
  qrMaster := TZQuery.create(nil);
  sql_text := 'SELECT * FROM ZALOBY_ZPRAVY WHERE TYP_ZPRAVY=4 AND (VAR_SYMB IS NULL OR UCET IS NULL)';
  try
    try
      qrMaster.Connection := DM.OracleConnection;
      qrMaster.SQL.Text:=sql_text;
      qrMaster.Open;

      while not qrMaster.EOF do
      begin
        var_symb := '';
        ucet := '';
        telo := qrMaster.FieldByName('TELO').AsString;
        var_symb := najdi_var_symb(telo);
        ucet := najdi_ucet(telo);
        //ShowMessage(ucet + '----' + var_symb + '*******' + telo);
        qrMaster.Edit;
        qrMaster.FieldByName('VAR_SYMB').AsString:=var_symb;
        qrMaster.FieldByName('UCET').AsString:=ucet;
        qrMaster.Post;
        qrMaster.ApplyUpdates;
        qrMaster.next;
      end;

      ShowMessage('Operace skončila');

    except
      ShowMessage('Operace skončila chybou');
    end;
  finally
    qrMaster.free;
  end;
end;


initialization
  {$I fmain.lrs}

end.

