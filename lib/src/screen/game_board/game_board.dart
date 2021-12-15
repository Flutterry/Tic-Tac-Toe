import 'package:tic_tac_toe/src/application.dart';
import 'package:tic_tac_toe/src/screen/game_board/local_model/local_models.dart';
import 'package:tic_tac_toe/src/screen/game_board/local_widget/local_widgets.dart';

class GameBoardScreen extends StatefulWidget {
  @override
  State<GameBoardScreen> createState() => _GameBoardScreenState();
}

class _GameBoardScreenState extends State<GameBoardScreen> {
  late GameBoardProvider provider;

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      provider.startAnimation();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    provider = context.watch<GameBoardProvider>();
    return Scaffold(
      backgroundColor: provider.color.withOpacity(0.7),
      appBar: AppBar(
        backgroundColor: provider.color,
        title: const CustomText(
          text: 'Tic Tac Toe',
          color: Colors.white,
          fontSize: 15,
        ),
      ),
      body: Center(
        child: SizedBox(
          width: getWidth(90),
          height: getWidth(90),
          child: Stack(
            children: provider.cells
                .expand((element) => element)
                .map(
                  (cell) => Positioned(
                    left: cell.row * XoCell.size,
                    top: cell.column * XoCell.size,
                    child: CustomXoCell(cell),
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
