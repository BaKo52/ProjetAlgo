unit unitAnno;

{$mode objfpc}{$H+} {$CODEPAGE UTF8}

interface
   uses Classes, SysUtils, GestionEcran;

   //automatisation de l'affichage du texte avec des coordonnées x et y
   procedure ecrireTexte(x1,y1:Integer;texte1:String);

   //affichage du menu principal
   procedure menuPrincipal();

   //affichage du menu de présentation
   procedure presentation();

   //affichage du menu de création de partie
   procedure create();

   //affichage du menu de gestion de l'île
   procedure ile(var valRess);

implementation

   procedure ecrireTexte(x1,y1:Integer;texte1:String);
   var
     pos:Coordonnees;
   begin
     pos.x:=x1-round(length(texte1)/2);
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
     ecrireTexte(x,y,texte);

     texte:='1. Pour créer une Nouvelle Partie';
     x:=100;
     y:=45;
     ecrireTexte(x,y,texte);

     texte:='2. Pour Quitter';
     x:=100;
     y:=50;
     ecrireTexte(x,y,texte);

     texte:='Allez à ? ';
     x:=100;
     y:=55;
     ecrireTexte(x,y,texte);



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
          ecrireTexte(x,y,texte);
          y:=y+1;
        end;

        texte:='1. Pour Accoster ?';
        x:=100;
        y:=45;
        ecrireTexte(x,y,texte);

        texte:='2. Pour Quitter';
        x:=100;
        y:=50;
        ecrireTexte(x,y,texte);

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
     ecrireTexte(x,y,texte);

     couleurs(white,black);
     texte:='Entrer le nom de votre personnage : ';
     x:=40;
     y:=15;
     ecrireTexte(x,y,texte);

   end;

   procedure ile(var valRess);
   var
     x,y:Integer;
     texte:String;

   begin
     effacerEcran;

     x:=50;
     y:=50;
     texte:='☺☻♥';
     ecrireTexte(x,y,texte);

     readln();
   end;

end.

