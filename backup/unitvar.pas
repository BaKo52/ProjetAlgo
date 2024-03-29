unit unitVar;

{$mode objfpc}{$H+}

interface
   uses Classes, SysUtils;

   type
     r = record //record contenant les données des ressources
       fish, bois, outil, laine, tissu, gold, colon, soldat, bateaux : Integer;
     end;

     b = record //record contenant les données des bâtiments
       maison, cabaneP, cabaneB, bergerie, atelier : Integer;
       chapelle, centreVille, chantierNaval : Boolean;
     end;

   //Unité de gestion des ressources: getX donne la valeur de la ressource, setX la modifie
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

   //soldats
   procedure setSoldat(val:Integer);
   function getSoldat : Integer;

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
   procedure setBergerie(val:Integer);
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

   //chantier naval
   procedure setNaval(val:Boolean);
   function getNaval : Boolean;

   //bateaux
   procedure setBateau(val:Integer);
   function getBateau : Integer;

   procedure setNbRound(val : Integer);

   function getNbRound : Integer;

   procedure setNom(val : String);
   function getNom : String;

   procedure setEtatBot1(val :Boolean);
   function getEtatBot1 : Boolean;

implementation
   var
     j : record //record gérant les données du joueur 1
       r : r;
       b : b;
     end;

     etatBot : record
       bot1 : Boolean;
     end;

     nbRound:Integer;
     nom : String;


   procedure initialisation;
   begin
     j.r.fish := 100;
     j.r.bois := 100;
     j.r.outil := 100;
     j.r.laine := 100;
     j.r.tissu := 100;
     j.r.gold := 50000;
     j.r.colon := 12;
     j.r.soldat := 0;
     j.r.bateaux := 0;

     j.b.maison := 3;
     j.b.cabaneP := 0;
     j.b.cabaneB := 0;
     j.b.bergerie := 0;
     j.b.atelier := 0;

     j.b.chapelle := false;
     j.b.centreVille := false;
     j.b.chantierNaval := false;

     nom := '';
     nbRound := 1;
   end;

   //fish
   procedure setFish(val:Integer);
   begin
     j.r.fish:=val;
   end;

   function getFish : Integer;
   begin
     getFish:=j.r.fish;
   end;

   //gold
   procedure setGold(val:Integer);
   begin
     j.r.gold:=val;
   end;

   function getGold : Integer;
   begin
     getGold:=j.r.gold;
   end;

   //bois
   procedure setBois(val:Integer);
   begin
     j.r.bois:=val;
   end;

   function getBois : Integer;
   begin
     getBois:=j.r.bois;
   end;

   //outil
   procedure setOutil(val:Integer);
   begin
     j.r.outil:=val;
   end;

   function getOutil : Integer;
   begin
     getOutil:=j.r.outil;
   end;

   //laine
   procedure setLaine(val:Integer);
   begin
     j.r.laine:=val;
   end;

   function getLaine : Integer;
   begin
     getLaine:=j.r.laine;
   end;

   //tissu
   procedure setTissu(val:Integer);
   begin
     j.r.tissu:=val;
   end;

   function getTissu : Integer;
   begin
     getTissu:=j.r.Tissu;
   end;

   //colon
   procedure setColon(val:Integer);
   begin
     j.r.colon:=val;
   end;

   function getColon : Integer;
   begin
     getColon:=j.r.colon;
   end;

   //soldats
   procedure setSoldat(val:Integer);
   begin
     j.r.soldat:=val;
   end;

   function getSoldat : Integer;
   begin
     getSoldat:=j.r.soldat;
   end;

   //bateau
   procedure setBateau(val:Integer);
   begin
     j.r.bateaux:=val;
   end;

   function getBateau : Integer;
   begin
     getBateau:=j.r.bateaux;
   end;

   //maison
   procedure setMaison(val:Integer);
   begin
     j.b.maison:=val;
   end;

   function getMaison : Integer;
   begin
     getMaison:=j.b.maison;
   end;

   //cabaneP
   procedure setCabaneP(val:Integer);
   begin
     j.b.cabaneP:=val;
   end;

   function getCabaneP : Integer;
   begin
     getCabaneP:=j.b.cabaneP;
   end;

   //cabaneB
   procedure setCabaneB(val:Integer);
   begin
     j.b.cabaneB:=val;
   end;

   function getCabaneB : Integer;
   begin
     getCabaneB:=j.b.cabaneB;
   end;

   //bergerie
   procedure setBergerie(val:Integer);
   begin
     j.b.bergerie:=val;
   end;

   function getBergerie : Integer;
   begin
     getBergerie:=j.b.bergerie;
   end;

   //atelier
   procedure setAtelier(val:Integer);
   begin
     j.b.atelier:=val;
   end;

   function getAtelier : Integer;
   begin
     getAtelier:=j.b.atelier;
   end;

   //chapelle
   procedure setChapelle(val:Boolean);
   begin
     j.b.chapelle:=val;
   end;

   function getChapelle : Boolean;
   begin
     getChapelle:=j.b.chapelle;
   end;

   //centre-ville
   procedure setCentreVille(val:Boolean);
   begin
     j.b.centreVille:=val;
   end;

   function getCentreVille : Boolean;
   begin
     getCentreVille:=j.b.centreVille;
   end;

   //Chantier naval
   procedure setNaval(val:Boolean);
   begin
     j.b.chantierNaval:=val;
   end;

   function getNaval : Boolean;
   begin
     getNaval:=j.b.chantierNaval;
   end;

   procedure setNbRound(val : Integer);
   begin
     nbRound := val;
   end;

   function getNbRound : Integer;
   begin
     getNbRound := nbRound;
   end;

   procedure setNom(val : String);
   begin
     nom := val;
   end;

   function getNom : String;
   begin
     getNom := nom;
   end;

   procedure setEtatBot1(val : Boolean);
   begin
     etatBot.bot1 := val;
   end;

   function getEtatBot1 : Boolean;
   begin
     getEtatBot1 := etatBot.bot1;
   end;

end.
