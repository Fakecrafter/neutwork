import std/random
import std/set
import misc

type
  Color* = enum yellow, white, red, orange, blue, green
  Axis = enum xAxis, yAxis, zAxis
  Position* = tuple[x: int, y: int, z: int]
  Piece* = ref object
    pos*: Position
    cx*: Color
    cy*: Color
    cz*: Color
  Cube* = array[8, Piece]

proc rotate(p: Position, rotationMatrix: array[3, array[3, int]]): Position =
  result.x = p.x*rotationMatrix[0][0] + p.y*rotationMatrix[0][1] + p.z*rotationMatrix[0][2]
  result.y = p.x*rotationMatrix[1][0] + p.y*rotationMatrix[1][1] + p.z*rotationMatrix[1][2]
  result.z = p.x*rotationMatrix[2][0] + p.y*rotationMatrix[2][1] + p.z*rotationMatrix[2][2]


proc newSolvedCube*(): Cube =
  let p1: Position = (1,1,1)
  let p2: Position = (1,1,-1)
  let p3: Position = (1,-1,1)
  let p4: Position = (1,-1,-1)
  let p5: Position = (-1,-1,1)
  let p6: Position = (-1,-1,-1)
  let p7: Position = (-1,1,1)
  let p8: Position = (-1,1,-1)
  result[0] = Piece(pos: p1, cx: orange, cy: green, cz: white)
  result[1] = Piece(pos: p2, cx: orange, cy: green, cz: yellow)
  result[2] = Piece(pos: p3, cx: orange, cy: blue,  cz: white)
  result[3] = Piece(pos: p4, cx: orange, cy: blue,  cz: yellow)
  result[4] = Piece(pos: p5, cx: red,    cy: blue,  cz: white)
  result[5] = Piece(pos: p6, cx: red,    cy: blue,  cz: yellow)
  result[6] = Piece(pos: p7, cx: red,    cy: green, cz: white)
  result[7] = Piece(pos: p8, cx: red,    cy: green, cz: yellow)

proc switchColor(p: Piece, a: Axis) =
  case a
  of xAxis:
    let temp = p.cy
    p.cy = p.cz
    p.cz = temp
  of yAxis:
    let temp = p.cx
    p.cx = p.cz
    p.cz = temp
  of zAxis:
    let temp = p.cx
    p.cx = p.cy
    p.cy = temp


# Y-Rotation
proc R*(c: Cube, rotations: int) =
  const rotationY = [[0,0,-1],[0,1,0],[1,0,0]]
  for i in 0 ..< rotations mod 4:
    for piece in c:
      if piece.pos.y == 1:
        piece.pos = rotate(piece.pos, rotationY)
        piece.switchColor(yAxis)

proc L*(c: Cube, rotations: int) =
  const rotationY = [[0,0,-1],[0,1,0],[1,0,0]]
  for i in 0 ..< rotations mod 4:
    for piece in c:
      if piece.pos.y == -1:
        piece.pos = rotate(piece.pos, rotationY)
        piece.switchColor(yAxis)

# Z-Rotation
proc U*(c: Cube, rotations: int) =
  const rotationZ = [[0,-1,0],[1,0,0],[0,0,1]]
  for i in 0 ..< rotations mod 4:
    for piece in c:
      if piece.pos.z == 1:
        piece.pos = rotate(piece.pos, rotationZ)
        piece.switchColor(zAxis)

proc D*(c: Cube, rotations: int) =
  const rotationZ = [[0,-1,0],[1,0,0],[0,0,1]]
  for i in 0 ..< rotations mod 4:
    for piece in c:
      if piece.pos.z == -1:
        piece.pos = rotate(piece.pos, rotationZ)
        piece.switchColor(zAxis)

# X-Rotation
proc F*(c: Cube, rotations: int) =
  const rotationX = [[1,0,0],[0,0,-1],[0,1,0]]
  for i in 0 ..< rotations mod 4:
    for piece in c:
      if piece.pos.x == 1:
        piece.pos = rotate(piece.pos, rotationX)
        piece.switchColor(xAxis)

proc B*(c: Cube, rotations: int) =
  const rotationX = [[1,0,0],[0,0,-1],[0,1,0]]
  for i in 0 ..< rotations mod 4:
    for piece in c:
      if piece.pos.x == -1:
        piece.pos = rotate(piece.pos, rotationX)
        piece.switchColor(xAxis)

proc newSetCube*(scramble: string): Cube =
  result = newSolvedCube()
  for char in scramble:
    case char
    of 'R': R(result, 1)
    of 'L': L(result, 1)
    of 'U': U(result, 1)
    of 'D': D(result, 1)
    of 'F': F(result, 1)
    of 'B': B(result, 1)
    else: discard

proc newRandomCube*(): Cube =
  randomize()
  result = newSolvedCube()
  for i in countup(0,10):
    let r = rand(6)
    case r
    of 0: R(result, rand(3)+1)
    of 1: L(result, rand(3)+1)
    of 2: U(result, rand(3)+1)
    of 3: D(result, rand(3)+1)
    of 4: F(result, rand(3)+1)
    of 5: B(result, rand(3)+1)
    else: discard

proc tileMatchingColor*(a: Piece, b: Piece): int =
  if (a.pos.x, a.pos.y) == (b.pos.x, b.pos.y):
    if a.cx == b.cx:
      result += 1
    if a.cy == b.cy:
      result += 1
  if (a.pos.x, a.pos.z) == (b.pos.x, b.pos.z):
    if a.cx == b.cx:
      result += 1
    if a.cz == b.cz:
      result += 1
  if (a.pos.y, a.pos.z) == (b.pos.y, b.pos.z):
    if a.cz == b.cz:
      result += 1
    if a.cy == b.cy:
      result += 1

proc pieceMatchingColor*(a: Piece, b: Piece): int =
  let apos = toHashSet([a.pos.x,a.pos.y,a.pos.z])
  let bpos = toHashSet([b.pos.x,b.pos.y,b.pos.z])
  if(len(apos * bpos) != 2):
    return 0
  let acolors = toHashSet([a.cx,a.cy,a.cz])
  let bcolors = toHashSet([b.cx,b.cy,b.cz])
  return len(acolors * bcolors)

proc matchingColor*(c: Cube): int =
  for i, pieceA in c:
    for j, pieceB in c:
      if i==j: continue
      result += tileMatchingColor(pieceA, pieceB)


proc checkSolved*(c: Cube): bool =
  for a,b in boxJmp(c,1,2):
    if tileMatchingColor(a,b) != 2: return false
  for a,b in boxJmp(c,2,1):
    if tileMatchingColor(a,b) != 2: return false
  return true

when isMainModule:
  let a = newSolvedCube()
  echo checkSolved(a)
