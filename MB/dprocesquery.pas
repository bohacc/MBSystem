unit dprocesquery;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  ExtCtrls, StdCtrls;

type

  { TfrmProcesQuery }

  TfrmProcesQuery = class(TForm)
    Bevel1: TBevel;
    Label1: TLabel;
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  frmProcesQuery: TfrmProcesQuery;

implementation

initialization
  {$I dprocesquery.lrs}

end.

