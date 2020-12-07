unit saveLoad;

{$mode objfpc}{$H+}

interface
  uses unitVar, Classes, SysUtils;

  procedure save(emplacement : Integer);

  procedure load(emplacement : Integer);


implementation

  procedure save(emplacement : Integer);
  var
    fichier : text;  //variable contenant le nom physique du fichier
  begin

    case emplacement of   // assignation du nom physique^au nom logique en fonction de l'emplacement de sauvegarde choisi
      1:assign(fichier, 'savefile/save1.txt');
      2:assign(fichier, 'savefile/save2.txt');
      3:assign(fichier, 'savefile/save3.txt');
    end;

    rewrite(fichier);     //ouverture du fichier en mode écriture (RAZ)

    //écriture de toute les variables dans le fichier
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

    close(fichier)

  end;

  procedure load(emplacement : Integer);
  var
    //varaible du nomLogique du fichier
    fichier : text;
    // variable temporaire afin de lire le contenu du fichier et d'ensuite l'attribuer à une variable du jeu
    temp : Integer;
    // variable recevant la variable booléenne pour chapelle et centreVille (on utilisera des ifs car readln(fichier, variable) ne prend pas en compte les booléens
    texte : String;
  begin
    case emplacement of   // assignation du nom physique^au nom logique en fonction de l'emplacement de sauvegarde choisi
      1:assign(fichier, 'savefile/save1.txt');
      2:assign(fichier, 'savefile/save2.txt');
      3:assign(fichier, 'savefile/save3.txt');
    end;

    reset(fichier);  // ouverture du fichier en  mode lecture


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
    then setChapelle(false);
    else setChapelle(true);

    readln(fichier,texte);
    if(texte = 'FALSE')
    then setCentreVille(false);
    else setCentreVille(true);

  end;

end.

