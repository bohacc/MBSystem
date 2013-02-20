unit FFirma; 

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, sqldb, db, FileUtil, LResources, Forms, Controls, Graphics,
  Dialogs, StdCtrls, DbCtrls, clipbrd, Buttons, ActnList, ZDataset, ZSqlUpdate,
  utils;

type

  { TfrmFirma }

  TfrmFirma = class(TForm)
    acLicence: TAction;
    ActionList1: TActionList;
    btok: TBitBtn;
    Button1: TButton;
    Button2: TButton;
    cbSit: TDBCheckBox;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    dsLicence: TDatasource;
    edLicence: TDBEdit;
    edPlatnost: TDBEdit;
    edNazev: TDBEdit;
    edUlice: TDBEdit;
    edMesto: TDBEdit;
    edPsc: TDBEdit;
    edIc: TDBEdit;
    edDic: TDBEdit;
    edDoplnijiciText: TDBEdit;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    edID: TMemo;
    qrLicence: TZQuery;
    qrLicenceDIC: TStringField;
    qrLicenceDOPLNUJICI_TEXT: TStringField;
    qrLicenceICO: TStringField;
    qrLicenceKOD: TStringField;
    qrLicenceKOD_BANKY: TStringField;
    qrLicenceKONTAKTNI_OSOBA: TStringField;
    qrLicenceKONTAKTNI_OSOBA_TEL: TStringField;
    qrLicenceLICENCNI_CISLO: TStringField;
    qrLicenceMESTO: TStringField;
    qrLicenceNAZEV: TStringField;
    qrLicencePLATNOST_LICENCE: TDateField;
    qrLicencePSC: TStringField;
    qrLicenceSIT: TSmallintField;
    qrLicenceUCET: TStringField;
    qrLicenceULICE: TStringField;
    UpdateLicence: TZUpdateSQL;
    procedure acLicenceExecute(Sender: TObject);
    procedure btokClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure dsLicenceDataChange(Sender: TObject; Field: TField);
    procedure FormShow(Sender: TObject);
    procedure qrLicenceAfterApplyUpdates(Sender: TObject);
    procedure qrLicenceAfterPost(DataSet: TDataSet);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  frmFirma: TfrmFirma;

implementation

{ TfrmFirma }
uses FHeslo, DHeslo, fmain, Data_module;

procedure TfrmFirma.Button1Click(Sender: TObject);
var
  ClipBoard : TClipboard;
  un,cn : string;
begin
  try
    cn:=Replace(Get_ComputerName,#0,'');
    un:=Replace(Get_UserName,#0,'');
    ClipBoard:=TClipBoard.Create();
    Clipboard.AsText:=edNazev.Text+';'+edUlice.Text+';'+edMesto.Text+';'+
                      edPsc.Text+';'+edIC.Text+';'+edDic.Text+';'+edPlatnost.Text+';'+
                      cn+';'+un+';'+edID.Text;
  finally
    ClipBoard.Free;
  end;
end;

procedure TfrmFirma.btokClick(Sender: TObject);
var
  ok : Boolean;
  l : string;
begin

  if trim(edNazev.Text)='' then
    MessageDlg('Název musí být vyplněn!',mtWarning,[mbOK],0)
  else
  if trim(edUlice.Text)='' then
      MessageDlg('Ulice musí být vyplněna!',mtWarning,[mbOK],0)
  else
  if trim(edMesto.Text)='' then
      MessageDlg('Město musí být vyplněno!',mtWarning,[mbOK],0)
  else
  if trim(edPsc.Text)='' then
      MessageDlg('Psč musí být vyplněno!',mtWarning,[mbOK],0)
  else
  if trim(edIC.Text)='' then
      MessageDlg('IČO musí být vyplněno!',mtWarning,[mbOK],0)
  else
  if trim(edDic.Text)='' then
      MessageDlg('DIČ musí být vyplněno!',mtWarning,[mbOK],0)
  else
  if trim(edPlatnost.Text)='' then
      MessageDlg('Platnost licence musí být vyplněna!',mtWarning,[mbOK],0);

  if (edNazev.Text<>'') and
     (edUlice.Text<>'') and
     (edMesto.Text<>'') and
     (edPsc.Text<>'') and
     (edIC.Text<>'') and
     (edDic.Text<>'') and
     (edPlatnost.Text<>'')
  then
    ok:=True
  else
    ok:=False;

  if ok then
  begin
    if qrLicence.Modified then
      qrLicence.Post;
    l:=generuj_licenci(edID.Text);
    if (edLicence.Text<>l) or (edLicence.Text='') or (l='') or (StrToDate(edPlatnost.Text)<Date()) then
    begin
      frmMain.platna_licence:=False;
      MessageDlg('Licence je neplatná, program není možné dále používat!',mtWarning,[mbOK],0);
    end
    else
      frmMain.platna_licence:=True;
    Close;
  end;
  //else
  //  MessageDlg('Vyplňte všechny povinné údaje!',mtWarning,[mbOK],0);

end;

procedure TfrmFirma.acLicenceExecute(Sender: TObject);
var
  s: string;
  lan : Integer=0;
begin
  s:=edNazev.Text+edUlice.Text+edMesto.Text+edPsc.Text+edIC.Text+edDic.Text+Replace(Replace(edPlatnost.Text,'.',''),'/','');
  if cbSit.Checked then
    lan:=1;
  edID.Text:=generuj_uc(s,lan);
end;

procedure TfrmFirma.Button2Click(Sender: TObject);
begin
  if not Assigned(frmHesloD) then
    Application.CreateForm(TfrmHesloD,frmHesloD);
  frmHesloD.ShowModal;
end;

procedure TfrmFirma.dsLicenceDataChange(Sender: TObject; Field: TField);
begin
  acLicence.Execute;
end;

procedure TfrmFirma.FormShow(Sender: TObject);
var
  b : boolean;
  Disk : Char;
  sVolName,sVolBuff,s : string;
  iSerNum : integer;
begin

  if not(qrLicence.Active) then
    qrLicence.Open;

  //s:=edNazev.Text+edUlice.Text+edMesto.Text+edPsc.Text+edIC.Text+edDic.Text;
  //edID.Text:=generuj_uc(s);
  //edLicence.Text:=generuj_licenci(edID.Text);

  acLicence.Execute;

{
  try
    b:=GetDiskInfo(Disk,sVolName,sVolBuff,iSerNum);
    if not(qrLicence.Active) then
      qrLicence.Open;
    qrLicence.Edit;
    edID.Text:=Get_ComputerName+'-'+Get_UserName+'-'+sVolName+'-'+Disk+'-'+IntToStr(iSerNum);
  except

  end;
}
end;

procedure TfrmFirma.qrLicenceAfterApplyUpdates(Sender: TObject);
begin
  qrLicence.CommitUpdates;
end;

procedure TfrmFirma.qrLicenceAfterPost(DataSet: TDataSet);
begin
  qrLicence.ApplyUpdates;
end;

initialization
  {$I ffirma.lrs}

end.

