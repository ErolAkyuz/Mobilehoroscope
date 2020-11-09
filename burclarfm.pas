unit burclarfm;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FMX.Objects, FMX.ListView, FMX.TabControl, System.Actions, FMX.ActnList,
  FMX.StdCtrls, FMX.Controls.Presentation, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdHTTP, FMX.ScrollBox, FMX.Memo, FMX.WebBrowser,
  FMX.Advertising, System.DateUtils;

type
  Tfmburclar = class(TForm)
    TabControl1: TTabControl;
    TabItem1: TTabItem;
    TabItem2: TTabItem;
    TabItem3: TTabItem;
    ListView1: TListView;
    Image1: TImage;
    ToolBar1: TToolBar;
    Button1: TButton;
    IdHTTP1: TIdHTTP;
    Memo1: TMemo;
    WebBrowser1: TWebBrowser;
    ListView2: TListView;
    Memo2: TMemo;
    procedure Button1Click(Sender: TObject);
    procedure ListView1ItemClick(const Sender: TObject;
      const AItem: TListViewItem);
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure BannerAd1ActionCanBegin(Sender: TObject;
      var WillLeaveApplication: Boolean);
    procedure BannerAd1ActionDidFinish(Sender: TObject);
    procedure BannerAd1DidFail(Sender: TObject; const Error: string);
  private
    procedure yorum;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmburclar: Tfmburclar;
  StreamData :TMemoryStream;
  Url,html,sec, sayfa,burc, burc1,metin        : string;
  ActionBeginDate: TDateTime; WastedSeconds: Integer;

implementation

{$R *.fmx}
{$R *.NmXhdpiPh.fmx ANDROID}
{$R *.LgXhdpiPh.fmx ANDROID}

Function aradansec( text, ilk, son:String ): String;
begin
   Delete(Text, 1, pos(ilk, Text) + Length(ilk)-1);
   Result := Copy(Text, 1, Pos(Son, Text)-1);
end;

function degis(s:string):string;
var
 sonuc:String;
 secenek:TReplaceFlags;//unutmayın
begin
  result:='';
  secenek:=[rfReplaceAll]; //Harf Duyarlılığı var
  s:=StringReplace(s,'ý','ı',secenek);  //&Yacute;&THORN;  &ETH;
  s:=StringReplace(s,'þ','ş',secenek);
  s:=StringReplace(s,'ð','ğ',secenek);
  s:=StringReplace(s,'Ý','İ',secenek);   // ya&eth;&yacute;&thorn;
  s:=StringReplace(s,'Þ','Ş',secenek);
  s:=StringReplace(s,'Ð','Ğ',secenek);
  s:=StringReplace(s,'Ã§','ç',secenek);
  s:=StringReplace(s,'Ã¼','ü',secenek);
  s:=StringReplace(s,'Ä±','ı',secenek);
  s:=StringReplace(s,'Ã¶','ö',secenek);
  s:=StringReplace(s,'Ã‡','Ç',secenek);
  s:=StringReplace(s,'ÅŸ','ş',secenek);
  s:=StringReplace(s,'Ä°','İ',secenek);
  s:=StringReplace(s,'ÄŸ','ğ',secenek);
  result:=s;
end;

Procedure listeyekoy( AItem:TListViewItem; LItem: TListItemText; strRefKod, strText:String; iOffsetX, iOffsetY, iWidth,iHeight, iFontSize:Integer; iFontColor: LongInt );
 begin
    LItem                := TListItemText.Create(AItem);
    LItem.Name           := strRefKod;
    LItem.Font.Size      := iFontSize;
    LItem.TextColor      := iFontColor;
    LItem.Align          := TListItemAlign.Leading; // En Sol
    LItem.VertAlign      := TListItemAlign.Leading; // En Üst
    LItem.PlaceOffset.X  := iOffsetX;
    LItem.PlaceOffset.Y  := iOffsetY;
    LItem.TextAlign      := TTextAlign.Leading;
    LItem.Trimming       := TTextTrimming.ttnone;
    LItem.IsDetailText   := False;
    LItem.Width          := iWidth;
    LItem.Height         := iHeight;
    LItem.Text           := strText;
    LItem.WordWrap       := True;
 end;

procedure Tfmburclar.BannerAd1ActionCanBegin(Sender: TObject;
  var WillLeaveApplication: Boolean);
