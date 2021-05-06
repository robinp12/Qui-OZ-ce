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

      fun {Loop X ListOfCharacters A Question}
         case X of nil then 
            if A == 0 then nil
            else Question
            end
         [] H|T then 
            if A>{Iterator H ListOfCharacters 0 0} then {Loop T ListOfCharacters A Question}
            else {Loop T ListOfCharacters {Iterator H ListOfCharacters 0 0} H}
            end
         end
      end

      fun {Iterator Question Database IterTrue IterFalse}
         case Database 
         of H|T then 
            if H.Question then {Iterator Question T IterTrue+1 IterFalse}
            else {Iterator Question T IterTrue IterFalse+1}
            end
         [] nil then 
            if IterTrue > IterFalse then IterFalse
            else IterTrue 
            end
         end 
      end

      proc {SplitTree Database Question AccTrue AccFalse T F}
         case Database of nil then T=AccTrue F=AccFalse
         [] H|G then 
            if H.Question then {SplitTree G Question {Record.subtract H Question}|AccTrue AccFalse T F}
            else {SplitTree G Question AccTrue {Record.subtract H Question}|AccFalse T F}
            end
         end
      end

      fun {Leaf Database ListNom}
         case Database of nil then ListNom
         [] H|T then {Leaf T H.1|ListNom}
         end
      end

      fun {TreeBuilder Database}
         BestQuestion BranchTrue BranchFalse in
         BestQuestion = {Loop {Record.arity Database.1}.2 Database 0 nil}
         if BestQuestion == nil then leaf({Leaf Database nil})
         else {SplitTree Database BestQuestion nil nil BranchTrue BranchFalse} question(BestQuestion true:{TreeBuilder BranchTrue} false:{TreeBuilder BranchFalse})
         end
      end

      fun {Response X}
         case X of question(Q true:T false:F) then
            if {ProjectLib.askQuestion Q} then {GameDriver T}
            else {GameDriver F}
            end
         [] leaf(N) then {ProjectLib.found N}
         end 
      end

      fun {GameDriver Tree}
         Result = {Response Tree}
      in
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