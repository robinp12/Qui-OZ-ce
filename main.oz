functor
import
   ProjectLib
   Browser
   OS
   System
   Application
   List
define
   CWD = {Atom.toString {OS.getCWD}}#"/"
   Browse = proc {$ Buf} {Browser.browse Buf} end
   Print = proc{$ S} {System.print S} end
   Args = {Application.getArgs record('nogui'(single type:bool default:false optional:true)
									  'db'(single type:string default:CWD#"database.txt"))} 
   TestDBTest
   Res
   Database
   QuestionCounterAcc
in 
   local
	  NoGUI = Args.'nogui'
	  DB = Args.'db'
     ListOfCharacters = {ProjectLib.loadDatabase file Args.'db'}
     NewCharacter = {ProjectLib.loadCharacter file CWD#"new_character.txt"}
	  % Vous devez modifier le code pour que cette variable soit
	  % assigné un argument 	
     ListOfAnswersFile = CWD#"test_answers.txt"
     ListOfAnswers = {ProjectLib.loadCharacter file CWD#"test_answers.txt"}

      A={NewCell 0}
      B={NewCell 0}
      C={NewCell 0}
      D={NewCell 0}
      E={NewCell 0}
      F={NewCell 0}
      G={NewCell 0}
      H={NewCell 0}

     fun {TreeBuilder Database}
       leaf(nil)
     end

      /* Longueur du tuple */
      fun { Length L }
         fun { Length2 L N }
            case L of H | T then { Length2 T N +1}
            [] nil then N
         end
      end
      in
         { Length2 L 0}
      end
   
      fun {GameDriver Tree}
         Result = 0
      in
         % Toujours renvoyer unit  
         unit
      end
   in

   local L L2 R1 Acc J2 in
      fun {Database Di}
         fun {Acc X}
            case X of nil then nil
            [] H|T then {Browse H} {Acc T}
            end
         end

         for X in ListOfCharacters do
               /* Renvoi toutes les question dans le L*/
               {Record.arity X L}

               /* Partie de droite sans le nom */
               L2 = L.2
               for Y in L2 do
                  H := {Dictionary.get Di Y} + 1
               /*{Dictionary.put Di Y @A}*/
               end

               
               /*{Browse {Acc {Record.toList X}}}*/
               /* Renvoi toutes les reponses */
               for Y in {Record.toList X} do
                  {Browse Y}
                  /*Compte les vrais de TOUTES les questions */
/* Reste plus qu'a compter les vrais/faux independement par question*/
                  if Y == true then A:=@A+1
                  end
               end
            end
         A:= @A - ({Length ListOfCharacters} - @A)
         B:= @B - ({Length ListOfCharacters} - @B)
         C:= @C - ({Length ListOfCharacters} - @C)
         D:= @D - ({Length ListOfCharacters} - @D)
      Res = result(1:@A 2:@B 3:@C 4:@D)
      end
   end
      %%             1
      %%            / \
      %%           2   2
      %%          / \ / \
      %%         3  3 3  3
      %%        / \ /
      %%       4  4 4

       
   local ListFullRecord ListQuestionRecord Di List T W L R in

      {Arity ListOfCharacters.1 ListFullRecord }

      {Dictionary.new Di}
      /*On remplit le dictionnaire des questions de la db */      
      for X in ListFullRecord.2 do
         {Dictionary.put Di X 0}
      end
      /*pour chaque question, on veut compter le nombre de true/false total */
      
     {Browse {Database Di}}

   end
   
   {ProjectLib.play opts(characters:ListOfCharacters driver:GameDriver 
                           noGUI:false builder:TreeBuilder 
                           autoPlay:ListOfAnswers newCharacter:NewCharacter)}
   {Application.exit 0}
   end
end