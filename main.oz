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
									  'db'(single type:string default:CWD#"database.txt")
                             'ans'(single type:string default:CWD#"test_answers.txt"))} 
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

   local ToRecord CreateTree TrueBranch FalseBranch QuestionRecord CharactersLength QuestionLength BuiltTree Convert CharacterListConverted Iter GetElementsInOrder LoopCharacter in
       fun {Convert X}
         if X \= nil then 
            case X.1
            of character(1:Name 'Est-ce que c\'est une fille ?':A 'A-t-il des cheveux noirs ?':B 'Porte-t-il des lunettes ?':C 'A-t-il des cheveux roux ?':D) then
               character(1:Name 'isGirl':A 'isBrown':B 'isGlasses':C 'isRed':D) | {Convert X.2}
            end
         else nil
         end
      end
      fun {CreateTree X}
         case X of nil then leaf('nom')
         [] H|T then question(H false:{FalseBranch T} true:{TrueBranch T})
         end
      end
      fun {TrueBranch X}
         case X of nil then leaf('nom')
         [] H|T then question(H false:{FalseBranch T} true:{TrueBranch T})
         end
      end
      fun {FalseBranch X}
         case X of nil then leaf('nom')
         [] H|T then question(H false:{FalseBranch T} true:{TrueBranch T})
         end
      end
      fun {ToRecord X}
         case X of H|T then H#0 |{ToRecord T}
         [] nil then nil
         end
      end
     /*fun {GetElementsInOrder Tree}
         case Tree 
         of question(1:X false:leaf(nom) true:leaf(nom)) then
            X|nil
         [] question(1:X false:L true:leaf(nom)) then
            {Append {GetElementsInOrder L} X}
         [] question(1:X false:leaf(nom) true:R) then
            X|{GetElementsInOrder R}
         [] question(1:X false:L true:R) then
            {Append {GetElementsInOrder L} X|{GetElementsInOrder R}}
         end
      end*/
      fun {LoopCharacter X}
         if X \= nil then X.1 | {LoopCharacter X.2} else nil end
      end

      CharacterListConverted = {Convert ListOfCharacters}
      QuestionRecord = {Record.arity ListOfCharacters.1}.2
      CharactersLength = {Length ListOfCharacters}
      QuestionLength =  {Length QuestionRecord}
      BuiltTree = {CreateTree QuestionRecord}
     
      /*{Browse {GetElementsInOrder BuiltTree}} */
      {Browse {CreateTree QuestionRecord}}
      {Browse {ToRecord QuestionRecord}}
      {Browse charactersLength(CharactersLength)}
      {Browse questionLength(QuestionLength)}
      {Browse {LoopCharacter CharacterListConverted}}

   end
   
   /*{ProjectLib.play opts(characters:ListOfCharacters driver:GameDriver 
                           noGUI:false builder:TreeBuilder 
                           autoPlay:ListOfAnswers newCharacter:NewCharacter)}
   {Application.exit 0}*/
   end
end