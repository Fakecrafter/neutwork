import std/sequtils
import std/random
type
  Layer = object
    inputSize: int
    weights: seq[seq[float64]]
    bias: seq[float64]
  Network = seq[Layer]

func calcNeuron(weights: seq[float64], inputs: seq[float64], bias: float64): float64 =
  result = bias
  for (x, y) in zip(weights, inputs):
    result += x*y

func run(nn: Network, inputs: var seq[float64]): seq[float64] =
  var outputs: seq[float64]
  for layer in nn:
    outputs = @[]
    for i in 0 ..< layer.inputSize:
      outputs.add(calcNeuron(layer.weights[i], inputs, layer.bias[i]))
    inputs = outputs
  result = outputs

proc createRandomNetwork(amount: seq[int]): Network = discard

when isMainModule:
  randomize()
  let a: Network = createRandomNetwork(@[784, 10, 10, 10])
