unit unitAnno;

{$mode objfpc}{$H+} {$CODEPAGE UTF8}

interface
  uses Classes, SysUtils, GestionEcran, unitvar, unitNaval;

  //affichage du menu principal
  procedure menuPrincipal();

  //affichage du menu de présentation
  procedure presentation();

  //affichage du menu de création de partie
  procedure create();

  //affichage du menu des choix
  procedure choixMenu();

  //affichage du menu de gestion des batiments/soldats
  procedure batiment();

  //procédure gérant le marchand
  procedure marchand();

implementation
   procedure menuPrincipal();
   var
     texte:String;
     logo:Text;
     y:Integer;

   begin
     changerTailleConsole(200,60);

     effacerEcran();
     assign(logo, 'logo.txt');
     reset(logo);

     y:=15;
     while not eof(logo) do
       begin
         readln(logo, texte);
         ecrireTexteCentre(100,y,texte);
         y:=y+1;
       end;

     texte:='1. Pour créer une nouvelle partie';
     ecrireTexteCentre(100,46,texte);

     texte:='2. Pour charger une sauvegarde';
     ecrireTexteCentre(100,48,texte);

     texte:='3. Pour quitter le jeu';
     ecrireTexteCentre(100,50,texte);

     texte:='Allez à ? ';
     ecrireTexteCentre(100,52,texte);

     close(logo)


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

        texte:='Alors on y va? ';
        ecrireTexteCentre(100,55,texte);

        close(intro);
      end;

   procedure create();
   var
     texte:String;

   begin
     effacerEcran();

     initialisation(); //Initialisation des ressources

     couleurs(black,LightGray);
     texte:='CREATION DE VOTRE PERSONNAGE';
     ecrireTexteCentre(100,5,texte);

     couleurs(white,black);
     texte:='Entrer le nom de votre personnage : ';
     ecrireTexteCentre(40,15,texte);

     readln(texte); // lit la variable du nom du joueur
     setNom(texte);
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
     texte:='2. Accéder au menu de gestion des bâtiments et des soldats';
     ecrireTexte(10, 31, texte);

     //accéder au menu de gestion des bateaux
     texte:='3. Accéder au menu de gestion des bateaux';
     ecrireTexte(10, 32, texte);

     //Quitter le jeu
     texte:='4. Sauvegarder et quitter le jeu';
     ecrireTexte(10, 33, texte);

     //demande du choix
     texte:='Que souhaitez-vous faire ? ';
     ecrireTexte(10, 34, texte);
   end;

   procedure batiment();
   var
     texte:String;
     z:Integer;
     ARRET:Boolean;
   begin
     ARRET:=True;

     while (ARRET) do
       begin
         effacerEcran();

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

         texte:='8. Construire un chantier naval: -1000 or, -100 bois, - 20 outils et -10 tissu';
         ecrireTexte(10, 37, texte);

         texte:='9. Recrutez 5 soldats: -25 or, -5 outils, -10 tissu et -25 poissons';
         ecriretexte(10,38, texte);

         texte:='10. Retour au menu précédent';
         ecrireTexte(10, 40, texte);

         texte:='Quel bâtiment voulez-vous construire ? ';
         ecrireTexte(10, 42, texte);

         readln(z);
         case z of
         1:
           begin
             if ((getGold>499) AND (getBois>9) AND (getOutil>4)) then
               begin
                 setMaison(getMaison+1);
                 setGold(getGold-500);
                 setBois(getBois-10);
                 setOutil(getOutil-5);
               end
             else
               begin
                 texte:='Vous n''avez pas les ressources pour construire une maison';
                 ecrireTexte(10, 39, texte);
                 readln();
               end;
           end;
         2:
           begin
             if ((getGold>499) AND (getBois>19) AND (getOutil>9)) then
               begin
                 setCabaneB(getCabaneB+1);
                 setGold(getGold-500);
                 setBois(getBois-20);
                 setOutil(getOutil-10);
               end
             else
               begin
                 texte:='Vous n''avez pas les ressources pour construire une cabane de bucheron';
                 ecrireTexte(10, 39, texte);
                 readln();
               end;
           end;
         3:
           begin
             if ((getGold>499) AND (getBois>19) AND (getOutil>9)) then
               begin
                 setCabaneP(getCabaneP+1);
                 setGold(getGold-500);
                 setBois(getBois-20);
                 setOutil(getOutil-10);
               end
             else
               begin
                 texte:='Vous n''avez pas les ressources pour construire une cabane de pêcheur';
                 ecrireTexte(10, 39, texte);
                 readln();
               end;
           end;
         4:
           begin
             if ((getGold>499) AND (getBois>19) AND (getOutil>9)) then
               begin
                 setBergerie(getBergerie+1);
                 setGold(getGold-500);
                 setBois(getBois-20);
                 setOutil(getOutil-10);
               end
             else
               begin
                 texte:='Vous n''avez pas les ressources pour construire une bergerie';
                 ecrireTexte(10, 39, texte);
                 readln();
               end;
           end;
         5:
           begin
             if ((getGold>499) AND (getBois>19) AND (getOutil>9) AND (getLaine>9)) then
               begin
                  setAtelier(getAtelier+1);
                  setGold(getGold-500);
                  setBois(getBois-20);
                  setOutil(getOutil-10);
                  setLaine(getLaine-10);
               end
             else
               begin
                 texte:='Vous n''avez pas les ressources pour construire une atelier de tisserand';
                 ecrireTexte(10, 39, texte);
                 readln();
               end;
           end;
         6:
           begin
             if ((getGold>1499) AND (getBois>79) AND (getOutil>29) AND (getTissu>29)) then
               begin
                  setChapelle(true);
                  setGold(getGold-1500);
                  setBois(getBois-80);
                  setOutil(getOutil-30);
                  settissu(getTissu-30);
               end
             else
               begin
                 texte:='Vous n''avez pas les ressources pour construire une chapelle';
                 ecrireTexte(10, 39, texte);
                 readln();
               end;
           end;
         7:
           begin
             if ((getGold>999) AND (getBois>44) AND (getOutil>19) AND (getTissu>19)) then
               begin
                  setCentreVille(true);
                  setGold(getGold-1000);
                  setBois(getBois-45);
                  setOutil(getOutil-20);
                  settissu(getTissu-20);
               end
             else
               begin
                 texte:='Vous n''avez pas les ressources pour construire un centre-ville';
                 ecrireTexte(10, 39, texte);
                 readln();
               end;
           end;
         8:
           begin
             if ((getGold>999) AND (getBois>99) AND (getOutil>19) AND (getTissu>9)) then
               begin
                  setNaval(true);
                  setGold(getGold-1000);
                  setBois(getBois-100);
                  setOutil(getOutil-20);
                  settissu(getTissu-10);
               end
             else
               begin
                 texte:='Vous n''avez pas les ressources pour construire un chantier naval';
                 ecrireTexte(10, 39, texte);
                 readln();
               end;
           end;

         9:
           begin
             if ((getGold>24) AND (getOutil>4) AND (getTissu>9) AND (getFish>24)) then
               begin
                 setGold(getGold-25);
                 setOutil(getOutil-5);
                 settissu(getTissu-10);
                 setFish(getFish-25);
                 setSoldat(getSoldat+5);
               end
             else
               begin
                 texte:='Vous n''avez pas les ressources pour recruter des soldats';
                 ecrireTexte(10, 39, texte);
                 readln();
               end;
           end;
         10:ARRET:=false;
         end;
     end;
   end;

   procedure AffMarchand();
   var
     texte:String;
   begin
     dessinerCadreXY(95,1,104,3,double,white,black);
     texte:='MARCHAND';
     ecrireTexteCentre(100,2,texte);

     dessinerCadreXY(149,24,173,31,simple,white,black);
     texte:='Nombre de ressources :';
     ecrireTexte(150,25,texte);
     texte:='- Bois : ';
     ecrireTexte(150,26,texte);
     write(getBois);
     texte:='- Poissons : ';
     ecrireTexte(150,27,texte);
     write(getFish);
     texte:='- Outils : ';
     ecrireTexte(150,28,texte);
     write(getOutil);
     texte:='- Laine : ';
     ecrireTexte(150,29,texte);
     write(getLaine);
     texte:='- Tissu : ';
     ecrireTexte(150,30,texte);
     write(getTissu);

     dessinerCadreXY(82,5,118,15,simple,white,black);
     texte:='Bois: 5 pièces d''or par laine';
     ecrireTexteCentre(100,6,texte);
     texte:='Poisson: 5 pièces d''or par laine';
     ecrireTexteCentre(100,8,texte);
     texte:='Laine: 5 pièces d''or par laine';
     ecrireTexteCentre(100,10,texte);
     texte:='Tissu: 10 pièces d''or par tissu';
     ecrireTexteCentre(100,12,texte);
     texte:='Outil: 2 pièces d''or par outil';
     ecrireTexteCentre(100,14,texte);

     dessinerCadreXY(1,4,15,7,simple,white,black);
     texte:='Argent :';
     ecrireTexte(2,5,texte);
     write(getGold);
     texte:='Tour: ';
     ecrireTexte(2,6,texte);
     write(GetNbRound()-1);
   end;

   procedure achat();
   var
     z,x,temp:Integer;
     texte:String;
     ARRET:Boolean;
   begin
     while (ARRET) do
       begin
         effacerEcran();
         affMarchand();

         texte:='1. Acheter du bois';
         ecrireTexteCentre(100,50,texte);
         texte:='2. Acheter du poisson';
         ecrireTexteCentre(100,51,texte);
         texte:='3. Acheter de la laine';
         ecrireTexteCentre(100,52,texte);
         texte:='4. Acheter du tissu';
         ecrireTexteCentre(100,53,texte);
         texte:='5. Acheter des outils';
         ecrireTextecentre(100,54,texte);
         texte:='6. Revenir au menu précédent';
         ecrireTexteCentre(100,55,texte);

         texte:='Que voulez-vous faire: ';
         ecrireTexteCentre(100,57,texte);

         readln(z);

         case z of
         1:
           begin
             texte:='Quelle quantité: ';
             ecrireTexteCentre(100,58,texte);
             readln(x);
             temp:=x*5;
             if(getGold()-temp>0) then
                begin
                     setGold(getGold()-temp);
                     setBois(getBois()+x);
                end
             else
               begin
                 write('Vous n''avez pas assez d''argent, appuyer sur entrée pour passer');
                 readln();
               end;
           end;
         2:
           begin
             texte:='Quelle quantité: ';
             ecrireTexteCentre(100,58,texte);
             readln(x);
             temp:=x*5;
             if(getGold()-temp>0) then
                begin
                     setGold(getGold()-temp);
                     setFish(getFish()+x);
                end
             else
               begin
                 write('Vous n''avez pas assez d''argent, appuyer sur entrée pour passer');
                 readln();
               end;
           end;
         3:
           begin
             texte:='Quelle quantité: ';
             ecrireTexteCentre(100,58,texte);
             readln(x);
             temp:=x*5;
             if(getGold()-temp>0) then
                begin
                     setGold(getGold()-temp);
                     setLaine(getLaine()+x);
                end
             else
               begin
                 write('Vous n''avez pas assez d''argent, appuyer sur entrée pour passer');
                 readln();
               end;
           end;
         4:
           begin
             texte:='Quelle quantité: ';
             ecrireTexteCentre(100,58,texte);
             readln(x);
             temp:=x*10;
             if(getGold()-temp>0) then
                begin
                     setGold(getGold()-temp);
                     setTissu(getTissu()+x);
                end
             else
               begin
                 write('Vous n''avez pas assez d''argent, appuyer sur entrée pour passer');
                 readln();
               end;
           end;
         5:
           begin
             texte:='Quelle quantité: ';
             ecrireTexteCentre(100,58,texte);
             readln(x);
             temp:=x*2;
             if(getGold()-temp>0) then
                begin
                     setGold(getGold()-temp);
                     setOutil(getOutil()+x);
                end
             else
               begin
                 write('Vous n''avez pas assez d''argent, appuyer sur entrée pour passer');
                 readln();
               end;
           end;
         6:ARRET:=false;
         end;
     end;
   end;

   procedure vente();
   var
     z,x:Integer;
     texte:String;
     ARRET:Boolean;
   begin
     ARRET:=true;
     while (ARRET) do
       begin
         effacerEcran();
         affMarchand();

         texte:='1. Vendre du bois';
         ecrireTexteCentre(100,50,texte);
         texte:='2. Vendre du poisson';
         ecrireTexteCentre(100,51,texte);
         texte:='3. Vendre de la laine';
         ecrireTexteCentre(100,52,texte);
         texte:='4. Vendre du tissu';
         ecrireTexteCentre(100,53,texte);
         texte:='5. Vendre des outils';
         ecrireTexteCentre(100,54,texte);
         texte:='6. Revenir au menu précédent';
         ecrireTexteCentre(100,55,texte);

         texte:='Que voulez-vous faire: ';
         ecrireTexteCentre(100,57,texte);

         readln(z);

         case z of
         1:
           begin
             texte:='Quelle quantité: ';                                     
         5:
             ecrireTexteCentre(100,58,texte);
             readln(x);
             if(getBois()-x>=0) then
                begin
                     setBois(getBois()-x);
                     setGold(getGold()+(x*5));
                end
             else
               begin
                 write('Vous n''avez pas assez de bois, appuyer sur entrée pour passer');
                 readln();
               end;
           end;
         2:
           begin
             texte:='Quelle quantité: ';
             ecrireTexteCentre(100,58,texte);
             readln(x);
             if(getFish()-x>=0) then
                begin
                     setGold(getGold()+(x*5));
                     setFish(getFish()-x);
                end
             else
               begin
                 write('Vous n''avez pas assez de poisson, appuyer sur entrée pour passer');
                 readln();
               end;
           end;
         3:
           begin
             texte:='Quelle quantité: ';
             ecrireTexteCentre(100,58,texte);
             readln(x);
             if(getLaine()-x>=0) then
                begin
                     setGold(getGold()+x*5);
                     setLaine(getLaine()-x);
                end
             else
               begin
                 write('Vous n''avez pas assez de laine, appuyer sur entrée pour passer');
                 readln();
               end;
           end;
         4:
           begin
             texte:='Quelle quantité: ';
             ecrireTexteCentre(100,58,texte);
             readln(x);
             if(getTissu()-x>=0) then
                begin
                     setGold(getGold()+x*10);
                     setTissu(getTissu()-x);
                end
             else
               begin
                 write('Vous n''avez pas assez d''argent, appuyer sur entrée pour passer');
                 readln();
               end;
           end;
         5:
           begin
             texte:='Quelle quantité: ';
             ecrireTexteCentre(100,58,texte);
             readln(x);
             if(getOutil()-x>0) then
                begin
                     setGold(getGold()+x*2);
                     setOutil(getOutil()-x);
                end
             else
               begin
                 write('Vous n''avez pas assez d''outil, appuyer sur entrée pour passer');
                 readln();
               end;
           end;
         6:
           begin
             ARRET:=false;
           end;
         end;
       end;
   end;

   procedure marchand();
   var
     texte:String;
     z:Integer;
     ARRET:Boolean;
   begin
     ARRET:=false;

     while not(ARRET) do
       begin
         effacerEcran();
         AffMarchand();

         texte:='1. Acheter';
         ecrireTexteCentre(100,20,texte);

         texte:='2. Vendre';
         ecrireTexteCentre(100,21,texte);

         texte:='3. Sortir du marchand';
         ecrireTexteCentre(100,22,texte);

         texte:='Que voulez-vous faire: ';
         ecrireTexteCentre(100,57,texte);

         readln(z);
         case z of
           1:
             begin
               achat();
             end;

           2:
             begin
               vente();
             end;
           3:
             begin
               ARRET:=true;
             end;

         end;
       end;
   end;
end.
