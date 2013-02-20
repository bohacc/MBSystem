unit fsbez_guidu;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  LR_Class, LR_DBSet, ZDataset;

type

  { TfrmSBezGuidu }

  TfrmSBezGuidu = class(TForm)
    dsMaster: TfrDBDataSet;
    frReport: TfrReport;
    qrMaster: TZQuery;
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  frmSBezGuidu: TfrmSBezGuidu;

implementation

initialization
  {$I fsbez_guidu.lrs}

end.

