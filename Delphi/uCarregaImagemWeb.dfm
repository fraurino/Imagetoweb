object frmImgtoView: TfrmImgtoView
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'View Imagem Web'
  ClientHeight = 390
  ClientWidth = 392
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object edtUrlImagem: TEdit
    Left = 0
    Top = 28
    Width = 392
    Height = 21
    Align = alTop
    TabOrder = 1
    TextHint = 'Url da Imagem'
    ExplicitTop = 44
    ExplicitWidth = 271
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 49
    Width = 392
    Height = 341
    Align = alClient
    Caption = 'View Image'
    TabOrder = 2
    ExplicitTop = 65
    ExplicitWidth = 271
    ExplicitHeight = 320
    object Image1: TImage
      Left = 2
      Top = 15
      Width = 388
      Height = 324
      Align = alClient
      Center = True
      Stretch = True
      ExplicitLeft = 0
      ExplicitTop = 14
      ExplicitWidth = 189
      ExplicitHeight = 216
    end
  end
  object Button2: TButton
    Left = 0
    Top = 0
    Width = 392
    Height = 28
    Cursor = crHandPoint
    Align = alTop
    Caption = 'Go Image web'
    TabOrder = 0
    OnClick = Button2Click
    ExplicitTop = -6
  end
end
