import 'package:chess_game_in_flutter/components/piece.dart';
import 'package:chess_game_in_flutter/values/colors.dart';
import 'package:flutter/material.dart';

class Square extends StatelessWidget {
  const Square(
      {super.key,
      required this.isWhite,
      required this.piece,
      required this.isSelected, 
      required this.onTap});
  // : _isSelectable = isSelectable;

  final bool isWhite;
  final ChessPiece? piece;
  final bool isSelected;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    Color? squareColor;
    //if selectable, then the square is green
    if (isSelected) {
      squareColor = Colors.green;
    }

    // otherwise it will be white or black
    else {
      squareColor = isWhite ? foregroundColor : backgroundColor;
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: squareColor,
        child: piece != null
            ? Image.asset(
                piece!.imagePath,
                color: piece!.isWhite
                    ? const Color.fromARGB(255, 94, 10, 10)
                    : Color.fromARGB(255, 86, 22, 177),
              )
            : null,
      ),
    );
  }
}
