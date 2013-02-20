unit uStoredProc; 

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Data_module;

implementation

function Get_Cislo_Dokladu(_Typ : Integer; _Rok : Integer) : Integer;
var
_StoredProc : TStoredProc;
begin
_StoredProc:=nil;
 try
   _StoredProc:=TStoredProc.Create(nil);
   _StoredProc.DatabaseName:=DM.Database.DatabaseName;
   _StoredProc.SessionName:=DM.Session.SessionName;
   _StoredProc.StoredProcName:='GET_CISLO_DOKLADU';
   _StoredProc.Params.CreateParam(ftInteger,'aTyp',ptInput).AsInteger:=_Typ;
   _StoredProc.Params.CreateParam(ftInteger,'aRok',ptInput).AsInteger:=_Rok;
   _StoredProc.Params.CreateParam(ftInteger,'aVystup',ptOutput);
   _StoredProc.ExecProc;

   Result := _StoredProc.Params.ParamValues['aVystup'];// _Vystup;
 finally
   if Assigned(_StoredProc) then
   begin
     _StoredProc.Free;
     _StoredProc:=nil;
   end;
 end;
end;

function Get_crypt_password(_Password : string) : string;
var
_StoredProc : TStoredProc;
begin
_StoredProc:=nil;
 try
   _StoredProc:=TStoredProc.Create(nil);
   _StoredProc.DatabaseName:=DM.Database.DatabaseName;
   _StoredProc.SessionName:=DM.Session.SessionName;
   _StoredProc.StoredProcName:='GET_CRYPT_PASSWORD';
   _StoredProc.Params.CreateParam(ftString,'aPassword',ptInput).AsString:=_Password;
   _StoredProc.Params.CreateParam(ftString,'aVystup',ptOutput);
   _StoredProc.ExecProc;

   Result := _StoredProc.Params.ParamValues['aVystup'];// _Vystup;
 finally
   if Assigned(_StoredProc) then
   begin
     _StoredProc.Free;
     _StoredProc:=nil;
   end;
 end;
end;

procedure Prevod_akcie(_ID_AKCIE : integer; _ID_AKCIONARE : integer; _DOKLAD : String; _DATUM : TDateTime; _SLOUCIT : Integer; _SQL : string);
var
_StoredProc : TStoredProc;
begin
_StoredProc:=nil;
 try
   _StoredProc:=TStoredProc.Create(nil);
   _StoredProc.DatabaseName:=DM.Database.DatabaseName;
   _StoredProc.SessionName:=DM.Session.SessionName;
   _StoredProc.StoredProcName:='PREVOD_AKCIE';
   _StoredProc.Params.CreateParam(ftInteger,'aID_AKCIE',ptInput).AsInteger:=_ID_AKCIE;
   _StoredProc.Params.CreateParam(ftInteger,'aID_AKCIONARE',ptInput).AsInteger:=_ID_AKCIONARE;
   _StoredProc.Params.CreateParam(ftString,'aDOKLAD',ptInput).AsString:=_DOKLAD;
   _StoredProc.Params.CreateParam(ftDateTime,'aDATUM',ptInput).AsDateTime:=_DATUM;
   _StoredProc.Params.CreateParam(ftInteger,'aSLOUCIT',ptInput).AsInteger:=_SLOUCIT;
   _StoredProc.Params.CreateParam(ftString,'aSQL',ptInput).AsString:=_SQL;
   _StoredProc.ExecProc;

 finally
   if Assigned(_StoredProc) then
   begin
     _StoredProc.Free;
     _StoredProc:=nil;
   end;
 end;
end;

function Get_NewID : Integer;
var
_StoredProc : TStoredProc;
begin
_StoredProc:=nil;
 try
   _StoredProc:=TStoredProc.Create(nil);
   _StoredProc.DatabaseName:=DM.Database.DatabaseName;
   _StoredProc.SessionName:=DM.Session.SessionName;
   _StoredProc.StoredProcName:='GET_NEWID';
   _StoredProc.Params.CreateParam(ftInteger,'Result', ptResult);
   _StoredProc.ExecProc;

   Result := _StoredProc.ParamByName('Result').asInteger;
 finally
   if Assigned(_StoredProc) then
   begin
     _StoredProc.Free;
     _StoredProc:=nil;
   end;
 end;
end;

function Get_param(_Kod : string) : String;
var
_StoredProc : TStoredProc;
begin
_StoredProc:=nil;
 try
   _StoredProc:=TStoredProc.Create(nil);
   _StoredProc.DatabaseName:=DM.Database.DatabaseName;
   _StoredProc.SessionName:=DM.Session.SessionName;
   _StoredProc.StoredProcName:='GET_PARAM';
   _StoredProc.Params.CreateParam(ftString,'aKOD',ptInput).AsString:=_KOD;
   _StoredProc.Params.CreateParam(ftString,'Result', ptResult);
   _StoredProc.ExecProc;

   Result := _StoredProc.ParamByName('Result').asString;
 finally
   if Assigned(_StoredProc) then
   begin
     _StoredProc.Free;
     _StoredProc:=nil;
   end;
 end;
end;

end.

