object frmCNAB: TfrmCNAB
  Left = 0
  Top = 0
  ActiveControl = Log
  Caption = 'frmCNAB'
  ClientHeight = 439
  ClientWidth = 632
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Calibri'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 19
  object Label1: TLabel
    Left = 19
    Top = 16
    Width = 181
    Height = 19
    Caption = 'Detalhes do Processamento'
  end
  object Log: TMemo
    Left = 15
    Top = 41
    Width = 603
    Height = 322
    TabOrder = 0
  end
  object Button1: TButton
    Left = 250
    Top = 384
    Width = 105
    Height = 38
    Caption = 'Fechar'
    TabOrder = 1
    OnClick = Button1Click
  end
  object OpenDialog: TOpenDialog
    Left = 552
    Top = 72
  end
end
