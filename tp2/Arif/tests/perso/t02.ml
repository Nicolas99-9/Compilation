print_int 54678103 ;;
print_newline () ;;

(* Calcul booléen. *)
if true  && false then print_int 12 else print_int 5 ;;
if true  && true  then print_int 4 else print_int 4 ;;
if false  || false then print_int 5 else print_int 6 ;;
if false || true  then print_int 78 else print_int 8 ;;
if not false       then print_int 10 else print_int 2 ;;
if true      then print_int 3 else print_int 4 ;;
