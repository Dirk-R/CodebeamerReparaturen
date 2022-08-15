unit main;

// kkkkk

interface

uses
 Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Rest.Client, Vcl.StdCtrls, Generics.Collections,
  REST.Types, Data.Bind.Components, Data.Bind.ObjectScope,
  REST.Authenticator.Basic, System.Rtti, System.Bindings.Outputs,
  Vcl.Bind.Editors, Data.Bind.EngExt, Vcl.Bind.DBEngExt,  System.JSON,
  Vcl.ComCtrls, StrUtils , WEB.ReqMulti, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdHTTP, WinInet , IDUri, IdServerIOHandler,
  IdSSL, IdSSLOpenSSL, IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack,  Vcl.Clipbrd,
  VclTee.TeeGDIPlus, VCLTee.TeEngine, VCLTee.Series, Vcl.ExtCtrls,
  VCLTee.TeeProcs, VCLTee.Chart, dateutils;

type
  TForm1 = class(TForm)
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    RESTClient1: TRESTClient;
    HTTPBasicAuthenticator1: THTTPBasicAuthenticator;
    Timer1: TTimer;
    ComboBox1: TComboBox;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    ListView1: TListView;
    procedure Timer1Timer(Sender: TObject);
    procedure FormClick(Sender: TObject);
    procedure ListView1Click(Sender: TObject);
    procedure ListView1CustomDrawItem(Sender: TCustomListView; Item: TListItem;
      State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure ListView3Click(Sender: TObject);
    procedure ListView1InfoTip(Sender: TObject; Item: TListItem;
      var InfoTip: string);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;
  Rueckmeldungen : TStringlist;

implementation

{$R *.dfm}

procedure TForm1.FormClick(Sender: TObject);
begin
 Timer1Timer(Nil);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
 Rueckmeldungen := TStringList.Create;
end;

procedure TForm1.ListView1Click(Sender: TObject);
begin
 Timer1Timer(Nil);
end;

procedure TForm1.ListView1CustomDrawItem(Sender: TCustomListView;
  Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);
begin
 if Item.SubItems[2] = 'In Bewertung' then ListView1.Canvas.Brush.Color := clLime;
 if Item.SubItems[2] = 'Unbearbeitet' then ListView1.Canvas.Brush.Color := clRed;
 if Item.SubItems[2] = 'Untersuchen' then ListView1.Canvas.Brush.Color := clYellow;
 if Item.SubItems[2] = 'Bewertung abgeschlossen' then ListView1.Canvas.Brush.Color := clSkyBlue;
 if Item.SubItems[2] = 'In Bearbeitung' then ListView1.Canvas.Brush.Color := clMaroon;
 ListView1.Canvas.Font.Size := 8;
 ListView1.Canvas.Font.Color := clBlack;
end;

procedure TForm1.ListView1InfoTip(Sender: TObject; Item: TListItem;
  var InfoTip: string);
begin
 ;
end;

procedure TForm1.ListView3Click(Sender: TObject);
var
 reportstring   : string;
 reportstr2     : string;
 jValue         : TJSONValue;
 pp             : Integer;
 JSonValue      : TJSonValue;
 pages          : Integer;
 Eintraege      : TJsonValue;
 jsArr          : TJsonArray;
 jsARR2         : TJsonArray;
 element        : TJSONValue;
 element2       : TJSONValue;
begin
 reportstring := '';
 reportstring := reportstring + '((%2719.56520.status%27%20IN%20(%27In%20Bewertung%27)%20OR%20%2719.56520.status%27%20';
 reportstring := reportstring + 'IN%20(%27In%20Bearbeitung%27)%20OR%20%2719.56520.status%27%20IN';
 reportstring := reportstring + '%20(%27Reparatur%20abgeschlossen%27)%20OR%20%2719.56520.status%27%20IN%20(%27In%20';
 reportstring := reportstring + 'Bearbeitung%20aus%20STK%27)%20OR%20%2719.56520.status%27%20IN%20(%27In%20Bewertung%20aus%20STK%27)%20OR%20%2719.56520';
 reportstring := reportstring + '.status%27%20IN%20(%27Untersuchen%20aus%20STK%27)%20OR%20%2719.56520.status%27%20IN%20';
 reportstring := reportstring + '(%27Bewertung%20abgeschlossen%27))%20AND%20%2756520.choiceList[44]%27%20IN%20(13373))%20AND%20project.id%20IN%20(19)%20AND%20tracker.id%20IN%20(56520)';
 RESTRequest1.Resource := '/query/page/1?queryString=' + reportstring;
 Clipboard.AsText := reportstring;
 RESTRequest1.Execute;
 jValue:=RESTResponse1.JSONValue;
 JsonValue := TJSonObject.ParseJSONValue(jvalue.ToString);
 pp := JsonValue.GetValue<Integer>('trackerItems.total');
 pages := ( pp div 25 ) + 1;
 Eintraege := JSonValue.FindValue('trackerItems.items');
 jsArr := Eintraege as TJSONArray;
 Listview1.Clear;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var
 JSonValue      : TJSonValue;
 jValue         : TJSONValue;
 total          : String;
 pp             : Integer;
 i              : Integer;
 Eintrag        : TListItem;
 Eintraege      : TJsonValue;
 jsArr          : TJsonArray;
 jsARR2         : TJsonArray;
 element        : TJSONValue;
 element2       : TJSONValue;
 pages          : Integer;
 suche          : String;
 ff             : String;
 ff2            : String;
 Gesamtpreis    : real;
 ol             : Integer;
 Stknotwenig    : String;
 gewaehr        : String;
 uu             : Integer;
begin
 FormatSettings.DecimalSeparator := '.';
 RESTRequest1.Resource := '/query/page/1?queryString=project.id%20IN%20(19)%20AND%20tracker.id%20IN%20(56520)%20AND%20workItemStatus%20NOT%20IN%20(%27Closed%27)%20ORDER%20BY%20%2756520.customField[7]%27%20ASC';
 RESTRequest1.Execute;
 jValue:=RESTResponse1.JSONValue;
 JsonValue := TJSonObject.ParseJSONValue(jvalue.ToString);
 pp := JsonValue.GetValue<Integer>('trackerItems.total');
 pages := ( pp div 25 ) + 1;
 Eintraege := JSonValue.FindValue('trackerItems.items');
 jsArr := Eintraege as TJSONArray;
 Listview1.Clear;
 //pages := 1;
 Gesamtpreis := 0;
 pp := 0;
 for I := 1 to pages  do begin
  suche := '/query/page/'+inttostr(i)+'?queryString=project.id%20IN%20(19)%20AND%20tracker.id%20IN%20(56520)%20AND%20workItemStatus%20NOT%20IN%20(%27Closed%27)%20ORDER%20BY%20%2756520.customField[7]%27%20ASC';
  RESTRequest1.Resource := suche;
  RESTRequest1.Execute;
  jValue:=RESTResponse1.JSONValue;
  JsonValue := TJSonObject.ParseJSONValue(jvalue.ToString);
  Eintraege := JSonValue.FindValue('trackerItems.items');
  jsArr := Eintraege as TJSONArray;
  with ListView1 do begin
   for element in jsArr do begin
    element.TryGetValue('rückmeldung.name', ff2);
    if (ComboBox1.ItemIndex = -1) or ((ComboBox1.ItemIndex <> -1) and (ff2 = ComboBox1.Items[ComboBox1.ItemIndex])) then begin
     inc(pp);
     Eintrag := Items.Add;
     Eintrag.Caption := inttostr(ListView1.Items.Count);
     Eintrag.SubItems.Add( element.GetValue<string>('gerät.name') );
     Eintrag.SubItems.Add( element.GetValue<string>('seriennummer'));
     Eintrag.SubItems.Add( element.GetValue<string>('status.name'));
     Eintrag.SubItems.Add( element.GetValue<string>('fehlerbeschreibungKunde'));
     try
      if element.TryGetValue('fehlerbeschreibungService', ff) then Eintrag.SubItems.Add( ff ) else Eintrag.SubItems.Add('');
      if element.TryGetValue('rückmeldung.name', ff) then begin
       if not Rueckmeldungen.Find(ff, ol) then Rueckmeldungen.Add(ff);
      end;

      // test 1

      if element.TryGetValue('preisGesamt', ff) then Eintrag.SubItems.Add( ff ) ;
      if element.TryGetValue('gewährleistung.name', gewaehr) then begin
       if gewaehr = 'Ja' then
        ff := '0.0'
      end;

      Gesamtpreis := Gesamtpreis + StrToFloat(ff);
      if element.TryGetValue('fehlercodes', jsArr2) then begin
       ff := '';
       for element2 in jsARR2 do begin
        ff := ff + element2.GetValue<string>('name') + ' / ';
       end;
       Eintrag.SubItems.Add(ff);
      end;

      // test2
      // test3
      // test4
      // test3
      // test
      // test3


      if element.TryGetValue('sTKNotwendig.name', Stknotwenig) then begin
       if (Stknotwenig = 'Ja') and (Gewaehr = 'Nein') then begin
        Eintrag.Subitems.Add('62.00');
        Gesamtpreis := Gesamtpreis + 62.00;
       end else
        Eintrag.SubItems.Add('0.00');
      end;
      Eintrag.SubItems.Add(gewaehr);


      for uu := 1 to 5 do begin
       if element.TryGetValue('arbeitspakete'+inttostr(uu)+'.name', ff) then begin

       end;
      end;


      for uu := 1 to 5 do begin


      end;

     finally

     end;
    end;
   end;
  end;
 end;

 Caption := InttoStr(pp) +  '....letzte Abfrage um: ' + DateTimeToStr(Now) + '......' + FloatToStr(Gesamtpreis);
 if ComboBox1.Items.Count = 0 then
  for i:= 0 to Rueckmeldungen.Count - 1 do begin
   ComboBox1.Items.Add( Rueckmeldungen[i] );
  end;

end;

end.
