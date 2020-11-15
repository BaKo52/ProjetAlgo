unit unitAnno;

{$mode objfpc}{$H+} {$CODEPAGE UTF8}



interface
   uses Classes, SysUtils, GestionEcran;

   type
       ressource = (poisson,bois,outil,laine,tissu,argent,colon);
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
     texte:String;

   begin
     effacerEcran;

     dessinerCadreXY(95,1,105,3,double,white,black);

     texte:='Isla Soma';
     couleurs(white,cyan);
     ecrireTexteCentre(100,2,texte);
     couleurs(white,black);

     texte:='Nom: ';
     ecrireTexte(10,5,texte);
     write(nom);

     texte:='Argent: ';
     ecrireTexte(10,6,texte);
     write(valRess[argent]);

     texte:='Nombre de ressources :';
     ecrireTexte(110,5,texte);

     texte:='- Bois : ';
     ecrireTexte(110,6,texte);
     write(valRess[bois]);

     texte:='- Poissons : ';
     ecrireTexte(110,7,texte);
     write(valRess[poisson]);

     texte:='- Outils : ';
     ecrireTexte(110,8,texte);
     write(valRess[outil]);

     texte:='- Laine : ';
     ecrireTexte(110,9,texte);
     write(valRess[laine]);

     texte:='- Tissu : ';
     ecrireTexte(110,10,texte);
     write(valRess[tissu]);

     texte:='Nombre de colons : ';
     ecrireTexte(110,10,texte);
     write(valRess[tissu]);

     texte:='Liste des bâtiments construits';
     ecrireTexte(,,texte);
     write();

   end;

end.
