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

     fun {TreeBuilder Database}
       leaf(nil)
     end

      /* Premier element d'un tuple */
      fun { Head L }
         case L of H | T then H
         [] nil then nil
         end
      end

      /* Restant des elements du tuple */
      fun { Tail L }
         case L of H | T then T
         [] nil then nil
         end
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
      
      fun { SumAux N Acc }
         if N == 1 then Acc + 1
         else { SumAux N -1 N * N + Acc } end
      end
      fun { Sum N }
         { SumAux N 0}
      end

      fun {GameDriver Tree}
         Result = 0
      in
      
         for X in ListOfCharacters do
            if X.'Est-ce que c\'est une fille ?' then {Browse {Sum 2}}
            else {Browse "faux"}
            end
         end
         % Toujours renvoyer unit
         unit
      end
   in
      {ProjectLib.play opts(characters:ListOfCharacters driver:GameDriver 
                            noGUI:false builder:TreeBuilder 
                            autoPlay:ListOfAnswers newCharacter:NewCharacter)}
      {Application.exit 0}
   end
end
