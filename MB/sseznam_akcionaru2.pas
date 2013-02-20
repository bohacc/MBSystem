unit sseznam_akcionaru2; 

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  sqldb, LR_DBSet, LR_Class;

type

  { TfrmSeznamAkcionaru2 }

  TfrmSeznamAkcionaru2 = class(TForm)
    frDBDataSet1: TfrDBDataSet;
    frDBDataSet2: TfrDBDataSet;
    quickrep1: TfrReport;
    qrMaster: TSQLQuery;
    qrFirma: TSQLQuery;
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  frmSeznamAkcionaru2: TfrmSeznamAkcionaru2;

implementation

initialization
  {$I sseznam_akcionaru2.lrs}

end.

