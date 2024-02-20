type
  Color = enum yellow, white, red, orange, blue, green
  Position = tuple[x: int, y: int, z: int]
  Piece = ref object
    pos: Position
    cx: Color
    cy: Color
    cz: Color
  Cube = array[8, Piece]

func rotate(p: Position, rotationMatrix: array[3, array[3, int]]): Position =
  result.x = p.x*rotationMatrix[0][0] + p.y*rotationMatrix[0][1] + p.z*rotationMatrix[0][2]
  result.y = p.x*rotationMatrix[1][0] + p.y*rotationMatrix[1][1] + p.z*rotationMatrix[1][2]
  result.z = p.x*rotationMatrix[2][0] + p.y*rotationMatrix[2][1] + p.z*rotationMatrix[2][2]


proc newSolvedCube(): Cube =
  let p1: Position = (1,1,1)
  let p2: Position = (1,1,-1)
  let p3: Position = (1,-1,1)
  let p4: Position = (1,-1,-1)
  let p5: Position = (-1,1,1)
  let p6: Position = (-1,1,-1)
  let p7: Position = (-1,-1,1)
  let p8: Position = (-1,-1,-1)
  result[0] = Piece(pos: p1, cx: orange, cy: green, cz: white)
  result[1] = Piece(pos: p2, cx: orange, cy: green, cz: yellow)
  result[2] = Piece(pos: p3, cx: orange, cy: blue,  cz: white)
  result[3] = Piece(pos: p4, cx: orange, cy: blue,  cz: yellow)
  result[4] = Piece(pos: p5, cx: red,    cy: blue,  cz: white)
  result[5] = Piece(pos: p6, cx: red,    cy: blue,  cz: yellow)
  result[6] = Piece(pos: p7, cx: red,    cy: green, cz: white)
  result[7] = Piece(pos: p8, cx: red,    cy: green, cz: yellow)

# Y-Rotation
proc R(c: Cube, rotations: int) =
  const rotationY = [[0,0,-1],[0,1,0],[1,0,0]]
  for i in 0 ..< rotations mod 4:
    for piece in c:
      if piece.pos.y == 1:
        piece.pos = rotate(piece.pos, rotationY)

proc L(c: Cube, rotations: int) =
  const rotationY = [[0,0,-1],[0,1,0],[1,0,0]]
  for i in 0 ..< rotations mod 4:
    for piece in c:
      if piece.pos.y == -1:
        piece.pos = rotate(piece.pos, rotationY)

# Z-Rotation
proc U(c: Cube, rotations: int) =
  const rotationZ = [[0,-1,0],[1,0,0],[0,0,1]]
  for i in 0 ..< rotations mod 4:
    for piece in c:
      if piece.pos.z == 1:
        piece.pos = rotate(piece.pos, rotationZ)

proc D(c: Cube, rotations: int) =
  const rotationZ = [[0,-1,0],[1,0,0],[0,0,1]]
  for i in 0 ..< rotations mod 4:
    for piece in c:
      if piece.pos.z == 1:
        piece.pos = rotate(piece.pos, rotationZ)

# X-Rotation
proc F(c: Cube, rotations: int) =
  const rotationX = [[1,0,0],[0,0,-1],[0,1,0]]
  for i in 0 ..< rotations mod 4:
    for piece in c:
      if piece.pos.x == 1:
        piece.pos = rotate(piece.pos, rotationX)

proc B(c: Cube, rotations: int) =
  const rotationX = [[1,0,0],[0,0,-1],[0,1,0]]
  for i in 0 ..< rotations mod 4:
    for piece in c:
      if piece.pos.x == 1:
        piece.pos = rotate(piece.pos, rotationX)

when isMainModule:
  let a = newSolvedCube()
  let b = newSolvedCube()
  if a[0][] == b[0][]:
    echo "hello"
