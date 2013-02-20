unit svypis_akcionare; 

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  LR_Class, LR_DBSet, sqldb;

type

  { TfrmVypisAkcionare }

  TfrmVypisAkcionare = class(TForm)
    frDBDataSet1: TfrDBDataSet;
    frDBDataSet2: TfrDBDataSet;
    quickrep1: TfrReport;
    qrMaster: TSQLQuery;
    qrSlave: TSQLQuery;
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  frmVypisAkcionare: TfrmVypisAkcionare;

implementation

initialization
  {$I svypis_akcionare.lrs}

end.

