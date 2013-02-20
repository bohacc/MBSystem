unit FZalobyHistorie;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, sqldb, FileUtil, LResources, Forms, Controls, Graphics,
  Dialogs, ExtCtrls, StdCtrls, DBGrids, ZDataset;

type

  { TfrmZalobyHistorie }

  TfrmZalobyHistorie = class(TForm)
    Button1: TButton;
    dsMaster: TDatasource;
    DBGrid1: TDBGrid;
    Panel1: TPanel;
    qrMaster: TZQuery;
    procedure FormShow(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  frmZalobyHistorie: TfrmZalobyHistorie;

implementation

{ TfrmZalobyHistorie }

procedure TfrmZalobyHistorie.FormShow(Sender: TObject);
begin
  qrMaster.Close;
  qrMaster.Open;
end;

initialization
  {$I fzalobyhistorie.lrs}

end.

