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

# ReScript vs. Elm

- Not a framework
- Impure
- Overhead-free interop with JS
- Human readable JS output
- More powerful type system
- Arrays by default

---

# ReScript vs. TypeScript

- Not a superset of JavaScript
- Simpler language
- Sound type system, not opt-in
- (Ridiculously) fast compiler

--- 

# Language Tour

---

# Let and blocks

Immutable bindings

```reasonml
let answer = 21 * 2
```

Block scope; returns last expression

```reasonml
let message = {
  let part1 = "Hello"
  let part2 = "world"
  part1 ++ " " ++ part2
}
```

[](https://twitter.com/jordwalke/status/1001944847379521536)


--- 

# Types

- Strong, static and sound
- Global type inference

Type annotation
```reasonml
let count: int = 42_000
let count = (42_000: int)
```

Type alias
```reasonml
type occurence = (char, int)
let lInHello: occurence = ('l', 2)
```

---

# Types (contd.)

Type parameters (generics)
```reasonml
type vec2<'a> = ('a, 'a)
let point: vec2<int> = (10, 10)
let point: vec2<float> = (10.0, 10.0)

let points: array<vec2<int>> = [(1,1), (2,2), (3,3)]
```

---

# Operators

Different operators for different types
```reasonml
3 + 5
3.0 +. 5.0
"Nash" ++ "FP"
```

Custom operators [will be added back soon](https://rescript-lang.org/blog/editor-support-custom-operators-and-more#custom-operators).

# String interpolation
```reasonml
let name = "Shritesh"
let age = 25
let greeting = `hello ${name}` // Strings only
let message = j`hello $age years old, $name`
```

---

# Records

Nominal product types requiring type declaration

```reasonml
type person = {
  name: string,
  age: int
}
let shritesh = {name: "Shritesh", age: 25} // type is inferred
let olderShritesh = {...shritesh, age: shritesh.age + 1}
```

---

# Mutation and ref

```reasonml
type player = {
  name: string,
  mutable score: int
}
let mario = {name: "Mario", score: 10}
mario.score = mario.score + 1
```

```reasonml
// built into the language
type ref<'a> = {
  mutable contents: 'a
}
```

```reasonml
let i = ref(0)
while i.contents < 10 {
  Js.Console.log(i.contents)
  i := i.contents + 1
}
```

--- 

# Objects

Structural, inferred, polymorphic product types; Compiles to JS Objects

```reasonml
let shritesh = {
  "name": "Shritesh",
  "nationality": "Nepali"
}

let zuko =  {
  "name": "Zuko",
  "breed": "Persian"
}

let print = entity => Js.Console.log(entity["name"])

print(shritesh);
print(zuko);
```

---

# Variants

Nominal sum types

```reasonml
type shape =
  | Point
  | Circle(float)
  | Triangle({base: float, height: float}) // inline record
  | Rectangle(float, float)

let area = shape => switch shape {
  | Point => 0.0
  | Circle(r) => Js.Math._PI *. r *. r
  | Triangle(t) => t.base *. t.height /. 2.0
  | Rectangle(l, b) => l *. b
}
```

---

# Recursive types

```reasonml
type rec node<'a> =
  | None
  | Node('a, node<'a>)

let linkedList = Node(10, Node(20, None))
```

---

# Caveats

- Stable but still changing
- stdlib (Belt) is incomplete / outdated