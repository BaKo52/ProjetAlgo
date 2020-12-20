unit unitBot1;

{$mode objfpc}{$H+}
{$CODEPAGE UTF8}

interface

uses
  Classes, SysUtils, unitVarBot1, gestionEcran, unitVar;

//procédure gérant l'affichage des ressources du bot pour garder le joueur informé de l'avancement du bot
procedure affichageRessourceBot1();

//procédure gérant la production des ressources du bot en fonction de ses btiments
procedure productionBot1();

//procédure gérant les tests que va faire le bot pour savoir quoi faire pendant son tour
procedure tourBot1();

//procédure servant à initialiser les valeurs d'estimation pour le premier tour du bot
procedure initialisationEstimationBot1();

implementation
var
  //record contenant les besoins des colons du bot
  besoin : Record
    fish, tissu, bois : Integer;
  end;

  manque : Record
    fish, tissu, bois, outil, laine, gold, marchand, entrepot : Boolean;
    //booléen indiquand si le bot est en manque de poisson, de tissu ou de bois
    //false : il n'en a pas besoin
    //true : il en a besoin
    //marchand : booléen indiquant si le bot devra marchander pour obtenir ses ressources (dernier recours du bot)
  end;

  //record contenant les estimations des ressources du bot
  estimation : Record
    fish, tissu, bois, laine, colon, outil : Integer;
    attaque : Boolean;
    //attaque : booléen indiquant si le bot se mesure en capacité d'attaquer le joueur
    //false : il n'estime pas être en mesure d'attaquer le joueur
    //true : il estime être en mesure de vaincre le joueur
  end;

procedure affichageRessourceBot1();
  begin
    effacerEcran();

    //affichage du titre
    couleurs(black, white);
    ecrireTexteCentre(100, 2, 'Ressources de ');
    writeln(getNomBot1());

    //affichage des matériaux de construction du bot
    couleurs(white, black);

    ecrireTexte(3, 8, 'Nombre de colons : ');
    write(getColonBot1());
    write('/', getMaisonBot1() * 4);

    ecrireTexte(3, 9, 'Nombre de soldats : ');
    write(getSoldatBot1());

    ecrireTexte(3, 10, 'Nombre de bateaux : ');
    write(getBateauBot1());

    ecrireTexte(3, 11, 'Argent : ');
    write(getGoldBot1());


    ecrireTexte(3, 13, 'Liste des matériaux :');

    ecrireTexte(3, 14, '- Bois : ');
    write(getBoisBot1());

    ecrireTexte(3, 15, '- Poissons : ');
    write(getFishBot1());

    ecrireTexte(3, 16, '- Laine : ');
    write(getLaineBot1());

    ecrireTexte(3, 17, '- Outil : ');
    write(getOutilBot1());

    ecrireTexte(3, 18, '- Tissu : ');
    write(getTissuBot1());

    ecrireTexte(3, 19, 'Liste des bâtiments : ');

    ecrireTexte(3, 20, '- Maison : ');
    write(getMaisonBot1());

    ecrireTexte(3, 21, '- Cabane de bûcheron : ');
    write(getCabaneBBot1());

    ecrireTexte(3, 22, '- Cabane de pêcheur : ');
    write(getCabanePBot1());

    ecrireTexte(3, 23, '- Bergerie : ');
    write(getBergerieBot1());

    ecrireTexte(3, 24, '- Atelier de tisserand : ');
    write(getAtelierBot1());

    ecrireTexte(3, 25, '- Entrepot : ');
    write(getEntrepotBot1());

    if (getChapelleBot1 = false) then
      begin
        ecrireTexte(3, 26, 'Le bot n''a pas encore de chapelle');
      end
    else
      begin
        ecrireTexte(3, 26, 'Le bot a une chapelle');
      end;

    if (getCentreVilleBot1 = false) then
      begin
        ecrireTexte(3, 27, 'Le bot n''a pas encore de centre-ville');
      end
    else
      begin
        ecrireTexte(3, 27, 'Le bot a un centre-ville');
      end;

    if (getNavalBot1 = false) then
      begin
        ecrireTexte(3, 28, 'Le bot n''a pas encore de chantier naval');
      end
    else
      begin
        ecrireTexte(3, 28, 'Le bot a un chantier naval');
      end;
  end;

