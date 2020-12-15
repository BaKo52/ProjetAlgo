unit unitNaval;

{$mode objfpc}{$H+}

interface
  uses Classes, SysUtils;

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
  procedure afficheDebversFin(l : listeBateau);

  //ajoute un bateau à la fin de la liste
  procedure ajouteFin(var l : listeBateau ; nom : String);

  //enlève le premier bateau de la liste
  procedure depileDeb(var l : listeBateau);

implementation

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

  procedure afficheDebversFin(l : listeBateau);
   var
     x : PBateau;
   begin
     x := l.pDeb;

     writeln('Premier bateau :');
     write('Votre bateau s''appelle : ', x^.nom);

     x :=x^.succ;

     while ((x <> l.pFin) AND (x <> NIL)) do
     begin
       writeln('Premier bateau :');
       writeln('Votre bateau s''appelle : ', x^.nom);
       x := x^.succ;
     end;
   end;

  procedure AffAttaque();
     var
       texte:String;
     begin
       dessinerCadreXY(95,1,104,3,double,white,black);
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

  procedure nextRound();
    var
      texte:String;
      res: Integer;
    begin
      EffacerEcran();
      nbRound:=nbRound+1;
      res:= getColon div 2;

      production();

      //Conso de poissons
      if res<getFish then
        begin
          setFish(getFish-res);
          texte:='Vos colons se délectent de vos poissons! Poissons restant: ';
          ecrireTexteCentre(100,10,texte);
          write(getFish);
        end
      else
        begin
          texte:='Vous n''avez plus assez de poisson, vos colons ont faim !';
          ecrireTexteCentre(100,10,texte);
          setColon(getColon-4);
        end;

      //Conso de tissu
      if (res + 3)<getTissu then
        begin
          setTissu(getTissu-(res + 3));
          texte:='Vos ressources en tissu subviennent à vos colons ! Tissu restant: ';
          ecrireTexteCentre(100,12,texte);
          write(getTissu);
        end
      else
        begin
          texte:='Vous n''avez plus assez de tissu, vos colons sont en colère !';
          ecrireTexteCentre(100,12,texte);
          setColon(getColon-2);
        end;

      //Conso de bois
      if (res div 2)<getBois then
        begin
          setBois(getBois-(res div 2));
          texte:='Vos ressources en bois subviennent à vos colons ! Bois restant: ';
          ecrireTexteCentre(100,14,texte);
          write(getBois);
        end
      else
        begin
          texte:='Vous n''avez plus assez de bois, vos colons ne peuvent plus se chauffer !';
          ecrireTexteCentre(100,14,texte);
          setColon(getColon-2);
        end;

      //Check centre-ville
      if getCentreVille=TRUE then
        begin
          texte:='Vous avez un centre-ville, vos colons sont heureux !';
          ecrireTexteCentre(100,16,texte);
        end
      else
        texte:='Vous n''avez pas de centre-ville, vos colons sont mécontent !';
        ecrireTexteCentre(100,16,texte);

      //Check chapelle
      if getChapelle=TRUE then
        begin
          texte:='Vous avez une chapelle, vos colons sont heureux !';
          ecrireTexteCentre(100,18,texte);
        end
      else
        texte:='Vous n''avez pas de chapelle, vos colons sont mécontent !';
        ecrireTexteCentre(100,18,texte);

      dessinerCadreXY(1,4,15,7,simple,white,black);
      texte:='Argent :';
      ecrireTexte(2,5,texte);
      write(getGold);
      texte:='Tour: ';
      ecrireTexte(2,6,texte);
      write(nbRound-1);

      readln();

      //Passage vers le tour suivant ou fin de partie
      EffacerEcran();
      If getColon<1 then
        begin
          texte:='L''entièreté de vos colons est mort !';
          ecrireTexteCentre(100,10,texte);
          texte:='Vous avez perdu !';
          ecrireTexteCentre(100,12,texte);
          readln();
          halt();
        end
      else
        begin
          setGold(getGold+(getColon*25));  //Taxes
          texte:='Vos colons vous on rapporté: ';
          ecrireTexteCentre(100,10,texte);
          write(getGold);
          if (nbRound mod 3 = 0) then
             begin
                  marchand(); //Marchand
             end;
          if (nbRound mod 8 = 0)then
             begin
                attaque(); //attaque sur la colonie
             end;

          ile();
        end;
    end;

  procedure naval();
    var
      texte : String;
      z, i : Integer;
      ARRET : Boolean;
      fichier : Text;
      tabBateau : Array [0..16] of String;
      l : listeBateau;
    begin
      randomize();
      if getNaval()=true then
        begin
          ARRET:=false;

          while not(ARRET) do
            begin
              effacerEcran();

              ile();

              texte:='1. Construire un navire : -500 or, - 50 bois et -20 outils';
              ecrireTexte(10, 30, texte);

              texte:='2. Retour au menu précédent';
              ecrireTexte(10, 32, texte);

              ecrireTexte(10,34,'Que voulez-vous faire ? ');

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
                        l := getListe();
                        ajouteFin(l, tabBateau[i]);
                     end
                  else
                      begin
                        texte:='Vous n''avez pas les ressources pour construire un navire';
                        ecrireTexte(10, 35, texte);
                        readln();
                      end;
                end;
              2:ARRET:=true;
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

