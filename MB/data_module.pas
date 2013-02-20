unit Data_module;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Dialogs,
  ZConnection, sqldb, OracleConnection, db;

type

  { TDM }

  TDM = class(TDataModule)
    OracleConnection: TZConnection;
    procedure DataModuleCreate(Sender: TObject);
    procedure OracleConnectionAfterConnect(Sender: TObject);
    procedure OracleConnection2Login(Sender: TObject; Username, Password: string
      );
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  DM: TDM;

implementation

{ TDM }

procedure TDM.DataModuleCreate(Sender: TObject);
begin

end;

procedure TDM.OracleConnectionAfterConnect(Sender: TObject);
begin

end;

procedure TDM.OracleConnection2Login(Sender: TObject; Username, Password: string
  );
begin

end;

initialization
  {$I data_module.lrs}

end.

