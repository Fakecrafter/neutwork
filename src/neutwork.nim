import std/sequtils
import std/random
type
  Layer = ref object
    inputSize: int
    weights: seq[seq[float64]]
    output: seq[float64]
  Network = seq[Layer]

func calcNeuron(weights: seq[float64], inputs: seq[float64]): float64 =
  for (x, y) in zip(weights, inputs):
    result += x*y
  if result < 0:
    result = 0

proc forwardProp(nn: Network, inputs: seq[float64]): seq[float64] =
  var inputs: seq[float64] = inputs
  for layer in nn:
    for i in 0 ..< layer.inputSize:
      layer.output[i] = calcNeuron(layer.weights[i], inputs)
    inputs = layer.output

proc backwardProp(nn: Network) = discard

proc createRandomNetwork(amount: seq[int]): Network =
  randomize()
  var newLayer: Layer = Layer(inputSize: amount[0])
  # potential to improve those for-loops
  for counter ,layerH in amount:
    if counter == 0: continue
    newLayer.weights = newSeq[seq[float64]](layerH)
    newLayer.output = newSeq[float64](layerH)
    for i in countup(0, layerH-1):
      newLayer.weights[i] = newSeq[float64](newLayer.inputSize)
      for j in countup(0, newLayer.inputSize-1):
        newLayer.weights[i][j] = rand(1.0)
    result.add(newLayer)
    newLayer.inputSize = layerH

when isMainModule:
  let a: Network = createRandomNetwork(@[10, 5, 3])
