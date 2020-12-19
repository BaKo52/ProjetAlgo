unit saveLoad;

{$mode objfpc}{$H+}

interface
  uses unitVar, Classes, SysUtils, unitNaval, unitVarBot1;

  procedure save(emplacement : Integer);

  procedure load(emplacement : Integer);


implementation

  procedure save(emplacement : Integer);
  var
    fichier : text;  //variable contenant le nom physique du fichier
  begin

    case emplacement of   // assignation du nom physique au nom logique en fonction de l'emplacement de sauvegarde choisi
      1:assign(fichier, 'savefile/save1.txt');
      2:assign(fichier, 'savefile/save2.txt');
      3:assign(fichier, 'savefile/save3.txt');
    end;

    rewrite(fichier);     //ouverture du fichier en mode écriture (RAZ)

    //écriture de toute les variables du joueur dans le fichier
    writeln(fichier, getNom());
    writeln(fichier, getFish());
    writeln(fichier, getBois());
    writeln(fichier, getOutil());
    writeln(fichier, getLaine());
    writeln(fichier, getTissu());
    writeln(fichier, getGold());
    writeln(fichier, getColon());
    writeln(fichier, getMaison());
    writeln(fichier, getCabaneP());
    writeln(fichier, getCabaneB());
    writeln(fichier, getBergerie());
    writeln(fichier, getAtelier());
    writeln(fichier, getChapelle());
    writeln(fichier, getCentreVille());
    writeln(fichier, getNaval());
    writeln(fichier, getSoldat());
    writeln(fichier, getBateaux());

    //écriture de toutes les variables du bot 1 dans le fichier
    writeln(fichier, getNomBot1());
    writeln(fichier, getFishBot1());
    writeln(fichier, getBoisbot1());
    writeln(fichier, getOutilBot1());
    writeln(fichier, getLaineBot1());
    writeln(fichier, getTissuBot1());
    writeln(fichier, getGoldBot1());
    writeln(fichier, getColonBot1());
    writeln(fichier, getMaisonBot1());
    writeln(fichier, getCabanePBot1());
    writeln(fichier, getCabaneBBot1());
    writeln(fichier, getBergerieBot1());
    writeln(fichier, getAtelierBot1());
    writeln(fichier, getChapelleBot1());
    writeln(fichier, getCentreVilleBot1());
    writeln(fichier, getNavalBot1());
    writeln(fichier, getSoldatBot1());
    writeln(fichier, getBateauBot1());

    close(fichier);

  end;

  procedure load(emplacement : Integer);
  var
    //varaible du nomLogique du fichier
    fichier : text;
    // variable temporaire afin de lire le contenu du fichier et d'ensuite l'attribuer à une variable du jeu
    temp : Integer;
    res : Integer;
    // variable recevant la variable booléenne pour chapelle et centreVille (on utilisera des ifs car readln(fichier, variable) ne prend pas en compte les booléens
    texte : String;
  begin
    case emplacement of   // assignation du nom physique^au nom logique en fonction de l'emplacement de sauvegarde choisi
      1:assign(fichier, 'savefile/save1.txt');
      2:assign(fichier, 'savefile/save2.txt');
      3:assign(fichier, 'savefile/save3.txt');
    end;

    reset(fichier);  // ouverture du fichier en  mode lecture


    readln(fichier, texte);
    setNom(texte);

    readln(fichier,temp); // ouverture du fichier et lecture de la variable
    setFish(temp);            // attribution de la variable lue à une des variables du jeu

    readln(fichier,temp);
    setBois(temp);

    readln(fichier,temp);
    setOutil(temp);

    readln(fichier,temp);
    setLaine(temp);

    readln(fichier,temp);
    setTissu(temp);

    readln(fichier,temp);
    setGold(temp);

    readln(fichier,temp);
    setColon(temp);

    readln(fichier,temp);
    setMaison(temp);

    readln(fichier,temp);
    setCabaneP(temp);

    readln(fichier,temp);
    setCabaneB(temp);

    readln(fichier,temp);
    setBergerie(temp);

    readln(fichier,temp);
    setAtelier(temp);

    readln(fichier,texte);
    if(texte = 'FALSE')
    then setChapelle(false)
    else setChapelle(true);

    readln(fichier,texte);
    if(texte = 'FALSE')
    then setCentreVille(false)
    else setCentreVille(true);

    readln(fichier,texte);
    if(texte = 'FALSE')
    then setNaval(false)
    else setNaval(true);

    readln(fichier,temp);
    setSoldat(temp);

    readln(fichier,res);

    //on fait pareil mais avec les variables du bot 1
    readln(fichier, texte);
    setNomBot1(texte);

    readln(fichier,temp);
    setFishBot1(temp);

    readln(fichier,temp);
    setBoisBot1(temp);

    readln(fichier,temp);
    setOutilBot1(temp);

    readln(fichier,temp);
    setLaineBot1(temp);

    readln(fichier,temp);
    setTissuBot1(temp);

    readln(fichier,temp);
    setGoldBot1(temp);

    readln(fichier,temp);
    setColonBot1(temp);

    readln(fichier,temp);
    setMaisonBot1(temp);

    readln(fichier,temp);
    setCabanePBot1(temp);

    readln(fichier,temp);
    setCabaneBBot1(temp);

    readln(fichier,temp);
    setBergerieBot1(temp);

    readln(fichier,temp);
    setAtelierBot1(temp);

    readln(fichier,texte);
    if(texte = 'FALSE')
    then setChapelleBot1(false)
    else setChapelleBot1(true);

    readln(fichier,texte);
    if(texte = 'FALSE')
    then setCentreVilleBot1(false)
    else setCentreVilleBot1(true);

    readln(fichier,texte);
    if(texte = 'FALSE')
    then setNavalBot1(false)
    else setNavalBot1(true);

    readln(fichier,temp);
    setSoldatBot1(temp);

    readln(fichier,temp);
    setBateauBot1(temp);

    close(fichier);

    attributionNomLoad(res);
  end;

end.

