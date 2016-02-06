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

open Parsing;;
let _ = parse_error;;
# 2 "parser.mly"

  open Ast

  (* Fonction pour aider à la localisation des erreurs. *)
  let current_pos () =
    Parsing.symbol_start_pos (),
    Parsing.symbol_end_pos ()

  (* Fonction de construction d'un [node_expr], qui renseigne correctement
     la localisation de l'expression. *)
  let mk_node e = { expr = e; pos = current_pos() }

# 32 "parser.ml"
let yytransl_const = [|
  258 (* CONST_UNIT *);
    0 (* EOF *);
  259 (* EOI *);
  261 (* LPAREN *);
  262 (* MINUS *);
  263 (* PLUS *);
  264 (* PRINT_INT *);
  265 (* PRINT_NEWLINE *);
  266 (* RPAREN *);
  267 (* SLASH *);
  268 (* STAR *);
    0|]

let yytransl_block = [|
  257 (* CONST_INT *);
  260 (* IDENT *);
    0|]

let yylhs = "\255\255\
\001\000\002\000\002\000\003\000\004\000\004\000\004\000\004\000\
\004\000\004\000\004\000\004\000\005\000\005\000\005\000\000\000"

let yylen = "\002\000\
\002\000\000\000\002\000\002\000\001\000\002\000\002\000\003\000\
\003\000\003\000\003\000\002\000\003\000\001\000\001\000\002\000"

let yydefred = "\000\000\
\000\000\000\000\015\000\014\000\000\000\000\000\000\000\000\000\
\016\000\000\000\000\000\000\000\005\000\000\000\000\000\007\000\
\006\000\001\000\003\000\004\000\000\000\000\000\000\000\000\000\
\013\000\000\000\000\000\011\000\010\000"

let yydgoto = "\002\000\
\009\000\010\000\011\000\012\000\013\000"

let yysindex = "\021\000\
\019\255\000\000\000\000\000\000\019\255\019\255\040\255\040\255\
\000\000\023\000\019\255\255\254\000\000\253\254\001\255\000\000\
\000\000\000\000\000\000\000\000\019\255\019\255\019\255\019\255\
\000\000\001\255\001\255\000\000\000\000"

let yyrindex = "\000\000\
\032\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\032\000\000\000\000\000\000\000\023\255\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\028\255\033\255\000\000\000\000"

let yygindex = "\000\000\
\000\000\026\000\000\000\251\255\007\000"

let yytablesize = 45
let yytable = "\014\000\
\015\000\020\000\021\000\022\000\021\000\022\000\025\000\023\000\
\024\000\023\000\024\000\023\000\024\000\016\000\017\000\026\000\
\027\000\028\000\029\000\003\000\004\000\001\000\018\000\005\000\
\006\000\012\000\007\000\008\000\012\000\012\000\009\000\002\000\
\012\000\009\000\009\000\008\000\019\000\009\000\008\000\008\000\
\003\000\004\000\008\000\000\000\005\000"

let yycheck = "\005\000\
\006\000\003\001\006\001\007\001\006\001\007\001\010\001\011\001\
\012\001\011\001\012\001\011\001\012\001\007\000\008\000\021\000\
\022\000\023\000\024\000\001\001\002\001\001\000\000\000\005\001\
\006\001\003\001\008\001\009\001\006\001\007\001\003\001\000\000\
\010\001\006\001\007\001\003\001\011\000\010\001\006\001\007\001\
\001\001\002\001\010\001\255\255\005\001"

let yynames_const = "\
  CONST_UNIT\000\
  EOF\000\
  EOI\000\
  LPAREN\000\
  MINUS\000\
  PLUS\000\
  PRINT_INT\000\
  PRINT_NEWLINE\000\
  RPAREN\000\
  SLASH\000\
  STAR\000\
  "

let yynames_block = "\
  CONST_INT\000\
  IDENT\000\
  "

let yyact = [|
  (fun _ -> failwith "parser")
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'instr_seq) in
    Obj.repr(
# 58 "parser.mly"
                ( _1 )
# 127 "parser.ml"
               : Ast.prog))
; (fun __caml_parser_env ->
    Obj.repr(
# 63 "parser.mly"
    ( [] )
# 133 "parser.ml"
               : 'instr_seq))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'instr) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'instr_seq) in
    Obj.repr(
# 65 "parser.mly"
    ( _1 :: _2 )
# 141 "parser.ml"
               : 'instr_seq))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'expr) in
    Obj.repr(
# 73 "parser.mly"
    ( Icompute _1 )
# 148 "parser.ml"
               : 'instr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'simple_expr) in
    Obj.repr(
# 92 "parser.mly"
    ( _1 )
# 155 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'simple_expr) in
    Obj.repr(
# 94 "parser.mly"
    ( mk_node (Eprint_newline _2) )
# 162 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'simple_expr) in
    Obj.repr(
# 96 "parser.mly"
     ( mk_node (Eprint_int _2) )
# 169 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 98 "parser.mly"
       ( mk_node (Ebinop (Badd,_1,_3)) )
# 177 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 100 "parser.mly"
 ( mk_node (Ebinop (Bsub,_1,_3)) )
# 185 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 102 "parser.mly"
       ( mk_node (Ebinop (Bmul,_1,_3)) )
# 193 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 104 "parser.mly"
       ( mk_node (Ebinop (Bdiv,_1,_3)) )
# 201 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 106 "parser.mly"
    ( mk_node (Eunop (Uminus, _2)) )
# 208 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'expr) in
    Obj.repr(
# 115 "parser.mly"
    ( _2 )
# 215 "parser.ml"
               : 'simple_expr))
; (fun __caml_parser_env ->
    Obj.repr(
# 117 "parser.mly"
    ( mk_node (Econst Cunit) )
# 221 "parser.ml"
               : 'simple_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : int) in
    Obj.repr(
# 119 "parser.mly"
     ( mk_node (Econst (Cint _1)) )
# 228 "parser.ml"
               : 'simple_expr))
(* Entry prog *)
; (fun __caml_parser_env -> raise (Parsing.YYexit (Parsing.peek_val __caml_parser_env 0)))
|]
let yytables =
  { Parsing.actions=yyact;
    Parsing.transl_const=yytransl_const;
    Parsing.transl_block=yytransl_block;
    Parsing.lhs=yylhs;
    Parsing.len=yylen;
    Parsing.defred=yydefred;
    Parsing.dgoto=yydgoto;
    Parsing.sindex=yysindex;
    Parsing.rindex=yyrindex;
    Parsing.gindex=yygindex;
    Parsing.tablesize=yytablesize;
    Parsing.table=yytable;
    Parsing.check=yycheck;
    Parsing.error_function=parse_error;
    Parsing.names_const=yynames_const;
    Parsing.names_block=yynames_block }
let prog (lexfun : Lexing.lexbuf -> token) (lexbuf : Lexing.lexbuf) =
   (Parsing.yyparse yytables 1 lexfun lexbuf : Ast.prog)
