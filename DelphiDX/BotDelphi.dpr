program BotDelphi;

uses
  Vcl.Forms,
  uPrincipal in 'Principal\uPrincipal.pas' {Form2},
  uSISDebug in 'Libs\uSISDebug.pas',
  udmConexao in 'Principal\udmConexao.pas' {dmConexao: TDataModule};

{$R *.res}

begin
    CreateDebug;

  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TdmConexao, dmConexao);
  Application.Run;
end.
