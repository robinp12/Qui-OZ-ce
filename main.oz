functor
import
   ProjectLib
   Browser
   OS
   System
   Application
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

   local ToRecord CreateTree TrueBranch FalseBranch QuestionRecord CharactersLength in
      fun {CreateTree X}
         case X of nil then leaf('nom')
         [] H|T then tree(1:H false:{FalseBranch T} true:{TrueBranch T})
         end
      end
      fun {TrueBranch X}
         case X of nil then leaf('nom')
         [] H|T then tree(1:H false:{FalseBranch T} true:{TrueBranch T})
         end
      end
      fun {FalseBranch X}
         case X of nil then leaf('nom')
         [] H|T then tree(1:H false:{FalseBranch T} true:{TrueBranch T})
         end
      end
      fun {ToRecord X}
         case X of H|T then H#0 |{ToRecord T}
         [] nil then nil
         end
      end

      QuestionRecord = {Record.arity ListOfCharacters.1}.2
      CharactersLength = {Length ListOfCharacters}
      
      {Browse {CreateTree QuestionRecord}}
      {Browse {ToRecord QuestionRecord}}
      {Browse charactersLength(CharactersLength)}
      /*{Browse QuestionRecord}*/
   end
   
   /*{ProjectLib.play opts(characters:ListOfCharacters driver:GameDriver 
                           noGUI:false builder:TreeBuilder 
                           autoPlay:ListOfAnswers newCharacter:NewCharacter)}
   {Application.exit 0}*/
   end
end