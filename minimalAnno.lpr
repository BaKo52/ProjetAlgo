program minimalAnno;
{$CODEPAGE UTF8}
uses unitAnno,GestionEcran;

type
  ressource = (poisson,bois,outil,laine,tissu);
  valeurRessource = Array [ressource] of Integer;

var
  x,y,z:Integer; //x : coordonnée x du texte
                 //y : coordonnée y du texte
                 //z : variable contenant le menu choisi par l'utilisateur
  texte:String;  //variable contenant le texte à écrire sur l'affichage

  nom:String;    //variable contenant le nom du joueur

  valRess:valeurRessource;

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
    x:=100;
    y:=55;
    ecrireTexte(x,y,texte);

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

    valRess[poisson]:= 10; //Remplisage du tableau
    valRess[bois]:= 10;
    valRess[outil]:= 10;
    valRess[laine]:= 10;
    valRess[tissu]:= 0;

    while(true) do
       begin
          ile(valRess);
          readln(z);
       end;

end.

