unit dpoznamka;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  ExtCtrls, StdCtrls, Buttons;

type

  { TfrmPoznamka }

  TfrmPoznamka = class(TForm)
    BitBtn1: TBitBtn;
    Memo1: TMemo;
    Panel1: TPanel;
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  frmPoznamka: TfrmPoznamka;

implementation

initialization
  {$I dpoznamka.lrs}

end.

