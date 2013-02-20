unit shistorie_akcie; 

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  LR_Class, LR_DBSet, sqldb;

type

  { TfrmHistorie_akcie }

  TfrmHistorie_akcie = class(TForm)
    frDBDataSet1: TfrDBDataSet;
    quickrep1: TfrReport;
    qrMaster: TSQLQuery;
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  frmHistorie_akcie: TfrmHistorie_akcie;

implementation

initialization
  {$I shistorie_akcie.lrs}

end.

