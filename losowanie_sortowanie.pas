unit Losowanie_Sortowanie;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TForm_LosSort }

  TForm_LosSort = class(TForm)
    Button_Koniec: TButton;
    Button_Info: TButton;
    Button_Sortuj: TButton;
    Button_Losuj: TButton;
    Edit_Info: TEdit;
    Label_ListaSort: TLabel;
    Label_ListaLos: TLabel;
    Lista_Losowanie: TListBox;
    Lista_Sortowanie: TListBox;
    procedure Button_InfoClick(Sender: TObject);
    procedure Button_KoniecClick(Sender: TObject);
    procedure Button_LosujClick(Sender: TObject);
  private
    function InformacjaOProgramie : string;
  public

  end;

var
  Form_LosSort: TForm_LosSort;

implementation

{$R *.lfm}

{ TForm_LosSort }

function TForm_LosSort.InformacjaOProgramie : string;
begin
  InformacjaOProgramie:='Kacper Jajuga'
end;

procedure TForm_LosSort.Button_KoniecClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TForm_LosSort.Button_LosujClick(Sender: TObject);
var
  i : integer;
begin
  for i:=1 to 20 do
  begin
    Lista_Losowanie.Items.Add(IntToStr(random(1000)));
  end;
end;

procedure TForm_LosSort.Button_InfoClick(Sender: TObject);
begin
  Edit_Info.Text:=InformacjaOProgramie;
end;

end.

