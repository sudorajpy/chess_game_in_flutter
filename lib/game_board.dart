import 'package:chess_game_in_flutter/components/piece.dart';
import 'package:chess_game_in_flutter/components/square.dart';
import 'package:chess_game_in_flutter/helper/helper_methods.dart';
import 'package:chess_game_in_flutter/values/colors.dart';
import 'package:flutter/material.dart';

class GameBoard extends StatefulWidget {
  const GameBoard({super.key});

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  // A 2d list representing the chess board
  // with each position probably having a chess piece
  late List<List<ChessPiece?>> board;

  // the currently selected piece on the board
  // if no piece is selected then this will be null
  ChessPiece? selectedPiece;

  //the row index of the selected piece
  // default value -1 indicate no piece is selected
  int selectedRow = -1;

  //the column index of the selected piece
  // default value -1 indicate no piece is selected
  int selectedColumn = -1;

  // a list of valid moves for the selected piece
  // each move is represented as a list with 2 elements: row, col
  List<List<int>> validMoves = [];

  @override
  void initState() {
    super.initState();
    _initializeBoard();
  }

  // initialize the board
  void _initializeBoard() {
    // initialize the board with null values, meaning no chess piece is present
    List<List<ChessPiece?>> newBoard =
        List.generate(8, (index) => List.generate(8, (index) => null));

    //place the pawns
    for (int i = 0; i < 8; i++) {
      newBoard[1][i] = ChessPiece(
          type: ChessPieceType.pawn,
          isWhite: false,
          imagePath: 'assets/images/pawn.png');
      newBoard[6][i] = ChessPiece(
          type: ChessPieceType.pawn,
          isWhite: true,
          imagePath: 'assets/images/pawn.png');
    }

    //place the rooks
    newBoard[0][0] = ChessPiece(
        type: ChessPieceType.rook,
        isWhite: false,
        imagePath: 'assets/images/rook.png');
    newBoard[0][7] = ChessPiece(
        type: ChessPieceType.rook,
        isWhite: false,
        imagePath: 'assets/images/rook.png');
    newBoard[7][0] = ChessPiece(
        type: ChessPieceType.rook,
        isWhite: true,
        imagePath: 'assets/images/rook.png');
    newBoard[7][7] = ChessPiece(
        type: ChessPieceType.rook,
        isWhite: true,
        imagePath: 'assets/images/rook.png');

    //place the knights
    newBoard[0][1] = ChessPiece(
        type: ChessPieceType.knight,
        isWhite: false,
        imagePath: 'assets/images/knight.png');
    newBoard[0][6] = ChessPiece(
        type: ChessPieceType.knight,
        isWhite: false,
        imagePath: 'assets/images/knight.png');
    newBoard[7][1] = ChessPiece(
        type: ChessPieceType.knight,
        isWhite: true,
        imagePath: 'assets/images/knight.png');
    newBoard[7][6] = ChessPiece(
        type: ChessPieceType.knight,
        isWhite: true,
        imagePath: 'assets/images/knight.png');

    //place the bishops
    newBoard[0][2] = ChessPiece(
        type: ChessPieceType.bishop,
        isWhite: false,
        imagePath: 'assets/images/bishop.png');
    newBoard[0][5] = ChessPiece(
        type: ChessPieceType.bishop,
        isWhite: false,
        imagePath: 'assets/images/bishop.png');
    newBoard[7][2] = ChessPiece(
        type: ChessPieceType.bishop,
        isWhite: true,
        imagePath: 'assets/images/bishop.png');
    newBoard[7][5] = ChessPiece(
        type: ChessPieceType.bishop,
        isWhite: true,
        imagePath: 'assets/images/bishop.png');

    //place the queens
    newBoard[0][3] = ChessPiece(
        type: ChessPieceType.queen,
        isWhite: false,
        imagePath: 'assets/images/queen.png');
    newBoard[7][3] = ChessPiece(
        type: ChessPieceType.queen,
        isWhite: true,
        imagePath: 'assets/images/queen.png');
    //place the kings
    newBoard[0][4] = ChessPiece(
        type: ChessPieceType.king,
        isWhite: false,
        imagePath: 'assets/images/king.png');
    newBoard[7][4] = ChessPiece(
        type: ChessPieceType.king,
        isWhite: true,
        imagePath: 'assets/images/king.png');

    setState(() {
      board = newBoard;
    });
  }

  // user selected a piece
  void pieceSelected(int row, int col) {
    setState(() {
      // selected a piece if there is a piece in that index
      if (board[row][col] != null) {
        selectedPiece = board[row][col];
        selectedRow = row;
        selectedColumn = col;
      }

      //if a piece is selected calculate valid moves
      validMoves =
          calculatedRawValidMoves(selectedColumn, selectedRow, selectedPiece);
    });
  }

  //calculate raw valid moves
  List<List<int>> calculatedRawValidMoves(int row, int col, ChessPiece? piece) {
    List<List<int>> candidateMoves = [];

    //diffrent directions based their color
    int direction = piece!.isWhite ? -1 : 1;

    switch (piece.type) {
      case ChessPieceType.pawn:
        // pawn can move forword if the square is not occupied
        if (isInBoard(row + direction, col) &&
            board[row + direction][col] == null) {
          candidateMoves.add([row + direction, col]);
        }

        //pawn can move 2 squares forword if they are at their initial stage
       if ((row == 1 && piece.isWhite) || (row == 6 && !piece.isWhite)) {
          if (isInBoard(row + 2 * direction, col) &&
              board[row + 2 * direction][col] == null &&
              board[row + direction][col] == null) {
            candidateMoves.add([row + 2 * direction, col]);
          }
        }
        
        // pawn can kill diagnolly
        if (isInBoard(row + direction, col - 1) &&
            board[row + direction][col - 1] != null &&
            board[row + direction][col - 1]!.isWhite) {
          candidateMoves.add([row + direction, col - 1]);
        }
        if (isInBoard(row + direction, col + 1) &&
            board[row + direction][col + 1] != null &&
            board[row + direction][col + 1]!.isWhite) {
          candidateMoves.add([row + direction, col + 1]);
        }

        break;
      case ChessPieceType.rook:
        break;
      case ChessPieceType.knight:
        break;
      case ChessPieceType.bishop:
        break;
      case ChessPieceType.queen:
        break;
      case ChessPieceType.king:
        break;
      default:
    }

    return candidateMoves;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor,
        body: GridView.builder(
            itemCount: 8 * 8,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 8),
            itemBuilder: (context, index) {
              //get the row and column number of this square
              int row = index ~/ 8; //this will give integer division means row
              int col = index % 8; //this will give remainder means column

              //check if this square is selected
              bool isSelected = selectedRow == row && selectedColumn == col;

              //check if this sqaure is a valid move
              bool isValidMove = false;
              for (var position in validMoves) {
                //compare row and colums
                if (position[0] == row && position[1] == col) {
                  isValidMove = true;
                }
              }

              return Square(
                isSelected: isSelected,
                isValidMove: isValidMove,
                isWhite: isWhite(index),
                piece: board[row][col],
                onTap: () => pieceSelected(row, col),
              );
            }));
  }
}