procedure productionBot1();
  var
    res : Integer ;
  begin
    //Production de poissons
    setFishBot1(getFishBot1()+(getCabanePBot1()*4)); //Une cabane de pêcheur produit 4 poissons


    //Production de bois
    setBoisBot1(getBoisBot1()+(getCabaneBBot1()*5)); //Une cabane de bucheron produit 5 bois

    //Production de tissu
    res:= getAtelierBot1()*5;    //met le nombre de laine requit pour créer le tissu dans une variable temporaire
    if res<getLaineBot1() then   //check si le bot à assez de laine
      begin
        setLaineBot1(getLaineBot1()-res);                 //soustrait la laine pour créer du tissu à la laine du bot
        setTissuBot1(getTissuBot1()+(getAtelierBot1*10)); //un atelier produit 10 tissu pour 5 laines
      end;

    //Production de Laine
    setLaineBot1(getLaineBot1()+(getBergerieBot1*5)); //Une bergerie produit 5 laines

    //Nouveau colons
    setColonBot1(getColonBot1()+round(getColonBot1()/5)); //donne 20% de la population en colon supplémentaire par tour
    if(getColonBot1()>(getMaisonBot1()*4)) then           //check que la population ne dépasse pas la limite
      setColonBot1(getMaisonBot1()*4);
  end;

//procédure planifiant les ressources qu'aura le bot à la fin du prochain tour
//après la procédure de production et avant le code qui regarde si le bot a perdu
//le but de cette procédure est de savoir si, dans l'état actuel, le bot survivra
//si les valeurs sont bonnes (i.e. tout les colons ne sont pas morts)
//alors le bot utilisera les ressources pour préparer son attaque sur le joueur
procedure planification();
  var
    res : Integer;
  begin
    res := getColonBot1 div 2;

    besoin.fish := res;        //conso des colons en poisson
    besoin.bois := res div 2;  //conso des colons en bois
    besoin.tissu := res + 3;   //conso des colons en tissu

    //estimation de la quantité de poisson du bot et on continue avec chaque ressource
    estimation.fish := getFishBot1() + getCabanePBot1() * 4 - besoin.fish;
    estimation.bois:= getBoisBot1() + getCabaneBBot1() * 5 - besoin.bois;
    estimation.laine:= getLaineBot1() + getBergerieBot1() * 5;

    res:= getAtelierBot1()*5;       //met le nombre de laine requit pour créer le tissu dans une variable temporaire
    if res <= estimation.laine then      //check si le bot aura assez de laine
      begin
        estimation.laine := getLaineBot1() - res;
        estimation.tissu := getTissuBot1() + getAtelierBot1() * 10 - besoin.tissu;
      end;
    //on utilise estimation.laine pour calculer si le bot a assez de laine pour produire le tissu
    //car le bot produit de la laine ensuite utilise celle-ci pour faire du tissu (comme le joueur)
    //dans le code côté joueur on a : production de laine ensuite production de tissu

    estimation.colon:= getColonBot1() + getColonBot1() div 5;
    //on estime le nombre de colon que va gagner le bot

    estimation.outil := getOutilBot1();

      //les trois prochains tests avec les estimations servent à savoir si les colons sont en danger
      //le premier sert à savoir si ils ont besoin de poisson
      //le deuxième pour le tissu
      //le dernier pour le bois
      //on donne un marge de manoeuvre de 20 unités
      //le bot est donc considéré en manque quand une des ses trois ressources est inférieur à 20
    if (estimation.fish < 10) then
      begin
        manque.fish := true;
      end;

    if (estimation.tissu < 10) then
      begin
        manque.tissu := true;
      end;

    if (estimation.bois < 10) then
      begin
        manque.bois := true;
      end;

    if (estimation.outil < 10) then
      begin
        manque.outil := true;
      end;
  end;

