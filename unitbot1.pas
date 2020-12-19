unit unitBot1;

{$mode objfpc}{$H+}
{$CODEPAGE UTF8}

interface

uses
  Classes, SysUtils, unitVarBot1, gestionEcran;

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
    fish, tissu, bois, outil, laine, gold, marchand : Boolean;
    //booléen indiquand si le bot est en manque de poisson, de tissu ou de bois
    //false : il n'en a pas besoin
    //true : il en a besoin
    //marchand : booléen indiquant si le bot devra marchander pour obtenir ses ressources (dernier recours du bot)
  end;

  //record contenant les estimations des ressources du bot
  estimation : Record
    fish, tissu, bois, laine, colon : Integer;
    attaque : Boolean;
    //attaque : booléen indiquant si le bot se mesure en capacité d'attaquer le joueur
    //false : il n'estime pas être en mesure d'attaquer le joueur
    //true : il estime être en mesure de vaincre le joueur
  end;

procedure affichageRessourceBot1();
  begin
    //affichage du titre
    couleurs(black, white);
    ecrireTexteCentre(100, 2, 'Ressources de ');
    writeln(getNomBot1());

    //affichage des matériaux de construction du bot
    couleurs(white, black);

    ecrireTexte(3, 8, 'Nombre de colons : ');
    write(getColonBot1());
    write('/', getMaisonBot1() * 4);

    ecrireTexte(3, 9, 'Argent : ');
    write(getGoldBot1());


    ecrireTexte(3, 11, 'Liste des matériaux :');

    ecrireTexte(3, 12, '- Bois : ');
    write(getBoisBot1());

    ecrireTexte(3, 13, '- Poissons : ');
    write(getFishBot1());

    ecrireTexte(3, 14, '- Laine : ');
    write(getLaineBot1());

    ecrireTexte(3, 15, '- Outil : ');
    write(getOutilBot1());

    ecrireTexte(3, 16, '- Tissu : ');
    write(getTissuBot1());

    ecrireTexte(3, 18, 'Liste des bâtiments : ');

    ecrireTexte(3, 19, '- Maison : ');
    write(getMaisonBot1());

    ecrireTexte(3, 20, '- Cabane de bûcheron : ');
    write(getCabaneBBot1());

    ecrireTexte(3, 21, '- Cabane de pêcheur : ');
    write(getCabanePBot1());

    ecrireTexte(3, 22, '- Bergerie : ');
    write(getBergerieBot1());

    ecrireTexte(3, 23, '- Atelier de tisserand : ');
    write(getAtelierBot1());

    if (getChapelleBot1 = false) then
      begin
        ecrireTexte(3, 24, 'Le bot n''a pas encore de chapelle');
      end
    else
      begin
        ecrireTexte(3, 24, 'Le bot a une chapelle');
      end;

    if (getCentreVilleBot1 = false) then
      begin
        ecrireTexte(3, 25, 'Le bot n''a pas encore de centre-ville');
      end
    else
      begin
        ecrireTexte(3, 25, 'Le bot a un centre-ville');
      end;

    if (getNavalBot1 = false) then
      begin
        ecrireTexte(3, 26, 'Le bot n''a pas encore de chantier naval');
      end
    else
      begin
        ecrireTexte(3, 26, 'Le bot a un chantier naval');
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
        estimation.laine := estimation.laine - res;
        estimation.tissu := getAtelierBot1() * 10 - besoin.tissu;
      end;
    //on utilise estimation.laine pour calculer si le bot a assez de laine pour produire le tissu
    //car le bot produit de la laine ensuite utilise celle-ci pour faire du tissu (comme le joueur)
    //dans le code côté joueur on a : production de laine ensuite production de tissu

    estimation.colon:= getColonBot1() + getColonBot1() div 5;

    if (estimation.fish <= 0) then
      begin
        estimation.colon := estimation.colon - 4; //le bot comme le joueur perd 4 colons s"il manque de poisson
        if ((estimation.colon) <= 0) then         //si le nombre de colon est critique (inférieur ou égal à 0) alors le bot est notifié qu'il doit combler le manque
          begin
            manque.fish := true;                  //le bot a besoin de poisson
          end;
      end;

    if (estimation.tissu <= 0) then
      begin
        estimation.colon := estimation.colon - 2; //même perte en colon que pour le joueur
        if ((estimation.colon) <= 0) then         //si le nombre de colon est critique (inférieur ou égal à 0) alors le bot est notifié qu'il doit combler le manque
          begin
            manque.tissu := true;                  //le bot a besoin de tissu
          end;
      end;

    if (estimation.bois <= 0) then
      begin
        estimation.colon := estimation.colon - 2; //même perte en colon que pour le joueur
        if ((estimation.colon) <= 0) then         //si le nombre de colon est critique (inférieur ou égal à 0) alors le bot est notifié qu'il doit combler le manque
          begin
            manque.Bois := true;                  //le bot a besoin de bois
          end;
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
    setEtatBot1(true);
    readln();
    halt();
  end;

procedure tourBot1();
  begin
    if not(getEtatBot1) then
      begin
        //estimation pour le tour
        planification();

        //on incrémente le compteur de tour du bot
        setNbRoundBot1(getNbRoundBot1() + 1 );

        //--------------------Suites de test logiques déterminant les actions du bot--------------------

          //les trois prochains tests servent pour les premiers tours
          //il servent à ce que le bot ai une production stable de chaque matériau de base
          //le bot va créer des cabane de pêcheur, de bucheron et des bergeries, jusqu'à ce qu'il en ai 10
          //ensuite il s'arrêtera (10 parrait être un nombre de bâtiments où la production est stable et suffissante)

        if ((getCabanePBot1() - 1) = getBergerieBot1()) then
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

        if (((getCabaneBBot1() - 1) = getCabanePBot1()) OR (getCabaneBBot1() = 0)) then
          begin
            if ((getGoldBot1 > 499) AND (getBoisBot1 > 19) AND (getOutilBot1 > 9)) then
              begin
                setCabaneBBot1(getCabaneBBot1+1);
                setGoldBot1(getGoldBot1-500);
                setBoisBot1(getBoisBot1-20);
                setOutilBot1(getOutilBot1-10);
              end;
          end;





        //on va tester si le bot a besoin d'une (ou plus) des trois ressources vitales pour les colons
        //à savoir le bois, le poisson ou le tissu
        if (manque.Bois = true) then
          begin
            //si le bot a besoin de bois il est obligé de l'acheter
            //car la construction de la cabane demande du bois en elle-même
            manque.marchand := true;
          end;
        if (manque.Tissu = true) then
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
                    manque.Tissu := false;
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
                    manque.Tissu := false;
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
                      manque.Tissu := false;
                   end
                //si on ne peut pas acheter le bâtiment on va marchander
                else manque.marchand := true;
              end;
          end;
        if(manque.Fish = true) then
          begin
            //si le bot a besoin de poisson on lui fait acheter une cabane de pêcheur s"il a les ressources
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



      end;


  end;
end.

