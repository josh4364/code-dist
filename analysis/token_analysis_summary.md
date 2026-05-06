# LLM Tokenization & Compressibility Analysis

Using OpenAI `o200k_base` tokenizer (GPT-4o).

## Language Efficiency Ranking
Ordered from most efficient (fewest tokens per character) to least.

| Rank | Language | Tokens/Char | Total Tokens | Total Chars |
|------|----------|-------------|--------------|-------------|
| 1 | `visual basic.vb` | 0.259 | 2357 | 9106 |
| 2 | `java.java` | 0.272 | 2010 | 7380 |
| 3 | `lumina_int.lumina` | 0.284 | 1496 | 5270 |
| 4 | `csharp.cs` | 0.285 | 2207 | 7742 |
| 5 | `lumina_dash_names.lumina` | 0.287 | 1511 | 5270 |
| 6 | `fortran.f90` | 0.290 | 2262 | 7796 |
| 7 | `python.py` | 0.294 | 1973 | 6717 |
| 8 | `lumina_no_comment.lumina` | 0.294 | 1550 | 5270 |
| 9 | `lumina.lumina` | 0.297 | 1794 | 6045 |
| 10 | `typescript.ts` | 0.299 | 2221 | 7437 |
| 11 | `COBOL.cbl` | 0.299 | 1575 | 5264 |
| 12 | `julia.jl` | 0.305 | 1664 | 5456 |
| 13 | `bare.bare` | 0.307 | 739 | 2407 |
| 14 | `kotlin.kt` | 0.308 | 2032 | 6608 |
| 15 | `rust.rs` | 0.309 | 1962 | 6354 |
| 16 | `matlab.m` | 0.309 | 1868 | 6036 |
| 17 | `lua.lua` | 0.310 | 2025 | 6533 |
| 18 | `swift.swift` | 0.311 | 2076 | 6673 |
| 19 | `javscript.js` | 0.312 | 2128 | 6829 |
| 20 | `objective-c.m` | 0.314 | 1943 | 6193 |
| 21 | `groovy.groovy` | 0.320 | 1959 | 6126 |
| 22 | `delphi.pas` | 0.321 | 2187 | 6810 |
| 23 | `cpp.cpp` | 0.323 | 2287 | 7083 |
| 24 | `pascal.pas` | 0.326 | 2012 | 6165 |
| 25 | `common lisp.lisp` | 0.328 | 1947 | 5931 |
| 26 | `nasm.s` | 0.330 | 1318 | 3989 |
| 27 | `c.c` | 0.331 | 1659 | 5005 |
| 28 | `zig.zig` | 0.332 | 2445 | 7359 |
| 29 | `f#.fs` | 0.334 | 2019 | 6053 |
| 30 | `php.php` | 0.334 | 2266 | 6793 |
| 31 | `ocaml.ml` | 0.340 | 2101 | 6179 |
| 32 | `dart.dart` | 0.340 | 2243 | 6593 |
| 33 | `scheme.scm` | 0.342 | 1833 | 5358 |
| 34 | `wasm-text.wat` | 0.342 | 4080 | 11913 |
| 35 | `fasm.s` | 0.344 | 1258 | 3660 |
| 36 | `scala.scala` | 0.344 | 2083 | 6058 |
| 37 | `erlang.erl` | 0.344 | 2031 | 5905 |
| 38 | `haskel.hs` | 0.345 | 1799 | 5215 |
| 39 | `clojure.clj` | 0.350 | 1812 | 5174 |
| 40 | `nim.nim` | 0.357 | 1919 | 5376 |
| 41 | `perl.pl` | 0.357 | 1885 | 5278 |
| 42 | `elixir.ex` | 0.359 | 2145 | 5974 |
| 43 | `go.go` | 0.363 | 2129 | 5868 |
| 44 | `ruby.rb` | 0.364 | 1769 | 4862 |
| 45 | `crystal.cr` | 0.376 | 1881 | 4999 |

## Top 20 Most Frequent Tokens
Newlines are represented as `↵`.

| Rank | Token | Frequency |
|------|-------|-----------|
| 1 | ` ` | 4892 |
| 2 | `↵` | 2890 |
| 3 | `   ` | 2601 |
| 4 | ` =` | 2177 |
| 5 | ` (` | 1998 |
| 6 | `1` | 1711 |
| 7 | `,` | 1684 |
| 8 | `       ` | 1532 |
| 9 | `)` | 1517 |
| 10 | `.` | 1289 |
| 11 | ` i` | 1268 |
| 12 | `0` | 1154 |
| 13 | `)↵` | 943 |
| 14 | `2` | 861 |
| 15 | ` {↵` | 775 |
| 16 | `:` | 693 |
| 17 | ` $` | 687 |
| 18 | `           ` | 638 |
| 19 | `;↵` | 634 |
| 20 | ` for` | 582 |