//procédure servant à initialiser les valeurs d'estimation
procedure initialisationEstimationBot1();
  begin
    estimation.bois := getBoisBot1();
    estimation.tissu := getTissuBot1();
    estimation.fish := getFishBot1();
    estimation.laine := getLaineBot1();
    estimation.colon := getColonBot1();
    estimation.attaque := false;
  end;

procedure mortBot1();
  begin
    effacerEcran();
    couleurs(green,black);
    ecrireTexteCentre(100, 29, 'Votre adversaire est mort !');
    ecrireTexteCentre(100, 31, 'Vous avez gagné bravo !');
    readln();
    halt();
  end;

procedure echange(z : Integer);
  var
    temp : Integer;
    reponse : Char;
    ARRET : Boolean;
  begin
    ARRET := false;
    reponse := 'a';
    case z of
      1:
        begin
          while not(ARRET) do
            begin
              effacerEcran();

              couleurs(black, white);
              ecrireTexteCentre(100, 2, 'Un échange vous est proposé par ');
              writeln(getNomBot1());

              couleurs(white, black);
              ecrireTexte(3, 8, 'Il vous propose l''échange suivant (il veut acheter) : ');

              temp := 70 - getBoisBot1();
                //si le bot demande plus que ce qu'a le joueur
                //le bot va donc demander la moitié de ce qu'a le joueur
              if (temp > getBois()) then
                begin
                  temp := getBois() div 2;
                end;
              deplacerCurseurXY(3, 10);
              write(temp, ' unité de bois pour ');
                //on augmente les prix pour inciter le joueur à accepter
              writeln(temp * 6, ' pièces d''or');

              ecrireTexte(3, 12, 'Acceptez-vous ? (y/n)');
                //on attend la réponse du joueur
              readln(reponse);
              case reponse of
              'y':
                begin
                  ARRET := true;
                  couleurs(green, black);
                  ecrireTexteCentre(3, 13, 'Vous avez accepté l''échange');
                  couleurs(white, black);

                  setGoldBot1(getGoldBot1() - temp * 6);
                  setGold(getGold() + temp * 6);

                  setBoisBot1(getBoisBot1() + temp);
                  setBois(getBois() - temp);
                  readln();
                end;
              'n':
                begin
                  ARRET := true;
                  couleurs(red, black);
                  ecrireTexteCentre(3, 13, 'Vous avez refusé l''échange');
                  couleurs(white, black);
                  readln();
                end;
              end;
            end;
        end;
      2:
        begin
          while not(ARRET) do
            begin
              effacerEcran();

              couleurs(black, white);
              ecrireTexteCentre(100, 2, 'Un échange vous est proposé par ');
              writeln(getNomBot1());

              couleurs(white, black);
              ecrireTexte(3, 8, 'Il vous propose l''échange suivant (il veut acheter) : ');

              temp := 70 - getOutilBot1();
                //si le bot demande plus que ce qu'a le joueur
                //le bot va donc demander la moitié de ce qu'a le joueur
              if (temp > getOutil()) then
                begin
                  temp := getOutil() div 2;
                end;
              deplacerCurseurXY(3, 10);
              write(temp, ' outils pour ');
                //on augmente les prix pour inciter le joueur à accepter
              writeln(temp * 3, ' pièces d''or');

              ecrireTexte(3, 12, 'Acceptez-vous ? (y/n)');
                //on attend la réponse du joueur
              readln(reponse);
              case reponse of
              'y':
                begin
                  ARRET := true;
                  couleurs(green, black);
                  ecrireTexteCentre(3, 13, 'Vous avez accepté l''échange');
                  couleurs(white, black);

                  setGoldBot1(getGoldBot1() - temp * 3);
                  setGold(getGold() + temp * 3);

                  setOutilBot1(getOutilBot1() + temp);
                  setOutil(getOutil() - temp);
                  readln();
                end;
              'n':
                begin
                  ARRET := true;
                  couleurs(red, black);
                  ecrireTexteCentre(3, 13, 'Vous avez refusé l''échange');
                  couleurs(white, black);
                  readln();
                end;
              end;
            end;
        end;
      3:
        begin
          while not(ARRET) do
            begin
              effacerEcran();

              couleurs(black, white);
              ecrireTexteCentre(100, 2, 'Un échange vous est proposé par ');
              writeln(getNomBot1());

              couleurs(white, black);
              ecrireTexte(3, 8, 'Il vous propose l''échange suivant (il veut acheter) : ');

              temp := 70 - getBoisBot1();
                //si le bot demande plus que ce qu'a le joueur
                //le bot va donc demander la moitié de ce qu'a le joueur
              if (temp > getFish()) then
                begin
                  temp := getFish() div 2;
                end;
              deplacerCurseurXY(3, 10);
              write(temp, ' unité de poissons pour ');
                //on augmente les prix pour inciter le joueur à accepter
              writeln(temp * 6, ' pièces d''or');

              ecrireTexte(3, 12, 'Acceptez-vous ? (y/n)');
                //on attend la réponse du joueur
              readln(reponse);
              case reponse of
              'y':
                begin
                  ARRET := true;
                  couleurs(green, black);
                  ecrireTexteCentre(3, 13, 'Vous avez accepté l''échange');
                  couleurs(white, black);

                  setGoldBot1(getGoldBot1() - temp * 6);
                  setGold(getGold() + temp * 6);

                  setFishBot1(getFishBot1() + temp);
                  setFish(getFish() - temp);
                  readln();
                end;
              'n':
                begin
                  ARRET := true;
                  couleurs(red, black);
                  ecrireTexteCentre(3, 13, 'Vous avez refusé l''échange');
                  couleurs(white, black);
                  readln();
                end;
              end;
            end;

        end;
      4:
        begin
          while not(ARRET) do
            begin
              effacerEcran();

              couleurs(black, white);
              ecrireTexteCentre(100, 2, 'Un échange vous est proposé par ');
              writeln(getNomBot1());

              couleurs(white, black);
              ecrireTexte(3, 8, 'Il vous propose l''échange suivant (il veut acheter) : ');

              temp := 70 - getTissuBot1();
                //si le bot demande plus que ce qu'a le joueur
                //le bot va donc demander la moitié de ce qu'a le joueur
              if (temp > getTissu()) then
                begin
                  temp := getTissu() div 2;
                end;
              deplacerCurseurXY(3, 10);
              write(temp, ' unité de tissu pour ');
                //on augmente les prix pour inciter le joueur à accepter
              writeln(temp * 6, ' pièces d''or');

              ecrireTexte(3, 12, 'Acceptez-vous ? (y/n)');
                //on attend la réponse du joueur
              readln(reponse);
              case reponse of
              'y':
                begin
                  ARRET := true;
                  couleurs(green, black);
                  ecrireTexteCentre(3, 13, 'Vous avez accepté l''échange');
                  couleurs(white, black);

                  setGoldBot1(getGoldBot1() - temp * 6);
                  setGold(getGold() + temp * 6);

                  setFishBot1(getFishBot1() + temp);
                  setFish(getFish() - temp);
                  readln();
                end;
              'n':
                begin
                  ARRET := true;
                  couleurs(red, black);
                  ecrireTexteCentre(3, 13, 'Vous avez refusé l''échange');
                  couleurs(white, black);
                  readln();
                end;
              end;
            end;
        end;
    end;

  end;

