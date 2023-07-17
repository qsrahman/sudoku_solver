import 'dart:io';

const int size = 9;
late List<List<int>> board;

// List<List<int>> board = [
//   [6, 5, 0, 8, 7, 3, 0, 9, 0],
//   [0, 0, 3, 2, 5, 0, 0, 0, 8],
//   [9, 8, 0, 1, 0, 4, 3, 5, 7],
//   [1, 0, 5, 0, 0, 0, 0, 0, 0],
//   [4, 0, 0, 0, 0, 0, 0, 0, 2],
//   [0, 0, 0, 0, 0, 0, 5, 0, 3],
//   [5, 7, 8, 3, 0, 1, 0, 2, 6],
//   [2, 0, 0, 0, 4, 8, 9, 0, 0],
//   [0, 9, 0, 6, 2, 5, 0, 8, 1],
// ];

// Wikipedia: near-worst case Sudoku
// List<List<int>> board = [
//   [0, 0, 0, 0, 0, 0, 0, 0, 0],
//   [0, 0, 0, 0, 0, 3, 0, 8, 5],
//   [0, 0, 1, 0, 2, 0, 0, 0, 0],
//   [0, 0, 0, 5, 0, 7, 0, 0, 0],
//   [0, 0, 4, 0, 0, 0, 1, 0, 0],
//   [0, 9, 0, 0, 0, 0, 0, 0, 0],
//   [5, 0, 0, 0, 0, 0, 0, 7, 3],
//   [0, 0, 2, 0, 1, 0, 0, 0, 0],
//   [0, 0, 0, 0, 4, 0, 0, 0, 9]
// ];

void fillBoard(String puzzle) {
  // convert the puzzle string to list of numbers with `.` replaced with 0
  List<int> plist = puzzle.split('').map((e) => int.tryParse(e) ?? 0).toList();

  // fill the board
  for (int i = 0; i < size * size; i++) {
    board[i ~/ size][i % size] = plist[i];
  }
}

// check if all cells are filled or not if
// there is any empty cell then return
// the values of row and col accordingly.
({bool isEmpty, int row, int col}) findEmptyCell() {
  for (int i = 0; i < size; i++) {
    for (int j = 0; j < size; j++) {
      if (board[i][j] == 0) {
        // there is one or more empty cells
        return (isEmpty: true, row: i, col: j);
      }
    }
  }
  // all cells are filled in no empty cell
  return (isEmpty: false, row: -1, col: -1);
}

// check if we can put a
// value in a paticular cell or not
bool isValid(int n, int r, int c) {
  // checking in row
  for (int i = 0; i < size; i++) {
    if (board[r][i] == n) {
      return false; //there is a cell with same value
    }
  }
  // checking column
  for (int i = 0; i < size; i++) {
    if (board[i][c] == n) {
      return false; //there is a cell with the value
    }
  }
  // checking 3x3 sub board
  int rowStart = (r ~/ 3) * 3;
  int colStart = (c ~/ 3) * 3;

  for (int i = rowStart; i < rowStart + 3; i++) {
    for (int j = colStart; j < colStart + 3; j++) {
      if (board[i][j] == n) {
        return false; // there is a cell with the value
      }
    }
  }
  return true;
}

// solve sudoku using backtracking/ recursion
bool solve() {
  var cell = findEmptyCell();

  // if there is no empty cells then the sudoku is already solved
  if (!cell.isEmpty) {
    return true;
  }
  // an empty cell was found

  // number between 1 to 9
  for (int n = 1; n <= size; n++) {
    // if we can assign n to the cell or not
    // the cell is board[row][col]
    if (isValid(n, cell.row, cell.col)) {
      board[cell.row][cell.col] = n;

      // backtracking
      if (solve()) {
        return true;
      }
      // if we can't proceed with this solution
      // reassign the cell
      board[cell.row][cell.col] = 0;
    }
  }
  return false;
}

// display sudoku
void printSudoku() {
  for (int i = 0; i < size; i++) {
    if (i % 3 == 0 && i != 0) {
      stdout.writeln('- - - - - - - - - - -');
    }
    for (int j = 0; j < size; j++) {
      if (j % 3 == 0 && j != 0) {
        stdout.write('| ');
      }
      if (j == 8) {
        stdout.writeln('${board[i][j]}');
      } else {
        stdout.write('${board[i][j]} ');
      }
    }
  }
  stdout.write('\n');
}
