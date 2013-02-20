unit SOznameniPostupiteleOPostoupeniPohledavky;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, sqldb, db, FileUtil, LResources, Forms, Controls, Graphics,
  Dialogs, LR_Class, LR_DBSet, LR_DSet, LR_Desgn, LR_PGrid, ZDataset;

type

  { TfrmSOznameniPostupiteleOPostoupeniPohledavky }

  TfrmSOznameniPostupiteleOPostoupeniPohledavky = class(TForm)
    dsMaster: TfrDBDataSet;
    frReport: TfrReport;
    qrMaster: TZQuery;
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  frmSOznameniPostupiteleOPostoupeniPohledavky: TfrmSOznameniPostupiteleOPostoupeniPohledavky;

implementation

{ TfrmSOznameniPostupiteleOPostoupeniPohledavky }


initialization
  {$I soznamenipostupiteleopostoupenipohledavky.lrs}

end.

