unit uSISDebug;

{
    DATA: 16/11/201/ 11:52
    DESTINADA A PARAMETROS PARA EXECU��O DE DEBUGS
    ELIO GON�ALVES DE LIMA

    obs:
        function CreateDebug(true ou false) - inicializa a variavel SIS
            classe principal para debug e testes

        CreateDebug(true, 'TESTES', '845.073.012-03','4040');

        SIS.Lib - indica fun��o globais ou genericas de tratamentos de dados



var Key:Char;
begin
    Key := #13;
    tmDebug.Enabled := False;

    if (SISDebug.Ativo) then begin

        EditNome.Text   := SISDebug.LoginDOC;
        EditNomeKeyPress(Sender, Key);

        EditPass.Text   := SISDebug.LoginSenha;
        EditPassKeyPress(Sender, Key);

        cboServidor.Items.Clear;
        cboServidor.Items.Add(SISDebug.LoginServidor);
        cboServidor.ItemIndex := cboServidor.Items.Count-1;
        cboServidorSelect(Sender);
        cboServidorKeyPress(Sender, Key);

        BitBtn1Click(Sender);

    end;

}
interface

uses
  Windows, SysUtils, Classes, Graphics, Forms, iniFiles, ShellAPI, TlHelp32,
  ComCtrls, WinInet, Math, dialogs, ClipBrd, StrUtils,
  DB, Messages, Variants, Controls, StdCtrls, ExtCtrls, jpeg,
  Zlib, ShlObj, ActiveX, ComObj, Registry, DBClient, SConnect, IdHTTP,
  IdSSLOpenSSLHeaders, IdSSL, IdSSLOpenSSL, RecError, SqlExpr;

  const
    cMsgCmdExecSucesso = 'Comando executado com sucesso!';
    SISFormatFloat = '###########0.00';
    SISFormatDBDatetimeFB = 'mm/dd/yyyy';

type

    TSISReturn = class
  private
    function getSucesso: Boolean;
        public
            Erro:Boolean;
            Mensagem:string;
            Texto:string;
            SQL:string;
            procedure ShowMessage(MensagemNova: string = '');
            procedure ShowErro(VisualizaErro: Boolean = True; MensagemNova: string = '');
            function IsMatriz(Abortar:Boolean = False;  ShowMsg:Boolean = False; Msg:string = ''): Boolean;
            property Sucesso:Boolean read getSucesso;
    end;



    TSISVars = class
        public
            FAtivo: Boolean;
    end;


    TSISLib = class(TSISVars)
    private
    procedure PostError(DataSet: TDataSet; E: EDatabaseError;
      var Action: TDataAction);

    procedure ReconcileError(DataSet: TCustomClientDataSet; E: EReconcileError;
      UpdateKind: TUpdateKind; var Action: TReconcileAction);

        function subStringExists(texto, substring: String): Boolean;
        function IsEmptyVariant(const Value: Variant): Boolean;

    public

        constructor Create;
        function FormUpdates(Objeto: TForm): Boolean; overload;
        function FormUpdates(Objeto: TDataModule): Boolean; overload;

        function ToFloatDB(value: double): string;
        // ClientDataSet
        function Query(SQLQ: TSQLQuery; sSQL: string): Boolean; overload;

        function Query(CDS:TClientDataSet; sSQL:string):Boolean; overload;
        function Query(Pai:TComponent; Conexao: TSocketConnection; sSQL: string): TClientDataSet; overload;

        procedure OrdernarClientDataSet(CDS: TClientDataSet; ColunaFieldName: String);

        function len(str:String):Integer;
        function lenBool(value:String):Boolean; Overload;
        function lenBool(value:Integer):Boolean; Overload;
        function lenBool(FArray:array of string):Boolean; Overload;

        function HexToString(H: String): String; overload;
        function StringToHex(S: String): String; overload;

        function MaxDec(H: String): String;
        function MaxCod(S: String): String;

        function ChecaDir(sDir:String):Boolean;
        procedure LimpaDir(Diretorio: string);

        function GravarArquivoTexto(FileName:String; Texto:String):Boolean;
        function LeArquivoTexto(FileName:String):String;
        procedure Explode(linha, Spr: String; var Comp: TStringList);

        function asp(value:string):string;
        function MsgConfirmacao(Mensagem:string):Boolean;
        function Msg(Mensagem: string): Boolean;

        function ToInt(value:string):Int64;
        function ToIntStr(value:string):string;
        function ToDate(value:string; formato:string):TDate;
        function ToDateTime(value:string; formato:string = 'dd/mm/yyyy hh:nn'):TDateTime;

        function ToFloat(value:string; round:Integer = 2): Double;
        function ObterTermo(APosicao: Integer; ASeparador,ALinha: String): String;

        function ReplaceSoNumero(value: string):String;
        function ChkSoNumero(value: string):boolean;
        function ImprimeCNPJ(CNPJ: string): string;
        function ImprimeCPF(CPF: string): string;
        function isCPF(value: string): boolean;
        function isCNPJ(value: string): boolean;
        Function ReplaceStr(Text, oldstring, newstring:string):string;
        function FileToString(FileName:string):TSISReturn;

        function ifthen(value:Boolean; Verdadeiro, Falso:Integer):Integer; overload;
        function ifthen(value:Boolean; Verdadeiro, Falso:string):string; overload;

        function LimpaStrDB(value: string): string;
        function LimpaString(str:String):String;

        function ReadIniStr(FileName:String; Chave:String; Campo:String; Value:String = ''):String;
        Procedure WriteIniStr(FileName:String; Chave:String; Campo:String; Value:String);
        function ReadIniInt(FileName:String; Chave:String; Campo:String; Value:String = ''):Integer;

        Procedure WriteIni(FileName:String; Chave:String; Campo:String; Value:Boolean); overload;
        Procedure WriteIni(FileName:String; Chave:String; Campo:String; Value:Integer); overload;
        Procedure WriteIni(FileName:String; Chave:String; Campo:String; Value:String); overload;
        Procedure WriteIni(FileName:String; Chave:String; Campo:String; Value:TDateTime); overload;

        function ToStr(value:Double; decimal:string = ','):string; overload;
        function ToStr(value:Int64):string; overload;

  end;

  TSISLibTel = class(TSISLib)
        public
            DDD:string;
            NUMERO:string;
            VALOR:string;
            function Check(vValor:string):Boolean;
    end;


  TSISSQLTipoTP = (tstInt, tstInt64, tstString, tstDatetime, tstFloat);

  TSISSQLTipo = class(TSISLib)

        public
            Valor:string;
            FormatoData:string;
            Tipo:TSISSQLTipoTP;
            ValorString:string;
            ValorDateTime:TDateTime;
            ValorFloat:Double;

            function getString: string;
            function getInt:Integer;
            function getDatetime:TDateTime;
            function getFloat:Double;

  end;

  TSISSQLTipoExecute = (tsteInsert, tsteUpdate, tsteDelete);

  TSISSQL = class(TSISLib)
    private
        FResultado: TSISReturn;

        FNomeTabela:string;
        FNomeMetodo: TSISSQLTipoExecute;
        FWhere:string;

        FCampos:array of TSISSQLTipo;
        FValores:array of TSISSQLTipo;
        FExecute:Boolean;
        SQLQ:TSQLQuery;

    procedure setSQLQ(pSQLQ: TSQLQuery);

        procedure setNomeMetodo(const Value: TSISSQLTipoExecute);
        procedure setNomeTabela(const Value: string);
        procedure setWhere(const Value: string);
        function FAddSQL(campo:string; valor:string; Tipo:TSISSQLTipoTP):TSISReturn;

        function getSQLInsert(Tabela:string): TSISReturn;
        function getSQLUpdate(Tabela, Where:string): TSISReturn;
        function ExecutarSQLQ(sSQL:string): TSISReturn;
    public


        constructor Create;

        procedure Clear;
        property Resultado:TSISReturn read FResultado;
        property NomeTabela:string read FNomeTabela write setNomeTabela;
        property NomeMetodo:TSISSQLTipoExecute read FNomeMetodo write setNomeMetodo;
        property Where:string read FWhere write setWhere;
        function AddSQL(campo:string; valor:string; Tipo:TSISSQLTipoTP = tstString):TSISReturn; overload;
        function AddSQL(campo:string; valor:Integer; Tipo:TSISSQLTipoTP = tstInt):TSISReturn; overload;
        function AddSQL(campo:string; valor: Int64; Tipo: TSISSQLTipoTP = tstInt64): TSISReturn; overload;
        function AddSQL(campo:string; valor: Double; Tipo: TSISSQLTipoTP; Formato:String): TSISReturn; overload;
        function setFormatoDate(campo, Formato:string): TSISReturn;
  end;


  TSISPaths = class(TSISSQL)
    public
        LibPath:string;
        LogPath:string;
        constructor Create;

  end;

  TSISFiles = class(TSISPaths)
    public
        LogFile:string;
        constructor Create;
  end;

  TSISJSON = class(TSISLib)

  public
            Response:string;
            HttpStatus:Integer;
  end;

    TSISHttpResponse = class(TSISLib)
  private
    FErro: Boolean;
    procedure setErro(const Value: Boolean);
    procedure setSucesso(const Value: Boolean);
    function GetSucesso: Boolean;
        public
            Response:string;
            HttpStatus:Integer;
            property Erro:Boolean read FErro write setErro;
            property Sucesso:Boolean read GetSucesso write setSucesso;
    end;

    type
        TSISHttpCustomHeaders = record
            Name:string;
            Value:string;
    end;

