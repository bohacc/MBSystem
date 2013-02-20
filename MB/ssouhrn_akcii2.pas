unit ssouhrn_akcii2; 

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  sqldb, LR_Class, LR_DBSet;

type

  { TfrmSouhrnAkcii2 }

  TfrmSouhrnAkcii2 = class(TForm)
    frDBDataSet1: TfrDBDataSet;
    quickrep1: TfrReport;
    qrMaster: TSQLQuery;
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  frmSouhrnAkcii2: TfrmSouhrnAkcii2;

implementation

initialization
  {$I ssouhrn_akcii2.lrs}

end.

