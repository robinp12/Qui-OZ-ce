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
      %%             1
      %%            / \
      %%           2   2
      %%          / \ / \
      %%         3  3 3  3
      %%        / \ /
      %%       4  4 4

 T1 = tree(1:'A-t-il des cheveux?' 'false':tree(leaf) 'true':tree(leaf))
 T2 = tree(1:'A-t-il une soeur?'
                                                            false:tree(1:'Est-ce un humain'
                                                                              false:tree(1:'Est-ce une fille?'
                                                                                                false:leaf(['Said Snider'])
                                                                                                true:leaf(['Georgie Rudd']))
                                                                               true:leaf(['Brenna Small']))
                                                            true:tree(1:'A-t-il des cheveux noirs?'
                                                                            false:tree(1:'Est-ce une fille?'
                                                                                             false:leaf(['Zayn Bryan'])
                                                                                             true:leaf(['Luis Black']))
                                                                            true:tree(1:'Est-ce un humain'
                                                                                            false:leaf(['Havin Craig'])
                                                                                            true:leaf(['Mercy Hood']))))
       fun {QuestionCounterAcc CharacterList Acc}
         local A B C D in
            case CharacterList.1
            of nil then A
            [] character(Name 'Est-ce que c\'est une fille ?':IsGirl 'A-t-il des cheveux noirs ?':HasBlackHair 'Porte-t-il des lunettes ?':HasGlasses 'A-t-il des cheveux roux ?':HasRedHair) then 
               {Print Name}
               if IsGirl then A = Acc.1 + 1 else A = Acc.1 end
               if HasBlackHair then B = Acc.2 + 1 else B = Acc.2 end
               if HasGlasses then C = Acc.3 + 1 else C = Acc.3 end
               if HasRedHair then D = Acc.4 + 1 else D = Acc.4 end
               {Print Acc}
               {QuestionCounterAcc CharacterList.2 acc(A B C D)}
            else 
               nil
            end
      end
    end
   {Print {Database}}
   {Print {QuestionCounterAcc ListOfCharacters acc(0 0 0 0)}}

      {ProjectLib.play opts(characters:ListOfCharacters driver:GameDriver 
                            noGUI:false builder:TreeBuilder 
                            autoPlay:ListOfAnswers newCharacter:NewCharacter)}
      {Application.exit 0}
   end
end