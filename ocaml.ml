open Printf

(* 1. Hello world/Text *)
let hello_world () = print_endline "Hello world!"

(* 2. Fibonacci sequence *)
let fib n =
  let a = ref 0 and b = ref 1 in
  for _ = 1 to n do
    let tmp = !a in
    a := !b;
    b := tmp + !b
  done;
  !a

(* 3. Factorial *)
let rec factorial n =
  if n <= 1 then 1 else n * factorial (n - 1)

(* 4. 99 bottles of beer *)
let bottles_of_beer () =
  for i = 99 downto 1 do
    let s = if i <> 1 then "s" else "" in
    let next = i - 1 in
    let s_next = if next <> 1 then "s" else "" in
    let next_count = if next > 0 then string_of_int next else "no more" in
    printf "%d bottle%s of beer on the wall, %d bottle%s of beer.\n" i s i s;
    printf "Take one down, pass it around, %s bottle%s of beer on the wall.\n\n" next_count s_next
  done

(* 5. Bubble sort *)
let bubble_sort arr =
  let n = Array.length arr in
  for i = 0 to n - 1 do
    for j = 0 to n - i - 2 do
      if arr.(j) > arr.(j + 1) then
        let tmp = arr.(j) in
        arr.(j) <- arr.(j + 1);
        arr.(j + 1) <- tmp
    done
  done;
  arr

(* 6. FizzBuzz *)
let fizzbuzz () =
  for i = 1 to 100 do
    if i mod 15 = 0 then print_endline "FizzBuzz"
    else if i mod 3 = 0 then print_endline "Fizz"
    else if i mod 5 = 0 then print_endline "Buzz"
    else print_endline (string_of_int i)
  done

(* 7. Empty program *)
let () = ()

(* 8. A+B *)
let a_plus_b input_str =
  String.split_on_char ' ' input_str
  |> List.filter (fun s -> s <> "")
  |> List.map int_of_string
  |> List.fold_left (+) 0

(* 9. 100 doors *)
let hundred_doors () =
  let doors = Array.make 101 false in
  for i = 1 to 100 do
    let j = ref i in
    while !j <= 100 do
      doors.(!j) <- not doors.(!j);
      j := !j + i
    done
  done;
  let open_doors = ref [] in
  for i = 1 to 100 do
    if doors.(i) then open_doors := i :: !open_doors
  done;
  List.rev !open_doors

(* 10. Quine *)
let quine () =
  let s = "let s = %S in Printf.printf s s;;" in
  Printf.printf s s;;

(* 11. Launch rocket with countdown and acceleration *)
let launch_rocket () =
  let accel = 9.8 in
  let velocity = ref 0.0 in
  for t = 10 downto 0 do
    printf "T-minus %d...\n%!" t;
    Unix.sleepf 0.1
  done;
  print_endline "Liftoff!";
  for t = 1 to 3 do
    velocity := !velocity +. accel;
    printf "Time: %ds, Velocity: %.1fm/s, Accel: %.1fm/s^2\n" t !velocity accel
  done

(* 12. Experimental Verification of the NKT Law *)
let nkt_law_verify t t_env t_init k =
  t_env +. (t_init -. t_env) *. exp (-.k *. t)

(* 13. Universal Lambda Machine *)
let universal_lambda () =
  let zero f x = x in
  let succ n f x = f (n f x) in
  let to_int n = n (fun x -> x + 1) 0 in
  to_int (succ (succ zero))

(* 14. Nautical bell *)
let nautical_bell time_str =
  let parts = String.split_on_char ':' time_str in
  let h = int_of_string (List.nth parts 0) in
  let m = int_of_string (List.nth parts 1) in
  let half_hours = ((h mod 4) * 2) + (if m >= 30 then 1 else 0) in
  if half_hours = 0 && m < 30 then 8 else half_hours

(* 15. Earliest difference between primes *)
let prime_diff target_diff =
  let is_prime n =
    if n < 2 then false else
    let rec check i =
      if i * i > n then true
      else if n mod i = 0 then false
      else check (i + 1)
    in check 2
  in
  let prev_prime = ref 2 in
  let current = ref 3 in
  let rec loop () =
    if is_prime !current then begin
      if !current - !prev_prime = target_diff then (!prev_prime, !current)
      else (prev_prime := !current; current := !current + 2; loop ())
    end else (current := !current + 2; loop ())
  in loop ()

(* 16. Canny edge detector (Simplified concept) *)
let canny_concept pixel_grid =
  let rows = Array.length pixel_grid in
  let cols = Array.length pixel_grid.(0) in
  let edges = Array.make_matrix rows cols 0.0 in
  for y = 1 to rows - 2 do
    for x = 1 to cols - 2 do
      let grad_x = float_of_int (pixel_grid.(y).(x+1) - pixel_grid.(y).(x-1)) in
      let grad_y = float_of_int (pixel_grid.(y+1).(x) - pixel_grid.(y-1).(x)) in
      edges.(y).(x) <- sqrt (grad_x ** 2.0 +. grad_y ** 2.0)
    done
  done;
  edges

(* 17. Death Star *)
let draw_death_star r =
  let r_f = float_of_int r in
  for y = -r to r do
    let y_f = float_of_int y in
    for x = -2 * r to 2 * r do
      let x_f = float_of_int x /. 2.0 in
      if (x_f *. x_f +. y_f *. y_f) <= (r_f *. r_f) then
        let dx = x_f -. (r_f /. 2.0) in
        let dy = y_f -. (r_f /. 2.0) in
        if (dx *. dx +. dy *. dy) <= ((r_f /. 3.0) ** 2.0) then print_string " "
        else print_string "#"
      else print_string " "
    done;
    print_newline ()
  done

(* 18. Chat server stub *)
let chat_server_stub () =
  let host = "127.0.0.1" and port = 65432 in
  (* Logic for Unix.socket, Unix.bind, Unix.listen would go here *)
  sprintf "Server configured for %s:%d" host port

(* 19. Faulhaber's triangle (Using Zarith/Rationals for precision if available, here basic float) *)
let faulhaber_triangle n =
  let rec combinations n k =
    if k = 0 || k = n then 1
    else combinations (n - 1) (k - 1) + combinations (n - 1) k
  in
  let bernoulli m =
    let b = Array.make (m + 1) 0.0 in
    for i = 0 to m do
      b.(i) <- 1.0 /. float_of_int (i + 1);
      for j = i downto 1 do
        b.(j-1) <- float_of_int j *. (b.(j-1) -. b.(j))
      done
    done;
    b.(0)
  in
  List.init n (fun p ->
    List.init (p + 1) (fun j ->
      (1.0 /. float_of_int (p + 1)) *. float_of_int (combinations (p + 1) j) *. bernoulli j
    )
  )

(* 20. Execute a Markov algorithm *)
let markov_algorithm rules text =
  let rec apply current_text =
    let rec find_rule = function
      | [] -> None
      | (pat, rep, term) :: rest ->
          match String.index_opt current_text pat.[0] with (* Optimization hint *)
          | _ -> 
            let re = Str.regexp_string pat in
            try 
              let _ = Str.search_forward re current_text 0 in
              Some (Str.replace_first re rep current_text, term)
            with Not_found -> find_rule rest
    in
    match find_rule rules with
    | Some (new_text, true) -> new_text
    | Some (new_text, false) -> apply new_text
    | None -> current_text
  in apply text