begin
  ActionBeginDate := Now;
end;

procedure Tfmburclar.BannerAd1ActionDidFinish(Sender: TObject);
var
Seconds: Integer;
begin
//  Seconds := SecondsBetween(ActionBeginDate, Now);
//  WastedSeconds := WastedSeconds + Seconds;
//  Label1.Text := IntToStr(WastedSeconds) + ' boyunca reklam izlenmiş ve bitmiş.';
end;

procedure Tfmburclar.BannerAd1DidFail(Sender: TObject; const Error: string);
begin
//  Label1.Text := 'Hata : ' + Error;
end;

procedure Tfmburclar.Button1Click(Sender: TObject);
begin
  with listview1.items.Add do
  begin
    Height := 100;
    Text := 'Koç Burcu';
    Detail := '(22 Mart - 20 Nisan)';
    Bitmap := image1.MultiResBitmap.items[0].Bitmap;
  end;

  with listview1.items.Add do
  begin
    Height := 100;
    Text := 'Boğa Burcu';
    Detail := '(21 Nisan – 21 Mayıs)';
    Bitmap := image1.MultiResBitmap.items[1].Bitmap;
  end;
  with listview1.items.Add do
  begin
    Height := 100;
    Text := 'İkizler Burcu';
    Detail := '(22 Mayıs - 23 Haziran)';
    Bitmap := image1.MultiResBitmap.items[2].Bitmap;
  end;

  with listview1.items.Add do
  begin
    Height := 100;
    Text := 'Yengeç Burcu';
    Detail := '(22 Haziran - 23 Temmuz)';
    Bitmap := image1.MultiResBitmap.items[3].Bitmap;
  end;

  with listview1.items.Add do
  begin
    Height := 100;
    Text := 'Aslan Burcu';
    Detail := '(24 Temmuz - 22 Ağustos)';
    Bitmap := image1.MultiResBitmap.items[4].Bitmap;
  end;

  with listview1.items.Add do
  begin
    Height := 100;
    Text := 'Başak Burcu';
    Detail := '(23 Ağustos - 22 Eylül)';
    Bitmap := image1.MultiResBitmap.items[5].Bitmap;
  end;

  with listview1.items.Add do
  begin
    Height := 100;
    Text := 'Terazi Burcu';
    Detail := '(23 Eylül - 22 Ekim)';
    Bitmap := image1.MultiResBitmap.items[6].Bitmap;
  end;

  with listview1.items.Add do
  begin
    Height := 100;
    Text := 'Akrep Burcu';
    Detail := '(23 Ekim - 22 Kasım)';
    Bitmap := image1.MultiResBitmap.items[7].Bitmap;
  end;

  with listview1.items.Add do
  begin
    Height := 100;
    Text := 'Yay Burcu';
    Detail := '(23 Kasım - 22 Aralık)';
    Bitmap := image1.MultiResBitmap.items[8].Bitmap;
  end;

  with listview1.items.Add do
  begin
    Height := 100;
    Text := 'Oğlak Burcu';
    Detail := '(23 Aralık - 20 Ocak)';
    Bitmap := image1.MultiResBitmap.items[9].Bitmap;
  end;

  with listview1.items.Add do
  begin
    Height := 100;
    Text := 'Kova Burcu';
    Detail := ' (21 Ocak - 19 Şubat)';
    Bitmap := image1.MultiResBitmap.items[10].Bitmap;
  end;

  with listview1.items.Add do
  begin
    Height := 100;
    Text := 'Balık Burcu';
    Detail := ' (20 Şubat - 21 Mart)';
    Bitmap := image1.MultiResBitmap.items[11].Bitmap;
  end;
end;

procedure Tfmburclar.Button2Click(Sender: TObject);
begin
//  BannerAd1.LoadAd;
end;

procedure Tfmburclar.FormCreate(Sender: TObject);
begin
  tabcontrol1.ActiveTab := Tabitem1;
//  BannerAd1.AdUnitID := 'ca-app-pub-2788669301895684/3932716258';
end;

procedure Tfmburclar.ListView1ItemClick(const Sender: TObject;
  const AItem: TListViewItem);
