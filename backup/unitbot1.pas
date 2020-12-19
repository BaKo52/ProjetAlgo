unit unitBot1;

{$mode objfpc}{$H+}
{$CODEPAGE UTF8}

interface

uses
  Classes, SysUtils, unitVarBot1, unitVar, gestionEcran;

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
    boolFish, boolTissu, boolBois : Boolean;
    //booléen indiquand si le bot est en manque de poisson, de tissu ou de bois
    //false : il n'en a pas besoin
    //true : il en a besoin
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
    //on utilise estimation.laine pour calculer si le bot a assez de laine pour produire le
    //car le bot produit de la laine ensuite utilise celle-ci pour faire du tissu comme le joueur
    //dans le code côté joueur on a : production de laine ensuite production de tissu

    estimation.colon:= getColonBot1() + getColonBot1() div 5;

    if (estimation.fish <= 0) then
      begin
        estimation.colon := estimation.colon - 4; //le bot comme le joueur perd 4 colons si il manque de poisson
        besoin.boolFish := true;                  //le bot a besoin de poisson
      end;

    if (estimation.tissu <= 0) then
      begin
        estimation.colon := estimation.colon - 2; //même perte en colon que pour le joueur
        besoin.boolTissu := true;                 //le bot a besoin de tissu
      end;

    if (estimation.bois <= 0) then
      begin
        estimation.colon := estimation.colon - 2; //même perte en colon que pour le joueur
        besoin.boolBois := true;                  //le bot a besoin de bois
      end;
  end;

//procédure servant à initialiser les valeurs d'estimation pour le premier tour du bot
procedure initialisationEstimationBot1();
  begin
    estimation.bois := getBoisBot1();
    estimation.tissu := getTissuBot1();
    estimation.fish := getFishBot1();
    estimation.laine := getLaineBot1();
    estimation.colon := getColonBot1();
    estimation.attaque := false;
  end;

procedure tourBot1();
  begin
    //estimation pour le tour
    planification();

    //--------------------Suites de test logiques déterminant les actions du bot--------------------

    if (getCabanePBot1() < 1) then
      begin

      end;
    (getCabaneBBot1() < 1)
    (getBergerieBot1() < 1)


    if (besoin.boolBois <= 0) then
      begin
        //besoin de cabane de bûcheron
      end;
    if (besoin.boolTissu <= 0) then
      begin
        //besoin atelier + faire check nbAtelier > nbBergerie alors construire bergerie sinon si nbAtelier < nbBergerie alors construire atelier sinon construire les deux
      end;
    if(estimation.fish <= 0) then
      begin
        //besoin de poisson
      end;

  end;
end.

