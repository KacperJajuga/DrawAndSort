unit Losowanie_Sortowanie;



{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TForm_LosSort }

  KolejnyElementListy = ^TypListy;

  TypListy = record
    dane : integer;
    nastepnyElement : KolejnyElementListy;
  end;

  Lista = object
    public
      head : KolejnyElementListy;

      constructor inicjalizacja;
      destructor niszczenie;
      procedure dodajNaKoniec(v : integer);
      procedure usunKoniec;
  end;

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
    procedure Button_SortujClick(Sender: TObject);
  private
    function InformacjaOProgramie : string;
  public

  end;

var
  Form_LosSort: TForm_LosSort;
  NowaLista : Lista;
  i : integer;

implementation

{$R *.lfm}

{ TForm_LosSort }

constructor Lista.inicjalizacja;
begin
  head := nil;
end;

destructor Lista.niszczenie;
begin
  while head <> nil do usunKoniec;
end;

procedure Lista.dodajNaKoniec(v : integer);
var
  p,e : KolejnyElementListy;
begin
  new ( e );
  e^.nastepnyElement := nil;
  e^.dane := v;
  p := head;
  if p = nil then
    head := e
  else
    begin
      while p^.nastepnyElement <> nil do p := p^.nastepnyElement;
      p^.nastepnyElement := e;
    end;
  end;

procedure Lista.usunKoniec;
var
  p : KolejnyElementListy;
begin
  p := head;
  if p <> nil then
    begin
      if p^.nastepnyElement <> nil then
        begin
          while p^.nastepnyElement^.nastepnyElement <> nil do
            p := p^.nastepnyElement;
          dispose (p^.nastepnyElement);
          p^.nastepnyElement := nil;
        end
      else
      begin
        dispose (p);
        head := nil;
      end;
    end;
end;

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
  wylosowanaLiczba: integer;
  p : KolejnyElementListy;
begin
  randomize;
  NowaLista.niszczenie;                         //czyszczenie listy, gdy nie bedziemy jej sortowac
  Lista_Losowanie.Clear;
  NowaLista.inicjalizacja;
  for i:=1 to 20 do
  begin
    NowaLista.dodajNaKoniec(random(1000));
  end;
end;

procedure TForm_LosSort.Button_SortujClick(Sender: TObject);
begin
  Lista_Sortowanie.Clear;
end;

procedure TForm_LosSort.Button_InfoClick(Sender: TObject);
begin
  Edit_Info.Text:=InformacjaOProgramie;
end;

end.

