import unittest
import ../src/cube

test "checkSolved on solvedCube":
  check checkSolved(newSolvedCube()) == true
test "checkSolved on setCube":
  check checkSolved(newSetCube("RULLL")) == false
test "checkSolved on randomCube":
  check checkSolved(newRandomCube()) == false
test "Rotate Once":
  let c = newSolvedCube()
  c.R(1)
  c.R(1)
  check checkSolved(c) == false
  c.R(1)
  c.R(1)
  check checkSolved(c) == true
test "Rotate Twice":
  let c = newSolvedCube()
  c.R(2)
  check checkSolved(c) == false
  c.R(2)
  check checkSolved(c) == true
test "Rotate Thrice":
  let c = newSolvedCube()
  c.R(3)
  c.R(3)
  check checkSolved(c) == false
  c.R(3)
  c.R(3)
  check checkSolved(c) == true
test "Rotate Zero":
  let c = newSolvedCube()
  c.R(0)
  check checkSolved(c) == true
test "Rotate Four":
  let c = newSolvedCube()
  c.R(4)
  check checkSolved(c) == true
test "tileMatchingColor parallel same color":
  let a = Piece(pos: (1,1,1), cx: white, cy: white, cz: green)
  let b = Piece(pos: (1,1,0), cx: white, cy: white, cz: blue)
  check tileMatchingColor(a,b) == 2
test "tileMatchingColor unparallel same color":
  let a = Piece(pos: (1,1,1), cx: white, cy: white, cz: green)
  let b = Piece(pos: (0,0,0), cx: white, cy: white, cz: blue)
  check tileMatchingColor(a,b) == 0
test "tileMatchingColor parallel same color wrong sides":
  let a = Piece(pos: (1,1,1), cx: white, cy: white, cz: green)
  let b = Piece(pos: (1,1,0), cx: blue, cy: white, cz: white)
  check tileMatchingColor(a,b) == 1
test "tileMatchingColor parallel wrong color":
  let a = Piece(pos: (1,1,1), cx: yellow, cy: white, cz: green)
  let b = Piece(pos: (0,1,1), cx: white, cy: yellow, cz: blue)
  check tileMatchingColor(a,b) == 0
test "matchingColor on solvedCube":
  let c = newSolvedCube()
  check matchingColor(c) == 48
test "matchingColor on halfSolvedCube":
  let c = newSolvedCube()
  c.R(2)
  check matchingColor(c) == 32
test "matchingColor on quarterSolvedCube":
  let c = newSolvedCube()
  c.R(2)
  c.F(2)
  check matchingColor(c) == 24
