unit unitAnno;

{$mode objfpc}{$H+} {$CODEPAGE UTF8}



interface
   uses Classes, SysUtils, GestionEcran, unitvar;

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
   procedure ile();

   //affichage du menu des choix
   procedure choixMenu();

   //affichage du menu de gestion des batiments
   procedure batiment();


implementation

   var
     nom:String;

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
     texte:String;

   begin
     changerTailleConsole(200,60);

     texte:='Anno 1701';
     ecrireTexteCentre(100,10,texte);

     texte:='1. Pour créer une Nouvelle Partie';
     ecrireTexteCentre(100,45,texte);

     texte:='2. Pour Quitter';
     ecrireTexteCentre(100,50,texte);

     texte:='Allez à ? ';
     ecrireTexteCentre(100,55,texte);



   end;

   procedure presentation();
      var
        y:Integer;
        texte:String;
        intro:Text;

      begin
        effacerEcran();
        assign(intro, 'intro.txt');
        reset(intro);

        y:=15;
        while not eof(intro) do
        begin
          readln(intro, texte);
          ecrireTexteCentre(100,y,texte);
          y:=y+1;
        end;

        texte:='1. Pour Accoster ?';
        ecrireTexteCentre(100,45,texte);

        texte:='2. Pour Quitter';
        ecrireTexteCentre(100,50,texte);

        close(intro);
      end;

   procedure create();
   var
     texte:String;

   begin
     effacerEcran();

     couleurs(black,LightGray);
     texte:='CREATION DE VOTRE PERSONNAGE';
     ecrireTexteCentre(100,5,texte);

     couleurs(white,black);
     texte:='Entrer le nom de votre personnage : ';
     ecrireTexteCentre(40,15,texte);

     readln(nom); // lit la variable du nom du joueur
   end;

   procedure ile();
   var
     texte:String;

   begin
     effacerEcran;

     dessinerCadreXY(95,1,105,3,double,white,black);

     texte:='Isla Soma';
     couleurs(white,lightRed);
     ecrireTexteCentre(100,2,texte);
     couleurs(white,black);

     texte:='Nom: ';
     ecrireTexte(10,7,texte);
     write(nom);

     texte:='Argent: ';
     ecrireTexte(10,8,texte);
     write(getGold);


     //affichage des ressources
     texte:='Nombre de ressources :';
     ecrireTexte(110,7,texte);

     texte:='- Bois : ';
     ecrireTexte(110,8,texte);
     write(getBois);

     texte:='- Poissons : ';
     ecrireTexte(110,9,texte);
     write(getFish);

     texte:='- Outils : ';
     ecrireTexte(110,10,texte);
     write(getOutil);

     texte:='- Laine : ';
     ecrireTexte(110,11,texte);
     write(getLaine);

     texte:='- Tissu : ';
     ecrireTexte(110,12,texte);
     write(getTissu);

     texte:='Nombre de colons : ';
     ecrireTexte(110,30,texte);
     write(getColon);
     write('/',getMaison*4);

     texte:='Liste des bâtiments construits : ';
     ecrireTexte(110,31,texte);

     texte:='- Maisons: ';
     ecrireTexte(110,32,texte);
     write(getMaison);

     texte:='- Cabane de pêcheur: ';
     ecrireTexte(110,33,texte);
     write(getCabaneP);

     texte:='- Cabane de bucheron: ';
     ecrireTexte(110,34,texte);
     write(getCabaneB);

     texte:='- Bergerie: ';
     ecrireTexte(110,35,texte);
     write(getBergerie);

     texte:='- Atelier de tisserand: ';
     ecrireTexte(110,36,texte);
     write(getAtelier);

     if (getChapelle = false) then
       begin
         texte:='Vous n''avez pas encore construit de chapelle';
         ecrireTexte(110,37,texte);
       end
     else
       begin
         texte:='Vous avez construit une chapelle';
         ecrireTexte(110,37,texte);
       end;

     if (getCentreVille = false) then
       begin
         texte:='Vous n''avez pas encore construit de centre-ville';
         ecrireTexte(110,38,texte);
       end
     else
       begin
         texte:='Vous avez construit un centre-ville';
         ecrireTexte(110,38,texte);
       end;
   end;

   procedure choixMenu();
   var
     texte:String;
   begin
     ile();

     //passer au prochain tour
     texte:='1. Passer au prochain tour';
     ecrireTexte(10, 30, texte);

     //accéder au menu de gestion des bâtiments
     texte:='2. Accéder au menu de gestion des bâtiments';
     ecrireTexte(10, 31, texte);

     //Quitter le jeu
     texte:='3. Quitter le jeu';
     ecrireTexte(10, 32, texte);

     //demande du choix
     texte:='Que souhaitez-vous faire ?';
     ecrireTexte(10, 34, texte);
   end;

   procedure batiment();
   var
     texte:String;
   begin
     ile();

     texte:='1. Construire une maison pouvant accueillir 4 colons: -500 or, - 10 bois et -5 outils';
     ecrireTexte(10, 30, texte);

     texte:='2. Construire une cabane de bucheron : -500 or, -20 bois et -10 outils';
     ecrireTexte(10, 31, texte);

     texte:='3. Construire une cabane de pêcheur : -500 or, -20 bois et -10 outils';
     ecrireTexte(10, 32, texte);

     texte:='4. Construire une bergerie: -500 or, -20 bois et -10 outils';
     ecrireTexte(10, 33, texte);

     texte:='5. Construire un atelier de tisserand: -500 or, -20 bois, -10 outils et -10 laines';
     ecrireTexte(10, 34, texte);

     texte:='6. Construire une chapelle: -1500 or, -80 bois, -30 outils et -30 tissu';
     ecrireTexte(10, 35, texte);

     texte:='7. Construire un centre-ville: -1000 or, -45 bois, -20 outils et -20 tissu';
     ecrireTexte(10, 36, texte);

     texte:='8. Retour au menu précédent';
     ecrireTexte(10, 37, texte);

     texte:='Quel bâtiment voulez-vous construire ? ';
     ecrireTexte(10, 39, texte);

   end;

end.
