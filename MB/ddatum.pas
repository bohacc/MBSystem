unit DDatum;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  EditBtn, StdCtrls, Utils, sqldb;

type

  { TdlgDatum }

  TdlgDatum = class(TForm)
    btOk: TButton;
    edDatum: TDateEdit;
    Label1: TLabel;
    procedure btOkClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  dlgDatum: TdlgDatum;

implementation

{ TdlgDatum }

uses FZaloby;

procedure TdlgDatum.FormShow(Sender: TObject);
begin
  edDatum.Date:=Date();
end;

procedure TdlgDatum.btOkClick(Sender: TObject);
begin

end;

initialization
  {$I ddatum.lrs}

end.

