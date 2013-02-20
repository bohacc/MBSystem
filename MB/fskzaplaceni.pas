unit fskzaplaceni;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  LR_Class, LR_DBSet, ZDataset;

type

  { TfrmSKUhrade }

  TfrmSKUhrade = class(TForm)
    dsMaster: TfrDBDataSet;
    frReport: TfrReport;
    qrMaster: TZQuery;
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  frmSKUhrade: TfrmSKUhrade;

implementation

initialization
  {$I fskzaplaceni.lrs}

end.

