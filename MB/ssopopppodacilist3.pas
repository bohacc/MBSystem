unit ssopopppodacilist3;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  LR_Class, LR_DBSet, ZDataset;

type

  { TfrmSOPOPPPodaciList3 }

  TfrmSOPOPPPodaciList3 = class(TForm)
    dsMaster: TfrDBDataSet;
    frReport: TfrReport;
    qrMaster: TZQuery;
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  frmSOPOPPPodaciList3: TfrmSOPOPPPodaciList3;

implementation

initialization
  {$I ssopopppodacilist3.lrs}

end.

