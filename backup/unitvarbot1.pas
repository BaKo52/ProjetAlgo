unit unitVarBot1;

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

     bot = record //record gérant les données du bot
       r : r;
       b : b;
       nom : String;
       nbRound : Integer;
       etat : Boolean       //booléen servant à savoir si le bot a perdu ou non
     end;

   //Unité de gestion des ressources: getX donne la valeur de la ressource, setX la modifie
   //initialisation
   procedure initialisationBot1;

   //fish
   procedure setFishBot1(val:Integer);
   function getFishBot1 : Integer;

   //gold
   procedure setGoldBot1(val:Integer);
   function getGoldBot1 : Integer;

   //bois
   procedure setBoisBot1(val:Integer);
   function getBoisBot1 : Integer;

   //outil
   procedure setOutilBot1(val:Integer);
   function getOutilBot1 : Integer;

   //laine
   procedure setLaineBot1(val:Integer);
   function getLaineBot1 : Integer;

   //tissu
   procedure setTissuBot1(val:Integer);
   function getTissuBot1 : Integer;

   //colon
   procedure setColonBot1(val:Integer);
   function getColonBot1 : Integer;

   //soldats
   procedure setSoldatBot1(val:Integer);
   function getSoldatBot1 : Integer;

   //maison
   procedure setMaisonBot1(val:Integer);
   function getMaisonBot1 : Integer;

   //cabaneP
   procedure setCabanePBot1(val:Integer);
   function getCabanePBot1 : Integer;

   //cabaneB
   procedure setCabaneBBot1(val:Integer);
   function getCabaneBBot1 : Integer;

   //bergerie
   procedure setBergerieBot1(val:Integer);
   function getBergerieBot1 : Integer;

   //atelier
   procedure setAtelierBot1(val:Integer);
   function getAtelierBot1 : Integer;

   //chapelle
   procedure setChapelleBot1(val:Boolean);
   function getChapelleBot1 : Boolean;

   //centre-ville
   procedure setCentreVilleBot1(val:Boolean);
   function getCentreVilleBot1 : Boolean;

   //chantier naval
   procedure setNavalBot1(val:Boolean);
   function getNavalBot1 : Boolean;

   //bateaux
   procedure setBateauBot1(val:Integer);
   function getBateauBot1 : Integer;

   procedure setNbRoundBot1(val : Integer);
   function getNbRoundBot1 : Integer;

   procedure setNomBot1(val : String);
   function getNomBot1 : String;

   //procédure et donction gérant l'état du bot 1
   procedure setEtatBot1(val :Boolean);
   function getEtatBot1 : Boolean;

