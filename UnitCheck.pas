unit UnitCheck;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, Grids, DBGrids, StdCtrls, Mask, DBCtrls, XPMan, jpeg,
  ExtCtrls, ComCtrls;

type
  TForm1 = class(TForm)
    ADOConnection1: TADOConnection;
    ADOQuery1: TADOQuery;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    ComboBox1: TComboBox;
    ADOPoezda: TADOQuery;
    ComboBox2: TComboBox;
    ADOVagon: TADOQuery;
    Label15: TLabel;
    Edit5: TEdit;
    XPManifest1: TXPManifest;
    Image1: TImage;
    DateTimePicker1: TDateTimePicker;
    procedure FormCreate(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure Edit5KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
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
 DateTimePicker1.Date:=date;
 ComboBox1.Clear;
 while ADOPoezda.Eof=false do
 begin
  ComboBox1.Items.Add('Поезд '+ADOPoezda.fieldbyname('num_pzd').AsString);
  ADOPoezda.Next;
 end;
 ComboBox1.ItemIndex:=0;

end;

procedure TForm1.ComboBox1Change(Sender: TObject);
begin
 ADOQuery1.Filter:='num_pzd='''+copy(ComboBox1.Text,7,4)+'''';
 try ADOVagon.Filter:='id_poezd='+ADOQuery1.fieldbyname('id_poezd').AsString
 except ADOVagon.Filter:='id_poezd=0'; end;

 ComboBox2.Clear;
 while ADOVagon.Eof=false do
 begin
  ComboBox2.Items.Add('Вагон '+ADOVagon.fieldbyname('num_vagon').AsString+' (мест '+ADOVagon.fieldbyname('kol_mest').AsString+')');
  ADOVagon.Next;
 end;
 ComboBox2.ItemIndex:=0;

end;

procedure TForm1.ComboBox2Change(Sender: TObject);
begin
 ADOQuery1.Filter:='num_vagon='+copy(ComboBox2.Text,7,2)+' and num_pzd='''+copy(ComboBox1.Text,7,4)+'''';

end;

procedure TForm1.DBGrid1DblClick(Sender: TObject);
begin
 ADOQuery1.Edit;
 ADOQuery1.FieldByName('check').AsBoolean:=true;
 ADOQuery1.Post;
end;

procedure TForm1.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
 if (TDBGrid(Sender).DataSource.DataSet.FieldByName('check').AsBoolean=true) //and (Column.Index>0) and not (gdSelected in State)
  then begin
   TDBGrid(Sender).Canvas.Font.Color:=clGreen;
   TDBGrid(Sender).Canvas.Brush.Color:=$00E1FFE1;
  end;
 TDBGrid(Sender).DefaultDrawColumnCell(Rect,DataCol,Column,State);

end;

procedure TForm1.Edit5KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if TEdit(Sender).Text=''
  then ADOQuery1.Filter:='num_vagon='+copy(ComboBox2.Text,7,2)+' and num_pzd='''+copy(ComboBox1.Text,7,4)+''''
  else ADOQuery1.Filter:='num_vagon='+copy(ComboBox2.Text,7,2)+' and num_pzd='''+copy(ComboBox1.Text,7,4)+''' and f like '''+TEdit(Sender).Text+'%''';

end;

end.