begin
  if listview1.ItemIndex = 0 then
  begin
    burc  := 'Koç';
    burc1  := 'koc';
    yorum;
    webbrowser1.URL:='http://www.kocburcu.net/koc-burcu-ozellikleri.html';
  end;

  if listview1.ItemIndex = 1 then
  begin
    burc  := 'Boğa';
    burc1  := 'boga';
    yorum;
  webbrowser1.URL:='http://www.bogaburcu.net/boga-burcu-ozellikleri.html';
  end;

  if listview1.ItemIndex = 2 then
  begin
    burc  := 'İkizler';
    burc1  := 'ikizler';
    yorum;
  webbrowser1.URL:='http://www.ikizlerburcu.net/ikizler-burcu-ozellikleri.html';
  end;

  if listview1.ItemIndex = 3 then
  begin
    burc  := 'Yengeç';
    burc1  := 'yengec';
    yorum;
  webbrowser1.URL:='http://www.yengecburcu.net/yengec-burcu-ozellikleri.html';
  end;

  if listview1.ItemIndex = 4 then
  begin
    burc  := 'Aslan';
    burc1  := 'aslan';
    yorum;
  webbrowser1.URL:='http://www.aslanburcu.net/aslan-burcu-ozellikleri.html';
  end;

  if listview1.ItemIndex = 5 then
  begin
    burc  := 'Başak';
    burc1  := 'basak';
    yorum;
  webbrowser1.URL:='http://www.basakburcu.net/basak-burcu-ozellikleri.html';
  end;

  if listview1.ItemIndex = 6 then
  begin
    burc  := 'Terazi';
    burc1  := 'terazi';
    yorum;
  webbrowser1.URL:='http://www.teraziburcu.net/terazi-burcu-ozellikleri.html';
  end;

  if listview1.ItemIndex = 7 then
  begin
    burc  := 'Akrep';
    burc1  := 'akrep';
    yorum;
  webbrowser1.URL:='http://www.akrepburcu.net/akrep-burcu-ozellikleri.html';
  end;

  if listview1.ItemIndex = 8 then
  begin
    burc  := 'Yay';
    burc1  := 'yay';
    yorum;
  webbrowser1.URL:='http://www.yayburcu.net/yay-burcu-ozellikleri.html';
  end;

  if listview1.ItemIndex = 9 then
  begin
    burc  := 'Oğlak';
    burc1  := 'oglak';
    yorum;
    webbrowser1.URL:='http://www.oglakburcu.net/oglak-burcu-ozellikleri.html';
  end;

  if listview1.ItemIndex = 10 then
  begin
    burc  := 'Kova';
    burc1  := 'kova';
    yorum;
  webbrowser1.URL:='http://www.kovaburcu.net/kova-burcu-ozellikleri.html';
  end;

   if listview1.ItemIndex = 11 then
  begin
    burc  := 'Balık';
    burc1  := 'balik';
    yorum;
  webbrowser1.URL:='http://www.balikburcu.net/balik-burcu-ozellikleri.html';
  end;

end;

procedure Tfmburclar.yorum;
const
 NONE              = $00; //Zero-value number
 INET_USERAGENT    = 'Mozilla/4.0, Indy Library (Windows; utf-8)';
 INET_REDIRECT_MAX = 10;
var
  StreamData :TMemoryStream;
  Url,html,sec, sayfa        : string;
  litemekle   : TListViewItem;
  LData1, LLabel1, LData2, LLabel2,LData3, LLabel3, LData4, LLabel4,LData5, LLabel5, LData6, LLabel6,
  LData7, LLabel7, LData8, LLabel8,LData9, LLabel9, LData10, LLabel10,LData11, LLabel11,
  LData12, LLabel12,LData13, LLabel13  : TListItemText;
  sag : integer;

begin
  TabControl1.Next;

  sayfa := 'http://www.sendeyim.net/astroloji/gunluk-burc-yorumlari/' + burc1 + '-burcu-gunluk-yorumu.html';
//  sayfa := 'https://www.sendeyim.com';
  idhttp1.request.userAgent:=INET_USERAGENT;
  idhttp1.redirectMaximum:=INET_REDIRECT_MAX;
  idhttp1.handleRedirects:=INET_REDIRECT_MAX<>NONE;
  Url := sayfa;
  StreamData := TMemoryStream.Create;
  try
    try
