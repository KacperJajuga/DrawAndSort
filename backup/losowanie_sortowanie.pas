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
      procedure dodajNaPoczatek(v : integer);
      procedure usunPoczatek;
      procedure podzielListe(var Lista1, Lista2 : Lista);
      procedure scalanieList(var Lista1, Lista2 : Lista);
      procedure sortowaniePrzezScalanie;
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
  while head <> nil do usunPoczatek;
end;

procedure Lista.dodajNaPoczatek(v : integer);
var
  p : KolejnyElementListy;
begin
  new ( p );
  p^.nastepnyElement := head;
  p^.dane := v;
  head := p;
end;

procedure Lista.usunPoczatek;
var
  p : KolejnyElementListy;
begin
  p := head;
  if p <> nil then
    begin
      head := p^.nastepnyElement;
      dispose (p);
    end;
end;

procedure Lista.podzielListe(var Lista1, Lista2 : Lista);
var
  p1, p2 : KolejnyElementListy;
  s : boolean;
begin
  s := false;
  Lista1.dodajNaPoczatek(0);
  Lista2.dodajNaPoczatek(0);
  p1 := Lista1.head;
  p2 := Lista2.head;
  while head <> nil do
    begin
      if s then
        begin
          p2^.nastepnyElement := head;
          p2 := p2^.nastepnyElement;
        end
      else
      begin
        p1^.nastepnyElement := head;
        p1 := p1^.nastepnyElement;
      end;
      head := head^.nastepnyElement;
      s := not s;
    end;
  p1^.nastepnyElement := nil;
  p2^.nastepnyElement := nil;
  Lista1.usunPoczatek;
  Lista2.usunPoczatek;
end;

procedure Lista.scalanieList(var Lista1, Lista2 : Lista);
var
  p : KolejnyElementListy;
begin
  dodajNaPoczatek(0);
  p := head;
  while (Lista1.head <> nil) and (Lista2.head <> nil) do
    begin
      if Lista1.head^.dane > Lista2.head^.dane then
        begin
          p^.nastepnyElement := Lista2.head;
          Lista2.head := Lista2.head^.nastepnyElement;
        end
      else
        begin
          p^.nastepnyElement := Lista1.head;
          Lista1.head := Lista1.head^.nastepnyElement;
        end;
      p := p^.nastepnyElement;
    end;
  while Lista1.head <> nil do
    begin
      p^.nastepnyElement := Lista1.head;
      Lista1.head := Lista1.head^.nastepnyElement;
      p := p^.nastepnyElement;
    end;
  while Lista2.head <> nil do
    begin
      p^.nastepnyElement := Lista2.head;
      Lista2.head := Lista2.head^.nastepnyElement;
      p := p^.nastepnyElement;
    end;
  usunPoczatek;
end;

procedure Lista.sortowaniePrzezScalanie;
var
  h1, h2 : Lista;
begin
  if (head <> nil) and (head^.nastepnyElement <> nil) then
    begin
      h1.inicjalizacja;
      h2.inicjalizacja;
      podzielListe(h1, h2);
      h1.sortowaniePrzezScalanie;
      h2.sortowaniePrzezScalanie;
      scalanieList(h1, h2);
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
  p : KolejnyElementListy;
begin
  randomize;
  NowaLista.niszczenie;                         //czyszczenie listy, gdy nie bedziemy jej sortowac
  Lista_Losowanie.Clear;
  NowaLista.inicjalizacja;
  for i:=1 to 20 do
  begin
    NowaLista.dodajNaPoczatek(random(1000));
  end;
  p := NowaLista.head;
  while p <> nil do
    begin
      Lista_Losowanie.Items.Add(IntToStr(p^.dane));
      p := p^.nastepnyElement;
    end;
end;

procedure TForm_LosSort.Button_SortujClick(Sender: TObject);
var
  p : KolejnyElementListy;
begin
  Lista_Sortowanie.Clear;
  NowaLista.sortowaniePrzezScalanie;
  p := NowaLista.head;
  while p <> nil do
    begin
      Lista_Sortowanie.Items.Add(IntToStr(p^.dane));
      p := p^.nastepnyElement;
    end;
  NowaLista.niszczenie;
end;

procedure TForm_LosSort.Button_InfoClick(Sender: TObject);
begin
  Edit_Info.Text:=InformacjaOProgramie;
end;

end.

