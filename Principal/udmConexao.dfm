object dmConexao: TdmConexao
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 585
  Width = 964
  object FDConnection: TFDConnection
    Params.Strings = (
      'Database=maxtime01'
      'User_Name=maxtime01'
      'Password=AB102030'
      'Server=mysql.maxtime.info'
      'DriverID=MySQL'
      'Compress=False'
      'CharacterSet=latin1')
    LoginPrompt = False
    Transaction = FDTransaction1
    UpdateTransaction = FDTransaction1
    Left = 73
    Top = 24
  end
  object FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink
    DriverID = 'MySQL'
    VendorLib = 'C:\BotDelpi\libmySQL.dll'
    Left = 73
    Top = 80
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 72
    Top = 136
  end
  object FDTransaction1: TFDTransaction
    Connection = FDConnection
    Left = 72
    Top = 192
  end
  object FDTransaction2: TFDTransaction
    Connection = FDConnection
    Left = 72
    Top = 248
  end
  object goex_conversa: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      'select * from goex_conversa')
    Left = 238
    Top = 141
  end
  object dsgoex_conversa: TDataSource
    DataSet = goex_conversa
    Left = 238
    Top = 197
  end
  object dsgoex_conversa_identificador: TDataSource
    DataSet = goex_conversa_identificador
    OnDataChange = dsgoex_conversa_identificadorDataChange
    Left = 240
    Top = 79
  end
  object goex_conversa_identificador: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      'select * from goex_conversa')
    Left = 240
    Top = 24
  end
  object goex_rotas_assistente: TFDQuery
    BeforePost = goex_rotas_assistenteBeforePost
    Connection = FDConnection
    SQL.Strings = (
      'select * from goex_conversa')
    Left = 438
    Top = 141
  end
  object dsgoex_rotas_assistente: TDataSource
    DataSet = goex_rotas_assistente
    Left = 438
    Top = 197
  end
  object dsgoex_assistente: TDataSource
    DataSet = goex_assistente
    OnDataChange = dsgoex_assistenteDataChange
    Left = 440
    Top = 79
  end
  object goex_assistente: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      'select * from goex_conversa')
    Left = 440
    Top = 24
  end
end
