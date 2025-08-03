import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'game_screen.dart';

void main() {
  runApp(const TicTacToeApp());
}

class TicTacToeApp extends StatelessWidget {
  const TicTacToeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => GameProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Tic-Tac-Toe',
        theme: ThemeData(
          primaryColor: Colors.teal,
          scaffoldBackgroundColor: Colors.grey[100],
          textTheme: const TextTheme(
            headlineMedium: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.teal),
            bodyMedium: TextStyle(fontSize: 18, color: Colors.black87),
          ),
        ),
        home: const GameScreen(),
      ),
    );
  }
}

class GameProvider with ChangeNotifier {
  List<String> board = List.filled(9, '');
  String currentPlayer = 'X';
  String? winner;
  bool isDraw = false;
  List<int> winningCells = [];

  void makeMove(int index) {
    if (board[index] == '' && winner == null && !isDraw) {
      board[index] = currentPlayer;
      checkWinner();
      if (winner == null && !isDraw) {
        currentPlayer = currentPlayer == 'X' ? 'O' : 'X';
      }
      notifyListeners();
    }
  }

  void checkWinner() {
    const winningCombinations = [
      [0, 1, 2], [3, 4, 5], [6, 7, 8], // Rows
      [0, 3, 6], [1, 4, 7], [2, 5, 8], // Columns
      [0, 4, 8], [2, 4, 6], // Diagonals
    ];

    for (var combo in winningCombinations) {
      if (board[combo[0]] != '' &&
          board[combo[0]] == board[combo[1]] &&
          board[combo[1]] == board[combo[2]]) {
        winner = board[combo[0]];
        winningCells = combo;
        notifyListeners();
        return;
      }
    }

    if (!board.contains('')) {
      isDraw = true;
      notifyListeners();
    }
  }

  void resetGame() {
    board = List.filled(9, '');
    currentPlayer = 'X';
    winner = null;
    isDraw = false;
    winningCells = [];
    notifyListeners();
  }
}