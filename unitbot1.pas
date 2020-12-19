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

implementation
var
  //record contenant les besoins des colons du bot
  besoin : Record
    fish, tissu, bois : Integer;
  end;

  //record contenant les estimations des ressources du bot
  estimation : Record
    fish, tissu, bois, laine, gold, colon, soldat, bateaux, outil : Integer;
    attaque : Boolean; //booléen indiquant si le bot se mesure en capacité d'attaquer le joueur
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

    readln();
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
    estimation.colon:= getColonBot1() + getColonBot1() div 5;
    estimation.gold:= getGoldBot1() + estimation.colon * 25;
    //on utilise estimation.colon pour calculer les taxes car le joueur gagne des colons ensuite gagne les taxes
    //en faisant donc payer les nouveaux colons

    estimation.laine:= getLaineBot1() + getBergerieBot1() * 5;

    res:= getAtelierBot1()*5;       //met le nombre de laine requit pour créer le tissu dans une variable temporaire
    if res <= estimation.laine then      //check si le bot aura assez de laine
      begin
        estimation.laine := estimation.laine - res;
        estimation.tissu := getAtelierBot1() * 10 - besoin.tissu;
      end;
    //on utilise estimation.laine pour la même raison que pour les colons et l'or
  end;

procedure initialisationEstimation()
  var
    res : Integer;
  begin
    planification();

    estimation.attaque := false;
    estimation.bateaux:= 0;
  end;

procedure tourBot1();
  var
    res : Integer;
  begin
    //Conso de poissons
    if estimation.fish>0 then
      begin
        setFish(estimation);
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
  end;

end.

