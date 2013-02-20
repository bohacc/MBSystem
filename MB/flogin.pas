unit flogin;

{$mode objfpc}{$H+}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, IniFiles, DB, ExtCtrls, FileUtil,
  LResources, ZDataset, sqldb, OracleConnection;

type

  { TfrmLogin }

  TfrmLogin = class(TForm)
    edDBName: TEdit;
    edPassword: TEdit;
    edUser: TEdit;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
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
    sbOK: TSpeedButton;
    sbStorno: TSpeedButton;
    Shape1: TShape;
    qrLicence: TZQuery;
    procedure edDBNameKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
      );
    procedure edPasswordEnter(Sender: TObject);
    procedure edPasswordKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edUserKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure sbOKClick(Sender: TObject);
    procedure sbStornoClick(Sender: TObject);
    procedure Shape1ChangeBounds(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  frmLogin: TfrmLogin;

implementation

uses FMain,Data_module,Utils;

procedure klik_ok(aKey : Word);
begin
  if (aKey=13) then
  begin
    frmLogin.sbOKClick(nil);
  end;
  if (aKey=VK_F5) then
  begin
    frmLogin.edPassword.Text:=frmLogin.edUser.Text;
    frmLogin.sbOKClick(nil);
  end;
end;

procedure TfrmLogin.sbOKClick(Sender: TObject);
var
  l,lg,s,uc : string;
  Ini: TIniFile;
begin

  Ini:=TIniFile.Create(ChangeFileExt(Application.ExeName, '.INI'));
try

  Application.ShowMainForm:=true;

  DM.OracleConnection.LoginPrompt:=False;
  DM.OracleConnection.Database:=edDBName.Text;
  DM.OracleConnection.User:=edUser.Text;
  DM.OracleConnection.Password:=edPassword.Text;
  DM.OracleConnection.Connect;
  //DM.OracleConnection.Connected:=true;
  //DM.SQLTransaction.Active:=True;

  // uložení přihlaš. udaju
  Ini.WriteString('DB_CONNECT', 'CONNECT_STRING', edDBName.Text);
  Ini.WriteString('DB_CONNECT', 'USER_NAME', edUser.Text);

  // uživatel
  frmMain.lbUzivatel.Caption:=UpperCase(DM.OracleConnection.User);


  try
// ověření licence
  if not qrLicence.Active then
    qrLicence.Connection:=DM.OracleConnection;
    qrLicence.Open;
  l:=qrLicenceLICENCNI_CISLO.AsString;

  s:=qrLicenceNAZEV.AsString+
     qrLicenceULICE.AsString+
     qrLicenceMESTO.AsString+
     qrLicencePSC.AsString+
     qrLicenceICO.AsString+
     qrLicenceDIC.AsString+
     Replace(qrLicencePlatnost_licence.Text,'.','');

     //ShowMessage(Replace(qrLicencePlatnost_licence.Text,'.',''));

  uc:=generuj_uc(s,qrLicenceSIT.AsInteger);
  lg:=generuj_licenci(uc);
  if ((l<>lg) or (l='') or (lg='') or (qrLicencePlatnost_licence.AsDateTime<Date())) and (MessageDlg('Licence není platná!',mtWarning,[mbOK],0)=mrOK) then
    //Application.Terminate;
    frmMain.platna_licence:=False
  else
    frmMain.platna_licence:=True;
// ------------------------------
  except
  end;

  if neprelozitelne_objekty then
    MessageDlg('Byly nalezeny nepřeložené objekty v databázi, informujte programátora.',mtWarning,[mbOK],0);

  Close;
finally
  Ini.free;
end;

end;

procedure TfrmLogin.sbStornoClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TfrmLogin.Shape1ChangeBounds(Sender: TObject);
begin

end;

procedure TfrmLogin.FormShow(Sender: TObject);
var
  ini: TIniFile;
begin
try
  try
    ini := TIniFile.Create(ChangeFileExt(Application.ExeName,'.INI'));
    edDBName.Text:=ini.ReadString('DB_CONNECT', 'CONNECT_STRING', '');
    edUser.Text:=ini.ReadString('DB_CONNECT', 'USER_NAME', '');
  except
  end;

  if (edDbname.Text<>'') and (edUser.text<>'') then
    edPassword.SetFocus;

finally
  ini.free;
end;
end;

procedure TfrmLogin.edDBNameKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  klik_ok(Key);
end;

procedure TfrmLogin.edPasswordEnter(Sender: TObject);
begin

end;

procedure TfrmLogin.edUserKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  klik_ok(Key);
end;

procedure TfrmLogin.edPasswordKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  klik_ok(Key);
end;


initialization
  {$I flogin.lrs}

end.

