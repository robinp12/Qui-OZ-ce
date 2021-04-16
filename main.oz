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
   Database
   TreeB
   T1
   T2
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
     Res
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
   
      A={NewCell 0}
      B={NewCell 0}
      C={NewCell 0}
      D={NewCell 0}
      E={NewCell 0}
      F={NewCell 0}
      G={NewCell 0}
      H={NewCell 0}

      fun {GameDriver Tree}
         Result = 0
      in
         % Toujours renvoyer unit
         unit
      end
   in

   fun {TestDBTest}
      for X in ListOfCharacters do
            if X.'A-t-il une soeur?' then A:=@A+1 end
            if X.'Est-ce un personnage fictif?' then B:=@B+1 end
            if X.'A-t-il des cheveux?' then C:=@C+1 end
            if X.'Est-ce un humain' then D:=@D+1 end
            if X.'A-t-il des cheveux noirs?' then E:=@E+1 end
            if X.'Porte-t-il des lunettes?' then F:=@F+1 end
            if X.'A-t-il des cheveux blond?' then G:=@G+1 end
            if X.'Est-ce une fille?' then H:=@H+1 end
      end
      A:= @A - ({Length ListOfCharacters} - @A)
      B:= @B - ({Length ListOfCharacters} - @B)
      C:= @C - ({Length ListOfCharacters} - @C)
      D:= @D - ({Length ListOfCharacters} - @D)
      E:= @E - ({Length ListOfCharacters} - @E)
      F:= @F - ({Length ListOfCharacters} - @F)
      G:= @G - ({Length ListOfCharacters} - @G)
      H:= @H - ({Length ListOfCharacters} - @H)
   Res = result(1:@A 2:@B 3:@C 4:@D 5:@E 6:@F 7:@G 8:@H)
   end

   fun {Database}
     for X in ListOfCharacters do
            if X.'Est-ce que c\'est une fille ?' then A:=@A+1 
            end
            if X.'A-t-il des cheveux noirs ?' then B:=@B+1 
            end
            if X.'Porte-t-il des lunettes ?' then C:=@C+1 
            end
            if X.'A-t-il des cheveux roux ?' then D:=@D+1 
            end
      end
      A:= @A - ({Length ListOfCharacters} - @A)
      B:= @B - ({Length ListOfCharacters} - @B)
      C:= @C - ({Length ListOfCharacters} - @C)
      D:= @D - ({Length ListOfCharacters} - @D)
   Res = result(1:@A 2:@B 3:@C 4:@D)
   
   end

 T1 = tree(key:1 value:true tree() tree())
 T2 = tree(key:1 value:faux leaf leaf)
   fun {TreeB K W T}
      case T
      of leaf then tree(key:K value:W leaf leaf)
      [] tree(key:Y value:V T1 T2) andthen K==Y then
      tree(key:K value:W T1 T2)
      [] tree(key:Y value:V T1 T2) andthen K<Y then
      tree(key:Y value:V {TreeB K W T1} T2)
      [] tree(key:Y value:V T1 T2) andthen K>Y then
      tree(key:Y value:V T1 {TreeB K W T2})
      end
   end

   {Browse {TreeB 1 true T1}}
   {Browse T1}

      {ProjectLib.play opts(characters:ListOfCharacters driver:GameDriver 
                            noGUI:false builder:TreeBuilder 
                            autoPlay:ListOfAnswers newCharacter:NewCharacter)}
      {Application.exit 0}
   end
end