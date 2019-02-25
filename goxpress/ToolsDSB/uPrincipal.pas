unit uPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Label1: TLabel;
    GroupBox1: TGroupBox;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses uCNAB, uLoadFile;

procedure TForm1.Button1Click(Sender: TObject);
begin
    frmCNAB.GerarArquivoTesteCNAB;
end;

procedure TForm1.FormCreate(Sender: TObject);
var LoadFile : TLoadFile;
    Params:TLoadFileParams;
    function Add(Campo, Valor:string; Posicao, Tamanho:Integer):Boolean;
    begin
        Params.Name     := Campo;
        Params.Valor    := Valor;
        Params.Posicao  := Posicao;
        Params.Tamanho  := Tamanho;
        LoadFile.Add(Params);
    end;
begin
    try
        LoadFile := TLoadFile.Create;
        //LoadFile.LoadFromFile('C:\Temp\TesteRemessa.txt');

        Add('Contato','Teste', 10, 20);
        Add('Fixo','Teste', 10, 20);
        Add('Celular','Teste', 10, 20);

        //LoadFile.SaveFromFile('C:\Temp\TemplateVariavel.txt');
    finally
        FreeAndNil(LoadFile);
    end;
end;

end.