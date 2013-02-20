unit svyplatni_listina3; 

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  LR_Class, LR_DBSet, sqldb;

type

  { TfrmVyplatniListina3 }

  TfrmVyplatniListina3 = class(TForm)
    frDBDataSet1: TfrDBDataSet;
    quickrep1: TfrReport;
    qrMaster: TSQLQuery;
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  frmVyplatniListina3: TfrmVyplatniListina3;

implementation

initialization
  {$I svyplatni_listina3.lrs}

end.

