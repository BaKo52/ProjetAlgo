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

implementation

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

procedure tourBot1();
  begin
    if not(getEtatBot1()) then
      begin

        if (getCabaneBBot1 = 0) then
          begin

          end;


      end;
  end;

end.

