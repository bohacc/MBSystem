unit svyplatni_listina; 

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  LR_Class, LR_DBSet, sqldb;

type

  { TfrmVyplatniListina }

  TfrmVyplatniListina = class(TForm)
    frDBDataSet1: TfrDBDataSet;
    quickrep1: TfrReport;
    qrMaster: TSQLQuery;
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  frmVyplatniListina: TfrmVyplatniListina;

implementation

initialization
  {$I svyplatni_listina.lrs}

end.

