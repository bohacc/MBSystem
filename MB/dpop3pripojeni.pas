unit dpop3pripojeni;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  StdCtrls;

type

  { Tfrmpop3pripojeni }

  Tfrmpop3pripojeni = class(TForm)
    Button1: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Label1: TLabel;
    Label2: TLabel;
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  frmpop3pripojeni: Tfrmpop3pripojeni;

implementation

initialization
  {$I dpop3pripojeni.lrs}

end.

