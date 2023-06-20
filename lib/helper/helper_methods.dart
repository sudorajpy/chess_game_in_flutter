bool isWhite(int index){
  int x = index ~/ 8; //this will give integer division means row
          int y = index % 8; //this will give remainder means column

          bool isWhite = (x + y) % 2 == 0; //alternate colors for each sqaure
          return isWhite;
}