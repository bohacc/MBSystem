unit sseznam_akcionaru; 

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  LR_Class, LR_DBSet, sqldb;

type

  { TfrmSeznamAkcionaru }

  TfrmSeznamAkcionaru = class(TForm)
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
  frmSeznamAkcionaru: TfrmSeznamAkcionaru;

implementation

initialization
  {$I sseznam_akcionaru.lrs}

end.

