unit SOznameniPostupiteleOPostoupeniPohledavkyOzn;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, sqldb, FileUtil, LResources, Forms, Controls, Graphics,
  Dialogs, LR_Class;

type

  { TfrmSOznameniPostupiteleOPostoupeniPohledavkyOzn }

  TfrmSOznameniPostupiteleOPostoupeniPohledavkyOzn = class(TForm)
    frReport1: TfrReport;
    qrMaster: TSQLQuery;
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  frmSOznameniPostupiteleOPostoupeniPohledavkyOzn: TfrmSOznameniPostupiteleOPostoupeniPohledavkyOzn;

implementation

initialization
  {$I soznamenipostupiteleopostoupenipohledavkyozn.lrs}

end.

