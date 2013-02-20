unit SOPOPP2;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, sqldb, db, FileUtil, LResources, Forms, Controls, Graphics,
  Dialogs, LR_Class, LR_DBSet, LR_DSet, LR_Desgn, LR_PGrid, ZDataset;

type

  { TfrmSOPOPP2 }

  TfrmSOPOPP2 = class(TForm)
    dsMaster: TfrDBDataSet;
    frReport: TfrReport;
    qrMaster: TZQuery;
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  frmSOPOPP2: TfrmSOPOPP2;

implementation

{ TfrmSOPOPP2 }


initialization
  {$I sopopp2.lrs}

end.

