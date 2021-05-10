functor
import
   ProjectLib
   Browser
   OS
   System
   Application
   Open
define
   CWD = {Atom.toString {OS.getCWD}}#"/"
   Browse = proc {$ Buf} {Browser.browse Buf} end
   Print = proc{$ S} {System.print S} end
   Args = {Application.getArgs record('nogui'(single type:bool default:false optional:true)
									  'db'(single type:string default:CWD#"database.txt")
                             'ans'(single type:string default:CWD#"test_answers.txt"))} 
in 
   local
      OutputFile
      NoGUI = Args.'nogui'
      DB = Args.'db'
      ListOfCharacters = {ProjectLib.loadDatabase file Args.'db'}
      % Vous devez modifier le code pour que cette variable soit
      % assigné un argument 	
      ListOfAnswersFile = CWD
      ListOfAnswers = {ProjectLib.loadCharacter file Args.'ans'}

      % Boucle pour recuperer la meilleure question

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

      % Boucle permettant de comparer 
      % chaque question pour connaitre la meilleure 
      
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

      % Diviser l'arbre en sous branche 
      % et suppression de question utilisée

      proc {SplitTree Database Question AccTrue AccFalse T F}
         case Database of nil then T=AccTrue F=AccFalse
         [] H|G then 
            if H.Question then {SplitTree G Question {Record.subtract H Question}|AccTrue AccFalse T F}
            else {SplitTree G Question AccTrue {Record.subtract H Question}|AccFalse T F}
            end
         end
      end

      % Creation de la liste contenant 
      % les noms a mettre dans les feuilles 
      
      fun {Leaf Database ListNom}
         case Database of nil then ListNom
         [] H|T then {Leaf T H.1|ListNom}
         end
      end

      % Creation de l'arbre et répartition des branches

      fun {TreeBuilder Database}
         BestQuestion BranchTrue BranchFalse in
         BestQuestion = {Loop {Record.arity Database.1}.2 Database 0 nil}
         if BestQuestion == nil then leaf({Leaf Database nil})
         else {SplitTree Database BestQuestion nil nil BranchTrue BranchFalse} question(BestQuestion true:{TreeBuilder BranchTrue} false:{TreeBuilder BranchFalse})
         end
      end

      % Parcours de l'arbre pour trouver 
      % la reponse dans le leaf

      fun {Response X}
         case X of question(Q true:T false:F) then
            if {ProjectLib.askQuestion Q} then {GameDriver T}
            else {GameDriver F}
            end
         [] leaf(N) then {ProjectLib.found N}
         end 
      end

      % Conversion du format de sortie de la reponse

      proc {WriteListToFile L F}
	 		% F must be an opened file
	 		case L
	 		of H|nil then
	    		{F write(vs:H)}
	 		[]H|T then
	    		{F write(vs:H#",")}
	    		{WriteListToFile T F}
          else {F write(vs:nil)}
	 		end
      end

      fun {GameDriver Tree}
         Result
         Filename = stdout
      in
         Result = {New Open.file init(name: Filename
				       flags: [write create truncate text])}

         if Result == false then
            {Print 'Je me suis trompé\n'}
            {ProjectLib.surrender}
         else
            {WriteListToFile {Response Tree} Result}
         end
         unit
      end
   in

   {ProjectLib.play opts(characters:ListOfCharacters driver:GameDriver 
                           noGUI:NoGUI builder:TreeBuilder 
                           autoPlay:ListOfAnswers)}
   {Application.exit 0}
   end
end