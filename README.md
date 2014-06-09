ocaml-glob [![Build Status](https://travis-ci.org/simonjbeaumont/ocaml-glob.png)](https://travis-ci.org/simonjbeaumont/ocaml-glob)
============

Library for matching against glob strings.

Build dependencies
------------------

* [OUnit](http://ounit.forge.ocamlcore.org/)

Installation
------------
This is intended to be an OPAM package but for now it can be insalled like
this:
```
$ make
$ make install
```

Unit tests can be run using:
```
$ make test
```

Usage
-----

```ocaml
let () =
  if Glob.matches_glob "*/foo/bar/*" "a/foo/bar/b"
  then print_endline "Yay!"
  else print_endline "Nay!"
```

Compile and run as follows:

```
$ ocamlfind ocamlopt -package unix -package glob -thread -linkpkg trial.ml -o trial
$ ./trial
Yay
```

