import 'package:tic_tac_toe/src/application.dart';
import 'package:tic_tac_toe/src/screen/game_board/local_model/xo_player.dart';

class XoCell {
  Player? player;
  AnimationController? animation;

  final int row;
  final int column;

  Color get color => colors[player] ?? Colors.white;

  static double size = getWidth(90) / 3;
  static double padding = 8;

  XoCell(this.row, this.column);
}
