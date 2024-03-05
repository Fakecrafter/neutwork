iterator boxJmp*[T](a: openArray[T], delay: int, steps = 1): tuple[a: T, b: T] =
  var counter = 0
  while counter < a.len:
    if counter+delay < a.len:
      yield (a[counter], a[counter+delay])
    else:
      yield (a[counter], a[counter+delay-a.len])
    counter += steps


when isMainModule:
  let seq = @[1,2,3,4,5,6,7]
  for a,b in boxJmp(seq,2,2):
    echo a,b
