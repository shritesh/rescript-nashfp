type t

@module("jsPDF") @new external make: unit => t = "jsPDF"

@send external text: (t, string, ~x: int, ~y: int) => unit = "text"
@send external save: (t, string) => unit = "save"
@send
external addImage: (
  t,
  string,
  ~format: [#JPEG | #PNG | #WEBP],
  ~x: int,
  ~y: int,
  ~width: int,
  ~height: int,
) => unit = "addImage"
