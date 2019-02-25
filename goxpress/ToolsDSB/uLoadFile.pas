unit uLoadFile;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls;


type
    TFParametrosResult = class
    public
        Name:string;
        Posicao:Integer;
        Tamanho:Integer;
        Formato:string;
    end;

    TFParametros = class
    private
        function GetCount: Integer;

    protected
        Field:array of TFParametrosResult;
        IndexCount:Integer;
    public
        property Count:Integer read GetCount;
        function Add(Params:TFParametrosResult):Boolean;

    end;

    TFRegistrosValue = class
    public
        Name:string;
        Value:string;
    end;

    TFRegistros = class
    private
        function GetCount: Integer;

    protected
        Field:array of array of TFRegistrosValue;
        IndexCount:Integer;

    public
        property Count:Integer read GetCount;
        function Add(Params:TFRegistrosValue):Boolean;
    end;

    TLoadFileParams = record
        Name:string;
        Valor:string;
        Posicao:Integer;
        Tamanho:Integer;
    end;

    TLoadFile = class(TWinControl)
    private
        FParametros:TFParametros;
        FRegistros:TFRegistros;

        function FormatarEsquerda(Texto: string; Tamanho: Integer; Preenchimento:Char = ' '): string;
        function FormatarDireita(Texto: string; Tamanho: Integer; Preenchimento: Char = ' '):string;
        function SubstituirPos(Valor: string; Posicao, Tamanho: Integer): Boolean;
        function Eof: Boolean;
        procedure First;
        function Next: Boolean;
        procedure Last;
        function SaveFromFileTemplate(FileName: string): Boolean;
        function MontaFileTxt: Boolean;
    public
        constructor Create;
        constructor Destroy;
        function LoadFromFile(FileName:string):Boolean;
        function SaveFromFile(FileName:string):Boolean;

        function Append:Boolean;
        function Add(Params:TLoadFileParams):Boolean;

    end;

implementation

{ TLoadFile }

function TLoadFile.FormatarEsquerda(Texto: string; Tamanho: Integer; Preenchimento:Char = ' '): string;
var TextoFormatado:string;
  i: Integer;
begin
    TextoFormatado := Texto;
    for i := Length(Texto) to Tamanho-1 do
        TextoFormatado := TextoFormatado + Preenchimento;

    Result := TextoFormatado;
end;

function TLoadFile.FormatarDireita(Texto: string; Tamanho: Integer; Preenchimento:Char = ' '): string;
var TextoFormatado:string;
  i: Integer;
begin
    TextoFormatado := Texto;
    for i := Length(Texto) to Tamanho-1 do
        TextoFormatado :=  Preenchimento + TextoFormatado;

    Result := TextoFormatado;
end;

function TLoadFile.Add(Params:TLoadFileParams):Boolean;
var P1:TFParametrosResult;
    P2:TFRegistrosValue;
begin
    P1          := TFParametrosResult.Create;
    P1.Name     := UpperCase(Params.Name);
    P1.Posicao  := Params.Posicao;
    P1.Tamanho  := Params.Tamanho;
    if (not FParametros.Add(P1)) then Exit;

    P2          := TFRegistrosValue.Create;
    P2.Name     := UpperCase(Params.Name);
    P2.Value    := Params.Valor;
    FRegistros.Add(P2);
end;




function TLoadFile.SubstituirPos(Valor: string; Posicao, Tamanho: Integer): Boolean;
var Linha, Parte1, Parte2:string;
  i: Integer;
begin
//
//    Linha := FFileRow.Strings[iLinhaIndex];
//
//    Parte1 := '';
//    Parte2 := '';
//    if (Length(Linha) > 0) then begin
//        for i := 1 to Length(Linha) do begin
//            if (i < Posicao) then
//                Parte1 := Parte1 + Linha[i];
//
//            if (i > Tamanho) then
//                Parte2 := Parte2 + Linha[i];
//        end;
//
//        Linha := Parte1 + FormatarEsquerda(Valor, Tamanho) + Parte2;
//
//    end else
//        Linha := FormatarEsquerda(' ', Posicao) +  FormatarEsquerda(Valor, Tamanho);
//
//    FFileRow.Strings[iLinhaIndex] := Linha;
end;


function TLoadFile.Append: Boolean;
begin
//    FFileRow.Add('');
//    iLinhaIndex := FFileRow.Count-1;
end;

function TLoadFile.Next: Boolean;
begin
//    inc(iLinhaIndex);
//    if (iLinhaIndex > FFileRow.Count) then
//        iLinhaIndex := FFileRow.Count;
end;

function TLoadFile.Eof: Boolean;
begin
//    Result := (iLinhaIndex >= FFileRow.Count-1);
end;

procedure TLoadFile.First;
begin
//    iLinhaIndex := 0;
end;

procedure TLoadFile.Last;
begin
//    iLinhaIndex := FFileRow.Count-1;
end;

constructor TLoadFile.Create;
begin
    FParametros := TFParametros.Create;
    FRegistros  := TFRegistros.Create;
//    FFileRow := TStringList.Create;

//    iLinhaIndex := 0;
//    FFileRow.Add('');
end;

constructor TLoadFile.Destroy;
begin
    FreeAndNil(FRegistros);
    FreeAndNil(FParametros);
