unit FSopopppredavaciprotokol;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, sqldb, FileUtil, LResources, Forms, Controls, Graphics,
  Dialogs, LR_DBSet, LR_Class, ZDataset;

type

  { TfrmSOPOPPPredavaciProtokol }

  TfrmSOPOPPPredavaciProtokol = class(TForm)
    frDBDataSet1: TfrDBDataSet;
    frReport: TfrReport;
    qrMaster: TZQuery;
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  frmSOPOPPPredavaciProtokol: TfrmSOPOPPPredavaciProtokol;

implementation

initialization
  {$I fsopopppredavaciprotokol.lrs}

end.

