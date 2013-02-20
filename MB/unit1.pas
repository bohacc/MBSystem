unit Unit1; 

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls, blcksock, smtpsend, pop3send, IpHtml, Ipfilebroker, synachar,
  mimemess, MimePart;

type
  ESMTP = class (Exception);
  EPOP3 = class (Exception);

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Memo2: TMemo;
    Memo1: TMemo;
    Memo3: TMemo;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  Form1: TForm1; 

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.Button1Click(Sender: TObject);
var
  pop3: TPOP3Send;
  i: integer;
begin
  pop3 := TPOP3Send.Create();
  try
    pop3.AutoTLS := false;
    pop3.Username:='m.bohacc';
    pop3.Password:='mata553';
    pop3.TargetHost:='pop3.seznam.cz';
    pop3.TargetPort := '995';
    pop3.FullSSL := true;
    pop3.Sock.SSL.SSLType := LT_SSLv3;

    pop3.Sock.SSLDoConnect();
    if not pop3.Login() then
      raise EPOP3.Create('POP3 ERROR: Login');

    //AddToLog('POP3 Stat');
    if not pop3.Stat() then
      raise EPOP3.Create('POP3 ERROR: stat');
    //AddToLog('Stat: '+IntToStr(pop3.StatCount)+' msgs');
    for i := 1 to pop3.StatCount do begin
      //AddToLog('POP3 Retr(' + IntToStr(i) + ')');
      if not pop3.Retr(i) then
        raise EPOP3.Create('POP3 ERROR: retr(' + IntToStr(i) + ')');
      Memo2.lines.Add(' ');
      Memo2.lines.Add('*** POP3 Retr(' + IntToStr(i) + ') *******');
      Memo2.lines.AddStrings(pop3.FullResult);
      pop3.FullResult.SaveToFile('mail_' + IntToStr(i) + '.msg');
      //if not pop3.Dele(i) then
      //  raise EPOP3.Create('POP3 ERROR: dele(' + IntToStr(i) + ')');
    end;

  finally
    pop3.Free;
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  pop:TPOP3Send;
  i : Integer;
  MIME : TMimeMess;
  memo4 : TMemo;
  part : Tmimepart;
begin
  pop:=TPOP3Send.create;
  Memo2.Clear;
  Memo1.Clear;
  Memo3.Clear;
  MIME :=TMimeMess.Create;
  Memo4:=TMemo.Create(nil);
  part:=Tmimepart.Create;
  try
    pop.AutoTLS := true;
    pop.Username:='m.bohacc';
    pop.Password:='mata553';
    pop.TargetHost:='pop3.seznam.cz';
    pop.AuthType:=POP3AuthAll;
    pop.login;
    pop.list(0);
    if pop.Stat then
    begin
      for i:=1 to pop .StatCount do
      begin
        pop.Retr(i);
        //Memo3.Lines.Add(MIME.MessagePart.Charset);
        MIME.Lines.Text:=pop.FullResult.Text;
        MIME.DecodeMessage;
        MIME.MessagePart.DecodePart;
        memo4.Lines.LoadFromStream(MIME.MessagePart.DecodedLines);
        Memo3.Lines.Add(Memo4.Text);
        Memo2.Lines.Add(MIME.MessagePart.Headers.Text);
        Memo1.Lines.Add(MIME.MessagePart.PartBody.Text);
        Memo2.Lines.Add('----------------------------------------------');
        Memo1.Lines.Add('----------------------------------------------');
      end;
    end;
    pop.logout;
  finally
    pop.free;
    MIME.Free;
    memo4.Free;
    part.Free;
  end;

end;

{
var
  pop : Tpop3send;
begin
    pop.AutoTLS := true;
    pop.AuthType:=POP3AuthAll;
    pop.TargetPort := '110';
    pop.Username:='bohacc';
    pop.Password:='mata553';
    pop.TargetHost:='pop3.seznam.cz';
end;
}

end.

