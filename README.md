---
marp: true
---

![ReScript Logo](https://rescript-lang.org/static/brand/rescript-logo.svg)

## @shritesh / NashFP


--- 

# Lineage

- BuckleScript: Compile OCaml to readable JS
- ReasonML: JS syntax for (native) OCaml
- ReScript: BuckleScript + JS focused ReasonML fork(-ish)

---

# ReScript vs. Elm

- Not a framework
- Impure
- Overhead-free interop with JS
- Human readable JS output
- More powerful type system

---

# ReScript vs. TypeScript

- Not a superset of JavaScript
- Cannot just strip types; Need to be compiled
- Sound type system
- Simpler language
- (Ridiculously) fast compiler

--- 

# Hello World

```reasonml
Js.Console.log("Hello World")
```

# FizzBuzz

```reasonml
open Js

for n in 0 to 20 {
  switch (mod(n, 3), mod(n, 5)) {
  | (0, 0) => "FizzBuzz"
  | (0, _) => "Fizz"
  | (_, 0) => "Buzz"
  | (_, _) => Int.toString(n)
  }->Console.log
}
```

---

# Caveats

- Stable but still changing
- stdlib (Belt) is incomplete / outdated