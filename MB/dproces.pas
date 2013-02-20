unit dproces;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  StdCtrls, ComCtrls, ExtCtrls;

type

  { TfrmProces }

  TfrmProces = class(TForm)
    Bevel1: TBevel;
    lbPom: TLabel;
    lbProces: TLabel;
    ProgressBar1: TProgressBar;
    procedure FormDeactivate(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  frmProces: TfrmProces;

implementation

{ TfrmProces }

procedure TfrmProces.FormDeactivate(Sender: TObject);
begin

end;

initialization
  {$I dproces.lrs}

end.

