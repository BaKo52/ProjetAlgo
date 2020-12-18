unit unitBot1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, unitVarBot1, gestionEcran;

implementation

procedure affichageRessourceBot1();
  begin
    couleurs(black, white);
    ecrireTexteCentre(100, 2, 'Ressources de ');
    writeln(getNomBot1());

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
    res:= getAtelierBot1()*5;
    if res<getLaineBot1() then
      begin
        setLaineBot1(getLaineBot1()-res);
        setTissuBot1(getTissuBot1()+(getAtelierBot1*10)); //Un atelier produit 10 tissu pour 5 laines
      end;

    //Production de Laine
    setLaineBot1(getLaineBot1()+(getBergerieBot1*15)); //Une bergerie produit 5 laines

    //Nouveau colons
    setColonBot1(getColonBot1()+round(getColonBot1()/5)); //donne 20% de la population en colon supplémentaire par tour
    if(getColonBot1()>(getMaisonBot1()*4)) then
       setColonBot1(getMaisonBot1()*4);
  end;

end.

