# Sudoku Solver

[Sudoku](https://en.wikipedia.org/wiki/Sudoku) is a 9×9 matrix filled with numbers 1 to 9 in such a way that every row, column, and sub-matrix (3×3) has each of the digits from 1 to 9. We are presented with a partly filled 9×9 matrix and have to fill every remaining cell in it. e.g, a Sudoku puzzle is given below.

```
8 5 0 | 0 0 2 | 4 0 0
7 2 0 | 0 0 0 | 0 0 9
0 0 4 | 0 0 0 | 0 0 0
- - - - - - - - - - -
0 0 0 | 1 0 7 | 0 0 2
3 0 5 | 0 0 0 | 9 0 0
0 4 0 | 0 0 0 | 0 0 0
- - - - - - - - - - -
0 0 0 | 0 8 0 | 0 7 0
0 1 7 | 0 0 0 | 0 0 0
0 0 0 | 0 3 6 | 0 4 0
```

And its solution is given below.

```
8 5 9 | 6 1 2 | 4 3 7
7 2 3 | 8 5 4 | 1 6 9
1 6 4 | 3 7 9 | 5 2 8
- - - - - - - - - - -
9 8 6 | 1 4 7 | 3 5 2
3 7 5 | 2 6 8 | 9 1 4
2 4 1 | 5 9 3 | 7 8 6
- - - - - - - - - - -
4 3 2 | 9 8 1 | 6 7 5
6 1 7 | 4 2 5 | 8 9 3
5 9 8 | 7 3 6 | 2 4 1
```

You can see that every row, column, and sub-matrix (3×3) includes each digit from 1 to 9 only once. Thus, we can also assume that a Sudoku is considered rightly filled if it meets all of these conditions:

1. In all 9 sub matrices 3×3 the elements should be 1-9, without repetition.
2. In all rows there should be elements between 1-9 , without repetition.
3. In all columns there should be elements between 1-9 , without repetition.

The Sudoku is represented as as `String` which is parsed by the `fillBoard()` function to create a 9x9 Sudoku board.

[Dart](https://dart.dev/) language is used to code the solution. The `solve()` function recursively follows these steps to solve the sudoku:

- If there are no unallocated cells, then the Sudoku is already solved. We will just return true.
- Or else, we will fill an unallocated cell with a digit between 1 to 9 so that there are no conflicts in any of the rows, columns, or the 3×3 sub-matrices.
- Now, we will try to fill the next unallocated cell and if this happens successfully, then we will return true.
- Else, we will come back and change the digit we used to fill the cell. If there is no digit which fulfills the need, then we will just return false as there is no solution to this Sudoku.

The `generate()` function number of digits to remove from the as input can be used to generate a random Sudoku.

# Usage

```dart
void main() {
  // create a 9x9 board filled with 0
  board = List.generate(
    9,
    (_) => List.filled(9, 0, growable: false),
    growable: false,
  );

  // Generate a random sudoku puzzle
  generate(57);
  print('Sudoku Puzzle:');
  printSudoku();

  final stopwatch = Stopwatch()..start();

  if (solve()) {
    print('Sudoku Puzzle Solution:');
    printSudoku();
  } else {
    print("No solution.");
  }

  print('Solution found in: ${stopwatch.elapsed.inMilliseconds} ms');
}
```
