object Form1: TForm1
  Left = 0
  Top = 0
  ActiveControl = Button1
  Caption = 'Form1'
  ClientHeight = 510
  ClientWidth = 733
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWhite
  Font.Height = -16
  Font.Name = 'Calibri'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 19
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 733
    Height = 510
    Align = alClient
    BevelOuter = bvNone
    ParentBackground = False
    TabOrder = 0
    object Panel2: TPanel
      Left = 0
      Top = 0
      Width = 733
      Height = 37
      Align = alTop
      BevelOuter = bvNone
      Color = 9199360
      ParentBackground = False
      TabOrder = 0
      object Label1: TLabel
        Left = 7
        Top = 7
        Width = 74
        Height = 23
        Caption = 'DSB Tools'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = -19
        Font.Name = 'Calibri'
        Font.Style = []
        ParentFont = False
      end
      object Panel3: TPanel
        Left = 0
        Top = 35
        Width = 733
        Height = 2
        Align = alBottom
        BevelOuter = bvNone
        Color = clAqua
        ParentBackground = False
        TabOrder = 0
      end
    end
    object GroupBox1: TGroupBox
      Left = 24
      Top = 56
      Width = 242
      Height = 72
      Caption = ' CNAB '
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -16
      Font.Name = 'Calibri'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      DesignSize = (
        242
        72)
      object Button1: TButton
        Left = 12
        Top = 32
        Width = 216
        Height = 28
        Anchors = [akLeft, akTop, akRight]
        Caption = 'Gerar Arquivo Teste Retorno'
        TabOrder = 0
        OnClick = Button1Click
      end
    end
  end
end
