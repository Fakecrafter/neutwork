type
  Layer = object
    weights: seq[float64]
    bias: seq[float64]
    outputs: seq[float64]
  Network = seq[Layer]