implementation
   var
     bot1 : bot;

   procedure initialisationBot1;
   begin
     bot1.r.fish := 100;
     bot1.r.bois := 100;
     bot1.r.outil := 100;
     bot1.r.laine := 100;
     bot1.r.tissu := 100;
     bot1.r.gold := 50000;
     bot1.r.colon := 12;
     bot1.r.soldat := 0;
     bot1.r.bateaux := 0;

     bot1.b.maison := 3;
     bot1.b.cabaneP := 0;
     bot1.b.cabaneB := 0;
     bot1.b.bergerie := 0;
     bot1.b.atelier := 0;

     bot1.b.chapelle := false;
     bot1.b.centreVille := false;
     bot1.b.chantierNaval := false;

     bot1.nom := 'Pol BOT';
     bot1.nbRound := 1;
     bot1.etat := false; //on la passe à false le bot n'est pas mort
   end;

   //fish
   procedure setFishBot1(val:Integer);
   begin
     bot1.r.fish:=val;
   end;

   function getFishBot1 : Integer;
   begin
     getFishBot1:=bot1.r.fish;
   end;

   //gold
   procedure setGoldBot1(val:Integer);
   begin
     bot1.r.gold:=val;
   end;

   function getGoldBot1 : Integer;
   begin
     getGoldBot1:=bot1.r.gold;
   end;

   //bois
   procedure setBoisBot1(val:Integer);
   begin
     bot1.r.bois:=val;
   end;

   function getBoisBot1 : Integer;
   begin
     getBoisBot1:=bot1.r.bois;
   end;

   //outil
   procedure setOutilBot1(val:Integer);
   begin
     bot1.r.outil:=val;
   end;

   function getOutilBot1 : Integer;
   begin
     getOutilBot1:=bot1.r.outil;
   end;

   //laine
   procedure setLaineBot1(val:Integer);
   begin
     bot1.r.laine:=val;
   end;

   function getLaineBot1 : Integer;
   begin
     getLaineBot1:=bot1.r.laine;
   end;

   //tissu
   procedure setTissuBot1(val:Integer);
   begin
     bot1.r.tissu:=val;
   end;

   function getTissuBot1 : Integer;
   begin
     getTissuBot1:=bot1.r.Tissu;
   end;

   //colon
   procedure setColonBot1(val:Integer);
   begin
     bot1.r.colon:=val;
   end;

   function getColonBot1 : Integer;
   begin
     getColonBot1:=bot1.r.colon;
   end;

   //soldats
   procedure setSoldatBot1(val:Integer);
   begin
     bot1.r.soldat:=val;
   end;

   function getSoldatBot1 : Integer;
   begin
     getSoldatBot1:=bot1.r.soldat;
   end;

   //bateau
   procedure setBateauBot1(val:Integer);
   begin
     bot1.r.bateaux:=val;
   end;

   function getBateauBot1 : Integer;
   begin
     getBateauBot1:=bot1.r.bateaux;
   end;

   //maison
   procedure setMaisonBot1(val:Integer);
   begin
     bot1.b.maison:=val;
   end;

   function getMaisonBot1 : Integer;
   begin
     getMaisonBot1:=bot1.b.maison;
   end;

   //cabaneP
   procedure setCabanePBot1(val:Integer);
   begin
     bot1.b.cabaneP:=val;
   end;

   function getCabanePBot1 : Integer;
   begin
     getCabanePBot1:=bot1.b.cabaneP;
   end;

   //cabaneB
   procedure setCabaneBBot1(val:Integer);
   begin
     bot1.b.cabaneB:=val;
   end;

   function getCabaneBBot1 : Integer;
   begin
     getCabaneBBot1:=bot1.b.cabaneB;
   end;

   //bergerie
   procedure setBergerieBot1(val:Integer);
   begin
     bot1.b.bergerie:=val;
   end;

   function getBergerieBot1 : Integer;
   begin
     getBergerieBot1:=bot1.b.bergerie;
   end;

   //atelier
   procedure setAtelierBot1(val:Integer);
   begin
     bot1.b.atelier:=val;
   end;

   function getAtelierBot1 : Integer;
   begin
     getAtelierBot1:=bot1.b.atelier;
   end;

   //chapelle
   procedure setChapelleBot1(val:Boolean);
   begin
     bot1.b.chapelle := val;
   end;

   function getChapelleBot1 : Boolean;
   begin
     getChapelleBot1 := bot1.b.chapelle;
   end;

   //centre-ville
   procedure setCentreVilleBot1(val:Boolean);
   begin
     bot1.b.centreVille := val;
   end;

   function getCentreVilleBot1 : Boolean;
   begin
     getCentreVilleBot1 := bot1.b.centreVille;
   end;

   //Chantier naval
   procedure setNavalBot1(val:Boolean);
   begin
     bot1.b.chantierNaval:=val;
   end;

   function getNavalBot1 : Boolean;
   begin
     getNavalBot1 := bot1.b.chantierNaval;
   end;

   procedure setNbRoundBot1(val : Integer);
   begin
     bot1.nbRound := val;
   end;

   function getNbRoundBot1 : Integer;
   begin
     getNbRoundBot1 := bot1.nbRound;
   end;

   procedure setNomBot1(val : String);
   begin
     bot1.nom := val;
   end;

   function getNomBot1 : String;
   begin
     getNomBot1 := bot1.nom;
   end;

   procedure setEtatBot1(val : Boolean);
   begin
     bot1.etat := val;
   end;

   function getEtatBot1 : Boolean;
   begin
     getEtatBot1 := bot1.etat;
   end;
end.

