unit SProc;

{$mode objfpc}{$H+}

interface

uses ZStoredProcedure, Classes, SysUtils;

procedure zaloby_presunout_do_archivu;

implementation

uses data_module;

procedure zaloby_presunout_do_archivu;
var
  proc : TZStoredProc;
begin
  proc.Connection:=data_module.DM.OracleConnection;
  proc.StoredProcName:='zaloby_presunout_do_archivu';
  proc.ExecProc;
  proc.Open;
end;

end.