end;

function TLoadFile.LoadFromFile(FileName: string): Boolean;
begin
    if (not FileExists(FileName)) then Exit;

//    FFileName := FileName;
//    FFileRow.LoadFromFile(FFileName);

    Result := True;
end;


function TLoadFile.SaveFromFile(FileName: string): Boolean;
var SaveDialog: TSaveDialog;
begin
    try
        SaveDialog := TSaveDialog.Create(Self);

        SaveDialog.InitialDir   := ExtractFilePath(FileName);
        SaveDialog.FileName     := FileName;
        if (not SaveDialog.Execute) then Exit;

//        FParametros.SaveToFile(SaveDialog.FileName);

    finally
        FreeAndNil(SaveDialog);
    end;

end;

function TLoadFile.SaveFromFileTemplate(FileName: string): Boolean;
var SaveDialog: TSaveDialog;
begin
    try
        SaveDialog := TSaveDialog.Create(Self);

        SaveDialog.InitialDir   := ExtractFilePath(FileName);
        SaveDialog.FileName     := FileName;
        if (not SaveDialog.Execute) then Exit;
//        FParametros.SaveToFile(SaveDialog.FileName);

    finally
        FreeAndNil(SaveDialog);
    end;

end;


function TLoadFile.MontaFileTxt: Boolean;
var
  p, r: Integer;
  Arquivo:TStringList;
  Campo, Linha:string;
begin

    try
        Arquivo := TStringList.Create;
        Linha   := '';

        try

//            for r := 0 to FFileRow.Count-1 do begin
//
//                for p := 0 to FParametros.Count-1 do begin
//                    Campo := FParametros.Campo(p);
//                end;
//
//            end;

        except on E:Exception do begin

            end;
        end;

    finally
        FreeAndNil(Arquivo);
    end;

end;


{ TFParametros }


function TFParametros.GetCount: Integer;
begin
    Result := Length(Field);
end;

function TFParametros.Add(Params: TFParametrosResult): Boolean;
var
  i: Integer;
begin
    try
        try
            if (Length(Field) > 0) then begin
                for i := 0 to Length(Field)-1 do begin
                    if (Field[i].Name = Params.Name) then begin
                        Field[i].Posicao := Params.Posicao;
                        Field[i].Tamanho := Params.Tamanho;
                        Field[i].Formato := Params.Formato;
                        Result := True;
                        Exit;
                    end;
                end;

                SetLength(Field, length(Field)+1);
                IndexCount                  := length(Field)-1;
                Field[IndexCount]           := TFParametrosResult.Create;
                Field[IndexCount].Name      := Params.Name;
                Field[IndexCount].Posicao   := Params.Posicao;
                Field[IndexCount].Tamanho   := Params.Tamanho;
                Field[IndexCount].Formato   := Params.Formato;
                Result := True;
                Exit;
            end;

            SetLength(Field, length(Field)+1);
            IndexCount                  := length(Field)-1;
            Field[IndexCount]           := TFParametrosResult.Create;
            Field[IndexCount].Name      := Params.Name;
            Field[IndexCount].Posicao   := Params.Posicao;
            Field[IndexCount].Tamanho   := Params.Tamanho;
            Field[IndexCount].Formato   := Params.Formato;
            Result := True;
        except
            Result := False;
        end;
    finally
        Params.Free;
    end;
end;

{ TFRegistros }

function TFRegistros.Add(Params: TFRegistrosValue): Boolean;
var c:Integer;
begin
    try
        if (Length(Field) > 0) then begin

            if (Length(Field[IndexCount]) > 0) then // colunas
                for c := 0 to Length(Field[IndexCount])-1 do begin
                    if (Field[IndexCount][c].Name = Params.Name) then begin
                        Field[IndexCount][c].Value := Params.Value;
                        Result := True;
                        Exit;
                    end;
                end;

            SetLength(Field[IndexCount], length(Field[IndexCount])+1);
            Field[IndexCount][length(Field[IndexCount])-1] := TFRegistrosValue.Create;
            Field[IndexCount][length(Field[IndexCount])-1].Name   := Params.Name;
            Field[IndexCount][length(Field[IndexCount])-1].Value  := Params.Value;
            Result := True;
            Exit;
        end;

        SetLength(Field, length(Field)+1);
        SetLength(Field[0], length(Field[0])+1);
        Field[0][0] := TFRegistrosValue.Create;
        Field[0][0].Name   := Params.Name;
        Field[0][0].Value  := Params.Value;
        Result := True;
    except
        Result := False;
    end;
end;

function TFRegistros.GetCount: Integer;
begin

end;

end.


//Params:TLoadFileParams;
//    function Add(Campo, Valor:string; Posicao, Tamanho:Integer):Boolean;
//    begin
//        Params.Name     := Campo;
//        Params.Valor    := Valor;
//        Params.Posicao  := Posicao;
//        Params.Tamanho  := Tamanho;
//        LoadFile.Add(Params);
//    end;
//begin
//    try
//        LoadFile := TLoadFile.Create;
//        //LoadFile.LoadFromFile('C:\Temp\TesteRemessa.txt');
//
//        Add('Contato','Teste', 10, 20);
//        Add('Fixo','Teste', 10, 20);
//        Add('Celular','Teste', 10, 20);
