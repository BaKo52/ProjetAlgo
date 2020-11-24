program minimalAnno;
{$CODEPAGE UTF8}
uses unitAnno,GestionEcran,SysUtils,unitvar;



var
  z:Integer;     //z : variable contenant le menu choisi par l'utilisateur
  texte:String;  //variable contenant le texte à écrire sur l'affichage

begin

    menuPrincipal();

    readln(z); //lecture de z

    if z=1 then //passage vers la présentation du jeu
         begin
               presentation(); //charge le menu de présentation
         end
     else
         begin
               halt(); //ferme le programme
         end;

    texte:='Alors on y va? ';
    ecrireTexteCentre(100,55,texte);

    readln(z);

    if z=1 then      //passage vers création de la partie
         begin
               create();  // charge le menu de création du personnage
         end
     else
         begin
               halt();
         end;

    initialisation();

    while(true) do
       begin
          choixMenu();
          readln(z);
          case z of
          1:halt(); //passer le tour
          2:batiment(); //menu de construction
          3:halt(); //quitte le programme
          end;
          readln();

          //sous programme de fin de tour avec taxe et check des conditions des colons et marchand
       end;

end.