procedure marchandage();
  var
    x : Integer; //variable qui détermine la valeur de la matière que veux le bot
  begin
    if (manque.marchand) then
      begin
        if (manque.bois) then
          begin
              //on check si le marchand est là
              //si oui on marchande en priorité avec lui
              //car le marchand ne peut pas refuser la transaction
            if ((getNbRoundBot1() mod 3) = 0) then
              begin
                  //on attribue a x la valeur que veux le bot
                  //j'ai choisi 100 comme valeur de sécurité afin que le bot ai une marge de manoeuvre
                  //on soustrait le bois actuel du bot à 100 afin de n'avoir que le bois nécessaire
                x := 100 - getBoisBot1();
                if (getGoldBot1() >= x * 5) then
                  begin
                    setBoisBot1(getBoisBot1() + x);
                    setGoldBot1(getGoldBot1() - (x * 5)); //5 pièces d'or pour une unité de bois
                  end;
                writeln('Le bot a acheté du bois : ', x);
                readln();
              end
              //sinon on marchande avec le joueur
              //on va vendre les ressources plus cher au joueur pour l'inciter à accepter
            else echange(1);
          end;
        if (manque.outil) then
          begin
            if ((getNbRoundBot1() mod 3) = 0) then
              begin
                  //on fait la même pour les autres ressources en adaptant les prix
                x := 100 - getOutilBot1();
                if (getGoldBot1() >= x * 2) then
                  begin
                    setOutilBot1(getOutilBot1() + x);
                    setGoldBot1(getGoldBot1() - (x * 2)); //2 pièces d'or pour un outil
                  end;
                writeln('Le bot a acheté des outils : ', x);
                readln();
              end
            else echange(2);
          end;
        if (manque.fish) then
          begin
            if ((getNbRoundBot1() mod 3) = 0) then
              begin
                  //on fait la même pour les autres ressources en adaptant les prix
                x := 100 - getOutilBot1();
                if (getGoldBot1() >= x * 5) then
                  begin
                    setFishBot1(getFishBot1() + x);
                    setGoldBot1(getGoldBot1() - (x * 5)); //5 pièces d'or pour une unité de poisson
                  end;
                writeln('Le bot a acheté du poissons : ', x);
                readln();
              end
            else echange(3);
          end;
        if (manque.tissu) then
          begin
            if ((getNbRoundBot1() mod 3) = 0) then
              begin
                  //on fait la même pour les autres ressources en adaptant les prix
                x := 100 - getOutilBot1();
                if (getGoldBot1() >= x * 5) then
                  begin
                    setTissuBot1(getTissuBot1() + x);
                    setGoldBot1(getGoldBot1() - (x * 5)); //5 pièces d'or pour une unité de tissu
                  end;
                writeln('Le bot a acheté du tissu : ', x);
                readln();
              end
            else echange(4);
          end;
      end;
  end;

