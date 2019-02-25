unit udmConexao;

interface

uses
  Vcl.Forms, System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client,
  FireDAC.Comp.UI, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet;

type
  TdmConexao = class(TDataModule)
    FDConnection: TFDConnection;
    FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    FDTransaction1: TFDTransaction;
    FDTransaction2: TFDTransaction;
    goex_conversa: TFDQuery;
    dsgoex_conversa: TDataSource;
    dsgoex_conversa_identificador: TDataSource;
    goex_conversa_identificador: TFDQuery;
    goex_rotas_assistente: TFDQuery;
    dsgoex_rotas_assistente: TDataSource;
    dsgoex_assistente: TDataSource;
    goex_assistente: TFDQuery;
    procedure FDConnectionBeforeConnect(Sender: TObject);
    procedure dsgoex_conversa_identificadorDataChange(Sender: TObject;
      Field: TField);
    procedure dsgoex_assistenteDataChange(Sender: TObject; Field: TField);
    procedure goex_rotas_assistenteAfterInsert(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
    function Conectar: boolean;
  end;

var
  dmConexao: TdmConexao;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TdmConexao.dsgoex_assistenteDataChange(Sender: TObject;
  Field: TField);
begin
    try
        goex_rotas_assistente.Close;

        if not goex_assistente.Active then Exit;
        if goex_assistente.RecordCount = 0 then Exit;

        goex_rotas_assistente.SQL.Clear;
        goex_rotas_assistente.SQL.Add(' select * from goex_rotas_assistente');
        goex_rotas_assistente.SQL.Add(' where id_empresa = ' + goex_assistente.FieldByName('id_empresa').AsString);
        goex_rotas_assistente.SQL.Add(' and id_assistente = ' + goex_assistente.FieldByName('id').AsString);
        goex_rotas_assistente.SQL.Add(' order by id desc');
        goex_rotas_assistente.Open;

    except

    end;
end;

procedure TdmConexao.dsgoex_conversa_identificadorDataChange(Sender: TObject;
  Field: TField);
begin
    try
        dmConexao.goex_conversa.Close;

        if not goex_conversa_identificador.Active then Exit;
        if goex_conversa_identificador.RecordCount = 0 then Exit;

        dmConexao.goex_conversa.SQL.Clear;
        dmConexao.goex_conversa.SQL.Add(' select * from goex_conversa');
        dmConexao.goex_conversa.SQL.Add(' where id_empresa = ' + goex_conversa_identificador.FieldByName('id_empresa').AsString);
        dmConexao.goex_conversa.SQL.Add(' and identificador = ' + Chr(39) + goex_conversa_identificador.FieldByName('identificador').AsString + Chr(39));
        dmConexao.goex_conversa.SQL.Add(' order by id desc');
        dmConexao.goex_conversa.Open;

    except

    end;
end;

procedure TdmConexao.FDConnectionBeforeConnect(Sender: TObject);
begin
    FDPhysMySQLDriverLink1.VendorLib := ExtractFilePath(Application.ExeName) + 'libmysql.dll';
end;

procedure TdmConexao.goex_rotas_assistenteAfterInsert(DataSet: TDataSet);
begin
    goex_rotas_assistente.FieldByName('id_empresa').AsInteger := goex_assistente.FieldByName('id_empresa').AsInteger;
    goex_rotas_assistente.FieldByName('id_assistete').AsInteger := goex_assistente.FieldByName('id').AsInteger;
end;

function TdmConexao.Conectar:boolean;
begin
    FDConnection                    := TFDConnection.Create(nil);
    FDConnection.Params.DriverID    := 'MySQL';
    FDConnection.Params.Database    := 'maxtime01';
    FDConnection.Params.Add('Server=mysql.maxtime.info');
    FDConnection.Params.UserName    := 'maxtime01';
    FDConnection.Params.Password    := 'AB102030';
    FDConnection.Connected          := True;

end;

end.
