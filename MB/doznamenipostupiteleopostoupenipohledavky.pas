unit DOznameniPostupiteleOPostoupeniPohledavky;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  StdCtrls, EditBtn, sqldb, Utils, db;

type

  { TfrmTiskZalob }

  TfrmTiskZalob = class(TForm)
    btTisk: TButton;
    edDatumImportu: TDateEdit;
    rbVse: TRadioButton;
    rbOznacene: TRadioButton;
    rbDatum: TRadioButton;
    procedure btTiskClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure rbDatumClick(Sender: TObject);
    procedure rbOznaceneClick(Sender: TObject);
    procedure rbVseClick(Sender: TObject);
  private
    { private declarations }
  public
    FSelRows: integer;
  end; 

var
  frmTiskZalob: TfrmTiskZalob;

implementation

{ TfrmTiskZalob }

uses FZaloby,SOznameniPostupiteleOPostoupeniPohledavky;

procedure TfrmTiskZalob.FormCreate(
  Sender: TObject);
begin
  edDatumImportu.Date:=Date();
end;

procedure TfrmTiskZalob.btTiskClick(Sender: TObject);
begin

end;

procedure TfrmTiskZalob.FormShow(
  Sender: TObject);
begin
  if FSelRows>0 then
    rbOznacene.Enabled:=True
  else
    rbOznacene.Enabled:=False;
end;

procedure TfrmTiskZalob.rbDatumClick(
  Sender: TObject);
begin
  if rbDatum.Checked then
    edDatumImportu.Visible:=true;
end;

procedure TfrmTiskZalob.rbOznaceneClick(
  Sender: TObject);
begin
  edDatumImportu.Visible:=false;
end;

procedure TfrmTiskZalob.rbVseClick(
  Sender: TObject);
begin
  edDatumImportu.Visible:=false;
end;

initialization
  {$I doznamenipostupiteleopostoupenipohledavky.lrs}

end.

