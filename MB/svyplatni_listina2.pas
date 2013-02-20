unit svyplatni_listina2; 

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  sqldb, LR_Class, LR_DBSet;

type

  { TfrmVyplatniListina2 }

  TfrmVyplatniListina2 = class(TForm)
    frDBDataSet1: TfrDBDataSet;
    quickrep1: TfrReport;
    qrMaster: TSQLQuery;
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  frmVyplatniListina2: TfrmVyplatniListina2;

implementation

initialization
  {$I svyplatni_listina2.lrs}

end.

