unit dprevod_akcie; 

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  sqldb, db, ExtCtrls, DBGrids, DbCtrls, StdCtrls, EditBtn, ZDataset;

type

  { TfrmPrevodAkcie }

  TfrmPrevodAkcie = class(TForm)
    Button1: TButton;
    cbSloucit: TCheckBox;
    edDatum: TDateEdit;
    DBGrid1: TDBGrid;
    DBGrid2: TDBGrid;
    DBNavigator1: TDBNavigator;
    DBNavigator2: TDBNavigator;
    dsAkcie: TDatasource;
    dsAkcionari: TDatasource;
    edDoklad: TEdit;
    edID: TEdit;
    edPrijmeni: TEdit;
    edJmeno: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    qrAkcieCISLO: TLongintField;
    qrAkcieCISLO_AKCIE: TLargeintField;
    qrAkcieDATUM: TDateField;
    qrAkcieHODNOTA: TFloatField;
    qrAkcieID: TLongintField;
    qrAkciePOZNAMKA: TMemoField;
    qrAkcieSERIE: TStringField;
    qrAkcieTEXT: TBlobField;
    qrAkcieTYP: TStringField;
    qrAkcionariAKCIE: TFloatField;
    qrAkcionariDIVIDENDA: TFloatField;
    qrAkcionariID: TLongintField;
    qrAkcionariJMENO: TStringField;
    qrAkcionariMESTO: TStringField;
    qrAkcionariOP: TStringField;
    qrAkcionariOS: TStringField;
    qrAkcionariPRIJMENI: TStringField;
    qrAkcionariPSC: TStringField;
    qrAkcionariRC: TStringField;
    qrAkcionariULICE: TStringField;
    Splitter1: TSplitter;
    qrAkcie: TZQuery;
    qrAkcionari: TZQuery;
    procedure Button1Click(Sender: TObject);
    procedure cbSloucitClick(Sender: TObject);
    procedure edDatumEnter(Sender: TObject);
    procedure edIDChange(Sender: TObject);
    procedure edIDEnter(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  frmPrevodAkcie: TfrmPrevodAkcie;

implementation

{ TfrmPrevodAkcie }
uses utils,fakcionari,uproc;

procedure TfrmPrevodAkcie.Button1Click(Sender: TObject);
var
  sloucit : Integer;
  sql : string;
begin
  try
    DBGrid2.Enabled:=false;

    if cbSloucit.Checked then
    begin
      sloucit:=1;
      sql:=qrAkcie.SQL.Text;
      Prevod_akcie(qrAkcie.FieldByName('ID').AsInteger,qrAkcionari.FieldByName('ID').AsInteger,edDoklad.Text,StrToDate(edDatum.Text),sloucit,sql);
    end
    else
    begin
      sloucit:=0;
      sql:='';
      qrAkcie.First;
      while not(qrAkcie.Eof) do
      begin
        Prevod_akcie(qrAkcie.FieldByName('ID').AsInteger,qrAkcionari.FieldByName('ID').AsInteger,edDoklad.Text,StrToDate(edDatum.Text),sloucit,sql);
        qrAkcie.Next;
      end;
    end;
    MessageDlg('Převod byl proveden.',mtInformation,[mbOK],0);
    //ShowMessage('Převod byl proveden.');
    //Refresh_DataSet(frmAkcionari.DBNavigator1.DataSource.DataSet);
{
    if not(frmAkcionari.qrMaster.Modified) then
      frmAkcionari.qrMaster.Edit;
    frmAkcionari.qrMasterAkcie.AsFloat:=StrToFloat(ExecSql_old('SELECT SUM(HODNOTA) FROM AKCIE WHERE CISLO='+frmAkcionari.qrMasterID.AsString+' GROUP BY CISLO'));
    if frmAkcionari.qrMaster.Modified then
      frmAkcionari.qrMaster.Post;
}
    ExecSQL('UPDATE AKCIONARI SET AKCIE=(SELECT SUM(HODNOTA) FROM AKCIE WHERE CISLO='+qrAkcionari.FieldByName('ID').AsString+') WHERE ID='+qrAkcionari.FieldByName('ID').AsString);
    ExecSQL('UPDATE AKCIONARI SET AKCIE=(SELECT SUM(HODNOTA) FROM AKCIE WHERE CISLO='+qrAkcie.FieldByName('CISLO').AsString+') WHERE ID='+qrAkcie.FieldByName('CISLO').AsString);
    DBGrid2.Enabled:=true;

    Refresh_DataSet(frmAkcionari.Navigator.DataSource.DataSet,frmAkcionari.qrMaster);

    Close;
  except
    DBGrid2.Enabled:=true;
    MessageDlg('Došlo k chybě!',mtError,[mbOK],0);
  end;
end;

procedure TfrmPrevodAkcie.cbSloucitClick(Sender: TObject);
begin
  if cbSloucit.Checked then
    MessageDlg('Pozor, převedené akcie budou sloučeny do jedné akcie!',mtWarning,[mbOK],0);
end;

procedure TfrmPrevodAkcie.edDatumEnter(Sender: TObject);
begin
  edDatum.SelectAll;
  edDatum.SelStart:=0;
end;

procedure TfrmPrevodAkcie.edIDChange(Sender: TObject);
begin
  qrAkcionari.DisableControls;
  qrAkcionari.Close;
  if trim(edID.TEXT) <> '' then
    qrAkcionari.Params.ParamByName('ID').AsInteger:=StrToInt(trim(edID.TEXT));
  qrAkcionari.Params.ParamByName('PRIJMENI').AsString:=edPrijmeni.Text;
  qrAkcionari.Params.ParamByName('JMENO').AsString:=edJmeno.Text;
  qrAkcionari.Open;
  qrAkcionari.EnableControls;
end;

procedure TfrmPrevodAkcie.edIDEnter(Sender: TObject);
begin
  edID.SelectAll;
  edID.SelStart:=0;
end;

initialization
  {$I dprevod_akcie.lrs}

end.

