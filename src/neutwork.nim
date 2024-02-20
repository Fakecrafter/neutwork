type
  Layer = object
    weights: seq[float64]
    bias: seq[float64]
    outputs: seq[float64]
  Network = seq[Layer]


func run(nn: Network, inputs: seq[float64]): seq[float64] = discard
