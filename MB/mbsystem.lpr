program mbsystem;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms
  { you can add units after this },
  FMain, SQLDBLaz, uConsts, Utils, uConstsMenu, FAkcionari, ftypy_akcii, fpsc,
  FFirma, flogin, fsablona, Data_module, fakcie, sseznam_akcionaru,
  svypis_akcionare, sSoucetAkciiZaTypAll, sseznam_akcionaru3,
  svyplatni_listina3, svyplatni_listina2, svyplatni_listina, ssouhrn_akcii2,
  dprevod_akcie, sseznam_akcionaru2, shistorie_akcie, sstitky2, sstitky,
  ssouhrn_akcii, dakcie_pohyb, uProc, lazreport, SDFLaz,
  RunTimeTypeInfoControls, laz_synapse, fheslo, dheslo, dpoznamka, FPartneri,
  fpartneriosoby, fpartneriadresy, fpartnerispojeni, fdanovesazby, fprodukty,
  fnabidky, fukoly, fudalosti, fprilohy, FZaloby,
  SOznameniPostupiteleOPostoupeniPohledavky, DUzamknoutZaloby,
  DOznameniPostupiteleOPostoupeniPohledavky, DDatum, FSOPOPPPodaciList,
  FSopopppredavaciprotokol, dproces, FZalobyHistorie, dpop3pripojeni,
  FZalobyTypyZprav, DZpravyDetail, zcomponent, FParametry, cestina,
  SSOPOPPPodaciList2, SProc, fzalobyarchiv, FZaloby_ostatni, fskzaplaceni,
  FSNezaplacene, fszaplacene, fsbez_guidu, fsbezudajuplatby, dprocesquery,
  dprogram, FChybneObjekty, ssopopppodacilist3, fzalobymlcoch,
  dpoznamkaUsneseni, SOPOPP2, SExekuce, sopopp3, snesparovane_zpravy, FSestavy;

//{$IFDEF WINDOWS}{$R mbsystem.rc}{$ENDIF}

//{$IFDEF WINDOWS}{$R manifest.rc}{$ENDIF}

{$R *.res}

begin
  Application.Title:='MB system';
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TDM, DM);
  Application.ShowMainForm:=False;
  Application.CreateForm(TfrmLogin, frmLogin);
    frmLogin.ShowModal;
    frmLogin.Free;
  Application.CreateForm(TfrmSestavy, frmSestavy);
  Application.Run;
end.

