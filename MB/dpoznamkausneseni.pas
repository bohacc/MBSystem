unit dpoznamkaUsneseni;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, LResources, Forms, Controls, Graphics,
  Dialogs, DbCtrls, ExtCtrls, StdCtrls;

type

  { TfrmPoznamkaUsneseni }

  TfrmPoznamkaUsneseni = class(TForm)
    btOk: TButton;
    dsUsneseni: TDatasource;
    DBMemo1: TDBMemo;
    Panel1: TPanel;
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  frmPoznamkaUsneseni: TfrmPoznamkaUsneseni;

implementation

initialization
  {$I dpoznamkausneseni.lrs}

end.

