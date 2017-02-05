unit fskzaplaceni_sumar;

{$mode delphi}

interface

uses
  Classes, SysUtils, FileUtil, ZDataset, LR_Class, LR_DBSet, LResources, Forms,
  Controls, Graphics, Dialogs, LR_DSet;

type

  { TfrmSKuhradeSumar }

  TfrmSKuhradeSumar = class(TForm)
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
  frmSKuhradeSumar: TfrmSKuhradeSumar;

implementation

{ TfrmSKuhradeSumar }

procedure TfrmSKuhradeSumar.dsMasterCheckEOF(Sender: TObject; var Eof: Boolean);
begin

end;

initialization
  {$I fskzaplaceni_sumar.lrs}

end.

