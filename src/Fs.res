@module("fs") @val external readFileBase64: (string, @as("base64") _) => string = "readFileSync"
