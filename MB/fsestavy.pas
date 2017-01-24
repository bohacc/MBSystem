unit FSestavy;

{$mode delphi}

interface

uses
  Classes, SysUtils, sqldb, db, FileUtil, LResources, Forms, Controls, Graphics,
  Dialogs, ZDataset, LR_Class, LR_DBSet;

type

  { TfrmSestavy }

  TfrmSestavy = class(TForm)
    dsMaster: TfrDBDataSet;
    frReport: TfrReport;
    qrMaster: TZQuery;
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  frmSestavy: TfrmSestavy;

implementation

initialization
  {$I fsestavy.lrs}

end.

