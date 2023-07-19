import 'package:sudoku_solver/sudoku_solver.dart';

void main() {
  // List of sudoku puzzles
  const List<String> sudokuPuzzles = [
    "650873090003250008980104357105000000400000002000000503578301026200048900090625081", // 0
    "850002400720000009004000000000107002305000900040000000000080070017000000000036040", // 1
    "005300000800000020070010500400005300010070006003200080060500009004000030000009700", // 2
    "000000000000003085001020000000507000004000100090000000500000073002010000000040009", // 3
  ];

  // create a NxN board filled with 0
  board = List.generate(
    N,
    (_) => List.filled(N, 0, growable: false),
    growable: false,
  );

  // Generate a random sudoku puzzle
  generate(57);

  // fill the board with the choosen sudoku
  // fromString(sudokuPuzzles[1]);

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
