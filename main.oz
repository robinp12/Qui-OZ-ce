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

   local CreateTree TrueBranch FalseBranch QuestionRecord CharactersLength QuestionLength BuiltTree Out GetElementsInOrder Insert CountQuestion Res A B C D QuestionWeight Loopin in
      
      A={NewCell 0}
      B={NewCell 0}
      C={NewCell 0}
      D={NewCell 0}

      fun {CountQuestion Y}
         for X in Y do
            if X.'Est-ce que c\'est une fille ?' then A:=@A+1 end
            if X.'A-t-il des cheveux noirs ?' then B:=@B+1 end
            if X.'Porte-t-il des lunettes ?' then C:=@C+1 end
            if X.'A-t-il des cheveux roux ?' then D:=@D+1 end
         end
            A:= @A - ({Length ListOfCharacters} - @A)
            B:= @B - ({Length ListOfCharacters} - @B)
            C:= @C - ({Length ListOfCharacters} - @C)
            D:= @D - ({Length ListOfCharacters} - @D)
         Res = result(@A#'Est-ce que c\'est une fille ?' @B#'A-t-il des cheveux noirs ?' @C#'Porte-t-il des lunettes ?' @D#'A-t-il des cheveux roux ?')
      end

      proc {Insert Key TreeIn TreeOut}
         if TreeIn == nil then TreeOut = tree(Key nil nil)
         else  
            local tree(K1 T1 T2) = TreeIn in 
               if Key == K1 then TreeOut = tree(Key T1 T2)
               elseif Key < K1 then 
                  local T in 
                     TreeOut = tree(K1 T T2)
                     {Insert Key T1 T}
                  end 
               else 
                  local T in 
                     TreeOut = tree(K1 T1 T)
                     {Insert Key T2 T}
                  end  
               end 
            end 
         end 
      end

      /* fun {GetElementsInOrder Tree}
         case Tree 
         of question(1:X false:leaf(nom) true:leaf(nom)) then X|nil
         [] question(1:X false:L true:leaf(nom)) then {Append {GetElementsInOrder L} X}
         [] question(1:X false:leaf(nom) true:R) then X|{GetElementsInOrder R}
         [] question(1:X false:L true:R) then {Append {GetElementsInOrder L} X|{GetElementsInOrder R}}
         end
      end */

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

      fun {Loopin X}
         case X of nil then nil
         [] H|T then 
            case H of nil then nil
            [] character(Name 'Est-ce que c\'est une fille ?':Girl 'A-t-il des cheveux noirs ?':Dark 'Porte-t-il des lunettes ?':Glasses 'A-t-il des cheveux roux ?':Red ) then Name(Girl#Dark#Glasses#Red)
            end | {Loopin T} 
         end
      end
/* character(Name 'Est-ce que c\'est une fille ?':isGirl 'A-t-il des cheveux noirs ?':isDark 'Porte-t-il des lunettes ?':isGlasses 'A-t-il des cheveux roux ?':isRed ) | {Loopin T} */
      QuestionRecord = {Record.arity ListOfCharacters.1}.2
      CharactersLength = {Length ListOfCharacters}
      QuestionLength =  {Length QuestionRecord}

      BuiltTree = {CreateTree QuestionRecord}
      QuestionWeight = {CountQuestion ListOfCharacters}

      /*{Browse {GetElementsInOrder BuiltTree}}*/
      {Browse charactersLength(CharactersLength)}
      {Browse questionLength(QuestionLength)}
      {Browse {CreateTree QuestionRecord}}
      {Browse QuestionWeight}
      {Browse {Loopin ListOfCharacters}}

   end
   
   {ProjectLib.play opts(characters:ListOfCharacters driver:GameDriver 
                           noGUI:false builder:TreeBuilder 
                           autoPlay:ListOfAnswers newCharacter:NewCharacter)}
         {Application.exit 0}
   end
end