open Ast
open Error

let not_implemented () = failwith "Not implemented"
(* compilation Ctrl c c*)
(* Les expressions de notre langage calculent des valeurs qui sont soit
   des entiers, soit des booléens, soit la valeur unité qui ne représente
   rien.
*)
type value =
  | Vint of int
  | Vbool of bool
  | Vunit


(* Cette déclaration nous permet de définir des environnements associant
   des valeurs à des chaînes de caractères.

   Le type de ces environnements est noté ['a Env.t], sachant que dans
   dans notre cas le paramètre ['a] sera systématiquement [value].
   Pour manipuler ces environnements, on a notamment les fonctions
   [Env.find : string -> 'a Env.t -> 'a] et
   [Env.add  : string -> 'a -> 'a Env.t -> 'a Env.t],
   ainsi que la constante [Env.empty : 'a Env.t].
   Voir la documentation de la bibliothèque Caml [Map.Make].
*)
module Env = Map.Make(String)


(* La fonction suivante prend une valeur (de type [value]) et en extrait
   le booléen qu'elle contient.
   Elle déclenche une erreur [Interpretation_error] si elle est utilisée
   sur une valeur non adaptée (comme [Vunit]). L'argument [pos] sert en cas
   d'erreur à indiquer la partie du fichier interprété qui a provoqué l'erreur.
   
   get_bool : Ast.position -> value -> bool
*)
let get_bool pos v =
  match v with
    | Vbool b -> b
    | _       -> error Interpretation_error pos
let get_int pos v =
  match v with
  |Vint b -> b
  |_      -> error Interpretation_error pos

let is_bool pos v =
  match v with
    | Vbool b -> true
    | _       -> false
let is_int pos v =
  match v with
  |Vint b -> true
  |_      -> false
	   (* Voici le cœur de l'interpréteur, qu'il va falloir compléter. Cette fonction
   prend en argument un environnement associant des valeurs à des chaînes de
   caractères ainsi qu'une expression de la forme décrite dans [Ast.mli], et
   renvoie la valeur calculée.

   interpret_expr : value Env.t -> Ast.node_expr -> value
*)
let rec interpret_expr env e =
  match e.expr with
    | Eunop (Unot, e)   ->
      let b = get_bool e.pos (interpret_expr env e) in
      Vbool (not b)
    | Eunop (Uminus, e)   ->
      let b = get_int e.pos (interpret_expr env e) in
      Vint (-b)
    | Eprint_newline e ->
      let _ = interpret_expr env e in
      print_newline ();
      Vunit
    | Eprint_int e ->
       let x = interpret_expr env e in
       print_int (get_int e.pos x);
       Vunit
    |Eident s -> Env.find s env 
    |Econst x -> begin  match x with
		   |Cint i -> Vint(i)
		   |Cbool i -> Vbool(i)
		   |_ -> Vunit
		 end
    |Eseq x -> let rec aux le =
		 match le with
		     |[] -> failwith "Liste vide erreur"
		     |[e] -> interpret_expr env e
		     |a::liste -> let _ = interpret_expr env a in aux liste
	       in aux x
    |Eletin(x,y,z) -> let v = interpret_expr env y in interpret_expr (Env.add x v env) z
    |Eif (x,y,z) -> let b1 =  (interpret_expr env x) in 
		  	if (is_bool x.pos b1)&&(get_bool x.pos b1) then
				interpret_expr env y
			else
				interpret_expr env z 
    |Ebinop (x,y,z)  -> match x with
		      |Badd -> let e1 =  get_int y.pos (interpret_expr env y) and
				   e2 = get_int z.pos (interpret_expr env z) in Vint(e1+e2)
                      |Bmul -> let e1 =  get_int y.pos (interpret_expr env y) and
				   e2 = get_int z.pos (interpret_expr env z) in Vint(e1*e2)
		      |Bsub -> let e1 =  get_int y.pos (interpret_expr env y) and
				   e2 = get_int z.pos (interpret_expr env z) in Vint(e1-e2)
		      |Bdiv -> let e1 =  get_int y.pos (interpret_expr env y) and
				   e2 = get_int z.pos (interpret_expr env z) in Vint(e1/e2)

		      |(Beq | Bneq | Blt | Ble | Bgt | Bge | Band | Bor) -> 
 				 let b1 =  (interpret_expr env y)
				 and b2 =  (interpret_expr env z)
				 in
				 if(( is_bool y.pos b1) && (is_bool z.pos b2))then
				   let x1 = get_bool y.pos b1
				   and x2 = get_bool z.pos b2 in
				   Vbool(match x with
					 |Beq -> x1 = x2
				         |Bneq -> x1 <> x2
					 |Band -> x1 && x2
					 |Bor -> x1 || x2
					 |_->  assert false)
				  else
				   let x1 = get_int y.pos b1
				   and x2 = get_int z.pos b2
	 			   in
				Vbool(match x with
					 |Beq -> (x1 = x2)
				         |Bneq -> (x1 <> x2)
					 |Blt -> (x1<x2)
					 |Ble -> (x1 <= x2)
		  			 |Bgt -> (x1>x2)
					 |Bge -> (x1>=x2)
				         |_-> assert false
					 )
    |_-> failwith"Not impltemented"



(* Enfin, la fonction principale, qu'il faut aussi compléter, et qui doit
   appliquer la fonction d'interprétation des expressions à toutes les
   instructions du programme. N'oubliez pas que les instructions peuvent
   agir sur l'environnement !

   interpret_prog : Ast.prog -> unit
 *)



(* parcourt de ma liste des instructions (Icompute ou Ilet)*)
(* let _ pour se debarasser du resultat qui ne renvoie pas unit , cas du ilet, modifier l'environnement*)						 
let interpret_prog (p : Ast.prog) : unit =
  let rec aux env e =
	    match e with
	          |[] -> print_newline()
		  |Icompute a::b ->  let _ = interpret_expr env a in aux env b
		  |Ilet (a,b) :: c ->
			let x = (interpret_expr env b) 
				in aux (Env.add a x env) c
		  |_-> failwith"Not impltemented"
  in
  aux(Env.empty) p
