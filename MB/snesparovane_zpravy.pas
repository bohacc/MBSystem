unit snesparovane_zpravy;

{$mode delphi}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  ZDataset, LR_DBSet, LR_Class, LR_DSet;

type

  { TfrmNesparovaneZpravy }

  TfrmNesparovaneZpravy = class(TForm)
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
  frmNesparovaneZpravy: TfrmNesparovaneZpravy;

implementation

{ TfrmNesparovaneZpravy }

procedure TfrmNesparovaneZpravy.dsMasterCheckEOF(Sender: TObject;
  var Eof: Boolean);
begin

end;

initialization
  {$I snesparovane_zpravy.lrs}

end.