//procédure servant à corriger les manques de ressources
procedure correction();
  begin
    //on va tester si le bot a besoin d'une (ou plus) des trois ressources vitales pour les colons
    //à savoir le bois, le poisson ou le tissu sont inférieur à 20
    //ici on boucle tant que le bot a besoin d'une des quatre ressources et qu'il ne doit pas aller au marchand
    //on fait ces tests afin d'éviter des pertes au bot
    while (((manque.bois) OR (manque.tissu) OR (manque.fish) OR (manque.outil)) AND not(manque.marchand)) do
      begin
        if (manque.Bois) then
          begin
            //si le bot a besoin de bois il est obligé de l'acheter
            //car la construction de la cabane demande du bois en elle-même
            manque.marchand := true;
          end;
        if (manque.outil) then
          begin
            //on est obligé d'aller au marchand pour les outils car c'est le seul moyen d'en obtenir
            manque.marchand := true;
          end;
        if (manque.Tissu) then
          begin
            //on va tester lequel entre l'atelier et la bergerie ralenti l'autre
            //on test pour savoir si on a plus d'atelier que de bergerie (il serait en manque de laine)
            if (getAtelierBot1() > getBergerieBot1()) then
              begin
                //si c'est vrai on fait acheter une bergerie au bot
                if ((getGoldBot1 > 499) AND (getBoisBot1 > 19) AND (getOutilBot1 > 9)) then
                  begin
                    setBergerieBot1(getBergerieBot1 + 1);
                    setGoldBot1(getGoldBot1 - 500);
                    setBoisBot1(getBoisBot1 - 20);
                    setOutilBot1(getOutilBot1 - 10);
                    manque.Tissu := false;
                  end
                //si on ne peut acheter le batiment on va marchander
                else manque.marchand := true;
              end
            //sinon on retest pour savoir si c'est l'inverse
            //on aurait trop de laine et pas assez d'atelier pour la transformer
            else if (getAtelierBot1() < getBergerieBot1()) then
              begin
                //si c'est vrai on fait acheter un atelier au bot
                if ((getGoldBot1 > 499) AND (getBoisBot1 > 19) AND (getOutilBot1 > 9) AND (getLaineBot1 > 9)) then
                  begin
                    setAtelierBot1(getAtelierBot1 + 1);
                    setGoldBot1(getGoldBot1 - 500);
                    setBoisBot1(getBoisBot1 - 20);
                    setOutilBot1(getOutilBot1 - 10);
                    setLaineBot1(getLaineBot1 - 10);
                    manque.tissu := false;
                  end
                //si on ne peut acheter le batiment on va marchander
                else manque.marchand := true;
              end
            //sinon on lui fait acheter les deux
            else
              begin
                if ((getGoldBot1 > 499) AND (getBoisBot1 > 19) AND (getOutilBot1 > 9)) then
                  begin
                    setBergerieBot1(getBergerieBot1 + 1);
                    setGoldBot1(getGoldBot1 - 500);
                    setBoisBot1(getBoisBot1 - 20);
                    setOutilBot1(getOutilBot1 - 10);
                    manque.tissu := false;
                  end
                //si on ne peut pas acheter le bâtiment on va marchander
                else manque.marchand := true;
                if ((getGoldBot1 > 499) AND (getBoisBot1 > 19) AND (getOutilBot1 > 9) AND (getLaineBot1 > 9)) then
                   begin
                      setAtelierBot1(getAtelierBot1 + 1);
                      setGoldBot1(getGoldBot1 - 500);
                      setBoisBot1(getBoisBot1 - 20);
                      setOutilBot1(getOutilBot1 - 10);
                      setLaineBot1(getLaineBot1 - 10);
                      manque.tissu := false;
                   end
                //si on ne peut pas acheter le bâtiment on va marchander
                else manque.marchand := true;
              end;
          end;
        if(manque.Fish) then
          begin
            //si le bot a besoin de poisson on lui fait acheter une cabane de pêcheur s'il a les ressources
            if ((getGoldBot1 > 499) AND (getBoisBot1 > 19) AND (getOutilBot1 > 9)) then
              begin
                setCabanePBot1(getCabanePBot1+1);
                setGoldBot1(getGoldBot1-500);
                setBoisBot1(getBoisBot1-20);
                setOutilBot1(getOutilBot1-10);
                manque.fish := false;
              end
            //si on ne peut pas acheter le bâtiment on va marchander
            else manque.marchand := true;
          end;
        if (manque.entrepot) then
          begin
            if ((getGoldBot1>499) AND (getOutilBot1>19) AND (getBoisBot1>99)) then
               begin
                 setGoldBot1(getGoldBot1-500);
                 setOutilBot1(getOutilBot1-20);
                 setBoisBot1(getBoisBot1-100);
                 setEntrepotBot1(getEntrepotBot1+1);
               end
            else manque.marchand := true
          end;
          //le bot refait des estimations afin de savoir s'il est toujours en manque de certaines ressources
        planification();
      end;

    //une fois toutes les opérations précédentes réalisés
    //le bot va marchander avec le marchand et/ou le joueur si nécessaire
    marchandage();
  end;

