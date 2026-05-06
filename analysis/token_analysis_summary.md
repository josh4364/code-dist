# LLM Tokenization & Compressibility Analysis

Using OpenAI `o200k_base` tokenizer (GPT-4o).

## Language Efficiency Ranking
Ordered from most efficient (fewest tokens per character) to least.

| Rank | Language | Tokens/Char | Total Tokens | Total Chars |
|------|----------|-------------|--------------|-------------|
| 1 | `README.md` | 0.212 | 510 | 2402 |
| 2 | `visual basic.vb` | 0.259 | 2357 | 9106 |
| 3 | `lumina_int_function_double_return.lumina` | 0.271 | 1484 | 5480 |
| 4 | `java.java` | 0.272 | 2010 | 7380 |
| 5 | `lumina_int.lumina` | 0.284 | 1496 | 5270 |
| 6 | `csharp.cs` | 0.285 | 2207 | 7742 |
| 7 | `lumina_dash_names.lumina` | 0.287 | 1511 | 5270 |
| 8 | `fortran.f90` | 0.290 | 2262 | 7796 |
| 9 | `python.py` | 0.294 | 1973 | 6717 |
| 10 | `lumina_no_comment.lumina` | 0.294 | 1550 | 5270 |
| 11 | `lumina.lumina` | 0.297 | 1794 | 6045 |
| 12 | `typescript.ts` | 0.299 | 2221 | 7437 |
| 13 | `COBOL.cbl` | 0.299 | 1575 | 5264 |
| 14 | `julia.jl` | 0.305 | 1664 | 5456 |
| 15 | `bare.bare` | 0.307 | 739 | 2407 |
| 16 | `kotlin.kt` | 0.308 | 2032 | 6608 |
| 17 | `rust.rs` | 0.309 | 1962 | 6354 |
| 18 | `matlab.m` | 0.309 | 1868 | 6036 |
| 19 | `lua.lua` | 0.310 | 2025 | 6533 |
| 20 | `swift.swift` | 0.311 | 2076 | 6673 |
| 21 | `javscript.js` | 0.312 | 2128 | 6829 |
| 22 | `objective-c.m` | 0.314 | 1943 | 6193 |
| 23 | `groovy.groovy` | 0.320 | 1959 | 6126 |
| 24 | `delphi.pas` | 0.321 | 2187 | 6810 |
| 25 | `cpp.cpp` | 0.323 | 2287 | 7083 |
| 26 | `pascal.pas` | 0.326 | 2012 | 6165 |
| 27 | `common lisp.lisp` | 0.328 | 1947 | 5931 |
| 28 | `nasm.s` | 0.330 | 1318 | 3989 |
| 29 | `c.c` | 0.331 | 1659 | 5005 |
| 30 | `zig.zig` | 0.332 | 2445 | 7359 |
| 31 | `f#.fs` | 0.334 | 2019 | 6053 |
| 32 | `php.php` | 0.334 | 2266 | 6793 |
| 33 | `ocaml.ml` | 0.340 | 2101 | 6179 |
| 34 | `dart.dart` | 0.340 | 2243 | 6593 |
| 35 | `scheme.scm` | 0.342 | 1833 | 5358 |
| 36 | `wasm-text.wat` | 0.342 | 4080 | 11913 |
| 37 | `fasm.s` | 0.344 | 1258 | 3660 |
| 38 | `scala.scala` | 0.344 | 2083 | 6058 |
| 39 | `erlang.erl` | 0.344 | 2031 | 5905 |
| 40 | `haskel.hs` | 0.345 | 1799 | 5215 |
| 41 | `clojure.clj` | 0.350 | 1812 | 5174 |
| 42 | `nim.nim` | 0.357 | 1919 | 5376 |
| 43 | `perl.pl` | 0.357 | 1885 | 5278 |
| 44 | `elixir.ex` | 0.359 | 2145 | 5974 |
| 45 | `go.go` | 0.363 | 2129 | 5868 |
| 46 | `ruby.rb` | 0.364 | 1769 | 4862 |
| 47 | `crystal.cr` | 0.376 | 1881 | 4999 |

## Top 20 Most Frequent Tokens
Newlines are represented as `↵`.

| Rank | Token | Frequency |
|------|-------|-----------|
| 1 | ` ` | 4941 |
| 2 | `↵` | 3026 |
| 3 | `   ` | 2676 |
| 4 | ` =` | 2254 |
| 5 | ` (` | 2003 |
| 6 | `1` | 1736 |
| 7 | `,` | 1692 |
| 8 | `       ` | 1600 |
| 9 | `)` | 1529 |
| 10 | `.` | 1294 |
| 11 | ` i` | 1290 |
| 12 | `0` | 1170 |
| 13 | `)↵` | 1014 |
| 14 | `2` | 868 |
| 15 | ` {↵` | 775 |
| 16 | `:` | 693 |
| 17 | ` $` | 687 |
| 18 | `           ` | 670 |
| 19 | `;↵` | 634 |
| 20 | ` for` | 585 |
