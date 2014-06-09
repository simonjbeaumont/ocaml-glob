open OUnit

let test_matches_glob glob subject expected_result () =
	let test_summary = Printf.sprintf
		"Checking \"%s\" does%s match glob \"%s\""
		subject (if not expected_result then " NOT" else "") glob
	in
	if expected_result
	then assert_bool test_summary (Glob.matches_glob glob subject)

let test_matrix = [
	(* Exact string matching *)
	"/foo/bar/", "/foo/bar/", true;
	"/foo/bar/", "foo/bar/", false;
	"/foo/bar/", "/foo/bar", false;
	"/foo/bar/", "abc/foo/bar", false;
	"/foo/bar/", "/foo/bar/abc", false;
	(* Star at start *)
	"*/foo/bar/", "/foo/bar/", true;
	"*/foo/bar/", "abc/foo/bar/", true;
	"*/foo/bar/", "/foo/bar/abc", false;
	(* Star at end *)
	"/foo/bar/*", "/foo/bar/", true;
	"/foo/bar/*", "/foo/bar/abc", true;
	"/foo/bar/*", "/foo/barabc", false;
	"/foo/bar/*", "abc/foo/bar/", false;
	(* Star in middle *)
	"/foo/*/", "/foo/bar/", true;
	"/foo/*/", "/foo///", true;
	"/foo/*/", "/foo/bar/abc", false;
	"/foo/*/", "/foo/bar/abc/", true;
	(* Two stars *)
	"*/*", "/foo/bar/", true;
	"*/*/", "/foo/bar/", true;
	"*/*/", "/foo/bar", false;
	"/*/*/", "/foo/bar/", true;
	"/*/*/", "foo/bar/", false;
]

let _ =
	let suite = "test_glob" >:::
		(List.map (fun (g, s, e) -> s >:: test_matches_glob g s e) test_matrix)
	in
	run_test_tt ~verbose:false suite
