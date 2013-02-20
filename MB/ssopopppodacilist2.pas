unit SSOPOPPPodaciList2;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  LR_Class, LR_DBSet, ZDataset;

type

  { TfrmSOPOPPPodaciList2 }

  TfrmSOPOPPPodaciList2 = class(TForm)
    dsMaster: TfrDBDataSet;
    frReport: TfrReport;
    qrMaster: TZQuery;
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  frmSOPOPPPodaciList2: TfrmSOPOPPPodaciList2;

implementation

initialization
  {$I ssopopppodacilist2.lrs}

end.

