unit unitFinTour;

{$mode objfpc}{$H+}
{$CODEPAGE UTF8}

interface
  uses Classes, SysUtils, unitVar, unitNaval, unitAnno, gestionEcran, unitGestionEvents, unitBot1;

  //gestion des tour
  procedure nextRound();

  //procédure gérant la production des ressources en fonction des batiments
  procedure production ();

implementation

procedure production ();
  var
    res: Integer;
  begin
    //Production de poissons
    setFish(getFish()+(getCabaneP()*4)); //Une cabane de pêcheur produit 4 poissons

    //Production de bois
    setBois(getBois()+(getCabaneB()*5)); //Une cabane de bucheron produit 5 bois

    //Production de tissu
    res:= getAtelier()*5;       //met le nombre de laine requit pour créer le tissu dans une variable temporaire
    if res<getLaine() then      //check si le joueur à assez de laine
      begin
        setLaine(getLaine()-res);             //soustrait la laine pour créer du tissu à la laine du bot
        setTissu(getTissu()+(getAtelier*10)); //Un atelier produit 10 tissu pour 5 laines
      end;

    //Production de Laine
    setLaine(getLaine()+(getBergerie*15)); //Une bergerie produit 5 laines

    //Nouveau colons
    setColon(getColon()+round(getColon()/5)); //donne 20% de la population en colon supplémentaire par tour
    if(getColon()>(getMaison()*4)) then
       setColon(getMaison()*4);
  end;

procedure nextRound();
  var
    texte:String;
    res: Integer;
  begin
    EffacerEcran();
    setNbRound(getNbRound()+1);
    res:= getColon() div 2;

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
    write(getNbRound()-1);

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
        if (GetNbRound() mod 3 = 0) then
           begin
             marchand(); //Marchand
           end;
        if (GetNbRound() mod 8 = 0)then
          begin
            attaque(); //attaque sur la colonie
          end;

        effacerEcran();
        productionBot1();
        affichageRessourceBot1();

        ile();
        gestionEvents(getNbRound());
      end;
  end;

end.

