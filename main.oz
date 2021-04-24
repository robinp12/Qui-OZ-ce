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

   local CreateTree TrueBranch FalseBranch ListQuestion QRecord CharactersLength in
      fun {CreateTree}
         nil
      end
      fun {TrueBranch}
         nil
      end
      fun {FalseBranch}
         nil
      end
      fun {ListQuestion X}
         case X of nil then nil
         [] H|T then tree(1:H false:{ListQuestion T} true:{ListQuestion T})
         end
      end

      QRecord = {Arity ListOfCharacters.1}.2
      CharactersLength = {Length ListOfCharacters}
      
      {Browse {ListQuestion QRecord}}
   end
   
   /*{ProjectLib.play opts(characters:ListOfCharacters driver:GameDriver 
                           noGUI:false builder:TreeBuilder 
                           autoPlay:ListOfAnswers newCharacter:NewCharacter)}
   {Application.exit 0}*/
   end
end