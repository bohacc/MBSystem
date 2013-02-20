unit fsbezudajuplatby;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  LR_Class, LR_DBSet, ZDataset;

type

  { TfrmSBezUdajuPlatby }

  TfrmSBezUdajuPlatby = class(TForm)
    dsMaster: TfrDBDataSet;
    frReport: TfrReport;
    qrMaster: TZQuery;
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  frmSBezUdajuPlatby: TfrmSBezUdajuPlatby;

implementation

initialization
  {$I fsbezudajuplatby.lrs}

end.

