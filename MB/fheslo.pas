unit fheslo;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  StdCtrls;

type

  { TfrmHeslo }

  TfrmHeslo = class(TForm)
    Button1: TButton;
    Edit1: TEdit;
    Label1: TLabel;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  frmHeslo: TfrmHeslo;

implementation

{ TfrmHeslo }

uses utils;

procedure TfrmHeslo.Button1Click(Sender: TObject);
begin
  Edit1.Text:=generuj_licenci(Memo1.Text);
end;

initialization
  {$I fheslo.lrs}

end.

