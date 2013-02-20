unit dheslo;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  StdCtrls, Buttons;

type

  { TfrmHesloD }

  TfrmHesloD = class(TForm)
    BitBtn1: TBitBtn;
    Edit1: TEdit;
    procedure BitBtn1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  frmHesloD: TfrmHesloD;

implementation

{ TfrmHesloD }
uses fheslo;

procedure TfrmHesloD.Button1Click(Sender: TObject);
begin

end;

procedure TfrmHesloD.FormShow(Sender: TObject);
begin
  Edit1.SetFocus;
end;

procedure TfrmHesloD.BitBtn1Click(Sender: TObject);
begin
  if not Assigned(frmHeslo) then
    Application.CreateForm(TfrmHeslo,frmHeslo);
  if Edit1.Text='mata553' then
  begin
    Edit1.Clear;
    frmHeslo.ShowModal;
  end
  else
  begin
    Edit1.Clear;
    close;
  end;
end;

initialization
  {$I dheslo.lrs}

end.

