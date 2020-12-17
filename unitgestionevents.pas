unit unitGestionEvents;

{$mode objfpc}{$H+}

interface
uses unitVar,GestionEcran;

procedure gestionEvents(nbRound:Integer);
procedure initialisationEvents();


implementation
var
numEvent:Integer;  
finEvent:Integer;
finEventx:Boolean;

procedure initialisationEvents();
   begin

     finEvent:=0;
     finEventx:=false;

   end;


   //finEvent
   procedure setFinEvent(val:Integer);
   begin
     finEvent:=val;
   end;

   function getFinEvent : Integer;
   begin
     getFinEvent:=finEvent;
   end;


   procedure setFinEventx(val:Boolean);
   begin
     finEventx:=val;
   end;

   function getFinEventx : Boolean;
   begin
     getFinEventx:=finEventx;
   end;


procedure gestionEvents(nbRound:Integer);
var
  texte:String;
  destroyMaison:Integer;
  destroyAtelier:Integer;
  killEvent3_Colons:Integer;


  begin
  randomize;


  // début de l'event et présentation de ce dernier

  if (nbRound mod 13 = 0) then
     begin
        if (getFinEventx()=false) then
           begin
              setFinEventx(true);
              numEvent:=random(2)+1;

              // 1 : Incendie
              // 2 : Maladie
              // 3 : Indiens qui viennent tuer des colons et des soldats
              // 4 : Les productions sont augmentées (un festin contre x ressources ?)
              if( numEvent=1 ) then
                 begin
                  setFinEvent(nbRound+3);
                  EffacerEcran();
                  texte:='Un incendie a été déclaré dans une maison.';
                  ecrireTexteCentre(100,10,texte);
                 end
              else if( numEvent=2 ) then
                 begin
                  setFinEvent(nbRound+5);
                  EffacerEcran();
                  texte:='Deux de vos colons sont morts pour une raison non expliquée.';
                  ecrireTexteCentre(100,10,texte);
                 end
              else if( numEvent=3 ) then
                 begin
                  setFinEvent(nbRound+5);
                  EffacerEcran();
                  texte:='Deux de vos colons sont morts pour une raison non expliquée.';
                  ecrireTexteCentre(100,10,texte);
                 end


           end;
     end;



  // Déroulement de l'event
  if((getFinEvent()-nbRound)>0) then
     begin

      //************************************ Event 1 ***************************

        if( numEvent=1 ) then
           begin
             if(nbRound=getFinEvent()-3) then
                begin
                  texte:='Une maison a été détruite, les habitants mourront vite si rien n''est fait.';
                  ecrireTexteCentre(100,30,texte);
                  setMaison(getMaison()-1);
                  readln;
                end
             else if(nbRound=getFinEvent()-2) then
                begin
                   EffacerEcran();
                   destroyMaison:=random(3);
                   destroyAtelier:=random(2);
                   texte:='L''incendie continue sa route et emporte des choses avec lui . . .';
                   ecrireTexteCentre(100,10,texte);
                   if(destroyMaison<>0) then
                      begin
                       texte:='Une/des maison(s) a/ont été détruite(s) : - ';
                       ecrireTexteCentre(95,30,texte);
                       setMaison(getMaison()-destroyMaison);
                       write(destroyMaison, ' maison(s)');
                      end
                   else if ((destroyAtelier<>0) AND (getAtelier()<>0)) then
                      begin
                       texte:='Un/des atelier(s) a/ont été détruit(s) : - ';
                       ecrireTexteCentre(95,31,texte);
                       setAtelier(getAtelier()-destroyAtelier);
                       write(destroyAtelier, ' atelier(s)');
                      end
                   else
                       begin
                       EffacerEcran();
                       texte:='Vous êtes chanceux aujourd''hui, l''incendie n''a rien emporté avec lui.';
                       ecrireTexteCentre(100,10,texte);
                       end;

                   readln;
                end
             else if(nbRound=getFinEvent()-1) then
                begin
                   EffacerEcran();
                   destroyMaison:=random(2);
                   destroyAtelier:=random(2);
                   texte:='L''incendie continue sa route et emporte des choses avec lui . . .';
                   ecrireTexteCentre(100,10,texte);
                   if(destroyMaison<>0) then
                      begin
                       texte:='Une/des maison(s) a/ont été détruite(s) : - ';
                       ecrireTexteCentre(95,30,texte);
                       setMaison(getMaison()-destroyMaison);
                       write(destroyMaison, ' maison(s)');
                      end
                   else if ((destroyAtelier<>0) AND (getAtelier()<>0)) then
                      begin
                       texte:='Un/des atelier(s) a/ont été détruit(s) : - ';
                       ecrireTexteCentre(95,31,texte);
                       setAtelier(getAtelier()-destroyAtelier);
                       write(destroyAtelier, ' atelier(s)');
                      end
                   else
                       begin
                       EffacerEcran();
                       texte:='Vous êtes chanceux aujourd''hui, l''incendie n''a rien emporté avec lui.';
                       ecrireTexteCentre(100,10,texte);
                       end;

                   // Vérification que les valeurs de maisons/ateliers détruits ne soient pas en dessous de 0
                   // auquel cas, on les passe à 0
                   if(getMaison()<0) then
                      setMaison(0);
                   if(getAtelier()<0) then
                      setAtelier(0);
                   readln;
                end
            end

      //************************************ Event 2 ***************************

        else if( numEvent=2 ) then
           begin
             if(nbRound=getFinEvent()-5) then
                begin
                  texte:='Quelque chose d''anormal se passe...';
                  ecrireTexteCentre(100,30,texte);
                  setColon(getColon()-2);
                  readln;
                end
             else if(nbRound=getFinEvent()-4) then
                begin
                   EffacerEcran();
                   texte:='De nouveaux Colons se retrouvés morts.';
                   ecrireTexteCentre(100,10,texte);
                   texte:='Les Colons restants prennent peur.';
                   ecrireTexteCentre(100,11,texte);
                   setColon(getColon()-(round(getColon()/4)));
                   readln;
                end
             else if(nbRound=getFinEvent()-3) then
                begin
                   EffacerEcran();
                   texte:='De nouveaux Colons se retrouvés morts.';
                   texte:='Les Colons restants sont méfiants.';
                   ecrireTexteCentre(100,11,texte);
                   ecrireTexteCentre(100,10,texte);
                   setColon(getColon()-(round(getColon()/4)+3));

                   readln;
                end
             else if(nbRound=getFinEvent()-2) then
                begin
                   EffacerEcran();
                   texte:='De nouveaux Colons se retrouvés morts.';
                   ecrireTexteCentre(100,10,texte);
                   texte:='Le nombre de morts par jour baisse. Les Colons gardent espoir.';
                   ecrireTexteCentre(100,11,texte);
                   setColon(getColon()-(round(getColon()/4)+2));

                   readln;
                end
             else if(nbRound=getFinEvent()-1) then
                begin
                   EffacerEcran();
                   texte:='De nouveaux Colons se retrouvés morts.';
                   ecrireTexteCentre(100,10,texte);
                   setColon(getColon()-(round(getColon()/4)+1));

                   readln;
                end
           end

      //************************************ Event 3 ***************************

        else if( numEvent=3 ) then // EN DEV - NON FAIT
           begin
             if(nbRound=getFinEvent()-2) then
                begin
                  texte:='Une maison a été détruite, les habitants mourront vite si rien n''est fait.';
                  ecrireTexteCentre(100,30,texte);
                  setMaison(getMaison()-1);
                  readln;
                end
             else if(nbRound=getFinEvent()-1) then
                begin
                   EffacerEcran();
                   destroyMaison:=random(3);
                   destroyAtelier:=random(2);
                   texte:='L''incendie continue sa route et emporte des choses avec lui . . .';
                   ecrireTexteCentre(100,10,texte);
                   if(destroyMaison<>0) then
                      begin
                       texte:='Une/des maison(s) a/ont été détruite(s) : - ';
                       ecrireTexteCentre(95,30,texte);
                       setMaison(getMaison()-destroyMaison);
                       write(destroyMaison, ' maison(s)');
                      end
                   else if ((destroyAtelier<>0) AND (getAtelier()<>0)) then
                      begin
                       texte:='Un/des atelier(s) a/ont été détruit(s) : - ';
                       ecrireTexteCentre(95,31,texte);
                       setAtelier(getAtelier()-destroyAtelier);
                       write(destroyAtelier, ' atelier(s)');
                      end
                   else
                       begin
                       EffacerEcran();
                       texte:='Vous êtes chanceux aujourd''hui, l''incendie n''a rien emporté avec lui.';
                       ecrireTexteCentre(100,10,texte);
                       end;

                   readln;
                end;
            end;



     end
  else if (getFinEventx()=true) then
    begin
        setfinEventx(false);
        setFinEvent(0);

        if( numEvent=1 ) then
           begin
            EffacerEcran();
            texte:='L''incendie est fini, il est temps de souffler un peu.';
            ecrireTexteCentre(100,10,texte);
            readln;
           end
        else if( numEvent=2 ) then
           begin
            EffacerEcran();
            texte:='Plus aucun mort n''est à déclarer par jour.';
            ecrireTexteCentre(100,10,texte);
            texte:='Les Colons restant continueront de se méfier pendant quelque temps.';
            ecrireTexteCentre(100,11,texte);
            readln;
           end
    end;






end;

end.

