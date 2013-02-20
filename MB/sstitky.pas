unit sstitky; 

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  LR_Class, LR_DBSet, sqldb;

type

  { TfrmStitkyI }

  TfrmStitkyI = class(TForm)
    frDBDataSet1: TfrDBDataSet;
    quickrep1: TfrReport;
    qrMaster: TSQLQuery;
    procedure FormCreate(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  frmStitkyI: TfrmStitkyI;

implementation

{ TfrmStitkyI }

procedure TfrmStitkyI.FormCreate(Sender: TObject);
begin

end;

initialization
  {$I sstitky.lrs}

end.