procedure attaqueBot();
  begin
    couleurs(red, black);
    ecrireTexteCentre(100, 3, 'Vous subissez une attaque de ');
    write(getNomBot1());
    couleurs(white, black);

    ecrireTexte(3, 8, 'Votre armée :');
    ecrireTexte(3, 9, '- Soldats :');
    write(getSoldat());
    ecrireTexte(3, 10, '- Bateaux :');
    write(getBateau());

    ecrireTexte(180, 8, 'Son armée :');
    ecrireTexte(180, 9, '- Soldats :');
    write(getSoldatBot1());
    ecrireTexte(180, 10, '- Bateaux :');
    write(getBateauBot1());

    ecrireTexteCentre(100, 20, 'Son armée est au bord de votre village, vous n''avez pas d''autre choix que d''attaquer !');
    readln();

    if ( (getSoldatBot1() + getBateauBot1() * 30) > ( (getSoldat() + getBateau * 30) ) ) then
      begin
        couleurs(red, black);
        ecrireTexteCentre(100, 23, 'Son armée était plus grande que la votre ...');
        ecrireTexteCentre(100, 24, 'Vous avez perdu !');
        readln();
        halt();
      end
    else
      begin
        couleurs(green, black);
        ecrireTexteCentre(100, 23, 'Votre armée est victorieuse !');
        ecrireTexteCentre(100, 24, 'Vous avez vaincu votre ennemi et vous êtes assuré le monopole des îles !');
        ecrireTexteCentre(100, 25, 'Bravo ! Vous avez gagné !');
        readln();
        halt();
      end;
  end;

