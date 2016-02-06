type token =
  | CONST_INT of (int)
  | CONST_UNIT
  | EOF
  | EOI
  | IDENT of (string)
  | LPAREN
  | MINUS
  | PLUS
  | PRINT_INT
  | PRINT_NEWLINE
  | RPAREN
  | SLASH
  | STAR

val prog :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf -> Ast.prog
