object Form1: TForm1
  Left = 0
  Top = 0
  Align = alBottom
  Caption = 'Reparaturen'
  ClientHeight = 274
  ClientWidth = 1493
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClick = FormClick
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object ComboBox1: TComboBox
    Left = 0
    Top = 253
    Width = 1493
    Height = 21
    Align = alBottom
    Style = csDropDownList
    TabOrder = 0
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 1493
    Height = 253
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 1
    object TabSheet1: TTabSheet
      Caption = 'Reparaturen'
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object ListView1: TListView
        Left = 0
        Top = 0
        Width = 1485
        Height = 225
        Align = alClient
        Columns = <
          item
            Caption = 'Nummer'
            Width = 100
          end
          item
            Caption = 'Ger'#228't'
            Width = 100
          end
          item
            Caption = 'Nummer'
          end
          item
            Caption = 'Status'
            Width = 150
          end
          item
            Caption = 'Fehlerbeschreibung Kunde'
            Width = 250
          end
          item
            Caption = 'Fehlerbeschreibung Service'
            Width = 400
          end
          item
            Caption = 'Preis'
            Width = 60
          end
          item
            Caption = 'FehlerCodes'
            Width = 200
          end
          item
          end
          item
          end>
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGreen
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        GridLines = True
        ParentFont = False
        TabOrder = 0
        ViewStyle = vsReport
        OnClick = ListView1Click
        OnCustomDrawItem = ListView1CustomDrawItem
        OnInfoTip = ListView1InfoTip
      end
    end
  end
  object RESTRequest1: TRESTRequest
    Accept = 'application/json, text/plain; q=0.9, text/html;q=0.8,/'
    AcceptCharset = 'utf-8, *;q=0.8, */*'
    AcceptEncoding = 'raw'
    Client = RESTClient1
    Params = <
      item
      end>
    Resource = 'v3/items/26830/attachments/186420/content'
    Response = RESTResponse1
    Timeout = 0
    SynchronizedEvents = False
    Left = 944
    Top = 104
  end
  object RESTResponse1: TRESTResponse
    ContentType = 'text/html'
    Left = 944
    Top = 56
  end
  object RESTClient1: TRESTClient
    Authenticator = HTTPBasicAuthenticator1
    Accept = 'application/json, text/plain; q=0.9, text/html;q=0.8,/'
    AcceptCharset = 'utf-8, *;q=0.8,*/*'
    AcceptEncoding = 'raw'
    BaseURL = 'https://haynl.codebeamer-x.com/cb/rest'
    FallbackCharsetEncoding = 'UTF-8'
    Params = <>
    Left = 936
    Top = 168
  end
  object HTTPBasicAuthenticator1: THTTPBasicAuthenticator
    Username = 'Dirk-R'
    Password = '3sra!3sra'
    Left = 1040
    Top = 64
  end
  object Timer1: TTimer
    Interval = 60000
    OnTimer = Timer1Timer
    Left = 824
    Top = 80
  end
end
