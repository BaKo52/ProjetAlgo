program minimalAnno;
{$CODEPAGE UTF8}
uses unitAnno,GestionEcran,SysUtils,unitvar;



var
  z:Integer;     //z : variable contenant le menu choisi par l'utilisateur
  texte:String;  //variable contenant le texte à écrire sur l'affichage

  ARRET: Boolean; //Variable d'arrêt
begin

    //Lancement du menu principal
    menuPrincipal();

    readln(z); //lecture de z

    //Choix menu Principal
    case z of //passage vers la présentation du jeu
    1:presentation(); //charge le menu de présentation
    2:halt();//ferme le programme
    end;

    //Choix menu De présentation
    texte:='Alors on y va? ';
    ecrireTexteCentre(100,55,texte);

    readln(z);
    case z of
    1:create();  // charge le menu de création du personnage
    2:halt(); //quite la partie
    end;

    initialisation(); //Initialisation des ressources

    ARRET:=FALSE;

    //Menu de la partie
    while(not(ARRET)) do
          begin
            choixMenu();
            readln(z);
            case z of
            1:nextRound(); //passer le tour
            2:batiment(); //menu de construction
            3:ARRET:=TRUE; //quitte le programme
            end;
          end;

          //sous programme de fin de tour avec taxe et check des conditions des colons et marchand

end.
