unit sseznam_akcionaru3; 

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  sqldb, LR_Class, LR_DBSet;

type

  { TfrmSeznamAkcionaru3 }

  TfrmSeznamAkcionaru3 = class(TForm)
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
  frmSeznamAkcionaru3: TfrmSeznamAkcionaru3;

implementation

initialization
  {$I sseznam_akcionaru3.lrs}

end.

