unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, VclTee.TeeGDIPlus, VCLTee.TeEngine,
  Vcl.ExtCtrls, VCLTee.TeeProcs, VCLTee.Chart, Vcl.StdCtrls, Vcl.Mask,
  VCLTee.TeeFunci, VCLTee.Series;

type
  TForm1 = class(TForm)
    LabeledEdit1: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    LabeledEdit3: TLabeledEdit;
    LabeledEdit4: TLabeledEdit;
    Button1: TButton;
    Button2: TButton;
    LabeledEdit5: TLabeledEdit;
    LabeledEdit6: TLabeledEdit;
    LabeledEdit7: TLabeledEdit;
    LabeledEdit8: TLabeledEdit;
    LabeledEdit9: TLabeledEdit;
    LabeledEdit10: TLabeledEdit;
    CheckBox1: TCheckBox;
    LabeledEdit11: TLabeledEdit;
    LabeledEdit12: TLabeledEdit;
    LabeledEdit13: TLabeledEdit;
    Chart1: TChart;
    Button3: TButton;
    Series1: TLineSeries;
    procedure Button2Click(Sender: TObject);
    procedure LabeledEdit1KeyPress(Sender: TObject; var Key: Char);
    procedure Button1Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  Re1,Im1,Re2,Im2:Real; //operators

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject); //calc
begin
  Re1:=StrToFloat(Form1.LabeledEdit1.Text);
  Im1:=StrToFloat(Form1.LabeledEdit3.Text);
  Re2:=StrToFloat(Form1.LabeledEdit2.Text);
  Im2:=StrToFloat(Form1.LabeledEdit4.Text);
  Form1.LabeledEdit5.Text:=FloatToStr(Re1+Re2)+'+'+FloatToStr(Im1+Im2)+'i'; //sum
  Form1.LabeledEdit6.Text:=FloatToStr(Re1-Re2)+'+('+FloatToStr(Im1-Im2)+')i'; //subs
  Form1.LabeledEdit7.Text:=FloatToStr((Re1*Re2)+(Im1*Im2*-1))+'+'+FloatToStr((Re1*Im2)+(Im1*Re2))+'i'; //mult
  Form1.LabeledEdit8.Text:='('+(FloatToStr((Re1*Re2)+(Im1*-Im2*-1))+'+('+FloatToStr((Re1*-Im2)+(Im1*Re2))+')i')+')/'+(FloatToStr((Re2*Re2)+(Im2*-Im2*-1)));
end;

procedure TForm1.Button2Click(Sender: TObject); //clear
var i:Byte;
begin
  for i:=0 to ComponentCount do
    if (Controls[i] is TLabeledEdit) then (Controls[i] as TLabeledEdit).Text:='0';
  Re1:=StrToFloat(Form1.LabeledEdit1.Text);
  Im1:=StrToFloat(Form1.LabeledEdit3.Text);
  Re2:=StrToFloat(Form1.LabeledEdit2.Text);
  Im2:=StrToFloat(Form1.LabeledEdit4.Text);
  Form1.LabeledEdit5.Text:=FloatToStr(Re1+Re2)+'+'+FloatToStr(Im1+Im2)+'i';
  Form1.LabeledEdit6.Text:=FloatToStr(Re1-Re2)+'+'+FloatToStr(Im1-Im2)+'i';
  Form1.LabeledEdit7.Text:=FloatToStr((Re1*Re2)+(Im1*Im2*-1))+'+'+FloatToStr((Re1*Im2)+(Im1*Re2))+'i';
  Form1.LabeledEdit8.Text:='('+(FloatToStr((Re1*Re2)+(Im1*-Im2*-1))+'+('+FloatToStr((Re1*-Im2)+(Im1*Re2))+')i')+')/'+(FloatToStr((Re2*Re2)+(Im2*-Im2*-1)));
end;

procedure TForm1.Button3Click(Sender: TObject);  //analyse
var Re,Im:Real;
begin
  Re:=StrToFloat(Form1.LabeledEdit9.Text);
  Im:=StrToFloat(Form1.LabeledEdit10.Text);
  Form1.LabeledEdit13.Text:='sqrt('+FloatToStr(sqr(Re)+sqr(Im))+')';
  if ((Re>0)and(Im>0))or((Re<0)and(Im<0)) then Form1.LabeledEdit11.Text:='atan('+FloatToStr(Im/Re)+')'
    else if (Re<0)and(Im>0) then Form1.LabeledEdit11.Text:='atan('+FloatToStr(Im/Re)+')+pi'
      else if (Re>0)and(Im<0) then Form1.LabeledEdit11.Text:='atan('+FloatToStr(Im/Re)+')-pi';
  Form1.LabeledEdit12.Text:=Form1.LabeledEdit13.Text+'*e^('+Form1.LabeledEdit11.Text+')';



        //not working yet. Maybe I'll fix that (but not in this life)
        var X,Y1:Integer;
        var X1,Y:Real;
        begin
          Series1.Clear;
          if (Im=0) then
            begin
              for X:=0 to Round(Re)+1 do
                begin
                  Y:=(X/Re)*Im;
                  Series1.AddXY(X,Y);
                end;
            end
          else if (Re=0) then
            begin
              for Y1:=0 to Round(Im)+1 do
                begin
                  X1:=(Y*Re)/Im;
                  Series1.AddXY(X,Y);
                end;
            end;
        end;
end;

procedure TForm1.CheckBox1Click(Sender: TObject);  //analysenable
begin
  if Form1.CheckBox1.Checked=True then
    begin
      Form1.LabeledEdit9.Enabled:=True;
      Form1.LabeledEdit10.Enabled:=True;
      Form1.LabeledEdit11.Enabled:=True;
      Form1.LabeledEdit12.Enabled:=True;
      Form1.LabeledEdit13.Enabled:=True;
      Form1.Button3.Enabled:=True;
      Form1.Chart1.Enabled:=True;
    end
  else
    begin
      Form1.LabeledEdit9.Enabled:=False;
      Form1.LabeledEdit10.Enabled:=False;
      Form1.LabeledEdit11.Enabled:=False;
      Form1.LabeledEdit12.Enabled:=False;
      Form1.LabeledEdit13.Enabled:=False;
      Form1.Button3.Enabled:=False;
      Form1.Chart1.Enabled:=False;
    end;
end;

procedure TForm1.LabeledEdit1KeyPress(Sender: TObject; var Key: Char); //chrset
begin
  if not (key in ['0'.. '9', '-', '+']) then
    key:= #0;
end;

end.
