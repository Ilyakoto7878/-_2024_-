unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, jpeg, ExtCtrls, XPMan, ComCtrls, DB, ADODB, Grids, DBGrids,
  StdCtrls, DBCtrls, Mask, FR_DSet, FR_DBSet, FR_Rich, FR_BarC, FR_Class,
  FR_Shape, dbcgrids;

type
  TForm1 = class(TForm)
    Image1: TImage;
    XPManifest1: TXPManifest;
    PageControl1: TPageControl;
    ADOConnection1: TADOConnection;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    ADOPerson: TADOQuery;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    GroupBox2: TGroupBox;
    DateTimePoisk: TDateTimePicker;
    ADOCity: TADOQuery;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    ADOPoisk: TADOQuery;
    Button1: TButton;
    DataSource2: TDataSource;
    DBGrid2: TDBGrid;
    ADOPoiskarrival: TDateTimeField;
    ADOPoiskpoezdid: TAutoIncField;
    ADOPoisknum_pzd: TWideStringField;
    ADOPoiskid_otkuda: TIntegerField;
    ADOPoiskid_kuda: TIntegerField;
    ADOPoiskotkudaid: TAutoIncField;
    ADOPoiskotkudaname_station: TWideStringField;
    ADOPoiskotkudaid_city: TIntegerField;
    ADOPoiskkudaid: TAutoIncField;
    ADOPoiskkudaname_station: TWideStringField;
    ADOPoiskkudaid_city: TIntegerField;
    ADOPoiskcoid: TAutoIncField;
    ADOPoiskconame_city: TWideStringField;
    ADOPoiskckid: TAutoIncField;
    ADOPoiskckname_city: TWideStringField;
    ADOPoisktimesetid: TAutoIncField;
    ADOPoiskid_poezd: TIntegerField;
    ADOPoiskdayofweek: TIntegerField;
    ADOPoiskgototo: TDateTimeField;
    ADOPoiskduration: TDateTimeField;
    ADOStation: TADOQuery;
    DataSource3: TDataSource;
    DBGrid3: TDBGrid;
    DataSource4: TDataSource;
    DBGrid4: TDBGrid;
    Image2: TImage;
    DBGrid5: TDBGrid;
    ADOPoiskpoiskdayofweekid: TIntegerField;
    ADOPoiskname_day: TWideStringField;
    ADOPoiskkratko_day: TWideStringField;
    GroupBox3: TGroupBox;
    DBRadioGroup1: TDBRadioGroup;
    Label4: TLabel;
    DBEdit1: TDBEdit;
    Label5: TLabel;
    DBEdit2: TDBEdit;
    Label6: TLabel;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    Label7: TLabel;
    Label8: TLabel;
    DBEdit5: TDBEdit;
    GroupBox1: TGroupBox;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    ComboBox3: TComboBox;
    DateTimePicker1: TDateTimePicker;
    Label14: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Label15: TLabel;
    Button2: TButton;
    Button3: TButton;
    GroupBox4: TGroupBox;
    ComboBox4: TComboBox;
    ADOVagon: TADOQuery;
    DBText1: TDBText;
    DataSource5: TDataSource;
    ComboBox5: TComboBox;
    Button4: TButton;
    ADOTicket: TADOQuery;
    frReport1: TfrReport;
    frBarCodeObject1: TfrBarCodeObject;
    frRichObject1: TfrRichObject;
    frDBDataSetTicket: TfrDBDataSet;
    frDBDataSetPerson: TfrDBDataSet;
    frDBDataSetPoisk: TfrDBDataSet;
    frShapeObject1: TfrShapeObject;
    DBCtrlGrid1: TDBCtrlGrid;
    ADOTInfo: TADOQuery;
    DataSource6: TDataSource;
    DBText2: TDBText;
    DBText3: TDBText;
    DBText4: TDBText;
    DBText5: TDBText;
    DBText6: TDBText;
    DBText7: TDBText;
    DBText8: TDBText;
    DBText9: TDBText;
    DBText10: TDBText;
    DBText11: TDBText;
    DBText12: TDBText;
    DBText13: TDBText;
    DBText14: TDBText;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Bevel1: TBevel;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure DBGrid3CellClick(Column: TColumn);
    procedure TabSheet1Show(Sender: TObject);
    procedure TabSheet3Show(Sender: TObject);
    procedure DBGrid4CellClick(Column: TColumn);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure Edit5KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure DBGrid2CellClick(Column: TColumn);
    procedure ComboBox4Change(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
    procedure DBCtrlGrid1PaintPanel(DBCtrlGrid: TDBCtrlGrid;
      Index: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  DateTimePoisk.Date:=Date;
  ADOCity.First;
  ComboBox1.Clear;
  ComboBox2.Clear;
  while ADOCity.Eof=false do
    begin
     ComboBox1.Items.Add(ADOCity.FieldByName('name_city').AsString);
     ComboBox2.Items.Add(ADOCity.FieldByName('name_city').AsString);
     ADOCity.Next;
    end;
  ComboBox1.ItemIndex:=4;
  ComboBox2.ItemIndex:=5;
  ADOCity.RecNo:=6;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
 if DateTimePoisk.Date<Date then ShowMessage('Дата уже прошла, нельзя купить билеты в прошлом:)')
 else begin
  ADOPoisk.Filter:='dayofweek='+inttostr(DayOfWeek(DateTimePoisk.Date))+' and co.name_city='''+ComboBox1.Text+''' and ck.name_city='''+ComboBox2.Text+'''';
  DBGrid2CellClick(DBGrid2.Columns[0]);
 end;
end;

procedure TForm1.DBGrid3CellClick(Column: TColumn);
begin
 ADOStation.Filter:='id_city='+ADOCity.fieldbyname('id').AsString;
 DBGrid4CellClick(DBGrid4.Columns[0]);
end;

procedure TForm1.TabSheet1Show(Sender: TObject);
begin
 ADOPoisk.Filter:='poezd.id=0';
end;

procedure TForm1.TabSheet3Show(Sender: TObject);
begin
 DBGrid3CellClick(DBGrid3.Columns[0]);
end;

procedure TForm1.DBGrid4CellClick(Column: TColumn);
begin
 ADOPoisk.Filter:='id_otkuda='+ADOStation.fieldbyname('id').AsString;
 if FileExists(ExtractFilePath(Application.ExeName)+'Station/'+ADOStation.fieldbyname('id').AsString+'.jpg')
  then Image2.Picture.LoadFromFile(ExtractFilePath(Application.ExeName)+'Station/'+ADOStation.fieldbyname('id').AsString+'.jpg')
  else Image2.Picture:=nil;

end;

procedure TForm1.DBGrid1DblClick(Sender: TObject);
begin
 Edit1.Text:=ADOPerson.fieldbyname('f').AsString;
 Edit2.Text:=ADOPerson.fieldbyname('i').AsString;
 Edit3.Text:=ADOPerson.fieldbyname('o').AsString;
 Edit4.Text:=ADOPerson.fieldbyname('num_doc').AsString;
 ComboBox3.ItemIndex:=DBRadioGroup1.ItemIndex;
 TabSheet1.Show;
end;

procedure TForm1.Edit5KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if TEdit(Sender).Text=''
  then ADOPerson.Filter:=''
  else ADOPerson.Filter:='f like ''%'+TEdit(Sender).Text+'%'' or i like ''%'+TEdit(Sender).Text+'%'' or o like ''%'+TEdit(Sender).Text+'%''';

end;

procedure TForm1.Button2Click(Sender: TObject);
begin
 ADOPerson.Filter:='';
 ADOPerson.Append;
 ADOPerson.FieldByName('tip_doc').AsInteger:=1;
 ADOPerson.Post;
 DBEdit1.SetFocus;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
 try ADOPerson.Post; except end;
 DBGrid1DblClick(self);
end;

procedure TForm1.DBGrid2CellClick(Column: TColumn);
begin
  ADOVagon.Filter:='id_poezd='+ADOPoisk.FieldByName('id_poezd').AsString;
  ADOVagon.First;
  ComboBox4.Clear;
  while ADOVagon.Eof=false do
    begin
     ComboBox4.Items.Add('Вагон '+ADOVagon.FieldByName('num_vagon').AsString);
     ADOVagon.Next;
    end;
  ComboBox4.ItemIndex:=0;
  ComboBox4Change(self);
end;

procedure TForm1.ComboBox4Change(Sender: TObject);
var i:integer;
begin
  ADOVagon.Filter:='num_vagon='+copy(ComboBox4.Text,7,2)+' and id_poezd='+ADOPoisk.FieldByName('id_poezd').AsString;
  ComboBox5.Clear;
  for i:=1 to ADOVagon.FieldByName('kol_mest').AsInteger do ComboBox5.Items.Add('Место '+IntToStr(i));
  ComboBox5.ItemIndex:=0;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
 ADOTicket.Append;
 ADOTicket.FieldByName('id_person').AsInteger:=ADOPerson.FieldByName('id').AsInteger;
 ADOTicket.FieldByName('id_poezd').AsInteger:=ADOPoisk.FieldByName('id_poezd').AsInteger;
 ADOTicket.FieldByName('num_vagon').AsString:=copy(ComboBox4.Text,7,2);
 ADOTicket.FieldByName('num_mesta').AsString:=copy(ComboBox5.Text,7,2);
 ADOTicket.FieldByName('dt_from').AsDateTime:=DateTimePoisk.Date+ADOPoisk.FieldByName('gototo').AsDateTime;
 ADOTicket.FieldByName('dt_arrival').AsDateTime:=DateTimePoisk.Date+ADOPoisk.FieldByName('arrival').AsDateTime;
 ADOTicket.FieldByName('num_ticket').AsString:=copy(ADOPoisk.FieldByName('num_pzd').AsString,2,3)+' '+FormatDateTime('yymmdd',DateTimePoisk.Date)+' '+copy(ComboBox4.Text,7,2)+copy(ComboBox5.Text,7,2);
 ADOTicket.Post;
 ShowMessage('Билет создан № '+ADOTicket.FieldByName('num_ticket').AsString+' для '+ADOPerson.FieldByName('f').AsString);
 frReport1.LoadFromFile('ticket.frf');
 if frReport1.PrepareReport then frReport1.ShowPreparedReport;
 ADOTInfo.Requery();
 ADOTInfo.Last;
end;

procedure TForm1.ComboBox2Change(Sender: TObject);
begin
 Button1Click(self);
end;

procedure TForm1.DBCtrlGrid1PaintPanel(DBCtrlGrid: TDBCtrlGrid;
  Index: Integer);
begin
//  if Odd(DBCtrlGrid1.DataSource.DataSet.RecNo) then DBCtrlGrid1.Color:=clRed else DBCtrlGrid1.Color:=clBlue;

end;

end.
