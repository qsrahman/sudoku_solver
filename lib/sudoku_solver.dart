import 'dart:io';
import 'dart:math';

final int N = 9;
// ignore: non_constant_identifier_names
final int SRN = sqrt(N).floor();
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

// Returns true if given row contains n.
bool numberInRow(int r, int n) {
  for (int c = 0; c < N; c++) {
    if (board[r][c] == n) {
      return true;
    }
  }
  return false;
}

// Returns true if given column contains n.
bool numberInCol(int c, int n) {
  for (int r = 0; r < N; r++) {
    if (board[r][c] == n) {
      return true;
    }
  }
  return false;
}

// Returns true if given 3 x 3 block contains n.
bool numberInBox(int rowStart, int colStart, int n) {
  for (int r = 0; r < SRN; r++) {
    for (int c = 0; c < SRN; c++) {
      if (board[rowStart + r][colStart + c] == n) {
        return true;
      }
    }
  }
  return false;
}

// Check if it is ok to put n in cell r, c
bool isSafe(int r, int c, int n) {
  return (!numberInRow(r, n) &&
      !numberInCol(c, n) &&
      !numberInBox(r - r % SRN, c - c % SRN, n));
}

// check if we can put a
// value in a paticular cell or not
// bool isSafe0(int n, int r, int c) {
//   // checking in row
//   for (int i = 0; i < N; i++) {
//     if (board[r][i] == n) {
//       return false; //there is a cell with same value
//     }
//   }
//   // checking column
//   for (int i = 0; i < N; i++) {
//     if (board[i][c] == n) {
//       return false; //there is a cell with the value
//     }
//   }
//   // checking 3x3 sub board
//   int rowStart = (r ~/ 3) * 3;
//   int colStart = (c ~/ 3) * 3;

//   for (int i = rowStart; i < rowStart + 3; i++) {
//     for (int j = colStart; j < colStart + 3; j++) {
//       if (board[i][j] == n) {
//         return false; // there is a cell with the value
//       }
//     }
//   }
//   return true;
// }

// check if all cells are filled or not if
// there is any empty cell then return
// the values of row and col accordingly.
({bool isEmpty, int row, int col}) findEmptyCell() {
  for (int i = 0; i < N; i++) {
    for (int j = 0; j < N; j++) {
      if (board[i][j] == 0) {
        // there is one or more empty cells
        return (isEmpty: true, row: i, col: j);
      }
    }
  }
  // all cells are filled in no empty cell
  return (isEmpty: false, row: -1, col: -1);
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
  for (int n = 1; n <= N; n++) {
    // if we can assign n to the cell or not
    // the cell is board[row][col]
    if (isSafe(cell.row, cell.col, n)) {
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

// A recursive function to fill remaining board
bool fillRemaining(int i, int j) {
  if (j >= N && i < N - 1) {
    i = i + 1;
    j = 0;
  }

  if (i >= N && j >= N) {
    return true;
  }

  if (i < SRN) {
    if (j < SRN) {
      j = SRN;
    }
  } else if (i < N - SRN) {
    if (j == (i ~/ SRN) * SRN) {
      j = j + SRN;
    }
  } else {
    if (j == N - SRN) {
      i = i + 1;
      j = 0;
      if (i >= N) {
        return true;
      }
    }
  }

  for (int n = 1; n <= N; n++) {
    if (isSafe(i, j, n)) {
      board[i][j] = n;
      if (fillRemaining(i, j + 1)) {
        return true;
      }
      board[i][j] = 0;
    }
  }
  return false;
}

// Remove the count no. of digits to complete board
void removeKDigits(int count) {
  while (count != 0) {
    int idx = Random().nextInt(N * N);

    // extract coordinates i and j
    int r = idx ~/ N;
    int c = idx % 9;

    if (c != 0) {
      c = c - 1;
    }
    if (board[r][c] != 0) {
      count--;
      board[r][c] = 0;
    }
  }
}

/*
  Following is the logic for generating the sudoku board.
  1. Fill all the diagonal 3x3 matrices.
  2. Fill recursively rest of the non-diagonal matrices.
    For every cell to be filled, we try all numbers until we
    find a safe number to be placed.
  3. Once matrix is fully filled, randomly remove K elements.
  */
void generate([int K = 31]) {
  int n;
  // Fill the diagonal SRN number of SRN x SRN matrices
  for (int h = 0; h < N; h += SRN) {
    // for diagonal box, start coordinates->r==c
    // Fill a SRN x SRN matrix.
    for (int i = 0; i < SRN; i++) {
      for (int j = 0; j < SRN; j++) {
        do {
          n = Random().nextInt(9) + 1;
        } while (numberInBox(h, h, n));
        board[h + i][h + j] = n;
      }
    }
  }

  // Fill remaining blocks
  fillRemaining(0, SRN);

  // Remove Randomly K digits to make game
  removeKDigits(K);
}

void fromString(String puzzle) {
  // convert the puzzle string to list of numbers.
  // var plist = puzzle.split('').map((e) => int.tryParse(e) ?? 0).toList();
  var plist = puzzle.split('').map((e) => int.parse(e)).toList();

  // fill the board
  for (int i = 0; i < N * N; i++) {
    board[i ~/ N][i % N] = plist[i];
  }
}

// display sudoku
void printSudoku() {
  for (int i = 0; i < N; i++) {
    if (i % 3 == 0 && i != 0) {
      stdout.writeln('- - - - - - - - - - -');
    }
    for (int j = 0; j < N; j++) {
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
