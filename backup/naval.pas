unit naval;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

implementation

  procedure naval();
    var
      texte:String;
      z:Integer;
      ARRET:Boolean;
    begin
      if getNaval=true then
        begin
             ARRET:=false;

             while not(ARRET) do
               begin
                 effacerEcran();

                 ile();

                 texte:='1. Construire un navire : -500 or, - 50 bois et -20 outils';
                 ecrireTexteCentre(10, 30, texte);

                 texte:='2. Retour au menu précédent';
                 ecrireTexteCentre(10, 32, texte);

                 ecrireTexteCentre(10,34,'Que voulez-vous faire ? ');

                 readln(z);

                 case z of
                 1:
                   begin
                     if ((getGold>499) AND (getBois>49) AND (getOutil>19)) then
                        begin
                           setBateau(getBateau+1);
                           setGold(getGold-500);
                           setBois(getBois-50);
                           setOutil(getOutil-20);
                        end
                     else
                         begin
                           texte:='Vous n''avez pas les ressources pour construire un navire';
                           ecrireTexte(10, 35, texte);
                           readln();
                         end;
                   end;
                 2:ARRET:=true;
                 end;
               end;
             end
             else
                 begin
                   texte:='Vous n''avez pas construit de chantier naval';
                   ecrireTexte(10, 35, texte);
                   readln();
                 end;
    end;

  procedure AffAttaque();
    var
      texte:String;
    begin
      dessinerCadreXY(95,1,104,3,double,white,black);
      texte:='Attaque de pirates';
      ecrireTexteCentre(100,2,texte);

      dessinerCadreXY(149,24,173,31,simple,white,black);
      texte:='Nombre de soldats :';
      ecrireTexte(150,25,texte);
      write(getSoldat);
      texte:='Nombre de pirates : ';
      ecrireTexte(150,26,texte);
      write('Inconnu');
    end;

  procedure combat();
  var
    z,temp:Integer;
    texte:String;
    ARRET:Boolean;
  begin
    ARRET := FALSE;
    Randomize;

   while (not(ARRET)) do
     begin
       effacerEcran();
       affAttaque();

       texte:='1. Partir au combat sur le rivage';
       ecrireTexteCentre(100,50,texte);
       texte:='2. Tendre un piège aux envahisseurs';
       ecrireTexteCentre(100,51,texte);
       texte:='3. Construire des défenses pour résister à l''attaque';
       ecrireTexteCentre(100,52,texte);

       texte:='Que voulez-vous faire: ';
       ecrireTexteCentre(100,57,texte);

       readln(z);

       case z of
       1:
         begin
           texte:='Vos hommes partent défendre votre colonie... ';
           ecrireTexteCentre(100,58,texte);
           if (getSoldat>0) then
              begin
                 temp:= random(10)+1;
                 if (getSoldat()-temp>=0) then
                    begin
                       setSoldat(getSoldat-temp);
                       write('Vous avez repoussé l''invasion !');
                       writeln('Vous avez perdu',temp,' Soldats. Il vous reste',getSoldat(),' soldats.');
                       ARRET := TRUE;
                    end
                 else
                   begin
                     setBois(getBois()-20); //Ajout des conditions de checks
                     setfish(getFish()-15);
                     setTissu(getTissu()-20);
                     write('Vos soldats ont tous péri durant cette attaque... Vous avez perdu 20 unités de bois, 15 unités de poissons et 20 unités tissus');
                     ARRET := TRUE;
                   end;
              end
           else
             begin
               setBois(getBois()-20); //Ajout des tests
               setfish(getFish()-15);
               setTissu(getTissu()-20);
               write('Vos soldats n''ont pas été assez nombreux pour défendre cette attaque... Vous avez perdu 20 uités de bois, 15 unités de poissons et 20 unités tissus');
               ARRET := TRUE;
             end;
         end;
       2:
         begin
           texte:='Vos hommes se préparent à tendre un piège... ';
           ecrireTexteCentre(100,58,texte);
           if (getSoldat>0) then
              begin
                 temp:= random(5)+1;
                 if (getSoldat()-temp>=0) then
                    begin
                       setBois(getBois()-15);
                       setFish(getFish()-5);
                       setTissu(getTissu()-10);
                       write('Vous avez repoussé l''invahsion mais vous avez perdu quelques ressources !');
                       writeln('Vous avez perdu',temp,' Soldats. Il vous reste',getSoldat(),' soldats.');
                       ARRET := TRUE;
                    end
                 else
                   begin
                     setBois(getBois()-50);
                     setfish(getFish()-30);
                     setTissu(getTissu()-50);
                     write('Vos soldats ont tous péri durant cette attaque... Vous avez perdu 50 uités de bois, 30 unités de poissons et 50 unités tissus');
                     ARRET := TRUE;
                   end;
              end
           else
             begin
               setBois(getBois()-20);
               setfish(getFish()-15);
               setTissu(getTissu()-20);
               write('Vos soldats n''ont pas été assez nombreux pour défendre cette attaque... Vous avez perdu 20 uités de bois, 15 unités de poissons et 20 unités tissus');
               ARRET := TRUE;
             end;
         end;
       3:
         begin
           texte:='Vos hommes se préparent à défendre la colonie... ';
           ecrireTexteCentre(100,58,texte);
           if (getSoldat>0) then
              begin
                 temp:= random(3)+1;
                 if (getSoldat()-temp>=0) then
                    begin
                       setBois(getBois()-40);
                       setFish(getFish()-10);
                       setTissu(getTissu()-20);
                       write('Vous avez repoussé l''invahsion !');
                       writeln('Vous avez perdu',temp,' Soldats. Il vous reste',getSoldat(),' soldats.');
                       ARRET := TRUE;
                    end
                 else
                   begin
                     setBois(getBois()-60);
                     setfish(getFish()-30);
                     setTissu(getTissu()-50);
                     write('Vos soldats ont tous péri durant cette attaque... Vous avez perdu 50 uités de bois, 30 unités de poissons et 50 unités tissus');
                     ARRET := TRUE;
                   end;
              end
           else
             begin
               setBois(getBois()-60);
               setfish(getFish()-30);
               setTissu(getTissu()-50);
               write('Vos soldats n''ont pas été assez nombreux pour défendre cette attaque... Vous avez perdu 60 uités de bois, 30 unités de poissons et 50 unités tissus');
               ARRET := TRUE;
             end;
         end;
     end;
       ARRET := TRUE;
   end;
   end;

end.

