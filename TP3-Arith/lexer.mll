{

  open Lexing
  open Parser
  open Ast
  open Error

  (* Petite fonction utile pour la localisation des erreurs. *)
  let current_pos b =
    lexeme_start_p b,
    lexeme_end_p b

}


  (* À compléter. Il faut gérer :
     - les blancs
     - les constantes
     - les noms "print_int" et "print_newline"
     - les symboles
     - les commentaires *)
rule token = parse
  (* Le retour à la ligne est traité à part pour aider la localisation. *)
  | '\n'
      { new_line lexbuf; token lexbuf }
  
  | "(*"
      { comment lexbuf } 
  (* Cadeau : la fonction print_newline et la constante unité. *)
  | "print_newline"
      { PRINT_NEWLINE }
  | "()"
      { CONST_UNIT }

  | [' ' '\t' '\r']+ 
      { token lexbuf }
  
  | ['0'-'9']+ as valeur
       	{ CONST_INT (int_of_string valeur)}

  | "print_int"
      { PRINT_INT }
  | "+"
      { PLUS }
  | "-"
      { MINUS }
  | "*"
      { STAR }
  | "/"
      { SLASH }
  | "("
      { LPAREN }
  | ")"
      { RPAREN }
  | ";;"
      { EOI }

  | _
      { error (Lexical_error (lexeme lexbuf)) (current_pos lexbuf) }
  (* Fin du fichier. *)
  | eof
      { EOF }

 and comment = parse
    | "*)" { token lexbuf }
    | _    { comment lexbuf }
    | eof { failwith "Commentaire non termine" }

