unit unitVar;

{$mode objfpc}{$H+}

interface
   uses Classes, SysUtils;

   //initialisation
   procedure initialisation;

   //fish
   procedure setFish(val:Integer);
   function getFish : Integer;

   //gold
   procedure setGold(val:Integer);
   function getGold : Integer;

   //bois
   procedure setBois(val:Integer);
   function getBois : Integer;

   //outil
   procedure setOutil(val:Integer);
   function getOutil : Integer;

   //laine
   procedure setLaine(val:Integer);
   function getLaine : Integer;

   //tissu
   procedure setTissu(val:Integer);
   function getTissu : Integer;

   //colon
   procedure setColon(val:Integer);
   function getColon : Integer;

   //maison
   procedure setMaison(val:Integer);
   function getMaison : Integer;

   //cabaneP
   procedure setCabaneP(val:Integer);
   function getCabaneP : Integer;

   //cabaneB
   procedure setCabaneB(val:Integer);
   function getCabaneB : Integer;

   //bergerie
   procedure setBegerie(val:Integer);
   function getBergerie : Integer;

   //atelier
   procedure setAtelier(val:Integer);
   function getAtelier : Integer;

   //chapelle
   procedure setChapelle(val:Boolean);
   function getChapelle : Boolean;

   //centre-ville
   procedure setCentreVille(val:Boolean);
   function getCentreVille : Boolean;

implementation
   var
     fish,bois,outil,laine,tissu,gold,colon,maison,cabaneP,cabaneB,bergerie,atelier:Integer;
     chapelle,centreVille:Boolean;

   procedure initialisation;
   begin
     fish:= 10;
     bois:= 10;
     outil:= 10;
     laine:= 10;
     tissu:= 10;
     gold:= 500;
     colon:= 20;

     maison:= 5;
     cabaneP:= 0;
     cabaneB:= 0;
     bergerie:= 0;
     atelier:= 0;

     chapelle:= false;
     centreVille:= false;

   end;

   //fish
   procedure setFish(val:Integer);
   begin
     fish:=val;
   end;

   function getFish : Integer;
   begin
     getFish:=fish;
   end;

   //gold
   procedure setGold(val:Integer);
   begin
     gold:=val;
   end;

   function getGold : Integer;
   begin
     getGold:=gold;
   end;

   //bois
   procedure setBois(val:Integer);
   begin
     bois:=val;
   end;

   function getBois : Integer;
   begin
     getBois:=bois;
   end;

   //outil
   procedure setOutil(val:Integer);
   begin
     outil:=val;
   end;

   function getOutil : Integer;
   begin
     getOutil:=outil;
   end;

   //laine
   procedure setLaine(val:Integer);
   begin
     laine:=val;
   end;

   function getLaine : Integer;
   begin
     getLaine:=laine;
   end;

   //tissu
   procedure setTissu(val:Integer);
   begin
     tissu:=val;
   end;

   function getTissu : Integer;
   begin
     getTissu:=Tissu;
   end;

   //colon
   procedure setColon(val:Integer);
   begin
     colon:=val;
   end;

   function getColon : Integer;
   begin
     getColon:=colon;
   end;

   //maison
   procedure setMaison(val:Integer);
   begin
     maison:=val;
   end;

   function getMaison : Integer;
   begin
     getMaison:=maison;
   end;

   //cabaneP
   procedure setCabaneP(val:Integer);
   begin
     cabaneP:=val;
   end;

   function getCabaneP : Integer;
   begin
     getCabaneP:=cabaneP;
   end;

   //cabaneB
   procedure setCabaneB(val:Integer);
   begin
     cabaneB:=val;
   end;

   function getCabaneB : Integer;
   begin
     getCabaneB:=cabaneB;
   end;

   //bergerie
   procedure setBegerie(val:Integer);
   begin
     bergerie:=val;
   end;

   function getBergerie : Integer;
   begin
     getBergerie:=bergerie;
   end;

   //atelier
   procedure setAtelier(val:Integer);
   begin
     atelier:=val;
   end;

   function getAtelier : Integer;
   begin
     getAtelier:=atelier;
   end;

   //chapelle
   procedure setChapelle(val:Boolean);
   begin
     chapelle:=val;
   end;

   function getChapelle : Boolean;
   begin
     getChapelle:=chapelle;
   end;

   //centre-ville
   procedure setCentreVille(val:Boolean);
   begin
     centreVille:=val;
   end;

   function getCentreVille : Boolean;
   begin
     getCentreVille:=centreVille;
   end;

end.
