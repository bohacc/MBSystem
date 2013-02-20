unit FSOPOPPPodaciList;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, sqldb, FileUtil, LResources, Forms, Controls, Graphics,
  Dialogs, LR_Class, LR_DBSet, ZDataset;

type

  { TfrmSOPOPPPodaciList }

  TfrmSOPOPPPodaciList = class(TForm)
    frDBDataSet1: TfrDBDataSet;
    frReport: TfrReport;
    qrMaster: TZQuery;
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  frmSOPOPPPodaciList: TfrmSOPOPPPodaciList;

implementation

initialization
  {$I fsopopppodacilist.lrs}

end.

