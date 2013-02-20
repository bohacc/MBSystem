unit fszaplacene;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  LR_Class, LR_DBSet, ZDataset;

type

  { TfrmSZaplacene }

  TfrmSZaplacene = class(TForm)
    dsMaster: TfrDBDataSet;
    frReport: TfrReport;
    qrMaster: TZQuery;
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  frmSZaplacene: TfrmSZaplacene;

implementation

initialization
  {$I fszaplacene.lrs}

end.

