import 'package:chess_game_in_flutter/components/piece.dart';
import 'package:chess_game_in_flutter/values/colors.dart';
import 'package:flutter/material.dart';

class Square extends StatelessWidget {
  const Square(
      {super.key,
      required this.isWhite,
      required this.piece,
      required this.isSelected,
      required this.onTap,
      required this.isValidMove});
  // : _isSelectable = isSelectable;

  final bool isWhite;
  final ChessPiece? piece;
  final bool isSelected;
  final void Function()? onTap;
  final bool isValidMove;

  @override
  Widget build(BuildContext context) {
    Color? squareColor;
    //if selectable, then the square is green
    if (isSelected) {
      squareColor = Colors.green;
    } else if (isValidMove) {
      squareColor = Colors.green[300];
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
                    ? Colors.white
                    : Colors.black // if the piece is black, then color it black
              )
            : null,
      ),
    );
  }
}
