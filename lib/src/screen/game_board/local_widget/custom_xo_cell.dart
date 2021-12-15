import 'package:animate_do/animate_do.dart';
import 'package:tic_tac_toe/src/application.dart';
import 'package:tic_tac_toe/src/screen/game_board/local_model/local_models.dart';

class CustomXoCell extends StatelessWidget {
  final XoCell xoCell;
  const CustomXoCell(this.xoCell);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.read<GameBoardProvider>().onCellTap(xoCell),
      child: FlipInY(
        animate: false,
        manualTrigger: true,
        controller: (p0) => xoCell.animation = p0,
        child: Container(
          width: XoCell.size - XoCell.padding,
          height: XoCell.size - XoCell.padding,
          decoration: BoxDecoration(
            color: xoCell.color,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                offset: const Offset(4, 4),
                blurRadius: 10,
              )
            ],
          ),
          child: Center(
            child: CustomText(
              text: xoCell.player == null ? '' : enumToString(xoCell.player),
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
