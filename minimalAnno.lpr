program minimalAnno;
{$CODEPAGE UTF8}
uses unitAnno, GestionEcran, SysUtils, unitvar, saveLoad, unitNaval,
  unitFinTour, unitGestionEvents;


var
  z:Integer;     //z : variable contenant le menu choisi par l'utilisateur

  ARRET: Boolean; //Variable d'arrêt

  loaded : Boolean; //variable servant à savoir si l'utilisateur a chargé une sauvegarde
begin
    loaded := false;

    //Lancement du menu principal
    menuPrincipal();

    readln(z); //lecture de z

    ARRET := false;

    //Choix menu Principal
    while not(ARRET) do
      begin
        case z of //passage vers la présentation du jeu
        1:
          begin
            presentation();
            ARRET := true;
          end;                   //charge le menu de présentation
        2:
          begin
            ecrireTexteCentre(100,53,'Choisissez l''emplacement de sauvegarde à charger (1,2 ou 3): ');
            readln(z);
            case z of
            1,2,3:
              begin
                load(z);
                loaded := true;
                ARRET := true;
              end
            else
              begin
                ecrireTexteCentre(100,54,'Mauvaise entrée');
                readln();
              end;
            end;
          end;
        3:halt();                //ferme le programme
        else
          begin
            effacerEcran;
            menuPrincipal;
            readln(z);
          end;
        end;
      end;

    if not(loaded) then      // check si le jouer a chargé une sauvegarde ou non
      begin
        ARRET:=false;

        readln(z);

        while not(ARRET) do
          begin
            case z of
            1:
              begin
                create();
                ARRET:=true;
              end;         // charge le menu de création du personnage
            2:halt();      //quitte la partie
            else
              begin
                presentation();
                readln(z);
              end;
            end;
          end;
      end;

    ARRET:=false;

    //Menu de la partie
    while(not(ARRET)) do
      begin
        choixMenu();
        readln(z);
        case z of
        1:nextRound(); //passer le tour
        2:batiment();  //menu de construction
        3:naval(); //menu du chantier naval
        4:
          begin
            ecrireTexte(10,35,'Quel emplacement de sauvegarde utiliser ? 1,2 ou 3 ? ');
            readln(z);
            case z of
              1,2,3: save(z);
              else
                begin
                  ecrireTexte(10,36,'Mauvaise entrée');
                  readln();
                end;
            end;

            ARRET:=TRUE; //quitte le programme
          end;

        end;
      end;

end.
