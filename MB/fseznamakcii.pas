unit FSeznamAkcii;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs, 
    fsablona; 

type
  TfrmSeznamAkcii = class(TfrmSablona)
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  frmSeznamAkcii: TfrmSeznamAkcii;

implementation

initialization
  {$I fseznamakcii.lrs}

end.

