---
marp: true
---

![ReScript Logo](https://rescript-lang.org/static/brand/rescript-logo.svg)

## @shritesh / NashFP


--- 

# Lineage

- BuckleScript: Compile OCaml to readable JS
- ReasonML: JS-like syntax for (native) OCaml
- ReScript: BuckleScript and forked ReasonML syntax


--- 
# Hello World

```reasonml
Js.log("Hello World")
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
  }->log
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

# Functions

```reasonml
let greet = () => "Hello"

let rec factorial = n =>
  if n <= 1 { 1 } else { n * factorial(n - 1) }

let make = (~bread, ~cheese, ~meat) => 
  j`$meat sandwich with $cheese cheese on $bread`

let sandwich = make(~cheese="feta", ~bread="flatbread", ~meat="lamb")
```

More features: Optional labels, explicit optionals, default values, uncurried functions.

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
  Js.log(i.contents)
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

let print = entity => Js.log(entity["name"])

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

Rectangle(3.0, 3.0)->area->Js.log
```

---

# Option and Result

```reasonml
type option<'a> = None | Some('a)
type result<'a, 'b> = Ok('a) | Error('b)
```

# Recursive types

```reasonml
type rec node<'a> =
  | None
  | Node('a, node<'a>)

let linkedList = Node(10, Node(20, None))
```

---

# Polymorphic variants

Anonymous variants that are structually typed

```reasonml
let drawVegetable = color => switch color {
  | #Green => "lettuce"
  | #Red => "radish"
  | #White => "mushroom"
  }

let drawFruit = color => switch color {
  | #Yellow => "banana"
  | #Red => "cranberry"
  | #Green => "avocado"
  }

let color = #Red
let vegetable = drawVegetable(color)
let fruit = drawFruit(color)
```

---

# Arrays

ReScript uses Arrays by default. Indexing is syntatic sugar for `Array.get`
```reasonml
open Belt
let arr = [1, 2, 3]
let first: option<int> = arr[0]
```

In OCaml and JS, `Array.get` doesn't return an option

```reasonml
// open Js
let arr = [1, 2, 3]
let first: int = arr[0]
```

---

# List
```reasonml
let l = list{1, 2, 3}

let isEmpty = switch l {
  | list{} => true
  | list{_head, ..._rest} => false
}
```

More data structures will follow this pattern in the future

---


# Control flow

```reasonml
if something { thenThis } else { thenThat }
if something { thenThis } // else { () }  // implicit

for i in 0 to 10 { Js.log(i) }
for i in 0 downto 10 { Js.log(i) }

while condition { inner_loop() } // See ref example above
```

---

# Destructuring and Pattern matching

Irrefutable patterns can be destructured
```reasonml
let coordinates = (1, 2, 0)
let (x, y, _) = coordinates

let sum = ((x, y, z)) = x + y + z // even in functions
```

Pattern matching using switch
```reasonml
switch Some(10) {
| Some(n) when n > 10 => "More than ten" // when guard
| Some(2) | Some(4) => "Two or four" // multiple clauses
| Some(_) => "Not two, four or ten"
| None => "No number given"
}
```
---


# Pipe (first)

Syntactic sugar for function application

```reasonml
let sum = (a, b, c) => a + b + c
let four = 1->sum(2, 1)
let addTwo = 1->sum(_, 1) // placeholder
let five = addTwo(3)

let someFive = five->Some // Can pipe into variants!!!
```

`|>` is deprecated, heavier, pipes last and doesn't work with variants

---

# Exceptions

---

# JSX

---

# Misc.

- Lazy
- First Class Modules / Functors

--- 

# Interop