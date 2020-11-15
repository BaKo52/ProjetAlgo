unit unitAnno;

{$mode objfpc}{$H+} {$CODEPAGE UTF8}



interface
   uses Classes, SysUtils, GestionEcran;

   type
       ressource = (poisson,bois,outil,laine,tissu,argent);
       bati = (maison,cabaneP,cabaneB,bergerie,tisserand);
       batSoc = (chapelle,centreVille);

       valeurRessource = Array [ressource] of Integer;
       batimentSocial = Array [bati] of Integer;
       chapelleCentreVille = Array [batSoc] of boolean;

   //automatisation de l'affichage du texte avec des coordonnées x et y (centre le texte)
   procedure ecrireTexteCentre(x1,y1:Integer;texte1:String);

   //automatisation de l'affichage du texte avec des coordonnées x et y (ne centre pas le texte)
   procedure ecrireTexte(x1,y1:Integer;texte1:String);

   //affichage du menu principal
   procedure menuPrincipal();

   //affichage du menu de présentation
   procedure presentation();

   //affichage du menu de création de partie
   procedure create();

   //affichage du menu de gestion de l'île
   procedure ile(var valRess:valeurRessource; nom:String);



implementation

   procedure ecrireTexteCentre(x1,y1:Integer;texte1:String);
   var
     pos:Coordonnees;
   begin
     pos.x:=x1-round(length(texte1)/2);
     pos.y:=y1;
     ecrireEnPosition(pos,texte1);
   end;

   procedure ecrireTexte(x1,y1:Integer;texte1:String);
   var
     pos:Coordonnees;
   begin
     pos.x:=x1;
     pos.y:=y1;
     ecrireEnPosition(pos,texte1);
   end;

   procedure menuPrincipal();
   var
     x,y:Integer;
     texte:String;

   begin
     changerTailleConsole(200,60);
     texte:='Anno 1701';
     x:=100;
     y:=10;
     ecrireTexteCentre(x,y,texte);

     texte:='1. Pour créer une Nouvelle Partie';
     x:=100;
     y:=45;
     ecrireTexteCentre(x,y,texte);

     texte:='2. Pour Quitter';
     x:=100;
     y:=50;
     ecrireTexteCentre(x,y,texte);

     texte:='Allez à ? ';
     x:=100;
     y:=55;
     ecrireTexteCentre(x,y,texte);



   end;

   procedure presentation();
      var
        x,y:Integer;
        texte:String;
        intro:Text;

      begin
        effacerEcran();
        assign(intro, 'intro.txt');
        reset(intro);

        x:=100;
        y:=15;
        while not eof(intro) do
        begin
          readln(intro, texte);
          ecrireTexteCentre(x,y,texte);
          y:=y+1;
        end;

        texte:='1. Pour Accoster ?';
        x:=100;
        y:=45;
        ecrireTexteCentre(x,y,texte);

        texte:='2. Pour Quitter';
        x:=100;
        y:=50;
        ecrireTexteCentre(x,y,texte);

        close(intro);
      end;

   procedure create();
   var
     x,y:Integer;
     texte:String;

   begin
     effacerEcran();

     couleurs(black,LightGray);
     texte:='CREATION DE VOTRE PERSONNAGE';
     x:=100;
     y:=5;
     ecrireTexteCentre(x,y,texte);

     couleurs(white,black);
     texte:='Entrer le nom de votre personnage : ';
     x:=40;
     y:=15;
     ecrireTexteCentre(x,y,texte);

   end;

   procedure ile(var valRess:valeurRessource; nom:String);
   var
     x,y:Integer;
     texte:String;

   begin
     effacerEcran;

     dessinerCadreXY(95,1,105,3,simple,white,black);

     x:=100;
     y:=2;
     texte:='Isla Soma';
     couleurs(white,cyan);
     ecrireTexteCentre(x,y,texte);
     couleurs(white,black

     x:=10;
     y:=5;
     texte:='Nom: ';
     ecrireTexte(x,y,texte);
     write(nom);

     x:=10;
     y:=6;
     texte:='Argent: ';
     ecrireTexte(x,y,texte);
     write(valRess[argent]);

     x:=110;
     y:=5;
     texte:='Ressources :';
     ecrireTexte(x,y,texte);

     x:=110;
     y:=6;
     texte:='- Bois : ';
     ecrireTexte(x,y,texte);
     write(valRess[bois]);

     x:=110;
     y:=7;
     texte:='- Poissons : ';
     ecrireTexte(x,y,texte);
     write(valRess[poisson]);

     x:=110;
     y:=8;
     texte:='- Outils : ';
     ecrireTexte(x,y,texte);
     write(valRess[outil]);

     x:=110;
     y:=9;
     texte:='- Laine : ';
     ecrireTexte(x,y,texte);
     write(valRess[laine]);

     x:=110;
     y:=10;
     texte:='- Tissu : ';
     ecrireTexte(x,y,texte);
     write(valRess[tissu]);

   end;

end.