procedure finTourBot();
  var
    res : Integer;
  begin
    res:= getColonBot1() div 2;

    //Conso de poissons
    if res<getFishBot1() then
      begin
        setFishBot1(getFishBot1-res);
      end
    else
      begin
        setColonBot1(getColonBot1-4);
      end;

    //Conso de tissu
    if (res + 3)<getTissuBot1 then
      begin
        setTissuBot1(getTissuBot1-(res + 3));
      end
    else
      begin
        setColonBot1(getColonBot1-2);
      end;

    //Conso de bois
    if (res div 2)<getBoisBot1 then
      begin
        setBoisBot1(getBoisBot1-(res div 2));
      end
    else
      begin
        setColonBot1(getColonBot1-2);
      end;


    //Passage vers le tour suivant ou fin de partie
    If getColonBot1<1 then
      begin
        mortBot1();
      end
    else
      begin
        setGoldBot1(getGoldBot1()+(getColonBot1()*25));  //Taxes
      end;

    if(getBoisBot1>getEntrepotBot1*200) then
      begin
        setBoisBot1(getEntrepotBot1*200);
        manque.entrepot := true;
      end;

    if(getFishBot1>getEntrepotBot1*200) then
      begin
        setFishBot1(getEntrepotBot1*200);
        manque.entrepot := true;
      end;

    if(getOutilBot1>getEntrepotBot1*200) then
      begin
        setOutilBot1(getEntrepotBot1*200);
        manque.entrepot := true;
      end;

    if(getLaineBot1>getEntrepotBot1*200) then
      begin
        setLaineBot1(getEntrepotBot1*200);
        manque.entrepot := true;
      end;

    if(getTissuBot1>getEntrepotBot1*200) then
      begin
        setTissuBot1(getEntrepotBot1*200);
        manque.entrepot := true;
      end;
  end;

