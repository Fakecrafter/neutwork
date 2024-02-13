import neo

type
  Layer = object
    weights: Vector[float64]
    bias: Vector[float64]
    outputs: Vector[float64]
  Network = seq[Layer]
