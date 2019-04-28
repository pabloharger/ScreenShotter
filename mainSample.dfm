object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Sample'
  ClientHeight = 547
  ClientWidth = 784
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 75
    Width = 31
    Height = 13
    Caption = 'Label1'
  end
  object Label2: TLabel
    Left = 16
    Top = 102
    Width = 31
    Height = 13
    Caption = 'Label1'
  end
  object Label3: TLabel
    Left = 16
    Top = 129
    Width = 31
    Height = 13
    Caption = 'Label1'
  end
  object Label4: TLabel
    Left = 16
    Top = 156
    Width = 31
    Height = 13
    Caption = 'Label1'
  end
  object Label5: TLabel
    Left = 16
    Top = 183
    Width = 31
    Height = 13
    Caption = 'Label1'
  end
  object Label6: TLabel
    Left = 72
    Top = 13
    Width = 259
    Height = 13
    Caption = 'To take the screenshot click in the button or CTRL + T'
    WordWrap = True
  end
  object Label7: TLabel
    Left = 16
    Top = 211
    Width = 31
    Height = 13
    Caption = 'Label1'
  end
  object Label8: TLabel
    Left = 16
    Top = 238
    Width = 31
    Height = 13
    Caption = 'Label1'
  end
  object Label9: TLabel
    Left = 16
    Top = 265
    Width = 31
    Height = 13
    Caption = 'Label1'
  end
  object Label10: TLabel
    Left = 16
    Top = 292
    Width = 31
    Height = 13
    Caption = 'Label1'
  end
  object Label11: TLabel
    Left = 16
    Top = 319
    Width = 31
    Height = 13
    Caption = 'Label1'
  end
  object Label12: TLabel
    Left = 16
    Top = 346
    Width = 31
    Height = 13
    Caption = 'Label1'
  end
  object Label13: TLabel
    Left = 16
    Top = 373
    Width = 31
    Height = 13
    Caption = 'Label1'
  end
  object Label14: TLabel
    Left = 16
    Top = 400
    Width = 31
    Height = 13
    Caption = 'Label1'
  end
  object Label15: TLabel
    Left = 16
    Top = 427
    Width = 31
    Height = 13
    Caption = 'Label1'
  end
  object Label16: TLabel
    Left = 16
    Top = 454
    Width = 31
    Height = 13
    Caption = 'Label1'
  end
  object Label17: TLabel
    Left = 16
    Top = 481
    Width = 31
    Height = 13
    Caption = 'Label1'
  end
  object Label18: TLabel
    Left = 72
    Top = 53
    Width = 69
    Height = 13
    Caption = 'Demo Fields...'
  end
  object ComboBox1: TComboBox
    Left = 72
    Top = 72
    Width = 700
    Height = 21
    TabOrder = 1
    Text = 'ComboBox1'
  end
  object Button1: TButton
    Left = 697
    Top = 514
    Width = 75
    Height = 25
    Caption = 'Submit'
    TabOrder = 17
  end
  object Edit1: TEdit
    Left = 72
    Top = 99
    Width = 700
    Height = 21
    TabOrder = 2
    Text = 'Edit1'
  end
  object Edit2: TEdit
    Left = 72
    Top = 126
    Width = 700
    Height = 21
    TabOrder = 3
    Text = 'Edit1'
  end
  object Edit3: TEdit
    Left = 72
    Top = 153
    Width = 700
    Height = 21
    TabOrder = 4
    Text = 'Edit1'
  end
  object Edit4: TEdit
    Left = 72
    Top = 180
    Width = 700
    Height = 21
    TabOrder = 5
    Text = 'Edit1'
  end
  object Button2: TButton
    Left = 351
    Top = 8
    Width = 75
    Height = 25
    Action = ActionPrint
    TabOrder = 0
  end
  object ComboBox2: TComboBox
    Left = 72
    Top = 208
    Width = 700
    Height = 21
    TabOrder = 6
    Text = 'ComboBox1'
  end
  object Edit5: TEdit
    Left = 72
    Top = 235
    Width = 700
    Height = 21
    TabOrder = 7
    Text = 'Edit1'
  end
  object Edit6: TEdit
    Left = 72
    Top = 262
    Width = 700
    Height = 21
    TabOrder = 8
    Text = 'Edit1'
  end
  object Edit7: TEdit
    Left = 72
    Top = 289
    Width = 700
    Height = 21
    TabOrder = 9
    Text = 'Edit1'
  end
  object Edit8: TEdit
    Left = 72
    Top = 316
    Width = 700
    Height = 21
    TabOrder = 10
    Text = 'Edit1'
  end
  object ComboBox3: TComboBox
    Left = 72
    Top = 343
    Width = 700
    Height = 21
    TabOrder = 11
    Text = 'ComboBox1'
  end
  object Edit9: TEdit
    Left = 72
    Top = 370
    Width = 700
    Height = 21
    TabOrder = 12
    Text = 'Edit1'
  end
  object Edit10: TEdit
    Left = 72
    Top = 397
    Width = 700
    Height = 21
    TabOrder = 13
    Text = 'Edit1'
  end
  object Edit11: TEdit
    Left = 72
    Top = 424
    Width = 700
    Height = 21
    TabOrder = 14
    Text = 'Edit1'
  end
  object Edit12: TEdit
    Left = 72
    Top = 451
    Width = 700
    Height = 21
    TabOrder = 15
    Text = 'Edit1'
  end
  object ComboBox4: TComboBox
    Left = 72
    Top = 478
    Width = 700
    Height = 21
    TabOrder = 16
    Text = 'ComboBox1'
  end
  object ActionManager1: TActionManager
    Left = 728
    Top = 8
    StyleName = 'Platform Default'
    object ActionPrint: TAction
      Caption = 'ActionPrint'
      ShortCut = 16468
      OnExecute = ActionPrintExecute
    end
  end
end
