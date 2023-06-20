import 'package:chess_game_in_flutter/components/piece.dart';
import 'package:flutter/material.dart';

class Square extends StatelessWidget {
  const Square({super.key , required this.isWhite , this.piece});

  final bool isWhite;
  final ChessPiece? piece;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: isWhite ? Colors.grey[200] : Colors.grey[500],
    );
  }
}