procedure tourBot1();
  begin
      //on incrémente le compteur de tour du bot
    setNbRoundBot1(getNbRoundBot1() + 1 );

      //on test pour savoir si le bot s'estime être prêt à attaquer
      //cette estimation est faîtes à la fin du dernier tour afin de donner un tour de préparation au joueur
      //(s'il remarque que la taille de l'armée du bot est devenue inquiétante)
      //si le test est vrai alors le bot attaque le joueur
      //sinon rien ne se passe
    if (estimation.attaque) then
      attaqueBot();

    //--------------------Suites de test logiques déterminant les actions du bot--------------------

      //les tests suivants servent à ce que le bot ai une production stable de chaque matériau de base
      //le bot va créer une cabane de bûcheron le premier tour
      //une cabane de pêcheur le tour suivant
      //ensuite une bergerie et il va répéter cela en boucle
    if ((getBergerieBot1() - 1) = getCabanePBot1()) then
      begin
        if ((getGoldBot1 > 499) AND (getBoisBot1 > 19) AND (getOutilBot1 > 9)) then
          begin
            setCabanePBot1(getCabanePBot1+1);
            setGoldBot1(getGoldBot1-500);
            setBoisBot1(getBoisBot1-20);
            setOutilBot1(getOutilBot1-10);
          end;
      end;

    if ((getCabaneBBot1() - 1) = getBergerieBot1()) then
      begin
        if ((getGoldBot1 > 499) AND (getBoisBot1 > 19) AND (getOutilBot1 > 9)) then
          begin
            setBergerieBot1(getBergerieBot1+1);
            setGoldBot1(getGoldBot1-500);
            setBoisBot1(getBoisBot1-20);
            setOutilBot1(getOutilBot1-10);
          end;
      end;

    if (((getCabanePBot1() - 1) = getCabaneBBot1()) OR (getCabanePBot1() = getCabaneBBot1())) then
      begin
        if ((getGoldBot1 > 499) AND (getBoisBot1 > 19) AND (getOutilBot1 > 9)) then
          begin
            setCabaneBBot1(getCabaneBBot1+1);
            setGoldBot1(getGoldBot1-500);
            setBoisBot1(getBoisBot1-20);
            setOutilBot1(getOutilBot1-10);
          end;
      end;



      //la priorité du bot 'hormis de faire survivre ses colons) est de tuer le joueur
      //pour ce faire il va tout d'abord créer un chantier naval s'il a les ressources pour
    if ( (not(getNavalBot1())) AND (getGoldBot1() > 999) AND (getBoisBot1() > 99) AND (getOutilBot1() > 19) AND (getTissuBot1() > 9) ) then
      begin
        setNavalBot1(true);
        setGoldBot1(getGoldBot1-1000);
        setBoisBot1(getBoisBot1-100);
        setOutilBot1(getOutilBot1-20);
        setTissuBot1(getTissuBot1-10);
      end;

      //ensuite il va utiliser tout les ressources restantes (i.e. celle qu'il n'a pas utilisé pour sauver les colons)
      //pour créer des bateaux
    if (getNavalBot1()) then
      begin
          //il va créer des bateaux jusqu'a ce qu'il ne puisse plus
        while ( (getGoldBot1() > 499) AND (getBoisBot1 > 49) AND (getOutilBot1() > 19) ) do
          begin
            setBateauBot1(getBateauBot1() + 1);
            setGoldBot1(getGoldBot1() - 500);
            setBoisBot1(getBoisBot1() - 50);
            setOutilBot1(getOutilBot1() - 20);
          end;

          //ensuite il va recruter des soldats avec l'argent restant
          //(on laisse cette partie sous la condition que le bot ai créé un chantier naval
          //car on veut qu'il économise pour un chantier naval et ensuite commence à recruter une armée)
        while ((getGoldBot1() > 24) AND (getOutilBot1 > 6) AND (getTissuBot1() > 9) AND (getFishBot1() > 24)) do
          begin
            setSoldatBot1(getSoldatBot1() + 5);
            setGoldBot1(getGoldBot1() - 25);
            setOutilBot1(getOutilBot1() - 5);
            setTissuBot1(getTissuBot1() - 10);
            setFishBot1(getFishBot1() - 25);
          end;
      end;

      //on fait les estimations pour le tour
      //on les fait après les achats de bâtiment de production et autres
      //car si on le fait avant le bot risque de dépenser plus qu'il ne peux
    planification();

      //on appelle la procédure corrigeant les manques de ressources
    correction();

    if ( (getSoldatBot1() + getBateauBot1() * 30) > ( (getSoldat() + getBateau * 30) + 40) ) then
      begin
          //on additione le nombre de soldat du bot au nombre de bateaux du bot qu'on multiplie par
          //et on le compare au résultat de ce calcul mais avec les chiffres de l'ennemi
          //j'ai décidé d'établir qu'un bateau (en situation de combat joueur contre bot) valait 30 soldats
          //on ajoute 40 au résultat de l'ennemi afin d'avoir un avantage numérique
          //ainsi que de donner le temps au joueur de remarquer l'augmentation de la taille de l'armée
          //et ainsi le temps de se préparer à une attaque
        estimation.attaque := true;
      end;



    productionBot1();

    finTourBot();

    affichageRessourceBot1();
    readln();
  end;
end.
