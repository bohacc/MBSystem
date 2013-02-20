unit ssouhrn_akcii; 

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  LR_Class, sqldb, db, SdfData, LR_DBSet, LR_DSet, LR_Desgn;

type

  { TfrmSouhrnAkcii }

  TfrmSouhrnAkcii = class(TForm)
    frDBDataSet1: TfrDBDataSet;
    quickrep1: TfrReport;
    qrMaster: TSQLQuery;
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  frmSouhrnAkcii: TfrmSouhrnAkcii;

implementation

initialization
  {$I ssouhrn_akcii.lrs}

end.