//     html:= idhttp1.Get(sayfa);
     idhttp1.Get(sayfa, StreamData);
     StreamData.Seek(0,soFromBeginning);
     memo1.SelectAll;
     memo1.ClearSelection;
     memo1.lines.LoadFromStream(StreamData);
     memo1.Lines.Text:=degis(memo1.Lines.Text);
    Except On E : Exception Do
//     MessageDlg('Exception: '+E.Message,mtError, [mbOK], 0);
    End;
  finally
    StreamData.free;
  end;

    listview2.items.Clear;
    litemekle := ListView2.Items.Add;
    litemekle.Height := 300;
    litemekle.Text   := '';
    sec := aradansec(memo1.Lines.Text, burc + ' Burcu Günlük Yorumu Aşk & İlişkiler</span></b>','<div style=');
    trimleft(sec);
    delete(sec, 1,25);
    while pos('</div>', sec) > 0 do
    begin
      sag := Ansipos('</div>', sec);
      Delete(sec, sag, 6);
    end;
    memo2.Lines.Clear;
    memo2.Lines.Add(sec);
    metin := aradansec(memo2.Lines.Text, '<div id="bosluk">', '<div class="reklam">');
    trimleft(metin);
    listeyekoy( LItemekle, LLabel1, 'Bas1', burc +  ' Burcu Günlük Yorumu Aşk & İlişkiler',   10, 10, 500, 200, 14, TAlphaColorRec.Maroon );
    listeyekoy( LItemekle, LData1, 'Data1', metin,  10, 30, 5000, 280, 13, TAlphaColorRec.Black );


    litemekle := ListView2.Items.Add;
    litemekle.Height := 300;
    litemekle.Text   := '';
    sec := aradansec(memo1.Lines.Text, burc + ' Burcu Günlük Yorumu İş &amp; Kariyer</span></b>','<div style=');
    trimleft(sec);
    memo2.Lines.Clear;
    memo2.Lines.Add(sec);
    delete(sec, 1,25);
    while pos('</div>', sec) > 0 do
    begin
      sag := Ansipos('</div>', sec);
      Delete(sec, sag, 6);
    end;
    metin := aradansec(memo2.Lines.Text, '<div id="bosluk"></div>', '</div>');
    trimleft(metin);
    listeyekoy( LItemekle, LLabel2, 'Bas2', burc +  ' Burcu Günlük Yorumu İş & Kariyer',   10, 10, 500, 200, 14, TAlphaColorRec.Maroon );
    listeyekoy( LItemekle, LData2, 'Data2', metin,  10, 30, 5000, 280, 13, TAlphaColorRec.Black );


    litemekle := ListView2.Items.Add;
    litemekle.Height := 300;
    litemekle.Text   := '';
    sec := aradansec(memo1.Lines.Text,burc + ' Burcu Günlük Yorumu Maddi Durum </span></b>',' <div class="reklam">');
    trimleft(sec);
    memo2.Lines.Clear;
    memo2.Lines.Add(sec);
    delete(sec, 1,25);
    while pos('</div>', sec) > 0 do
    begin
      sag := Ansipos('</div>', sec);
      Delete(sec, sag, 6);
    end;
    metin := aradansec(memo2.Lines.Text, '<div id="bosluk"></div>', '</div>');
    trimleft(metin);
    listeyekoy( LItemekle, LLabel2, 'Bas3', burc +  ' Burcu Günlük Yorumu Maddi Durum',   10, 10, 500, 200, 14, TAlphaColorRec.Maroon );
    listeyekoy( LItemekle, LData2, 'Data3', metin,  10, 30, 5000, 280, 13, TAlphaColorRec.Black );

    litemekle := ListView2.Items.Add;
    litemekle.Height := 300;
    litemekle.Text   := '';
    sec := aradansec(memo1.Lines.Text, burc + ' Burcu Günlük Yorumu Genel Durum </span></b>','<div style="font-size: 14px;padding:5px;border: 1px solid #ddd;margin-top:5px;">');
    trimleft(sec);
    memo2.Lines.Clear;
    memo2.Lines.Add(sec);
    delete(sec, 1,25);
    while pos('</div>', sec) > 0 do
    begin
      sag := Ansipos('</div>', sec);
      Delete(sec, sag, 6);
    end;
    metin := aradansec(memo2.Lines.Text, '<div id="bosluk"></div>', '</div>');
    trimleft(metin);
    listeyekoy( LItemekle, LLabel2, 'Bas4', burc +  ' Burcu Günlük Yorumu Genel Durum',   10, 10, 500, 200, 14, TAlphaColorRec.Maroon );
    listeyekoy( LItemekle, LData2, 'Data4', metin,  10, 30, 5000, 280, 13, TAlphaColorRec.Black );

    litemekle := ListView2.Items.Add;
    litemekle.Height := 300;
    litemekle.Text   := '';
    sec := aradansec(memo1.Lines.Text, 'mynet.com Sitesi '  + burc + ' Burcu Bugün Burç Yorumu</span></b>','<div style="border: 1px solid #ddd;">');
    trimleft(sec);
    delete(sec, 1,60);
    memo2.Lines.Clear;
    memo2.Lines.Add(sec);
    while pos('</div>', sec) > 0 do
    begin
      sag := Ansipos('</div>', sec);
      Delete(sec, sag, 6);
    end;
    metin := aradansec(memo2.Lines.Text, '', '</div>');
    metin := '                         ' + metin;
    listeyekoy( LItemekle, LLabel2, 'Bas6', 'mynet.com Sitesi '  + burc + ' Burcu Bugün Burç Yorumu',   10, 10, 500, 200, 14, TAlphaColorRec.Maroon );
    listeyekoy( LItemekle, LData2, 'Data6', metin,  10, 40, 5000, 280, 13, TAlphaColorRec.Black );

    litemekle := ListView2.Items.Add;
    litemekle.Height := 300;
    litemekle.Text   := '';
    sec := aradansec(memo1.Lines.Text, 'Sabah Gazetesi ' + burc + ' Burcu Bugün Burç Yorumu</span></b>','<div style="border: 1px solid #ddd;margin-top:5px;">');
    trimleft(sec);
    delete(sec, 1,60);
    memo2.Lines.Clear;
    memo2.Lines.Add(sec);
    while pos('</div>', sec) > 0 do
    begin
      sag := Ansipos('</div>', sec);
      Delete(sec, sag, 6);
    end;
    metin := aradansec(memo2.Lines.Text, '<div style="font-size: 14px;margin:5px">', '</div>');
    trimleft(metin);
    listeyekoy( LItemekle, LLabel2, 'Bas7', 'Sabah Gazetesi ' + burc + ' Burcu Bugün Burç Yorumu',   10, 10, 500, 200, 14, TAlphaColorRec.Maroon );
    listeyekoy( LItemekle, LData2, 'Data7', sec,  10, 50, 5000, 280, 13, TAlphaColorRec.Black );

    litemekle := ListView2.Items.Add;
    litemekle.Height := 300;
    litemekle.Text   := '';
    sec := aradansec(memo1.Lines.Text, 'Milliyet Gazetesi ' + burc + ' Burcu Bugün Burç Yorumu</span>','</div>');
    trimleft(sec);
    delete(sec, 1,60);
    memo2.Lines.Clear;
    memo2.Lines.Add(sec);
    metin := aradansec(memo2.Lines.Text, '<div id="bosluk">', '<div class="reklam">');
    trimleft(metin);    listeyekoy( LItemekle, LLabel2, 'Bas9', 'Milliyet Gazetesi ' + burc + ' Burcu Bugün Burç Yorumu',   10, 10, 500, 200, 14, TAlphaColorRec.Maroon );
    listeyekoy( LItemekle, LData2, 'Data9', sec,  10, 50, 5000, 280, 13, TAlphaColorRec.Black );

    litemekle := ListView2.Items.Add;
    litemekle.Height := 300;
    litemekle.Text   := '';
    sec := aradansec(memo1.Lines.Text, 'Takvim Gazetesi ' + burc + ' Burcu Bugün Burç Yorumu</span></b>','</div>');
    trimleft(sec);
    delete(sec, 1,58);
    memo2.Lines.Clear;
    memo2.Lines.Add(sec);
    metin := aradansec(memo2.Lines.Text, '<div id="bosluk">', '<div class="reklam">');
    trimleft(metin);
    listeyekoy( LItemekle, LLabel2, 'Bas10', 'Takvim Gazetesi ' + burc + ' Burcu Bugün Burç Yorumu',   10, 10, 500, 200, 14, TAlphaColorRec.Maroon );
    listeyekoy( LItemekle, LData2, 'Data10', sec,  10, 50, 5000, 280, 13, TAlphaColorRec.Black );
end;


end.
