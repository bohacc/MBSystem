unit FDataModule; 

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  OracleConnection;

type

  { TfrmDataModule }

  TfrmDataModule = class(TForm)
    OracleConnection1: TOracleConnection;
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  frmDataModule: TfrmDataModule;

implementation

initialization
  {$I fdatamodule.lrs}

end.