//    TSISHttp = class(TSISLib)
//            FSSL: TIdSSLIOHandlerSocketOpenSSL;
//            FHttp: TIdHTTP;
//        private
//            FCustomHeaders:array of TSISHttpCustomHeaders;
//
//            function CreateFHttp:Boolean;
//        public
//            HttpResponse:TSISHttpResponse;
//
//            constructor Create;
//            function Post(URL: string; strParams:string): TSISHttpResponse;
//            function HeaderAdd(Name, value:string):Boolean;
//            function HeaderClear: Boolean;
//    end;

    TSISHttp = class(TSISLib)
            FSSL: TIdSSLIOHandlerSocketOpenSSL;
            FHttp: TIdHTTP;
        private
            FCustomHeaders:array of TSISHttpCustomHeaders;

            function CreateFHttp:Boolean;
        public
            HttpResponse:TSISHttpResponse;

            constructor Create;
            function Post(URL: string; strParams:string): TSISHttpResponse;
            function Get(const Url: string): TSISHttpResponse;
            function HeaderAdd(Name, value:string):Boolean;
            function HeaderClear: Boolean;
    end;

  TTEMP = RECORD
    MENSAGEM_RETORNO:string;
  end;

  TSISUsuario = record
      Codigo:Integer;
      Nome:string;
  end;

  TSISDebug = class(TSISFiles)
  private
    procedure SetAtivo(const Value: Boolean);
    Public
        Usuario:TSISUsuario;
        TEMP:TTEMP;
        IniFileSistema:string;
        LoginDOC:string;
        LoginSenha:string;
        LoginServidor:string;
        FinalizaAplicacao:Boolean;
        DirSaveCNAB:string;

        HTTP:TSISHttp;
        Telefone:TSISLibTel;
        SQL:TSISSQL;
        constructor Create(pAtivo:Boolean);
        function AddLog(value: string): Boolean; overload;
        function AddLog(FileName:string; value: string): Boolean; overload;
    published
        property Ativo:Boolean read FAtivo write SetAtivo;

  end;

  // fun��es globais
  function fEmptyVariant(const Value: Variant): Boolean;

var
  SISDebug: TSISDebug;

procedure CreateDebug(Ativo: Boolean = false); overload;
procedure CreateDebug(Ativo: Boolean; LoginServidor, LoginDOC, LoginSenha:string); overload;

implementation


procedure CreateDebug(Ativo: Boolean = false);
begin
    Ativo := False;
//    Ativo := True;
    CreateDebug(Ativo ,'' ,'' ,'');

//    CreateDebug(Ativo ,'ZEMATESTE' ,'667.849.135-15' ,'8080');
//    CreateDebug(Ativo ,'KROTON' ,'667.849.135-15' ,'8080');
//    CreateDebug(Ativo ,'TESTES' ,'845.073.012-03' ,'4040');
//    CreateDebug(false ,'OI FRAUDE' ,'845.073.012-03' ,'4040');
//    CreateDebug(false ,'SAO PAU LO', '466.103.218-76','a123s');
    CreateDebug(Ativo ,'TESTE_BF', '216.399.218-77','123456');

end;

procedure CreateDebug(Ativo: Boolean; LoginServidor, LoginDOC, LoginSenha:string);
begin
    SISDebug            := TSISDebug.Create(Ativo);
    SISDebug.LoginServidor  := LoginServidor;
    SISDebug.LoginDOC       := LoginDOC;
    SISDebug.LoginSenha     := LoginSenha;
end;


{ TSISLib }


procedure TSISLib.ReconcileError(
  DataSet: TCustomClientDataSet; E: EReconcileError; UpdateKind: TUpdateKind;
  var Action: TReconcileAction);
begin
    Action := HandleReconcileError(DataSet,UpdateKind,E);
end;

procedure TSISLib.PostError(
  DataSet: TDataSet; E: EDatabaseError; var Action: TDataAction);
begin
    with EDBClient(E) do begin
        if ErrorCode = 9729 then
            MessageDlg('Usu�rio j� cadastrado.', mtError, [mbOK], 0)
        else
            MessageDlg(Message, mtError, [mbOK], 0);
    end;
    Action := daAbort;
end;



function TSISLib.FormUpdates(Objeto:TForm):Boolean;
var
  i: Integer;
begin
    for i := 0 to Objeto.ComponentCount - 1 do begin
        if (Objeto.Components[i].ClassType = TClientDataSet) then begin
            if lenBool((Objeto.Components[i] as TClientDataSet).ProviderName)  then begin
                    (Objeto.Components[i] as TClientDataSet).OnReconcileError    := ReconcileError;
                    (Objeto.Components[i] as TClientDataSet).OnPostError         := PostError;
            end;
        end;
    end;

end;

function TSISLib.FormUpdates(Objeto:TDataModule):Boolean;
var
  i: Integer;
begin
    for i := 0 to Objeto.ComponentCount - 1 do begin
        if (Objeto.Components[i].ClassType = TClientDataSet) then begin
            if lenBool((Objeto.Components[i] as TClientDataSet).ProviderName)  then begin
                    (Objeto.Components[i] as TClientDataSet).OnReconcileError    := ReconcileError;
                    (Objeto.Components[i] as TClientDataSet).OnPostError         := PostError;
            end;
        end;
    end;
end;


function TSISLib.subStringExists(texto, substring:String):Boolean;
begin
    Result := AnsiContainsStr(texto, substring);
end;

function TSISLib.ObterTermo(APosicao: Integer; ASeparador,
  ALinha: String): String;
