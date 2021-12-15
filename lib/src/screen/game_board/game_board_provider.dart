import 'package:tic_tac_toe/src/application.dart';
import 'package:tic_tac_toe/src/screen/game_board/local_model/local_models.dart';

class GameBoardProvider extends ChangeNotifier {
  Player currentPlayer = Player.X;
  final cells = List.generate(
    3,
    (x) => List.generate(
      3,
      (y) => XoCell(x, y),
    ),
  );

  Color get color => colors[currentPlayer] ?? Colors.white;

  bool get _checkWin {
    bool win = false;
    // row
    for (final row in cells) {
      for (final cell in row) {
        if (cell.player != currentPlayer) break;
        if (cell == row.last) win = true;
      }
    }

    final reversedRows = List.generate(
      3,
      (x) => List.generate(
        3,
        (y) => cells[y][x],
      ),
    );
    // column
    for (final column in reversedRows) {
      for (final cell in column) {
        if (cell.player != currentPlayer) break;
        if (cell == column.last) win = true;
      }
    }

    // diag
    for (var i = 0; i < 3; i++) {
      if (cells[i][i].player != currentPlayer) break;
      if (i == 2) win = true;
    }

    final reversedDiag = cells.map((row) => row.reversed.toList()).toList();
    // reverse diag
    for (var i = 0; i < 3; i++) {
      if (reversedDiag[i][i].player != currentPlayer) break;
      if (i == 2) win = true;
    }

    return win;
  }

  bool get _checkDraw {
    return cells
        .expand((element) => element)
        .every((cell) => cell.player != null);
  }

  void onCellTap(XoCell xoCell) {
    if (xoCell.player != null) return;
    xoCell.player = currentPlayer;
    if (_checkWin) {
      _showDialog(
        'Player ${enumToString(currentPlayer)} is Win',
        'Press to Restart Game',
      );
    } else if (_checkDraw) {
      _showDialog(
        'Draw',
        'Press to Restart Game',
      );
    }
    currentPlayer = currentPlayer == Player.X ? Player.O : Player.X;

    xoCell.animation
      ?..reset()
      ..forward();

    notifyListeners();
  }

  void startAnimation() {
    final expandedList = cells.expand((element) => element);
    for (var i = 0; i < expandedList.length; i++) {
      Future.delayed(Duration(milliseconds: 100 * i), () {
        expandedList.elementAt(i).animation
          ?..reset()
          ..forward();
      });
    }
  }

  void _showDialog(String title, String body) {
    final dialog = AlertDialog(
      title: Text(title),
      content: Text(body),
      actions: [TextButton(onPressed: _restart, child: const Text('restart'))],
    );

    showDialog(
      context: ContextService.context,
      barrierDismissible: false,
      builder: (_) => dialog,
    );
  }

  void _restart() {
    currentPlayer = Player.X;
    cells.expand((element) => element).forEach((cell) => cell.player = null);
    pop();
    startAnimation();
    notifyListeners();
  }
}
