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

       dessinerCadreXY(149,24,173,31,simple,white,black);
       texte:='Nombre de soldats :';
       ecrireTexte(150,25,texte);
       write(getSoldat);
       texte:='Nombre de pirates : ';
       ecrireTexte(150,26,texte);
       write('Inconnu');
     end;

  procedure capituler();
   var
     x,y,temp:Integer;
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
             texte:='Vous avez décider de laisser les pirates envhair votre colonie...';
             ecrireTexteCentre(100,58,texte);
             Randomize;
             if (getSoldat>0) then
                begin
                   temp:= random(5)+1;
                   setSoldat(getSoldat()-temp);
                   x:=random(5)+1;
                   setColon(getColon()-x);
                   setBois(getBois()-50);
                   setFish(getFish()-50);
                   setTissu(getTissu()-50);
                   write('L''ennemi a tué quelques habitants et soldats');
                   writeln('Vous avez perdu',temp,' soldats. Il vous reste',getSoldat(),' soldats.');
                   writeln('Vous avez perdu',x,' colons. Il vous reste',getColon(),' colons.');
                   ARRET := TRUE;
                end
             else
               begin
                 y:=random(7)+1;
                 setColon(getColon()-y);
                 setBois(getBois()-50);
                 setfish(getFish()-50);
                 setTissu(getTissu()-50);
                 write('Vos ennemis ont envahi votre colonie... Vous avez perdu',getColon(),' colons, 50 uités de bois, 50 unités de poissons et 50 unités tissus');
                 ARRET := TRUE;
               end;
             end;
             ARRET := TRUE;
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

       texte:='1. Partir au combat sur le rivage';
       ecrireTexteCentre(100,50,texte);
       texte:='2. Tendre un piège aux envahisseurs';
       ecrireTexteCentre(100,51,texte);
       texte:='3. Construire des défenses pour résister à l''attaque';
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
                       write('Vous avez repoussé l''invasion !');
                       writeln('Vous avez perdu',temp,' Soldats. Il vous reste',getSoldat(),' soldats.');
                       ARRET := TRUE;
                    end
                 else
                   begin
                     setBois(getBois()-20); //Ajout des conditions de checks
                     setfish(getFish()-15);
                     setTissu(getTissu()-20);
                     write('Vos soldats ont tous péri durant cette attaque... Vous avez perdu 20 unités de bois, 15 unités de poissons et 20 unités tissus');
                     ARRET := TRUE;
                   end;
              end
           else
             begin
               setBois(getBois()-20); //Ajout des tests
               setfish(getFish()-15);
               setTissu(getTissu()-20);
               write('Vos soldats n''ont pas été assez nombreux pour défendre cette attaque... Vous avez perdu 20 uités de bois, 15 unités de poissons et 20 unités tissus');
               ARRET := TRUE;
             end;
         end;
       2:
         begin
           texte:='Vos hommes se préparent à tendre un piège... ';
           ecrireTexteCentre(100,58,texte);
           if (getSoldat>0) then
              begin
                 temp:= random(5)+1;
                 if (getSoldat()-temp>=0) then
                    begin
                       setBois(getBois()-15);
                       setFish(getFish()-5);
                       setTissu(getTissu()-10);
                       write('Vous avez repoussé l''invahsion mais vous avez perdu quelques ressources !');
                       writeln('Vous avez perdu',temp,' Soldats. Il vous reste',getSoldat(),' soldats.');
                       ARRET := TRUE;
                    end
                 else
                   begin
                     setBois(getBois()-50);
                     setfish(getFish()-30);
                     setTissu(getTissu()-50);
                     write('Vos soldats ont tous péri durant cette attaque... Vous avez perdu 50 uités de bois, 30 unités de poissons et 50 unités tissus');
                     ARRET := TRUE;
                   end;
              end
           else
             begin
               setBois(getBois()-20);
               setfish(getFish()-15);
               setTissu(getTissu()-20);
               write('Vos soldats n''ont pas été assez nombreux pour défendre cette attaque... Vous avez perdu 20 uités de bois, 15 unités de poissons et 20 unités tissus');
               ARRET := TRUE;
             end;
         end;
       3:
         begin
           texte:='Vos hommes se préparent à défendre la colonie... ';
           ecrireTexteCentre(100,58,texte);
           if (getSoldat>0) then
              begin
                 temp:= random(3)+1;
                 if (getSoldat()-temp>=0) then
                    begin
                       setBois(getBois()-40);
                       setFish(getFish()-10);
                       setTissu(getTissu()-20);
                       write('Vous avez repoussé l''invahsion !');
                       writeln('Vous avez perdu',temp,' Soldats. Il vous reste',getSoldat(),' soldats.');
                       ARRET := TRUE;
                    end
                 else
                   begin
                     setBois(getBois()-60);
                     setfish(getFish()-30);
                     setTissu(getTissu()-50);
                     write('Vos soldats ont tous péri durant cette attaque... Vous avez perdu 50 uités de bois, 30 unités de poissons et 50 unités tissus');
                     ARRET := TRUE;
                   end;
              end
           else
             begin
               setBois(getBois()-60);
               setfish(getFish()-30);
               setTissu(getTissu()-50);
               write('Vos soldats n''ont pas été assez nombreux pour défendre cette attaque... Vous avez perdu 60 uités de bois, 30 unités de poissons et 50 unités tissus');
               ARRET := TRUE;
             end;
         end;
     end;
       ARRET := TRUE;
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
         case z of
           1:
             begin
               combat();
             end;
           2:
             begin
               capituler();
             end;
         end;
       end;
     ARRET := TRUE;
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

