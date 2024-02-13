import neo

type
  TurnRange = range[0..4]
  Color = enum yellow, white, red, orange, blue, green
  Piece = ref object
    position: Vector[float64]
    cx: Color
    cy: Color
    cz: Color
  Cube = array[8, Piece]

proc solvedCube(): Cube =
  let v1 = vector(1.0,1.0,1.0)
  let v2 = vector(1.0,1.0,-1.0)
  let v3 = vector(1.0,-1.0,1.0)
  let v4 = vector(1.0,-1.0,-1.0)
  let v5 = vector(-1.0,1.0,1.0)
  let v6 = vector(-1.0,1.0,-1.0)
  let v7 = vector(-1.0,-1.0,1.0)
  let v8 = vector(-1.0,-1.0,-1.0)

  result[0] = Piece(position: v1, cx: orange, cy: green, cz: white)
  result[1] = Piece(position: v2, cx: orange, cy: green, cz: yellow)
  result[2] = Piece(position: v3, cx: orange, cy: blue,  cz: white)
  result[3] = Piece(position: v4, cx: orange, cy: blue,  cz: yellow)
  result[4] = Piece(position: v5, cx: red,    cy: blue,  cz: white)
  result[5] = Piece(position: v6, cx: red,    cy: blue,  cz: yellow)
  result[6] = Piece(position: v7, cx: red,    cy: green, cz: white)
  result[7] = Piece(position: v8, cx: red,    cy: green, cz: yellow)

# Y-Rotation
func R(c: Cube, rotations: int) =
  let rotationY = matrix(@[@[0.0, 0.0, -1.0], @[0.0, 1.0, 0.0], @[1.0, 0.0, 0.0]])
  for i in 0 .. rotations mod 4:
    for piece in c:
      if piece.position[1] == 1.0:
        piece.position *= rotationY

func L(c: Cube, rotations: int) =
  let rotationY = matrix(@[@[0.0, 0.0, -1.0], @[0.0, 1.0, 0.0], @[1.0, 0.0, 0.0]])
  for i in 0 .. rotations mod 4:
    for piece in c:
      if piece.position[1] == -1.0:
        piece.position *= rotationY

# Z-Rotation
func U(c: Cube, rotations: int) =
  let rotationZ = matrix(@[@[0.0, 0.0, 0.0], @[-1.0, 0.0, 0.0], @[0.0, 1.0, 1.0]])
  for i in 0 .. rotations mod 4:
    for piece in c:
      if piece.position[1] == 1.0:
        piece.position *= rotationZ

func D(c: Cube, rotations: int) =
  let rotationZ = matrix(@[@[0.0, 0.0, 0.0], @[-1.0, 0.0, 0.0], @[0.0, 1.0, 1.0]])
  for i in 0 .. rotations mod 4:
    for piece in c:
      if piece.position[1] == 1.0:
        piece.position *= rotationZ

# X-Rotation
func F(c: Cube, rotations: int) =
  let rotationX = matrix(@[@[1.0, 0.0, 0.0],@[0.0, 0.0, -1.0],@[0.0, 1.0, 0.0]])
  for i in 0 .. rotations mod 4:
    for piece in c:
      if piece.position[1] == 1.0:
        piece.position *= rotationX

func B(c: Cube, rotations: int) =
  let rotationX = matrix(@[@[1.0, 0.0, 0.0],@[0.0, 0.0, -1.0],@[0.0, 1.0, 0.0]])
  for i in 0 .. rotations mod 4:
    for piece in c:
      if piece.position[1] == 1.0:
        piece.position *= rotationX



let
  testCube = solvedCube()
  rotationX = matrix(@[@[1.0, 0.0, 0.0], @[0.0, 0.0, -1.0], @[0.0, 1.0, 0.0]])
  rotationY = matrix(@[@[0.0, 0.0, -1.0], @[0.0, 1.0, 0.0], @[1.0, 0.0, 0.0]])
  rotationZ = matrix(@[@[0.0, 0.0, 0.0], @[-1.0, 0.0, 0.0], @[0.0, 1.0, 1.0]])

testCube[0].position *= 3.0
echo testCube[0].position