var sAux: TStringList;
begin
  ALinha := trim(ALinha);
  Result:='';
  sAux:=TStringList.Create;
  sAux.Text:=StringReplace(ALinha,ASeparador,#13#10,[rfReplaceAll, rfIgnoreCase]);
  if APosicao <= sAux.Count then
    Result:= trim(sAux.Strings[APosicao-1]);
  sAux.Free;
end;
procedure TSISLib.OrdernarClientDataSet(CDS: TClientDataSet; ColunaFieldName: String);
var
  vIndice: string;
  vExiste: boolean;
begin
  if CDS.IndexFieldNames = ColunaFieldName then
  begin
    vIndice := AnsiUpperCase(ColunaFieldName + '_INV');

    try
      CDS.IndexDefs.Find(vIndice);
      vExiste := True;
    except
      vExiste := False;
    end;

    if not (vExiste) then
    begin
      with CDS.IndexDefs.AddIndexDef do
      begin
        Name := vIndice;
        Fields := ColunaFieldName;
        Options := [ixDescending];
      end;
    end;

    CDS.IndexName := vIndice;
  end
  else
    CDS.IndexFieldNames := ColunaFieldName;
end;



function TSISLib.Query(SQLQ: TSQLQuery; sSQL: string): Boolean;
begin
     try
        Result := False;
        SQLQ.Close;
        SQLQ.SQL.Clear;
        SQLQ.SQL.Add(sSQL);
        SQLQ.Open;
        Result := (not SQLQ.IsEmpty);
    except
        Result := False;
    end;
end;


function TSISLib.Query(CDS:TClientDataSet; sSQL:string):Boolean;
begin
    try
        Result := False;

        CDS.Close;
        CDS.CommandText := sSQL;
        CDS.Active := True;
        Result := (CDS.RecordCount > 0);
    except
        Result := False;
    end;

end;

function TSISLib.Query(Pai:TComponent; Conexao: TSocketConnection; sSQL: string): TClientDataSet;
begin
    try
        Result := TClientDataSet.Create(Pai);
        Result.Close;
        Result.ConnectionBroker.Connection := Conexao;
        Result.CommandText := sSQL;
        Result.Active := True;
    except
        Result := nil;
    end;
end;

function TSISLib.ToStr(value:Int64):string;
begin
    Result := IntToStr(value);
end;

function TSISLib.ToStr(value:Double; decimal:string = ','):string;
begin

    Result := FormatFloat('#########0.00', value);

    if ((lenBool(decimal)) and (decimal <> ',')) then
        Result := ReplaceStr(Result, ',', decimal);

end;

function TSISLib.len(str:String):Integer;
begin
    Result := length(trim(str));
end;

function TSISLib.lenBool(value:String):Boolean;
begin
    Result := (len(value) > 0);
end;

function TSISLib.lenBool(value:Integer):Boolean;
begin
    Result := (value > 0);
end;


function TSISLib.StringToHex(S: String): String;
var I: Integer;
begin
    try

        for I := 1 to length (S) do
            Result := Result+IntToHex(ord(S[i]),2);

    except
        Result := '';
    end;

end;

function TSISLib.ToDate(value:string; formato:string):TDate;
var d, m, a:string;

begin
    try

        Result := 0;
        value := Trim(value);
        if (not lenBool(value)) then Exit;


        if (formato = 'dd.mm.yyyy') then begin
                d := trim(Copy(value ,1 ,2));
                m := trim(Copy(value ,4 ,2));
                a := trim(Copy(value, 7, 4));

                Result := StrToDate(d+'/'+m+'/'+a);
        end;

    except
        Result := 0;
    end;

end;

function TSISLib.ToDateTime(value:string; formato:string = 'dd/mm/yyyy hh:nn'):TDateTime;
var sDataTemp, d, m, a, h, n:string;
    DataTemp:TDateTime;
begin
    try

        value := Trim(value);
        // 11/12/2018 10:11

        d := trim(Copy(value ,1 ,2));
        m := trim(Copy(value ,4 ,2));
        a := trim(Copy(value, 7, 4));
        a := trim(Copy(value, 7, 4));
        h := trim(Copy(value, 11, 2));
        n := trim(Copy(value, 14, 2));

        sDataTemp := d + '/' + m + '/' + a;
        if (lenBool(h) and lenBool(n)) then
            sDataTemp := sDataTemp + ' ' + h + ':' + n;

        try
            Result := StrToDateTime(sDataTemp);

        except

        end;

        if (formato = 'dd.mm.yyyy') then begin
                d := trim(Copy(value ,1 ,2));
                m := trim(Copy(value ,4 ,2));
                a := trim(Copy(value, 7, 4));

                Result := StrToDate(d+'/'+m+'/'+a);
        end;

    except
        Result := 0;
    end;

end;





function TSISLib.ToFloatDB(value: double): string;
var FormatString:string;
begin
    try
        FormatString := FormatFloat('#########0.00', value);
        FormatString := ReplaceStr(FormatString, ',','.');
        Result := asp(FormatString);
    except
        Result := '0';
    end;
end;

function TSISLib.ToFloat(value: string; round:Integer = 2): Double;
var FormatString:TFormatSettings;
begin
    try
        value := Trim(value);
        value := ReplaceStr(value, '.','');
        value := ReplaceStr(value, ',','.');

        FormatString.DecimalSeparator := '.';
        FormatString.CurrencyDecimals := 2;
        Result := StrToFloat(value, FormatString);
    except
        Result := 0;
    end;
end;

function TSISLib.ToInt(value: string): Int64;
begin
    try
        Result := 0;
        if (not lenBool(value)) then Exit;

        Result := StrToInt64(Trim(value));
    except
        Result := 0;
    end;
end;

function TSISLib.ToIntStr(value: string): string;
begin
    try
        Result := '0';
        if (not lenBool(value)) then Exit;

        Result := IntToStr(StrToInt64(Trim(value)));
    except
        Result := '0';
    end;
end;

constructor TSISLib.Create;
begin
    inherited Create;

end;


procedure TSISLib.Explode(linha, Spr: String; var Comp: TStringList);
var
  c,i,a:integer;
  StrAux:String;
begin
    a:=0;
    c:=1;
    linha:=linha+' '+Spr;
    Comp.Clear;
    for i:=1 to Length(linha) do begin
        if(linha[i]<>Spr)then begin
            Straux := copy(linha,i-c+1,c);
            c:=c+1;
        end else begin
            Comp.Add(Trim(StrAux));
            a:=a+1;
            c:=1;
        end;
    end;
end;

function TSISLib.FileToString(FileName: string): TSISReturn;
var   arq: TextFile;
        linha:string;
begin

    Result := TSISReturn.Create;
    Result.Erro := False;

    if (not FileExists(FileName)) then begin
        Result.Erro := True;
        Result.Texto := '';
        Exit;
    end;

    AssignFile(arq, FileName);

    {$I-}
    Reset(arq);
    {$I+}

    if (IOResult <> 0) then begin
        Result.Erro := True;
        Result.Texto := '';
        Exit;
    end;

    while (not eof(arq)) do begin
        readln(arq, linha);
        Result.Texto := Result.Texto + linha;
    end;

    CloseFile(arq);

end;

function TSISLib.HexToString(H: String): String;
var I: Integer;
begin
    try
        Result:= '';

        for I := 1 to length (H) div 2 do
            Result:= Result+Char(StrToInt('$'+Copy(H,(I-1)*2+1,2)));

    except
        Result := '';
    end;
end;


function TSISLib.ifthen(value: Boolean; Verdadeiro, Falso: Integer): Integer;
begin
    Result := Falso;

    if value then
        Result := Verdadeiro;

end;

function TSISLib.ifthen(value: Boolean; Verdadeiro, Falso: string): string;
begin
    Result := Falso;

    if value then
        Result := Verdadeiro;

end;


function TSISLib.IsEmptyVariant(const Value: Variant): Boolean;
begin
    Result := fEmptyVariant(Value);
end;

function TSISLib.GravarArquivoTexto(FileName:String; Texto:String):Boolean;
var  arq: TextFile;
begin
    try
        Result := False;

        ForceDirectories(ExtractFilePath(FileName));

        AssignFile(arq, FileName);
        Rewrite(arq);
        Writeln(arq,  Texto);
        CloseFile(arq);

        Result := True;
    except
        Result := False;
    end;
end;

function TSISLib.LeArquivoTexto(FileName:String):String;
var  arq: TextFile;
    i, n: integer;
    linha:String;

begin
    try
        AssignFile(arq, FileName);

        Application.ProcessMessages;

        {$I-}         // desativa a diretiva de Input
        Reset(arq);   // [ 3 ] Abre o arquivo texto para leitura
        {$I+}         // ativa a diretiva de Input
        Application.ProcessMessages;

        Result := '';
        if (IOResult <> 0) then
            Application.ProcessMessages
        else begin

            while (not eof(arq)) do begin
                Application.ProcessMessages;
                readln(arq, linha);
                Result := Result + trim(linha);
            end;

            CloseFile(arq);
        end;

        Application.ProcessMessages;

    except
        Result := '';
    end;

end;

procedure TSISLib.LimpaDir(Diretorio: string);
var i: integer;
    sr: TSearchRec;
begin
    try
        I := FindFirst(Diretorio + '*.*', faAnyFile, SR);
        while I = 0 do begin
            DeleteFile(Diretorio +  SR.Name);
            I := FindNext(SR);
        end;
    except
    end;
end;

function TSISLib.MaxCod(S: String): String;
var I: Integer;
    sTemp, Reverse:String;
begin

    // codifica uma string

    try
        sTemp := '';
        for I := 1 to length (S) do
            sTemp := sTemp+IntToHex(ord(S[i]),2);

        sTemp := StringToHex(sTemp);

        Reverse := '';
        for I := length(sTemp) Downto 1  do
            Reverse := Reverse + sTemp[i];

        Result := Reverse;
    except
        Result := '';
    end;

end;


function TSISLib.MaxDec(H: String): String;
var I: Integer;
    sTemp, Reverse:String;
begin

    // decodifica um testo codigficado

    try
        Result:= '';

        Reverse := '';
        for I := length(H) Downto 1  do
            Reverse := Reverse + H[i];

        sTemp := HexToString(Reverse);
        for I := 1 to length (sTemp) div 2 do
            Result:= Result + Char(StrToInt('$'+Copy(sTemp,(I-1)*2+1,2)));

        Result:= Trim(Result);

    except
        Result := '';
    end;
end;

function TSISLib.MsgConfirmacao(Mensagem: string): Boolean;
begin
    if MessageDlg(Mensagem,mtConfirmation, [mbYes,mbNo],0) = mrNo then Exit;
    Result := True;
end;

function TSISLib.Msg(Mensagem: string): Boolean;
begin
    MessageDlg(Mensagem,mtWarning, [mbOK],0);
end;



function TSISLib.asp(value: string): string;
begin
    Result := #39 + Trim(value) + #39;
end;

function TSISLib.ChecaDir(sDir:String):Boolean;
var OutPutList: TStringList;
    i:Integer;
    DirT:String;
begin

    // checa o endere�o passado em sDIr e verifica se o caminho todo � v�lido
    // caso n�o seja cria todo o camiho

    try
        OutPutList := TStringList.Create;

        ExtractStrings(['\'], [], PChar(sDir), OutPutList);
        //Split('\', sDir, OutPutList);

        DirT := '';

        for i:=0 to OutPutList.Count-1 do begin

            if (i = 0) then
                DirT := OutPutList.Strings[i]
            else
                DirT := DirT+'\'+OutPutList.Strings[i];

            if (not DirectoryExists(DirT)) then
                MkDir(DirT);

        end;

    finally
        OutPutList.Free;
    end;

end;

function TSISLib.isCPF(value: string): boolean;
var  CPF, dig10, dig11: string;
    s, i, r, peso: integer;
begin

    for i:=1 to len(value) do
        if (value[i] in['0'..'9']) then
            CPF := CPF + value[i];

// length - retorna o tamanho da string (CPF é um número formado por 11 dígitos)
  if ((CPF = '00000000000') or (CPF = '11111111111') or
      (CPF = '22222222222') or (CPF = '33333333333') or
      (CPF = '44444444444') or (CPF = '55555555555') or
      (CPF = '66666666666') or (CPF = '77777777777') or
      (CPF = '88888888888') or (CPF = '99999999999') or
      (length(CPF) <> 11))
     then begin
              isCPF := false;
              exit;
            end;

// try - protege o código para eventuais erros de conversão de tipo na função StrToInt
  try
{ *-- Cálculo do 1o. Digito Verificador --* }
    s := 0;
    peso := 10;
    for i := 1 to 9 do
    begin
// StrToInt converte o i-ésimo caractere do CPF em um número
      s := s + (StrToInt(CPF[i]) * peso);
      peso := peso - 1;
    end;
    r := 11 - (s mod 11);
    if ((r = 10) or (r = 11))
       then dig10 := '0'
    else str(r:1, dig10); // converte um número no respectivo caractere numérico

{ *-- Cálculo do 2o. Digito Verificador --* }
    s := 0;
    peso := 11;
    for i := 1 to 10 do
    begin
      s := s + (StrToInt(CPF[i]) * peso);
      peso := peso - 1;
    end;
    r := 11 - (s mod 11);
    if ((r = 10) or (r = 11))
       then dig11 := '0'
    else str(r:1, dig11);

{ Verifica se os digitos calculados conferem com os digitos informados. }
    if ((dig10 = CPF[10]) and (dig11 = CPF[11]))
       then isCPF := true
    else isCPF := false;
  except
    isCPF := false
  end;
end;



function TSISLib.isCNPJ(value: string): boolean;
var   CNPJ, dig13, dig14: string;
    sm, i, r, peso: integer;


begin

    for i:=1 to len(value) do
        if (value[i] in['0'..'9']) then
            CNPJ := CNPJ + value[i];

// length - retorna o tamanho da string do CNPJ (CNPJ é um número formado por 14 dígitos)
  if ((CNPJ = '00000000000000') or (CNPJ = '11111111111111') or
      (CNPJ = '22222222222222') or (CNPJ = '33333333333333') or
      (CNPJ = '44444444444444') or (CNPJ = '55555555555555') or
      (CNPJ = '66666666666666') or (CNPJ = '77777777777777') or
      (CNPJ = '88888888888888') or (CNPJ = '99999999999999') or
      (length(CNPJ) <> 14))
     then begin
            isCNPJ := false;
            exit;
          end;

// "try" - protege o código para eventuais erros de conversão de tipo através da função "StrToInt"
  try
{ *-- Cálculo do 1o. Digito Verificador --* }
    sm := 0;
    peso := 2;
    for i := 12 downto 1 do
    begin
// StrToInt converte o i-ésimo caractere do CNPJ em um número
      sm := sm + (StrToInt(CNPJ[i]) * peso);
      peso := peso + 1;
      if (peso = 10)
         then peso := 2;
    end;
    r := sm mod 11;
    if ((r = 0) or (r = 1))
       then dig13 := '0'
    else str((11-r):1, dig13); // converte um número no respectivo caractere numérico

{ *-- Cálculo do 2o. Digito Verificador --* }
    sm := 0;
    peso := 2;
    for i := 13 downto 1 do
    begin
      sm := sm + (StrToInt(CNPJ[i]) * peso);
      peso := peso + 1;
      if (peso = 10)
         then peso := 2;
    end;
    r := sm mod 11;
    if ((r = 0) or (r = 1))
       then dig14 := '0'
    else str((11-r):1, dig14);

{ Verifica se os digitos calculados conferem com os digitos informados. }
    if ((dig13 = CNPJ[13]) and (dig14 = CNPJ[14]))
       then isCNPJ := true
    else isCNPJ := false;
  except
    isCNPJ := false
  end;
end;

function TSISLib.ImprimeCNPJ(CNPJ: string): string;
var i:Integer;
begin

    CNPJ := ReplaceSoNumero(CNPJ);

    if (len(CNPJ) > 14) then begin
        Result := '';
        Exit;
    end;

    if (len(CNPJ) < 14) then
        for i := len(CNPJ) to 13 do
            CNPJ := '0' + CNPJ;


    { máscara do CNPJ: 99.999.999.9999-99 }
    imprimeCNPJ := copy(CNPJ, 1, 2)
                    + '.' + copy(CNPJ, 3, 3)
                    + '.' + copy(CNPJ, 6, 3)
                    + '/' + copy(CNPJ, 9, 4)
                    + '-' + copy(CNPJ, 13, 2);

end;

function TSISLib.ImprimeCPF(CPF: string): string;
var i:Integer;
begin

    CPF := ReplaceSoNumero(CPF);

    if (len(CPF) > 11) then begin
        Result := '';
        Exit;
    end;

    if (len(CPF) < 11) then
        for i := len(CPF) to 10 do
            CPF := '0' + CPF;

  imprimeCPF := copy(CPF, 1, 3) + '.' + copy(CPF, 4, 3) + '.' +
    copy(CPF, 7, 3) + '-' + copy(CPF, 10, 2);
end;

function TSISLib.ReplaceSoNumero(value: string):String;
var TXT:string;
    i: integer;
begin
    Result := '';
    for i:=1 to len(value) do
        if (value[i] in['0'..'9']) then
            Result := Result + value[i];

end;

function TSISLib.ChkSoNumero(value: string):boolean;
var value2:string;
    i: integer;
begin
    value2 := '';
    for i:=1 to len(value) do
        if (value[i] in['0'..'9']) then
            value2 := value2 + value[i];

    Result := (value2 = value);
end;



function TSISLib.ReplaceStr(Text, oldstring, newstring: string): string;
var atual, strtofind, originalstr:pchar;
    NewText:string;
    lenoldstring,lennewstring,m,index:integer;
begin

    NewText         := Text;
    originalstr     := pchar(Text);
    strtofind       := pchar(oldstring);
    lenoldstring    := length(oldstring);
    lennewstring    := length(newstring);
    Atual           := StrPos(OriginalStr,StrtoFind);
    index           := 0;

    while (Atual <> nil) do begin
        m       := Atual - OriginalStr - index + 1;
        Delete(NewText,m,lenoldstring);
        Insert(newstring,NewText,m);
        inc(index,lenoldstring-lennewstring);
        Atual   := StrPos(Atual+lenoldstring,StrtoFind);
    end;

    Result  := NewText;


end;

function TSISLib.lenBool(FArray: array of string): Boolean;
begin
    Result := (Length(FArray) = 0);
end;

{ TSISPaths }

constructor TSISPaths.Create;
begin

    inherited Create;

    // gerar estrutura de diretorios
    LibPath := 'C:\Debug\Lib\';
    LogPath := LibPath + 'Log\';

    if (not FAtivo) then begin
        LimpaDir(LibPath);
        RemoveDir(LibPath);
        Exit;
    end;

    ChecaDir(LibPath);
    ChecaDir(LogPath);
end;

function TSISLib.LimpaStrDB(value: string): string;
begin
    Result := ReplaceStr(value, #39, ' ');
end;

function TSISLib.LimpaString(str:String):String;
var Valor :String;
begin
    Valor := ReplaceStr(str, #$D#$A,'');
    Valor := ReplaceStr(Valor, #$D,'');
    Result := Valor;
end;

function TSISLib.ReadIniStr(FileName:String; Chave:String; Campo:String; Value:String = ''):String;
var
  ArqIni : tIniFile;
begin

  if not FileExists(FileName) then Exit;

  ArqIni := tIniFile.Create(FileName);
  Try
    Result := ArqIni.ReadString(Chave, Campo, Value);

    if Result = Value then
      WriteIniStr(FileName, Chave, Campo, Value);
  Finally
    ArqIni.Free;
  end;
end;

Procedure TSISLib.WriteIniStr(FileName:String; Chave:String; Campo:String; Value:String);
var
  ArqIni : TIniFile;
begin
  ArqIni := TIniFile.Create(FileName);
  Try
    ArqIni.WriteString(Chave, Campo, Value);
  Finally
    ArqIni.Free;
  end;
end;

function TSISLib.ReadIniInt(FileName:String; Chave:String; Campo:String; Value:String = ''):Integer;
var Res:String;
begin
    try
        Res := ReadIniStr(FileName, Chave, Campo, Value);
        if (not lenBool(Res)) then
            Result := 0
        else
            Result := ToInt(Res);
    except
        WriteIni(FileName, Chave, Campo, 0);

        Result := 0;
    end;
end;

Procedure TSISLib.WriteIni(FileName:String; Chave:String; Campo:String; Value:Integer);
var
  ArqIni : TIniFile;
begin
  WriteIniStr(FileName, Chave, Campo, IntToStr(Value));
end;

Procedure TSISLib.WriteIni(FileName:String; Chave:String; Campo:String; Value:String);
var
  ArqIni : TIniFile;
begin
  WriteIniStr(FileName, Chave, Campo, Value);
end;

Procedure TSISLib.WriteIni(FileName:String; Chave:String; Campo:String; Value:Boolean);
var
  ArqIni : TIniFile;
begin
  WriteIniStr(FileName, Chave, Campo, BoolToStr(Value));
end;

Procedure TSISLib.WriteIni(FileName:String; Chave:String; Campo:String; Value:TDateTime);
var
  ArqIni : TIniFile;
begin
  WriteIniStr(FileName, Chave, Campo, DateTimeToStr(Value));
end;






{ TSISFiles }

constructor TSISFiles.Create;
begin
    inherited Create;
    LogFile := LogPath + 'Log.ini';
end;

{ TSISDebug }

constructor TSISDebug.Create(pAtivo:Boolean);
begin
    Ativo        := pAtivo;
    inherited Create;

    Ativo       := pAtivo;
    HTTP        := TSISHttp.Create;
    Telefone    := TSISLibTel.Create;
    SQL         := TSISSQL.Create;
end;

procedure TSISDebug.SetAtivo(const Value: Boolean);
begin
    // modifica o status do debug
    FAtivo := Value;
end;

function TSISDebug.AddLog(value: string): Boolean;
begin
    // cria um arquivo ini de log com o conteudo passado com a chave global
    if (not Ativo) then Exit;
    WriteIni(LogFile, 'Global' , FormatDateTime('dd-mm-yyyy hh:nn:ss', Now), value);
end;

function TSISDebug.AddLog(FileName:string; value: string): Boolean;
begin
    // gera um arquivo no diretorio de log com o conteudo de value
    if (not Ativo) then Exit;
    GravarArquivoTexto(LogPath + FileName, value);
end;


{ TSISReturn }

function TSISReturn.getSucesso: Boolean;
begin
    Result := (not Erro);
end;

function TSISReturn.IsMatriz(Abortar:Boolean = False;  ShowMsg:Boolean = False; Msg:string = ''): Boolean;
begin
    //Result := (not fEmptyVariant(Maxtriz));

    if (not Result) then begin

        if ShowMsg then
            ShowMessage(Msg);

        if Abortar then Abort;

    end;
end;

procedure TSISReturn.ShowErro(VisualizaErro: Boolean = True; MensagemNova: string = '');
begin
    if (not VisualizaErro) then begin
        MessageDlg(MensagemNova, mtInformation, [mbOK],0);
        Exit;
    end;

    MessageDlg('Aten��o: ' + Mensagem + IfThen(Length(MensagemNova) > 0, ' ' + MensagemNova, ''), mtInformation, [mbOK],0);

end;

procedure TSISReturn.ShowMessage(MensagemNova: string = '');
begin
    if (Length(trim(MensagemNova)) > 0) then
        Mensagem := MensagemNova;

    MessageDlg(Mensagem, mtInformation, [mbOK],0);
end;

function fEmptyVariant(const Value: Variant): Boolean;
begin
    Result := VarIsClear(Value)
                or VarIsEmpty(Value)
                or VarIsNull(Value)
                or (VarCompareValue(Value, Unassigned) = vrEqual);

    if (not Result) and VarIsStr(Value) then
        Result := Value = '';
end;

{ TSISSQL }

//
//function TSISSQL.AddSQL(campo:string; valor: string; Tipo:TSISSQLTipoTP = tstString): TSISReturn;
//begin
//    Result := FAddSQL(campo, valor, Tipo);
//end;
//
//function TSISSQL.AddSQL(campo:string; valor: Int64; Tipo: TSISSQLTipoTP = tstInt64): TSISReturn;
//begin
//    if (Tipo = tstInt64) then
//        Tipo := tstString;
//
//    Result := FAddSQL(campo, IntToStr(valor), Tipo);
//end;
//
//function TSISSQL.AddSQL(campo:string; valor: Integer; Tipo: TSISSQLTipoTP = tstInt): TSISReturn;
//begin
//    Result := FAddSQL(campo, IntToStr(valor), Tipo);
//end;
//
//function TSISSQL.AddSQL(campo:string; valor: Double; Tipo: TSISSQLTipoTP; Formato:String): TSISReturn;
//var FIndex:Integer;
//
//    function LocalizaCampo:Boolean;
//    var i: Integer;
//    begin
//        Result := False;
//
//        if (Length(FCampos) = 0) then Exit;
//
//        for i := 0 to Length(FCampos)-1 - 1 do
//            if (UpperCase(FCampos[i].getString) = UpperCase(campo)) then begin
//                FIndex := i;
//                Result := True;
//                Exit;
//            end;
//
//    end;
//begin
//
//    try
//        Result := TSISReturn.Create;
//        Result.Erro  := False;
//
//        if (LocalizaCampo) then begin
//            FCampos[FIndex].Valor           := campo;
//            FCampos[FIndex].Tipo            := Tipo;
//            FCampos[FIndex].FormatoData     := Formato;
//
//            FValores[FIndex].Tipo           := Tipo;
//            FValores[FIndex].FormatoData    := Formato;
//
//            if (Tipo = tstFloat) then
//                FValores[FIndex].ValorFloat     := valor
//            else
//                FValores[FIndex].ValorDateTime  := valor;
//
//            Exit;
//        end;
//
//        SetLength(FCampos, Length(FCampos)+1);
//        SetLength(FValores, Length(FValores)+1);
//
//        FIndex                          := (Length(FCampos) - 1);
//        FCampos[FIndex]                 := TSISSQLTipo.Create;
//        FCampos[FIndex].Valor           := campo;
//        FCampos[FIndex].Tipo            := Tipo;
//        FCampos[FIndex].FormatoData     := Formato;
//
//        FValores[FIndex]                := TSISSQLTipo.Create;
//        if (Tipo = tstFloat) then
//            FValores[FIndex].ValorFloat     := valor
//        else
//            FValores[FIndex].ValorDateTime  := valor;
//
//        FValores[FIndex].Tipo           := Tipo;
//        FValores[FIndex].FormatoData    := Formato;
//
//
//    except
//        Result.Erro := True;
//    end;
//
//end;
//
//
//
//constructor TSISSQL.Create;
//begin
//    FResultado := TSISReturn.Create;
//end;
//
//
//function TSISSQL.Executar(Tabela: string): TSISReturn;
//begin
//    FNomeTabela := Tabela;
//    Result      := Executar;
//end;
//
//function TSISSQL.Executar: TSISReturn;
//var sSQL:string;
//begin
//
//    try
//        if (FNomeMetodo = tsteInsert) then begin
//
//            if (not lenBool(FNomeTabela)) then begin
//                FResultado.Erro     := False;
//                FResultado.Mensagem := 'Informe a tabela para execu��o';
//                FExecute            := False;
//                Exit;
//            end;
//
//            FResultado := getSQLInsert(FNomeTabela);
//            if (FResultado.Erro) then Exit;
//
//            FResultado := SetCMD(FResultado.SQL);
//
//        end else if (FNomeMetodo = tsteUpdate) then begin
//
//            if (not lenBool(FNomeTabela)) then begin
//                FResultado.Erro     := False;
//                FResultado.Mensagem := 'Informe a tabela para execu��o';
//                FExecute            := False;
//                Exit;
//            end;
//
//            if (not lenBool(FWhere)) then begin
//                FResultado.Erro     := False;
//                FResultado.Mensagem := 'Informe a tabela para execu��o';
//                FExecute            := False;
//                Exit;
//            end;
//
//            FResultado := getSQLUpdate(FNomeTabela, FWhere);
//            if (FResultado.Erro) then Exit;
//
//            FResultado := SetCMD(FResultado.SQL);
//
//        end else begin
//
//            FResultado.Erro     := False;
//            FResultado.Mensagem := 'Nenhum metodo informado';
//            FExecute            := False;
//
//        end;
//
//    finally
//        Result := FResultado;
//    end;
//
//end;
//
//
//function TSISSQL.Executar(Metodo: TSISSQLTipoExecute;
//  Tabela: string): TSISReturn;
//begin
//    setNomeMetodo(Metodo);
//    setNomeTabela(Tabela);
//    Result := Executar;
//
//end;
//
//function TSISSQL.Executar(Metodo: TSISSQLTipoExecute; Tabela,
//  Where: string): TSISReturn;
//begin
//    if (Metodo = tsteInsert) then begin
//        if (SISDebug.lenBool(Where)) then begin
//            Resultado.Erro := True;
//            Resultado.Mensagem := 'Erro: Para executar metodo de insert n�o informe o where';
//            raise Exception.Create(Resultado.Mensagem);
//            Exit;
//        end;
//    end;
//    FWhere := Where;
//    setNomeTabela(Tabela);
//    setNomeMetodo(Metodo);
//    Result := Executar;
//end;
//
//function TSISSQL.Executar(Metodo: TSISSQLTipoExecute): TSISReturn;
//begin
//    setNomeMetodo(Metodo);
//    Result := Executar;
//end;
//
//
//function TSISSQL.setFormatoDate(campo, Formato:string): TSISReturn;
//var FIndex:Integer;
//    i: Integer;
//begin
//    Result.Erro := False;
//    if (Length(FCampos) = 0) then Exit;
//
//    for i := 0 to Length(FCampos)-1 - 1 do
//        if (UpperCase(FCampos[i].getString) = UpperCase(campo)) then begin
//            FIndex := i;
//            FCampos[i].FormatoData := Formato;
//            Result.Erro := False;
//            Exit;
//        end;
//end;
//
//procedure TSISSQL.setNomeMetodo(const Value: TSISSQLTipoExecute);
//begin
//    FNomeMetodo := Value;
//end;
//
//procedure TSISSQL.setNomeTabela(const Value: string);
//begin
//  FNomeTabela := Value;
//end;
//
//procedure TSISSQL.setWhere(const Value: string);
//begin
//    FWhere := Value;
//end;
//
//function TSISSQL.FAddSQL(campo, valor: string; Tipo: TSISSQLTipoTP): TSISReturn;
//var FIndex:Integer;
//
//    function LocalizaCampo:Boolean;
//    var i: Integer;
//    begin
//        Result := False;
//
//        if (Length(FCampos) = 0) then Exit;
//
//        for i := 0 to Length(FCampos)-1 - 1 do
//            if (UpperCase(FCampos[i].getString) = UpperCase(campo)) then begin
//                FIndex := i;
//                Result := True;
//                Exit;
//            end;
//
//    end;
//begin
//
//    try
//        Result := TSISReturn.Create;
//        Result.Erro  := False;
//
//        if (LocalizaCampo) then begin
//            FCampos[FIndex].Valor     := campo;
//            FCampos[FIndex].Tipo      := Tipo;
//            FValores[FIndex].Valor    := valor;
//            FValores[FIndex].Tipo     := Tipo;
//            Exit;
//        end;
//
//        SetLength(FCampos, Length(FCampos)+1);
//        SetLength(FValores, Length(FValores)+1);
//
//        FIndex                  := (Length(FCampos) - 1);
//        FCampos[FIndex]         := TSISSQLTipo.Create;
//        FCampos[FIndex].Valor   := campo;
//        FCampos[FIndex].Tipo    := Tipo;
//
//        FValores[FIndex]        := TSISSQLTipo.Create;
//        FValores[FIndex].Valor  := valor;
//        FValores[FIndex].Tipo   := Tipo;
//
//
//    except
//        Result.Erro := True;
//    end;
//
//end;
//
//function TSISSQL.getSQLInsert(Tabela:string): TSISReturn;
//var sSQL, sSQLC, sSQLV:string;
//    i:Integer;
//begin
//
//    try
//        Result := TSISReturn.Create;
//        Result.Erro := False;
//        Result.SQL  := '';
//        sSQLC       := '';
//        sSQLV       := '';
//
//        for i := 0 to Length(FCampos)-1 do begin
//
//            if (i > 0) then begin
//                sSQLC := sSQLC + ',';
//                sSQLV := sSQLV + ',';
//            end;
//
//            sSQLC := sSQLC + FCampos[i].Valor;
//
//            if FCampos[i].Tipo = tstString then begin
//                sSQLV := sSQLV + asp(FValores[i].getString);
//
//            end else if FCampos[i].Tipo = tstInt then begin
//                sSQLV := sSQLV + ToIntStr(FValores[i].getString);
//
//            end else if FCampos[i].Tipo = tstDatetime then begin
//                sSQLV := sSQLV + asp(FormatDateTime(FValores[i].FormatoData , FValores[i].getDatetime));
//
//            end else if FCampos[i].Tipo = tstFloat then begin
//                sSQLV := sSQLV + asp(FormatFloat(FValores[i].FormatoData, FValores[i].getFloat));
//            end;
//
//        end;
//
//        sSQL := 'INSERT INTO ' + Tabela + '(' + sSQLC + ')';
//        sSQL := sSQL + ' VALUES ';
//        sSQL := sSQL + '(' + sSQLV + ')';
//
//        Result.SQL  := sSQL;
//
//    except on E:Exception do begin
//            Result.Erro := True;
//            Result.Mensagem := E.ClassName + ' - ' + E.Message;
//        end;
//
//    end;
//
//end;
//
//function TSISSQL.getSQLUpdate(Tabela, Where:string): TSISReturn;
//var sSQL, sSQLU:string;
//    i:Integer;
//begin
//
//    try
//        Result := TSISReturn.Create;
//
//        if (not lenBool(Tabela)) then begin
//            Result.Erro := True;
//            Result.Mensagem := 'Informe o nome da tabela!';
//            Exit;
//
//        end else if (not lenBool(Where)) then begin
//            Result.Erro := True;
//            Result.Mensagem := 'Informe a instru��o sql do where para o update!';
//            Exit;
//        end;
//
//        Result.Erro := False;
//        Result.SQL  := '';
//        sSQLU       := '';
//
//        for i := 0 to Length(FCampos)-1 do begin
//
//            if (i > 0) then
//                sSQLU := sSQLU + ',';
//
//            sSQLU := sSQLU + FCampos[i].Valor;
//
//            if FCampos[i].Tipo = tstString then begin
//                sSQLU := sSQLU + ' = ' + asp(FValores[i].getString);
//
//            end else if FCampos[i].Tipo = tstInt then begin
//                sSQLU := sSQLU + ' = ' + ToIntStr(FValores[i].getString);
//
//            end else if FCampos[i].Tipo = tstDatetime then begin
//                sSQLU := sSQLU + ' = ' + asp(FormatDateTime(FValores[i].FormatoData , FValores[i].getDatetime));
//
//            end else if FCampos[i].Tipo = tstFloat then begin
//                sSQLU := sSQLU + ' = ' + asp(FormatFloat(FValores[i].FormatoData, FValores[i].getFloat));
//            end;
//
//        end;
//
//        sSQL := 'Update ' + Tabela + ' set ';
//        sSQL := sSQL + sSQLU;
//        sSQL := sSQL + ' where ' + Where;
//        Result.SQL  := sSQL;
//
//    except on E:Exception do begin
//            Result.Erro := True;
//            Result.Mensagem := E.ClassName + ' - ' + E.Message;
//        end;
//
//    end;
//
//end;

procedure TSISSQL.Clear;
begin
    SetLength(FCampos, 0);
    SetLength(FValores, 0);
end;


function TSISSQL.AddSQL(campo:string; valor: string; Tipo:TSISSQLTipoTP = tstString): TSISReturn;
begin
    Result := FAddSQL(campo, valor, Tipo);
end;

function TSISSQL.AddSQL(campo:string; valor: Int64; Tipo: TSISSQLTipoTP = tstInt64): TSISReturn;
begin
    if (Tipo = tstInt64) then
        Tipo := tstString;

    Result := FAddSQL(campo, IntToStr(valor), Tipo);
end;

function TSISSQL.AddSQL(campo:string; valor: Integer; Tipo: TSISSQLTipoTP = tstInt): TSISReturn;
begin
    Result := FAddSQL(campo, IntToStr(valor), Tipo);
end;

function TSISSQL.AddSQL(campo:string; valor: Double; Tipo: TSISSQLTipoTP; Formato:String): TSISReturn;
var FIndex:Integer;

    function LocalizaCampo:Boolean;
    var i: Integer;
    begin
        Result := False;

        if (Length(FCampos) = 0) then Exit;

        for i := 0 to Length(FCampos)-1 - 1 do
            if (UpperCase(FCampos[i].getString) = UpperCase(campo)) then begin
                FIndex := i;
                Result := True;
                Exit;
            end;

    end;
begin

    try
        Result := TSISReturn.Create;
        Result.Erro  := False;

        if (LocalizaCampo) then begin
            FCampos[FIndex].Valor           := campo;
            FCampos[FIndex].Tipo            := Tipo;
            FCampos[FIndex].FormatoData     := Formato;

            FValores[FIndex].Tipo           := Tipo;
            FValores[FIndex].FormatoData    := Formato;

            if (Tipo = tstFloat) then
                FValores[FIndex].ValorFloat     := valor
            else
                FValores[FIndex].ValorDateTime  := valor;

            Exit;
        end;

        SetLength(FCampos, Length(FCampos)+1);
        SetLength(FValores, Length(FValores)+1);

        FIndex                          := (Length(FCampos) - 1);
        FCampos[FIndex]                 := TSISSQLTipo.Create;
        FCampos[FIndex].Valor           := campo;
        FCampos[FIndex].Tipo            := Tipo;
        FCampos[FIndex].FormatoData     := Formato;

        FValores[FIndex]                := TSISSQLTipo.Create;
        if (Tipo = tstFloat) then
            FValores[FIndex].ValorFloat     := valor
        else
            FValores[FIndex].ValorDateTime  := valor;

        FValores[FIndex].Tipo           := Tipo;
        FValores[FIndex].FormatoData    := Formato;


    except
        Result.Erro := True;
    end;

end;



constructor TSISSQL.Create;
begin
    FResultado := TSISReturn.Create;
end;


function TSISSQL.ExecutarSQLQ(sSQL:string): TSISReturn;
begin
    try
        Result := Resultado;

        try
            SQLQ.Close;

            SQLQ.SQL.Clear;
            SQLQ.SQL.Add(sSQL);
            SQLQ.ExecSQL;


            Result.Erro     := False;
            Result.Mensagem := 'Comando executado com sucesso.';
            Application.ProcessMessages;

        except on E: Exception do begin
                SISDebug.AddLog('SQL ERRO.sql', sSQL);
                Result.Erro     := True;
                Result.Mensagem := 'Erro execu��o comando: '+ E.ClassName + ' - ' + E.Message;
            end;
        end;

    finally

    end;
end;

function TSISSQL.setFormatoDate(campo, Formato:string): TSISReturn;
var FIndex:Integer;
    i: Integer;
begin
    Result.Erro := False;
    if (Length(FCampos) = 0) then Exit;

    for i := 0 to Length(FCampos)-1 - 1 do
        if (UpperCase(FCampos[i].getString) = UpperCase(campo)) then begin
            FIndex := i;
            FCampos[i].FormatoData := Formato;
            Result.Erro := False;
            Exit;
        end;
end;

procedure TSISSQL.setSQLQ(pSQLQ: TSQLQuery);
begin
        SQLQ := pSQLQ;
end;


procedure TSISSQL.setNomeMetodo(const Value: TSISSQLTipoExecute);
begin
    FNomeMetodo := Value;
end;

procedure TSISSQL.setNomeTabela(const Value: string);
begin
  FNomeTabela := Value;
end;

procedure TSISSQL.setWhere(const Value: string);
begin
    FWhere := Value;
end;

function TSISSQL.FAddSQL(campo, valor: string; Tipo: TSISSQLTipoTP): TSISReturn;
var FIndex:Integer;

    function LocalizaCampo:Boolean;
    var i: Integer;
    begin
        Result := False;

        if (Length(FCampos) = 0) then Exit;

        for i := 0 to Length(FCampos)-1 - 1 do
            if (UpperCase(FCampos[i].getString) = UpperCase(campo)) then begin
                FIndex := i;
                Result := True;
                Exit;
            end;

    end;
begin

    try

        Result := TSISReturn.Create;
        Result.Erro  := False;

        if (LocalizaCampo) then begin
            FCampos[FIndex].Valor     := campo;
            FCampos[FIndex].Tipo      := Tipo;
            FValores[FIndex].Valor    := valor;
            FValores[FIndex].Tipo     := Tipo;
            Exit;
        end;

        SetLength(FCampos, Length(FCampos)+1);
        SetLength(FValores, Length(FValores)+1);

        FIndex                  := (Length(FCampos) - 1);
        FCampos[FIndex]         := TSISSQLTipo.Create;
        FCampos[FIndex].Valor   := campo;
        FCampos[FIndex].Tipo    := Tipo;

        FValores[FIndex]        := TSISSQLTipo.Create;
        FValores[FIndex].Valor  := valor;
        FValores[FIndex].Tipo   := Tipo;


    except
        Result.Erro := True;
    end;

end;

function TSISSQL.getSQLInsert(Tabela:string): TSISReturn;
var sValor, sSQL, sSQLC, sSQLV:string;
    i:Integer;
    fValor:Double;
begin

    try
        Result := TSISReturn.Create;
        Result.Erro := False;
        Result.SQL  := '';
        sSQLC       := '';
        sSQLV       := '';

        for i := 0 to Length(FCampos)-1 do begin

            if (i > 0) then begin
                sSQLC := sSQLC + ',';
                sSQLV := sSQLV + ',';
            end;

            sSQLC := sSQLC + FCampos[i].Valor;

            if FCampos[i].Tipo = tstString then begin
                sSQLV := sSQLV + asp(FValores[i].getString);

            end else if FCampos[i].Tipo = tstInt then begin
                sSQLV := sSQLV + ToIntStr(FValores[i].getString);

            end else if FCampos[i].Tipo = tstDatetime then begin
                sSQLV := sSQLV + asp(FormatDateTime(FValores[i].FormatoData , FValores[i].getDatetime));

            end else if FCampos[i].Tipo = tstFloat then begin
                fValor := FValores[i].getFloat;
                sValor := FormatFloat(FValores[i].FormatoData, fValor);
                sSQLV := sSQLV + ReplaceStr(ReplaceStr(sValor, '.',''),',','.');
            end;

        end;

        sSQL := 'INSERT INTO ' + Tabela + '(' + sSQLC + ')';
        sSQL := sSQL + ' VALUES ';
        sSQL := sSQL + '(' + sSQLV + ')';

        Result.SQL  := sSQL;

    except on E:Exception do begin
            Result.Erro := True;
            Result.Mensagem := E.ClassName + ' - ' + E.Message;
        end;

    end;

end;

function TSISSQL.getSQLUpdate(Tabela, Where:string): TSISReturn;
var sValor, sSQL, sSQLU:string;
    fValor:Double;
    i:Integer;
begin

    try
        Result := TSISReturn.Create;

        if (not lenBool(Tabela)) then begin
            Result.Erro := True;
            Result.Mensagem := 'Informe o nome da tabela!';
            Exit;

        end else if (not lenBool(Where)) then begin
            Result.Erro := True;
            Result.Mensagem := 'Informe a instru��o sql do where para o update!';
            Exit;
        end;

        Result.Erro := False;
        Result.SQL  := '';
        sSQLU       := '';

        for i := 0 to Length(FCampos)-1 do begin

            if (i > 0) then
                sSQLU := sSQLU + ',';

            sSQLU := sSQLU + FCampos[i].Valor;

            if FCampos[i].Tipo = tstString then begin
                sSQLU := sSQLU + ' = ' + asp(FValores[i].getString);

            end else if FCampos[i].Tipo = tstInt then begin
                sSQLU := sSQLU + ' = ' + ToIntStr(FValores[i].getString);

            end else if FCampos[i].Tipo = tstDatetime then begin
                sSQLU := sSQLU + ' = ' + asp(FormatDateTime(FValores[i].FormatoData , FValores[i].getDatetime));

            end else if FCampos[i].Tipo = tstFloat then begin
                fValor := FValores[i].getFloat;
                sValor := FormatFloat(FValores[i].FormatoData, fValor);
                sSQLU := sSQLU + ' = ' + ReplaceStr(ReplaceStr(sValor, '.',''),',','.');
            end;

        end;

        sSQL := 'Update ' + Tabela + ' set ';
        sSQL := sSQL + sSQLU;
        sSQL := sSQL + ' where ' + Where;
        Result.SQL  := sSQL;

    except on E:Exception do begin
            Result.Erro := True;
            Result.Mensagem := E.ClassName + ' - ' + E.Message;
        end;

    end;

end;

{ TSISSQLTipo }

function TSISSQLTipo.getDatetime: TDateTime;
begin
    Result := ValorDateTime;
end;

function TSISSQLTipo.getFloat: Double;
begin
    Result := ValorFloat;
end;

function TSISSQLTipo.getInt: Integer;
begin
    Result := ToInt(Valor);
end;

function TSISSQLTipo.getString: string;
begin
    Result := Valor;
end;

{ TSISHttp }
//
//constructor TSISHttp.Create;
//begin
//    HttpResponse                    := TSISHttpResponse.Create;
//
//    FSSL                            := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
//    FHttp                           := TIdHTTP.Create(nil);
//
//    FHttp.HandleRedirects           := True;
//    FHttp.ProtocolVersion           := pv1_1;
//
//    FSSL.PassThrough                :=False;
//    FSSL.SSLOptions.Method          := sslvTLSv1;
//    FSSL.SSLOptions.Mode            := sslmUnassigned;
//    FSSL.SSLOptions.VerifyMode      := [];
//    FSSL.SSLOptions.VerifyDepth     := 0;
//    FSSL.Port                       := 443;
//
//    FHTTP.IOHandler                     := FSSL;
//    FHTTP.Request.BasicAuthentication   := False;
//
//    IdSSLOpenSSLHeaders.Load;
//    FHTTP.ReadTimeout               := 15000;
//    FHTTP.ConnectTimeout            := 3000;
//end;
//
//function TSISHttp.CreateFHttp: Boolean;
//begin
//    try
//        FSSL                            := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
//        FHttp                           := TIdHTTP.Create(nil);
//
//        FHttp.HandleRedirects           := True;
//        FHttp.ProtocolVersion           := pv1_1;
//
//        FSSL.PassThrough                :=False;
//        FSSL.SSLOptions.Method          := sslvTLSv1;
//        FSSL.SSLOptions.Mode            := sslmUnassigned;
//        FSSL.SSLOptions.VerifyMode      := [];
//        FSSL.SSLOptions.VerifyDepth     := 0;
//        FSSL.Port                       := 443;
//
//        FHTTP.IOHandler                     := FSSL;
//        FHTTP.Request.BasicAuthentication   := False;
//
//        IdSSLOpenSSLHeaders.Load;
//        FHTTP.ReadTimeout               := 15000;
//        FHTTP.ConnectTimeout            := 3000;
//        Result := True;
//
//    except
//        Result := False;
//    end;
//end;
//
//function TSISHttp.HeaderAdd(Name, value: string): Boolean;
//begin
//    SetLength(FCustomHeaders, length(FCustomHeaders)+1);
//    FCustomHeaders[length(FCustomHeaders)-1].Name := Name;
//    FCustomHeaders[length(FCustomHeaders)-1].Value := value;
//end;
//
//function TSISHttp.HeaderClear: Boolean;
//begin
//    SetLength(FCustomHeaders, 0);
//end;
//
//
//function TSISHttp.Post(URL: string; strParams:string): TSISHttpResponse;
//var Request:TStream;
//    sResponse:String;
//  i,iPos: Integer;
//begin
//    try
//
//        try
//            Request := TStringStream.Create(strParams);
//
//            if (not Assigned(FHttp)) then
//                CreateFHttp;
//
//            FHttp.Request.CustomHeaders.Clear;
//
//            for i := 0 to Length(FCustomHeaders)- 1 do
//                FHttp.Request.CustomHeaders.Values[FCustomHeaders[i].Name] := FCustomHeaders[i].Value;
//
//            FHttp.Request.Accept     := 'application/json';
//            FHttp.Request.ContentType:= 'application/json; charset=utf-8';
//            FHttp.ReadTimeout        := 50000;
//
//            sResponse := FHttp.Post(url, Request);//  arrParams
//
//            HttpResponse.Response   := sResponse;
//            HttpResponse.HttpStatus := FHttp.ResponseCode;
//            HttpResponse.FErro      := False;
//
//        except
//            on e: EIdHTTPProtocolException do begin
//                    HttpResponse.Response   := e.ErrorMessage;
//                    HttpResponse.HttpStatus := FHttp.ResponseCode;
//                    HttpResponse.FErro      := True;
//                end;
//            on E: Exception do begin
//                HttpResponse.Response   := e.Message;
//                HttpResponse.HttpStatus := FHttp.ResponseCode;
//                HttpResponse.FErro      := True;
//
//            end;
//        end;
//
//
//         if (SISDebug.subStringExists(HttpResponse.Response, 'forwarding call to back-end server')) then
//            HttpResponse.Response := 'Falha na comunica��o com o servidor.';
//
//
//     finally
//           Result   := HttpResponse;
//           Request.Free;
//     end;
//
//end;

constructor TSISHttp.Create;
begin
    HttpResponse                    := TSISHttpResponse.Create;

    CreateFHttp;

//    FSSL                            := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
//    FHttp                           := TIdHTTP.Create(nil);
//
//    FHttp.HandleRedirects           := True;
//    FHttp.ProtocolVersion           := pv1_1;
//
//    FSSL.PassThrough                :=False;
//    FSSL.SSLOptions.Method          := sslvTLSv1;
//    FSSL.SSLOptions.Mode            := sslmUnassigned;
//    FSSL.SSLOptions.VerifyMode      := [];
//    FSSL.SSLOptions.VerifyDepth     := 0;
//    FSSL.Port                       := 443;
//
//    FHTTP.IOHandler                     := FSSL;
//    FHTTP.Request.BasicAuthentication   := False;
//
//    IdSSLOpenSSLHeaders.Load;
//    FHTTP.ReadTimeout               := 15000;
//    FHTTP.ConnectTimeout            := 3000;
end;

function TSISHttp.CreateFHttp: Boolean;
begin
    try
        FSSL                            := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
        FHttp                           := TIdHTTP.Create(nil);

        FHttp.HandleRedirects           := True;
        FHttp.ProtocolVersion           := pv1_1;

        FSSL.PassThrough                := False;
        FSSL.SSLOptions.Method          := sslvTLSv1;
        FSSL.SSLOptions.Mode            := sslmUnassigned;
        FSSL.SSLOptions.VerifyMode      := [];
        FSSL.SSLOptions.VerifyDepth     := 0;
        FSSL.Port                       := 443;

//        FHTTP.IOHandler                     := FSSL;
        FHTTP.Request.BasicAuthentication   := False;
//        IdSSLOpenSSLHeaders.Load;
        FHTTP.ReadTimeout               := 15000;
        FHTTP.ConnectTimeout            := 3000;
        Result := True;

    except
        Result := False;
    end;
end;

{

ObjChat:= TChatMalta.Create;
      ObjChat.MyHttp:= MyHttp;
      ObjChat.MySSL := MySSL;

      MyHttp.HandleRedirects:= True;
      MyHttp.ProtocolVersion:= pv1_1;

      MySSL.PassThrough:=False;
      MySSL.SSLOptions.Method:= sslvTLSv1;
      MySSL.SSLOptions.Mode := sslmUnassigned;
      MySSL.SSLOptions.VerifyMode := [];
      MySSL.SSLOptions.VerifyDepth := 0;
      MySSL.Port := 443;

      MyHTTP.IOHandler:=MySSL;
      MyHTTP.Request.BasicAuthentication:=false;

      IdSSLOpenSSLHeaders.Load;
      MyHTTP.ReadTimeout:=15000;
      MyHTTP.ConnectTimeout:=3000;

      }



function TSISHttp.HeaderAdd(Name, value: string): Boolean;
begin
    SetLength(FCustomHeaders, length(FCustomHeaders)+1);
    FCustomHeaders[length(FCustomHeaders)-1].Name := Name;
    FCustomHeaders[length(FCustomHeaders)-1].Value := value;
end;

function TSISHttp.HeaderClear: Boolean;
begin
    SetLength(FCustomHeaders, 0);
end;


function TSISHttp.Get(const Url: string): TSISHttpResponse;
var
  NetHandle: HINTERNET;
  UrlHandle: HINTERNET;
  Buffer: array[0..1024] of Char;
  BytesRead: dWord;
  Resultado:string;
begin
    try

        Resultado := '';
        NetHandle := InternetOpen('Delphi 5.x', INTERNET_OPEN_TYPE_PRECONFIG, nil, nil, 0);

        if Assigned(NetHandle) then begin

            try
                UrlHandle := InternetOpenUrl(NetHandle, PChar(Url), nil, 0, INTERNET_FLAG_RELOAD, 0);

                if Assigned(UrlHandle) then begin
                    { UrlHandle valid? Proceed with download }

                    FillChar(Buffer, SizeOf(Buffer), 0);

                    repeat
                        Resultado := Resultado + Buffer;
                        FillChar(Buffer, SizeOf(Buffer), 0);
                        InternetReadFile(UrlHandle, @Buffer, SizeOf(Buffer), BytesRead);
                    until BytesRead = 0;

                    InternetCloseHandle(UrlHandle);

                    HttpResponse.Response   := UTF8Decode(Resultado);
                    HttpResponse.HttpStatus := 200;
                    HttpResponse.FErro      := False;

                end else begin
                    { UrlHandle is not valid. Raise an exception. }
                    HttpResponse.Response   := 'Cannot open URL :' + Url;
                    HttpResponse.HttpStatus := -1;
                    HttpResponse.FErro      := True;
                end;

            finally
                InternetSetOption(NetHandle,INTERNET_OPTION_RESET_URLCACHE_SESSION,0,0);
                InternetCloseHandle(URLHandle);
            end;

        end else begin

            { NetHandle is not valid. Raise an exception }
            HttpResponse.Response   := 'Unable to initialize Wininet';
            HttpResponse.HttpStatus := -1;
            HttpResponse.FErro      := True;
        end;

    finally
        InternetCloseHandle(NetHandle);
        Result   := HttpResponse;
    end;
end;


function TSISHttp.Post(URL: string; strParams:string): TSISHttpResponse;
var Request:TStream;
    sResponse:String;
  i,iPos: Integer;
begin
    try

        try
            Request := TStringStream.Create(strParams);

            if (not Assigned(FHttp)) then
                CreateFHttp;

            FHttp.Request.CustomHeaders.Clear;

            for i := 0 to Length(FCustomHeaders)- 1 do
                FHttp.Request.CustomHeaders.Values[FCustomHeaders[i].Name] := FCustomHeaders[i].Value;

            FHttp.Request.Accept     := 'application/json';
            FHttp.Request.ContentType:= 'application/json; charset=utf-8';
            FHttp.ReadTimeout        := 50000;

            sResponse := FHttp.Post(url, Request);//  arrParams

            HttpResponse.Response   := sResponse;
            HttpResponse.HttpStatus := FHttp.ResponseCode;
            HttpResponse.FErro      := False;

        except
            on e: EIdHTTPProtocolException do begin
                    HttpResponse.Response   := e.ErrorMessage;
                    HttpResponse.HttpStatus := FHttp.ResponseCode;
                    HttpResponse.FErro      := True;
                end;
            on E: Exception do begin
                HttpResponse.Response   := e.Message;
                HttpResponse.HttpStatus := 500;
                HttpResponse.FErro      := True;

            end;
        end;


         if (subStringExists(HttpResponse.Response, 'forwarding call to back-end server')) then
            HttpResponse.Response := 'Falha na comunica��o com o servidor.';


     finally
           Result   := HttpResponse;
           Request.Free;
     end;

end;

{ TSISHttpResponse }

function TSISHttpResponse.GetSucesso: Boolean;
begin
    Result := (not Erro);
end;

procedure TSISHttpResponse.setErro(const Value: Boolean);
begin
  FErro := Value;
end;

procedure TSISHttpResponse.setSucesso(const Value: Boolean);
begin
    FErro := (not Value);
end;



{ TSISLibTel }

function TSISLibTel.Check(vValor: string): Boolean;

    function ValidaTelefone:Boolean;

        function getSequencial(value:Integer):string;
        var i:Integer;
        begin
            for i := 1 to 9 - 1 do
                Result := Result + IntToStr(value);
        end;

    var i:Integer;
    begin
        Result := False;

        for i := 1 to 9 - 1 do
            if (getSequencial(i) = trim(VALOR)) then Exit;

        if (copy(trim(VALOR), 1, 4) = '0000') then Exit;
        if (copy(trim(VALOR), 1, 4) = '1111') then Exit;
        if (copy(trim(VALOR), 1, 4) = '2222') then Exit;
        if (copy(trim(VALOR), 1, 4) = '3333') then Exit;
        if (copy(trim(VALOR), 1, 4) = '4444') then Exit;
        if (copy(trim(VALOR), 1, 4) = '5555') then Exit;
        if (copy(trim(VALOR), 1, 4) = '6666') then Exit;
        if (copy(trim(VALOR), 1, 4) = '7777') then Exit;
        if (copy(trim(VALOR), 1, 4) = '8888') then Exit;
        if (copy(trim(VALOR), 1, 4) = '9999') then Exit;

        Result := True;
    end;

begin

    try
        Result  := False;
        VALOR   := ReplaceSoNumero(vValor);

        if (not lenBool(VALOR)) then Exit;
        if (len(VALOR) < 8) then Exit;

        if (len(VALOR) = 13) then begin
            // 552192550331
            DDD     := Copy(VALOR, 3, 2);
            NUMERO  := Copy(VALOR, 5, 9);

        end else if (len(VALOR) = 12) then begin
            // 2120823274
            DDD := Copy(VALOR, 3, 2);
            NUMERO := Copy(VALOR, 5, 8);

        end else if (len(VALOR) = 10) then begin
            // 2120823274
            DDD := Copy(VALOR, 1, 2);
            NUMERO := Copy(VALOR, 3, 8);

        end else if (len(VALOR) = 11) then begin
            DDD := Copy(VALOR, 1, 2);
            NUMERO := Copy(VALOR, 3, 9);

        end else
            Exit;

        if (not ValidaTelefone) then Exit;
        Result := True;
    except
        Result := False;
    end;
end;

end.


function TForm5.PostJson(url, strParams: string): TResponseJson;
var
  ObjResult:TResponseJson;
  Request:TStream;
  sResponse:String;
  MySSL: TIdSSLIOHandlerSocketOpenSSL;
  MyHttp: TIdHTTP;
begin
     try
        MySSL   := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
        MyHttp  := TIdHTTP.Create(nil);

        MyHttp.HandleRedirects          := True;
        MyHttp.ProtocolVersion          := pv1_1;

        MySSL.PassThrough               :=False;
        MySSL.SSLOptions.Method         := sslvTLSv1;
        MySSL.SSLOptions.Mode           := sslmUnassigned;
        MySSL.SSLOptions.VerifyMode     := [];
        MySSL.SSLOptions.VerifyDepth    := 0;
        MySSL.Port                      := 443;

        MyHTTP.IOHandler:=MySSL;
        MyHTTP.Request.BasicAuthentication:=false;

        IdSSLOpenSSLHeaders.Load;
        MyHTTP.ReadTimeout      := 15000;
        MyHTTP.ConnectTimeout   := 3000;

        try
            Request := TStringStream.Create(strParams);
            MyHttp.Request.CustomHeaders.Clear;
            MyHttp.Request.CustomHeaders.Values['client_id']    := '21395797-1a9a-33fa-802c-e0d121b771fb';
            MyHttp.Request.CustomHeaders.Values['secret']       := 'f1544c00-3ae9-3b06-8d90-69a8dcad35f4';
            MyHttp.Request.CustomHeaders.Values['access_token'] := '04030015-2c52-3fa6-a946-1fd4b21e6b90';

            MyHttp.Request.Accept     := 'application/json';
            MyHttp.Request.ContentType:= 'application/json; charset=utf-8';
            //MyHttp.ReadTimeout        := 50000;

            sResponse := MyHttp.Post(url,Request);//  arrParams

            ObjResult.Response  := sResponse;
            ObjResult.HttpStatus:= MyHttp.ResponseCode;

        except
            on e: EIdHTTPProtocolException do begin
                ObjResult.Response:= e.ErrorMessage;
                ObjResult.HttpStatus:= MyHttp.ResponseCode;
                end;
            on E: Exception do begin
                ObjResult.Response  := e.Message;
                ObjResult.HttpStatus:= MyHttp.ResponseCode;
            end;
        end;

     finally
           Result:= ObjResult;
           Request.Free;
     end;
end;
