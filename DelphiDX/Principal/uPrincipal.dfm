object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'Form2'
  ClientHeight = 681
  ClientWidth = 1105
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 17
  object Panel3: TPanel
    Left = 0
    Top = 0
    Width = 1105
    Height = 681
    Align = alClient
    BevelOuter = bvNone
    Color = 15987699
    ParentBackground = False
    TabOrder = 0
    object PageControl1: TPageControl
      Left = 408
      Top = 17
      Width = 686
      Height = 648
      ActivePage = tabAssistene
      TabOrder = 0
      OnChange = PageControl1Change
      object tabConversas: TTabSheet
        Caption = 'Conversas'
        object Panel1: TPanel
          Left = 0
          Top = 0
          Width = 678
          Height = 32
          Align = alTop
          Color = 15395562
          ParentBackground = False
          TabOrder = 0
          object Label11: TLabel
            Left = 4
            Top = 6
            Width = 78
            Height = 18
            Caption = 'Conversas'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -15
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
        end
        object Panel2: TPanel
          Left = 0
          Top = 32
          Width = 678
          Height = 584
          Align = alClient
          BevelOuter = bvNone
          Color = clWhite
          ParentBackground = False
          TabOrder = 1
          object Label10: TLabel
            Left = 9
            Top = 45
            Width = 84
            Height = 16
            Caption = 'Identificadores'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object Label3: TLabel
            Left = 9
            Top = 195
            Width = 119
            Height = 16
            Caption = 'His'#243'rico d Conversas'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object Label5: TLabel
            Left = 9
            Top = 360
            Width = 120
            Height = 16
            Caption = 'Mesagem do Usu'#225'rio'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object Label9: TLabel
            Left = 9
            Top = 468
            Width = 106
            Height = 16
            Caption = 'Mesagem do Robo'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object Button6: TButton
            Left = 8
            Top = 11
            Width = 127
            Height = 25
            Caption = 'Limpar Tudo'
            TabOrder = 0
          end
          object DBGrid2: TDBGrid
            Left = 9
            Top = 65
            Width = 654
            Height = 89
            DataSource = dmConexao.dsgoex_conversa_identificador
            Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
            TabOrder = 1
            TitleFont.Charset = ANSI_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -15
            TitleFont.Name = 'Arial'
            TitleFont.Style = []
            Columns = <
              item
                Expanded = False
                FieldName = 'id'
                Width = 52
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'id_empresa'
                Title.Caption = 'Empresa'
                Width = 74
                Visible = True
              end
              item
                Color = 12574719
                Expanded = False
                FieldName = 'tipo_identificador'
                Title.Caption = 'TP.Identificador'
                Width = 112
                Visible = True
              end
              item
                Color = 12574719
                Expanded = False
                FieldName = 'identificador'
                Title.Caption = 'Identificador'
                Width = 102
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'documento'
                Title.Caption = 'Documento'
                Width = 96
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'fatura'
                Title.Caption = 'Fatura'
                Width = 83
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'etapa'
                Title.Caption = 'ETP'
                Width = 38
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'msg_repetida_cliente'
                Title.Caption = 'MRC'
                Width = 40
                Visible = True
              end>
          end
          object Button4: TButton
            Left = 10
            Top = 164
            Width = 127
            Height = 25
            Caption = 'Limpar Tudo'
            TabOrder = 2
          end
          object DBGrid1: TDBGrid
            Left = 9
            Top = 214
            Width = 654
            Height = 139
            DataSource = dmConexao.dsgoex_conversa
            Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
            TabOrder = 3
            TitleFont.Charset = ANSI_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -15
            TitleFont.Name = 'Arial'
            TitleFont.Style = []
            Columns = <
              item
                Expanded = False
                FieldName = 'id'
                Width = 63
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'data'
                Visible = True
              end
              item
                Color = 12574719
                Expanded = False
                FieldName = 'identificador'
                Width = 96
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'responsavel'
                Width = 89
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'id_assistente'
                Width = 101
                Visible = True
              end>
          end
          object DBMemo1: TDBMemo
            Left = 9
            Top = 379
            Width = 655
            Height = 81
            DataField = 'mensagem'
            DataSource = dmConexao.dsgoex_conversa
            TabOrder = 4
          end
          object DBMemo2: TDBMemo
            Left = 9
            Top = 488
            Width = 654
            Height = 83
            DataField = 'resposta'
            DataSource = dmConexao.dsgoex_conversa
            TabOrder = 5
          end
          object BTAtualizarConversa: TButton
            Left = 590
            Top = 12
            Width = 75
            Height = 25
            Caption = 'Atualizar'
            TabOrder = 6
            OnClick = BTAtualizarConversaClick
          end
        end
      end
      object tabAssistene: TTabSheet
        Caption = 'Assistente'
        ImageIndex = 1
        object Label13: TLabel
          Left = 10
          Top = 292
          Width = 32
          Height = 16
          Caption = 'Rotas'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label14: TLabel
          Left = 9
          Top = 49
          Width = 58
          Height = 16
          Caption = 'Assistente'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label15: TLabel
          Left = 10
          Top = 469
          Width = 106
          Height = 16
          Caption = 'Mesagem do Robo'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Panel4: TPanel
          Left = 0
          Top = 0
          Width = 678
          Height = 32
          Align = alTop
          Color = 15395562
          ParentBackground = False
          TabOrder = 0
          object Label12: TLabel
            Left = 4
            Top = 6
            Width = 78
            Height = 18
            Caption = 'Assistente'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -15
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
        end
        object DBGrid3: TDBGrid
          Left = 10
          Top = 311
          Width = 657
          Height = 146
          DataSource = dmConexao.dsgoex_rotas_assistente
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
          TabOrder = 1
          TitleFont.Charset = ANSI_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -15
          TitleFont.Name = 'Arial'
          TitleFont.Style = []
          Columns = <
            item
              Expanded = False
              FieldName = 'id'
              Width = 63
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'ordem'
              Visible = True
            end
            item
              Color = 12574719
              Expanded = False
              FieldName = 'parametro'
              Width = 219
              Visible = True
            end>
        end
        object DBGrid4: TDBGrid
          Left = 9
          Top = 69
          Width = 657
          Height = 207
          DataSource = dmConexao.dsgoex_assistente
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
          TabOrder = 2
          TitleFont.Charset = ANSI_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -15
          TitleFont.Name = 'Arial'
          TitleFont.Style = []
          Columns = <
            item
              Expanded = False
              FieldName = 'id'
              Width = 52
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'id_empresa'
              Title.Caption = 'Empresa'
              Width = 74
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'tipo'
              Width = 102
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'nome'
              Width = 141
              Visible = True
            end>
        end
        object DBMemo3: TDBMemo
          Left = 9
          Top = 488
          Width = 657
          Height = 113
          DataField = 'pergunta'
          DataSource = dmConexao.dsgoex_rotas_assistente
          TabOrder = 3
        end
        object BTAtualizarAssistente: TButton
          Left = 590
          Top = 38
          Width = 75
          Height = 25
          Caption = 'Atualizar'
          TabOrder = 4
          OnClick = BTAtualizarAssistenteClick
        end
        object DBNavigator1: TDBNavigator
          Left = 426
          Top = 282
          Width = 240
          Height = 25
          DataSource = dmConexao.dsgoex_rotas_assistente
          TabOrder = 5
        end
      end
    end
    object GroupBox2: TGroupBox
      Left = 10
      Top = 10
      Width = 378
      Height = 80
      Caption = ' Infoma'#231#245'es do Servidor '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      object Label4: TLabel
        Left = 14
        Top = 24
        Width = 22
        Height = 16
        Caption = 'URL'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object spStatusServidor: TShape
        Left = 330
        Top = 22
        Width = 31
        Height = 14
      end
      object URL: TEdit
        Left = 14
        Top = 42
        Width = 347
        Height = 24
        TabOrder = 0
        Text = 'http://localhost:2525'
      end
    end
    object GroupBox1: TGroupBox
      Left = 10
      Top = 95
      Width = 378
      Height = 378
      Caption = ' Teste de Mensagem '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      object Label2: TLabel
        Left = 15
        Top = 73
        Width = 127
        Height = 16
        Caption = 'Mensagem do Usu'#225'rio'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object Label1: TLabel
        Left = 14
        Top = 24
        Width = 50
        Height = 16
        Caption = 'Empresa'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object Label6: TLabel
        Left = 82
        Top = 24
        Width = 58
        Height = 16
        Caption = 'Assistente'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object Label7: TLabel
        Left = 154
        Top = 24
        Width = 62
        Height = 16
        Caption = 'Tecnologia'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object Label8: TLabel
        Left = 261
        Top = 24
        Width = 71
        Height = 16
        Caption = 'Identificador'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object edMsgTesteMsg: TMemo
        Left = 15
        Top = 90
        Width = 346
        Height = 89
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        Lines.Strings = (
          'Teste')
        ParentFont = False
        TabOrder = 0
      end
      object Button1: TButton
        Left = 286
        Top = 187
        Width = 75
        Height = 25
        Caption = 'Enviar'
        TabOrder = 1
        OnClick = Button1Click
      end
      object edMsgTesteEmpresa: TEdit
        Left = 15
        Top = 42
        Width = 55
        Height = 24
        TabOrder = 2
        Text = '1'
      end
      object edMsgTesteAssistente: TEdit
        Left = 81
        Top = 42
        Width = 63
        Height = 24
        TabOrder = 3
        Text = '1'
      end
      object edMsgTesteTenologia: TEdit
        Left = 153
        Top = 42
        Width = 94
        Height = 24
        TabOrder = 4
        Text = '5001'
      end
      object edMsgTesteIdentificador: TEdit
        Left = 260
        Top = 42
        Width = 101
        Height = 24
        TabOrder = 5
        Text = '11952550331'
      end
      object edMsgTesteResp: TMemo
        Left = 15
        Top = 229
        Width = 346
        Height = 134
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 6
      end
    end
    object Button2: TButton
      Left = 988
      Top = 8
      Width = 103
      Height = 25
      Caption = 'Conectar DB'
      TabOrder = 3
      OnClick = Button2Click
    end
  end
  object Timer1: TTimer
    Interval = 2500
    OnTimer = Timer1Timer
    Left = 904
    Top = 32
  end
end
