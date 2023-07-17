import 'package:sudoku_solver/sudoku_solver.dart';

void main() {
  // List of sudoku puzzles
  const List<String> sudokuPuzzles = [
    '65.873.9...325...898.1.43571.5......4.......2......5.35783.1.262...489...9.625.81', // 0
    '85...24..72......9..4.........1.7..23.5...9...4...........8..7..17..........36.4.', // 1
    '..53.....8......2..7..1.5..4....53...1..7...6..32...8..6.5....9..4....3......97..', // 2
    '..............3.85..1.2.......5.7.....4...1...9.......5......73..2.1........4...9', // 3
  ];

  // create a sizexsize board filled with 0
  board = List.generate(
    size,
    (_) => List.filled(size, 0, growable: false),
    growable: false,
  );

  // fill the board with the choosen sudoku
  fillBoard(sudokuPuzzles[1]);

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
