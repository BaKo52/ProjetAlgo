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

    ARRET := true;

    //Choix menu Principal
    while ARRET=true do begin
      case z of //passage vers la présentation du jeu
      1:
        begin
          presentation();
          ARRET := false;
        end;                   //charge le menu de présentation
      2:halt();                //ferme le programme
      else
        effacerEcran;
        menuPrincipal;
        readln(z);
      end;
    end;

    //Choix menu De présentation
    texte:='Alors on y va? ';
    ecrireTexteCentre(100,55,texte);

    readln(z);

    ARRET:=true;

    while ARRET=true do begin
      case z of
      1:
        begin
          create();
          ARRET:=false;
        end;         // charge le menu de création du personnage
      2:halt();      //quitte la partie
      else
        begin
          presentation();
          texte:='Alors on y va? ';
          ecrireTexteCentre(100,55,texte);
          readln(z);
        end;
      end;
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

end.
