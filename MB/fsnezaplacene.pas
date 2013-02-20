unit FSNezaplacene;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  LR_Class, LR_DBSet, ZDataset;

type

  { TfrmSNezaplacene }

  TfrmSNezaplacene = class(TForm)
    dsMaster: TfrDBDataSet;
    frReport: TfrReport;
    qrMaster: TZQuery;
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  frmSNezaplacene: TfrmSNezaplacene;

implementation

initialization
  {$I fsnezaplacene.lrs}

end.

