unit sSoucetAkciiZaTypAll; 

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  sqldb, LR_Class, LR_DBSet;

type

  { TfrmSSoucetAkciiZaTypAll }

  TfrmSSoucetAkciiZaTypAll = class(TForm)
    frDBDataSet1: TfrDBDataSet;
    quickrep1: TfrReport;
    qrMaster: TSQLQuery;
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  frmSSoucetAkciiZaTypAll: TfrmSSoucetAkciiZaTypAll;

implementation

initialization
  {$I ssoucetakciizatypall.lrs}

end.

