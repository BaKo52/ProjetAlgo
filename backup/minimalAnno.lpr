program minimalAnno;
{$CODEPAGE UTF8}
uses unitAnno,GestionEcran,SysUtils,unitvar;



var
  z:Integer;     //z : variable contenant le menu choisi par l'utilisateur
  texte:String;  //variable contenant le texte à écrire sur l'affichage

  nom:String;    //variable contenant le nom du joueur


begin

    menuPrincipal();

    readln(z); //lecture de z

    if z=1      //passage vers la présentation du jeu
     then
         begin
               effacerEcran();
               presentation(); //charge le menu de présentation
         end
     else
         begin
               halt(); //ferme le programme
         end;

    texte:='Alors on y va? ';
    ecrireTexteCentre(100,55,texte);

    readln(z);

    if z=1      //passage vers création de la partie
     then
         begin
               create();  // charge le menu de création du personnage
               readln(nom); // lit la variable du nom du joueur
         end
     else
         begin
               halt();
         end;

    initialisation

    while(true) do
       begin
          ile(nom);
          readln(z);
       end;

end.
