#9.2.1 Breaking out of loops

i = 0
  while (i < Inf) {
    if (i==20) {
      break }
    else {
      cat ("i equals " , i , "\n")
      i  = i + 1
    }
  }