unit unitNaval;

{$mode objfpc}{$H+}
{$CODEPAGE UTF8}

interface
  uses Classes, SysUtils, gestionEcran, unitVar;

  type
    PBateau = ^bateau;

    bateau = record
      nom : String;
      succ, prec : PBateau;
    end;

    listeBateau = record
      pDeb, pFin : PBateau;
    end;

  //affichage du menu de gestion des bateaux
  procedure naval();

  //affiche la liste des bateaux du début vers la fin
  procedure afficheDebVersFin(l : listeBateau; x,y : Integer);

  //ajoute un bateau à la fin de la liste
  procedure ajouteFin(var l : listeBateau ; nom : String);

  //enlève le premier bateau de la liste
  procedure depileDeb(var l : listeBateau);

  //procédure gérant l'attaque de pirate
  procedure attaque();

  //affichage des ressources, du nom et des bâtiments
  procedure ile();

var
  l : listeBateau;

implementation

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

     dessinerCadreXY(9,6,30,10,simple,white,black);

     texte:='Nom: ';
     ecrireTexte(10,7,texte);
     write(getNom());

     texte:='Argent: ';
     ecrireTexte(10,8,texte);
     write(getGold);

     texte:='Tour: ';
     ecrireTexte(10,9,texte);
     write(getNbRound);

     dessinerCadreXY(109,6,134,15,simple,white,black);

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

     texte:='- Nombre de soldat : ';
     ecrireTexte(110,13,texte);
     write(getSoldat);

     texte:='- Nombre de bateau : ';
     ecrireTexte(110,14,texte);
     write(getBateau);

     dessinerCadreXY(109,29,161,40,simple,white,black);

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

       if (getNaval = false) then
       begin
         texte:='Vous n''avez pas encore construit de chantier naval';
         ecrireTexte(110,39,texte);
       end
     else
       begin
         texte:='Vous avez construit un chantier naval';
         ecrireTexte(110,39,texte);
       end;
   end;

  procedure ajouteFin(var l : listeBateau ; nom : String);
    var
      x : PBateau;
    begin
      new(x);
      // remplit les champs
      x^.nom := nom;

      //l'inclus dans la chaine
      x^.prec := l.pFin;
      x^.succ := NIL;

      if (l.pFin <> NIL) then
        begin
          (l.pFin)^.succ := x;
        end
      else l.pDeb := x;
      l.pFin := x;
    end;

  procedure depileDeb(var l : listeBateau);
    var
      x : PBateau;
    begin
      if (l.pDeb<>NIL) then
        begin
          //je garde l'adresse de l'ancien début pour libérer de la mémoire
          x := l.pDeb;

          //le suivant de mon ancien début devient le nouveau début
          l.pDeb:= (l.pDeb)^.succ;

          //il n'y a pas de prédécesseur du nouveau sommet
          (l.pDeb)^.prec := NIL;

          //je libère la mémoire de mon ancien sommet
          dispose(x);
        end;
    end;

  procedure afficheDebVersFin(l : listeBateau; x,y : Integer);
   var
     temp : PBateau;   //variable contenant l'élément en cours de lecture dans la chaine
     i : Integer;      //compteur
     xStart : Integer; //x de départ gardé pour plus tard
     yStart : Integer; //y de départ gardé pour plus tard
   begin
     //intitialise les variables
     temp := l.pDeb;
     i := 1;
     xStart := x;
     yStart := y;

     //fait le premier bateau en dehors de la boucle car temp = l.pFin
     ecrireTexte(x,y,'Bateau n°');
     write(i, ' : ');
     writeln(temp^.nom);

     //incrémente i et y pour la première écriture
     i := i + 1;
     y := y +1;

     while ((temp <> l.pFin) AND (temp <> NIL)) do     // tant que l'on n'est pas à la fin de la liste
     begin
       ecrireTexte(x,y,'Bateau n°');
       write(i, ' : ');     //écrit le numéro du bateau
       writeln(temp^.nom);  //écrit le nom du bateau
       temp := temp^.succ;  //prend l'élément suivant de la liste
       i := i + 1;
       y := y + 1;   //incrémente y et i

       if (y = 48) then  //si le texte rencontre les choix que doit prendre l'utilisateur
         begin
           y := yStart; //reset le y au y de départ
           x := xStart + 35; //reset le x au x de départ avec un décalage de 35 (plus grande String des noms de bateaux)
           xStart := xStart + 35 //rajoute 35 au start si le texte rerencontre les choix de l'utilisateur
         end;
     end;
   end;

  procedure AffAttaque();
     var
       texte:String;
     begin
       dessinerCadreXY(90,1,109,3,double,white,black);
       texte:='Attaque de pirates';
       ecrireTexteCentre(100,2,texte);

       dessinerCadreXY(149,24,180,27,simple,white,black);
       texte:='Nombre de soldats :';
       ecrireTexte(150,25,texte);
       write(getSoldat);
       texte:='Nombre de pirates : ';
       ecrireTexte(150,26,texte);
       write('Inconnu');
     end;

  procedure capituler();
   var
     x,temp:Integer;
     texte:String;
     ARRET:Boolean;
   begin

     ARRET := FALSE;

        while (not(ARRET)) do
        begin
             effacerEcran();
             affAttaque();
             Randomize;
             begin
             texte:='Vous avez décider de laisser les pirates envahir votre colonie...';
             ecrireTexteCentre(100,58,texte);
             readln;
             Randomize;
             x:=random(5)+1;
             if (getBois>50) AND (getColon>x) AND (getFish>50) AND (getTissu>50)) then
                begin
                   effacerEcran();
                   setColon(getColon()-x);
                   setBois(getBois()-50);
                   setFish(getFish()-50);
                   setTissu(getTissu()-50);
                   texte:=('Les pirates ont saccagé votre village');
                   ecrireTexte(50,23,texte);
                   texte:=('Nombre de colons perdus: ');
                   ecrireTexte(50,25,texte);
                   write(x);
                   texte:=('Nombre de colons restant: ');
                   ecrireTexte(50,26,texte);
                   write(getColon());
                   texte:=('Nombre de poissons perdus: ');
                   ecrireTexte(50,27,texte);
                   texte:=('Nombre de poissons restant: ');
                   ecrireTexte(50,28,texte);
                   texte:=('Nombre de tissus perdus: ');
                   ecrireTexte(50,29,texte);
                   texte:=('Nombre de tissus restant: ');
                   ecrireTexte(50,29,texte);
                   readln;
                   ARRET := TRUE;
                end
             else
               begin
                 effacerEcran();
                 setColon(0);
                 setBois(0);
                 setfish(0);
                 setTissu(0);
                 texte:=('Vos ennemis ont envahi votre colonie... Vous avez perdu');
                 ecrireTexte(50,25,texte);
                 readln;
                 halt();
               end;
             end;
        end;
   end;

  procedure combat();
   var
     z,temp:Integer;
     texte:String;
     ARRET:Boolean;
   begin
     ARRET := FALSE;
     Randomize;

   while (not(ARRET)) do
     begin
       effacerEcran();
       affAttaque();

       texte:='1. Partir au combat sur le rivage : beaucoup de soldats risquent de mourir';
       ecrireTexteCentre(100,50,texte);
       texte:='2. Tendre un piège aux envahisseurs : - 15 bois, -5 poissons, -10 tissu mais moins de soldats risquent de mourir ';
       ecrireTexteCentre(100,51,texte);
       texte:='3. Construire des défenses pour résister à l''attaque :  -40 bois, -10 poissons, -20 tissu mais les pertes seront minimes';
       ecrireTexteCentre(100,52,texte);

       texte:='Que voulez-vous faire: ';
       ecrireTexteCentre(100,57,texte);

       readln(z);

       case z of
       1:
         begin
           texte:='Vos hommes partent défendre votre colonie... ';
           ecrireTexteCentre(100,58,texte);
           if (getSoldat>0) then
              begin
                 temp:= random(10)+1;
                 if (getSoldat()-temp>=0) then
                    begin
                       setSoldat(getSoldat-temp);
                       texte:=('Vous avez repoussé l''invasion !');
                       ecrireTexte(50,23,texte);
                       texte:=('Nombre de soldats perdu: ');
                       ecrireTexte(50,24,texte);
                       write(temp);
                       texte:=('Nombre de soldats restant: ');
                       ecrireTexte(50,25,texte);
                       write(getSoldat());
                       readln;
                       ARRET := TRUE;
                    end
                 else
                   begin
                     if ((getBois>20) AND (getFish>15) AND (getTissu>20)) then
                       begin
                         effacerEcran;
                         setBois(getBois()-20);
                         setfish(getFish()-15);
                         setTissu(getTissu()-20);
                         setSoldat(0);
                         texte:=('Vos soldats ont tous péri durant cette attaque... Vous avez perdu 20 unités de bois, 15 unités de poissons et 20 unités de tissus');
                         ecrireTexte(50,25,texte);
                         readln;
                         ARRET := TRUE;
                       end
                   else
                       begin
                         effacerEcran();
                         setBois(0);
                         setfish(0);
                         setTissu(0);
                         setSoldat(0);
                         texte:=('Vos soldats ont tous péri durant cette attaque... Vous avez perdu toutes vos ressources... Partie perdue !');
                         ecrireTexte(50,25,texte);
                         readln;
                         halt();
                       end;
                   end;
              end
           else
              if ((getBois>20) AND (getFish>15) AND (getTissu>20)) then
                 begin
                   effacerEcran();
                   setBois(getBois()-20);
                   setfish(getFish()-15);
                   setTissu(getTissu()-20);
                   texte:=('Vous avez perdu 20 unités de bois, 15 unités de poissons et 20 unités tissus');
                   ecrireTexte(50,25,texte);
                   readln;
                   ARRET := TRUE;
                 end
             else
                 begin
                   effacerEcran();
                   setBois(0);
                   setfish(0);
                   setTissu(0);
                   setSoldat(0);
                   texte:=('Vous avez perdu toutes vos ressources... Partie perdue !');
                   ecrireTexte(50,25,texte);
                   readln;
                   halt();
                 end;
             end;
       2:
         begin
           texte:='Vos hommes se préparent à tendre un piège... ';
           ecrireTexteCentre(100,58,texte);
           if (getSoldat>0) then
              begin
                 temp:= random(7)+1;
                 if ((getSoldat()-temp>=0) AND (getBois>15) AND (getFish>5) AND (getTissu>10)) then
                    begin
                       effacerEcran();
                       setBois(getBois()-15);
                       setFish(getFish()-5);
                       setTissu(getTissu()-10);
                       setSoldat(getSoldat() - temp);
                      texte:=('Vous avez repoussé l''invasion mais vous avez perdu des ressources!');
                       ecrireTexte(50,23,texte);
                       texte:=('Nombre de soldats perdu: ');
                       ecrireTexte(50,24,texte);
                       write(temp);
                       texte:=('Nombre de soldats restant: ');
                       ecrireTexte(50,25,texte);
                       write(getSoldat());
                       readln;
                       ARRET := TRUE;
                    end
                 else
                   begin
                     effacerEcran();
                     setBois(0);
                     setfish(0);
                     setTissu(0);
                     setSoldat(0);
                     texte:=('Vos soldats ont tous péri durant cette attaque... Vous avez perdu toutes vos ressources!');
                     ecrireTexte(50,24,texte);
                     texte:=('Vous avez perdu !');
                     ecrireTexte(50,25,texte);
                     readln;
                     halt();
                   end;
              end
           else
             if ((getBois>20) AND (getFish>15) AND (getTissu>20)) then
                    begin
                       effacerEcran();
                       setBois(getBois()-20);
                       setFish(getFish()-15);
                       setTissu(getTissu()-20);
                       texte:=('Vous n''avez pas assez de soldats pour repousser l''attaque !');
                       ecrireTexte(50,25,texte);
                       readln;
                       ARRET := TRUE;
                    end
                 else
                   begin
                     effacerEcran();
                     setBois(0);
                     setfish(0);
                     setTissu(0);
                     texte:=('Vous avez perdu toutes vos ressources!');
                     ecrireTexte(50,24,texte);
                     texte:=('Vous avez perdu !');
                     ecrireTexte(50,25,texte);
                     readln;
                     halt();
                   end;
              end;
       3:
         begin
           texte:='Vos hommes se préparent à défendre la colonie... ';
           ecrireTexteCentre(100,58,texte);
           if (getSoldat>0) then
              begin
                 temp:= random(3)+1;
                 if ((getSoldat()-temp>=0) AND (getBois>40) AND (getFish>10) AND (getTissu>20)) then
                    begin
                       effacerEcran();
                       setBois(getBois()-40);
                       setFish(getFish()-10);
                       setTissu(getTissu()-20);
                       setSoldat(getSoldat() - temp);
                       texte:=('Vous avez repoussé l''invasion !');
                       ecrireTexte(50,23,texte);
                       texte:=('Nombre de soldats perdu: ');
                       ecrireTexte(50,24,texte);
                       write(temp);
                       texte:=('Nombre de soldats restant: ');
                       ecrireTexte(50,25,texte);
                       write(getSoldat());
                       readln;
                       ARRET := TRUE;
                    end
                 else
                   begin
                     effacerEcran();
                     setBois(0);
                     setfish(0);
                     setTissu(0);
                     setSoldat(0);
                     texte:=('Vos soldats ont tous péri durant cette attaque... Vous avez perdu toutes vos ressources ! ');
                     ecrireTexte(50,24,texte);
                     texte:=('Vous avez perdu !');
                     ecrireTexte(50,25,texte);
                     readln;
                     halt();
                   end;
              end
           else
               begin
                 if ((getBois>40) AND (getFish>10) AND (getTissu>20)) then
                        begin
                           effacerEcran();
                           setBois(getBois()-40);
                           setFish(getFish()-10);
                           setTissu(getTissu()-20);
                           texte:=('Vous n''avez pas repoussé l''invasion !');
                           ecrireTexte(50,24,texte);
                           readln;
                           ARRET := TRUE;
                        end
                     else
                       begin
                         effacerEcran();
                         setBois(0);
                         setfish(0);
                         setTissu(0);
                         setSoldat(0);
                         texte:=(' Vous avez perdu toutes vos ressources ! ');
                         ecrireTexte(50,24,texte);
                         texte:=('Vous avez perdu !');
                         ecrireTexte(50,25,texte);
                         readln;
                         halt();
                       end;
               end;
         end;
       end;
     end;
   end;

  procedure attaque();
   var
     texte:String;
     z:Integer;
     ARRET:Boolean;
   begin
     ARRET := FALSE;

     while (not(ARRET)) do
       begin
         effacerEcran();
         AffAttaque();

         texte:='1. Se battre';
         ecrireTexteCentre(100,20,texte);

         texte:='2. Capituler';
         ecrireTexteCentre(100,21,texte);

         texte:='Que voulez-vous faire: ';
         ecrireTexteCentre(100,57,texte);

         readln(z);
         if (z=1) then
            begin
               combat();
               ARRET := TRUE;
            end
         else if (z=2) then
            begin
               capituler();
               ARRET := TRUE;
            end
         else
             begin
               ARRET := FALSE;
             end;
       end;
   end;

  procedure naval();
    var
      texte : String;
      z, i : Integer;
      ARRET : Boolean;
      fichier : Text;
      tabBateau : Array [0..16] of String;
    begin
      randomize();
      if getNaval() then
        begin
          ARRET:=false;

          while not(ARRET) do
            begin
              effacerEcran();

              ile();

              if (l.pDeb <> NIL)
              then afficheDebVersFin(l,10,12)
              else ecrireTexte(10, 12, 'Vous n''avez pas encore de bateaux');

              texte:='1. Construire un navire : -500 or, - 50 bois et -20 outils';
              ecrireTexte(10, 50, texte);

              texte:='2. Retour au menu précédent';
              ecrireTexte(10, 52, texte);

              ecrireTexte(10, 54, 'Que voulez-vous faire ? ');

              readln(z);

              case z of
              1:
                begin
                  if ((getGold>499) AND (getBois>49) AND (getOutil>19)) then
                     begin
                       setBateau(getBateau+1);
                       setGold(getGold-500);
                       setBois(getBois-50);
                       setOutil(getOutil-20);

                       assign(fichier, 'nomBateau.txt');
                       reset(fichier);
                       for i:= 0 to 16 do
                         begin
                           readln(fichier, tabBateau[i]);
                         end;
                       i := random(16);
                       ajouteFin(l, tabBateau[i]);
                     end
                  else
                    begin
                      texte:='Vous n''avez pas les ressources pour construire un navire';
                      ecrireTexte(10, 35, texte);
                      readln();
                    end;
                end;
              2: ARRET := true
              else writeln('Mauvaise saisie');
              end;
            end;
          end
          else
              begin
                texte:='Vous n''avez pas construit de chantier naval';
                ecrireTexte(10, 35, texte);
                readln();
              end;
    end;
end.

