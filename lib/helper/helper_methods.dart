bool isWhite(int index){
  int row = index ~/ 8; //this will give integer division means row
          int col = index % 8; //this will give remainder means column

          bool isWhite = (row + col) % 2 == 0; //alternate colors for each sqaure
          return isWhite;
}