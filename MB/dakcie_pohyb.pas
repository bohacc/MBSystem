unit dakcie_pohyb; 

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  StdCtrls, DbCtrls, Buttons, Calendar, EditBtn;

type

  { TfrmAkciePohyb }

  TfrmAkciePohyb = class(TForm)
    BitBtn1: TBitBtn;
    Button1: TButton;
    cbTyp: TDBComboBox;
    edDatum: TDBCalendar;
    edSerie: TDBEdit;
    edCislo_akcie: TDBEdit;
    edHodnota: TDBEdit;
    edPoznamka: TDBMemo;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    procedure BitBtn1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure cbTypChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  frmAkciePohyb: TfrmAkciePohyb;

implementation

{ TfrmAkciePohyb }
uses fakcionari,utils,dpoznamka;

procedure TfrmAkciePohyb.FormCreate(Sender: TObject);
begin
  InitDBComboSQL('SELECT * FROM TYPY_AKCII',cbTyp);
  cbTyp.DataSource:=frmAkcionari.dsPohyb;
  edSerie.DataSource:=frmAkcionari.dsPohyb;
  edCislo_akcie.DataSource:=frmAkcionari.dsPohyb;
  edHodnota.DataSource:=frmAkcionari.dsPohyb;
  edPoznamka.DataSource:=frmAkcionari.dsPohyb;
  edDatum.DataSource:=frmAkcionari.dsPohyb;
end;

procedure TfrmAkciePohyb.BitBtn1Click(Sender: TObject);
begin
  if frmAkcionari.dsPohyb.DataSet.Modified then
  begin
    frmAkcionari.qrPohybCISLO.AsInteger:=frmAkcionari.qrMasterID.AsInteger;
    frmAkcionari.dsPohyb.DataSet.Post;
    frmAkcionari.qrPohyb.ApplyUpdates;
  end;
  //frmAkcionari.qrPohyb.Database.Commit;
  Refresh_DataSet(frmAkcionari.Navigator.DataSource.DataSet,frmAkcionari.qrMaster);
  Refresh_DataSet(frmAkcionari.DBNavigator1.DataSource.DataSet,frmAkcionari.qrPohyb);
  Close;
end;

procedure TfrmAkciePohyb.Button1Click(Sender: TObject);
begin
    if not(Assigned(frmPoznamka)) then
      Application.CreateForm(TfrmPoznamka,frmPoznamka);
    frmPoznamka.Memo1.Text:=frmAkcionari.dsPohyb.DataSet.fieldByName('POZNAMKA').AsString;
    frmPoznamka.ShowModal;
    frmAkcionari.qrPohyb.Connection.StartTransaction;
    if not(frmAkcionari.dsPohyb.DataSet.Modified) then
      frmAkcionari.dsPohyb.DataSet.Edit
    else
    begin
      frmAkcionari.dsPohyb.DataSet.Post;
      frmAkcionari.dsPohyb.DataSet.Edit;
    end;
    frmAkcionari.dsPohyb.DataSet.fieldByName('POZNAMKA').AsString:=frmPoznamka.Memo1.Text;
    frmAkcionari.dsPohyb.DataSet.Post;
    frmAkcionari.dsPohyb.DataSet.Edit;
end;

procedure TfrmAkciePohyb.cbTypChange(Sender: TObject);
begin
  if cbTyp.Text<>'' then
    edHodnota.Text:=Get_cached_string('SELECT HODNOTA FROM TYPY_AKCII WHERE TYP=',''''+cbTyp.Text+'''');
  frmAkcionari.dsPohyb.DataSet.fieldByName('SERIE').AsString:=cbTyp.Text;
end;

procedure TfrmAkciePohyb.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  frmAkcionari.dsPohyb.DataSet.Cancel;
  frmAkcionari.qrPohyb.Cancel;
end;

initialization
  {$I dakcie_pohyb.lrs}

end.

