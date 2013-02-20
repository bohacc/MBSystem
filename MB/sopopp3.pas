unit sopopp3;

{$mode delphi}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  LR_Class, LR_DBSet, ZDataset, LR_DSet;

type

  { TfrmSOPOPP3 }

  TfrmSOPOPP3 = class(TForm)
    dsMaster: TfrDBDataSet;
    frReport: TfrReport;
    qrMaster: TZQuery;
    procedure dsMasterCheckEOF(Sender: TObject; var Eof: Boolean);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  frmSOPOPP3: TfrmSOPOPP3;

implementation

{ TfrmSOPOPP3 }

procedure TfrmSOPOPP3.dsMasterCheckEOF(Sender: TObject; var Eof: Boolean);
begin

end;

initialization
  {$I sopopp3.lrs}

end.

