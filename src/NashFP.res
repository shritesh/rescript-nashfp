open Pdf

let imageData = Fs.readFileBase64("nashfp.png")

let pdf = make()
pdf->addImage(imageData, ~format=#PNG, ~x=10, ~y=10, ~width=30, ~height=15)
pdf->text("Hello, NashFP", ~x=10, ~y=30)
pdf->save("nashfp.pdf")
