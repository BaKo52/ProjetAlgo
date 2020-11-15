program minimalAnno;
{$CODEPAGE UTF8}
uses unitAnno,GestionEcran,SysUtils;



var
  z:Integer;     //z : variable contenant le menu choisi par l'utilisateur
  texte:String;  //variable contenant le texte à écrire sur l'affichage

  nom:String;    //variable contenant le nom du joueur

  valRess:valeurRessource;
  nbBati:batiment;
  chapelleCentre:batimentSocial;

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

    valRess[poisson]:= 10; //Remplisage des différents tableaux
    valRess[bois]:= 10;
    valRess[outil]:= 10;
    valRess[laine]:= 10;
    valRess[tissu]:= 0;
    valRess[argent]:= 500;
    valRess[colon]:= 20;

    nbBati[maison]:= 0;
    nbBati[cabaneP]:= 0;
    nbBati[cabaneB]:= 0;
    nbBati[bergerie]:= 0;
    nbBati[tisserand]:= 0;

    chapelleCentre[chapelle]:= false;
    chapelleCentre[centreVille]:= false;

    while(true) do
       begin
          ile(valRess,nbBati,chapelleCentre,nom);
          readln(z);
       end;

end.
