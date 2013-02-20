unit dprogram;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  Buttons, StdCtrls;

type

  { TdlgProgram }

  TdlgProgram = class(TForm)
    BitBtn1: TBitBtn;
    Memo1: TMemo;
    procedure Memo1Change(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  dlgProgram: TdlgProgram;

implementation

{ TdlgProgram }

procedure TdlgProgram.Memo1Change(Sender: TObject);
begin

end;

initialization
  {$I dprogram.lrs}

end.

