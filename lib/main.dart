import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tictactoe/CustomDialog.dart';
import 'package:tictactoe/GameButton.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List<GameButton> buttonList;

  var player1;
  var player2;
  var activeplayer ;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    buttonList = doInit();

  }


  List<GameButton> doInit(){

    player1 = List();
    player2 = List();
    activeplayer = 1;


    var gamesButton = <GameButton>[
      new GameButton(id: 1),
      new GameButton(id: 2),
      new GameButton(id: 3),
      new GameButton(id: 4),
      new GameButton(id: 5),
      new GameButton(id: 6),
      new GameButton(id: 7),
      new GameButton(id: 8),
      new GameButton(id: 9),
    ];
    return gamesButton;
  }

  void PlayGame(GameButton gb){
    setState(() {
      if(activeplayer == 1){
        gb.text = "X";
        gb.bg = Colors.red;
        activeplayer = 2;
        player1.add(gb.id);
      }else{
        gb.text = "O";
        gb.bg = Colors.blueAccent;
        activeplayer = 1;
        player2.add(gb.id);
      }
      gb.enable = false;
      int winner = checkWinner();
      if(winner == -1){
        if(buttonList.every((element) => element.text != "")){
          showDialog(
              context: context,
              builder: (_){
                return CustomDialog("Opps ! Game Tied","Play Again, Tap On Reset Button",resetGame);
              }
          );
        }
        // else{
        //   activeplayer == 2 ? autoPlay() : null ;
        // }
      }
    });
  }

  // void autoPlay() {
  //   var emptyCells = new List();
  //   var list = new List.generate(9, (i) => i + 1);
  //   for (var cellID in list) {
  //     if (!(player1.contains(cellID) || player2.contains(cellID))) {
  //       emptyCells.add(cellID);
  //     }
  //   }
  //
  //   var r = new Random();
  //   var randIndex = r.nextInt(emptyCells.length-1);
  //   var cellID = emptyCells[randIndex];
  //   int i = buttonList.indexWhere((p)=> p.id == cellID);
  //   PlayGame(buttonList[i]);
  // }
  //

  int checkWinner(){
    var winner = -1;


    if (player1.contains(1) && player1.contains(2) && player1.contains(3)) {
      winner = 1;
    }
    if (player2.contains(1) && player2.contains(2) && player2.contains(3)) {
      winner = 2;
    }

    // row 2
    if (player1.contains(4) && player1.contains(5) && player1.contains(6)) {
      winner = 1;
    }
    if (player2.contains(4) && player2.contains(5) && player2.contains(6)) {
      winner = 2;
    }

    // row 3
    if (player1.contains(7) && player1.contains(8) && player1.contains(9)) {
      winner = 1;
    }
    if (player2.contains(7) && player2.contains(8) && player2.contains(9)) {
      winner = 2;
    }

    // col 1
    if (player1.contains(1) && player1.contains(4) && player1.contains(7)) {
      winner = 1;
    }
    if (player2.contains(1) && player2.contains(4) && player2.contains(7)) {
      winner = 2;
    }

    // col 2
    if (player1.contains(2) && player1.contains(5) && player1.contains(8)) {
      winner = 1;
    }
    if (player2.contains(2) && player2.contains(5) && player2.contains(8)) {
      winner = 2;
    }

    // col 3
    if (player1.contains(3) && player1.contains(6) && player1.contains(9)) {
      winner = 1;
    }
    if (player2.contains(3) && player2.contains(6) && player2.contains(9)) {
      winner = 2;
    }

    //diagonal
    if (player1.contains(1) && player1.contains(5) && player1.contains(9)) {
      winner = 1;
    }
    if (player2.contains(1) && player2.contains(5) && player2.contains(9)) {
      winner = 2;
    }

    if (player1.contains(3) && player1.contains(5) && player1.contains(7)) {
      winner = 1;
    }
    if (player2.contains(3) && player2.contains(5) && player2.contains(7)) {
      winner = 2;
    }

    if(winner != -1){
      if(winner == 1){
        _countPlayer1 = _countPlayer1 + 1;
        showDialog(
          context: context,
          builder: (_) => CustomDialog("Player 1 Won","Play Again, Tap On Reset Button",resetGame),
        );
      }else{
        _countPlayer2 = _countPlayer2 + 1;
        showDialog(
          context: context,
          builder: (_) => CustomDialog("Player 2 Won","Play Again, Tap On Reset Button",resetGame),
        );
      }
    }
    return winner;
  }


  void resetGame(){
    if(Navigator.canPop(context)){Navigator.pop(context);}
    setState(() {
      buttonList = doInit();
    });
  }

  int _countPlayer1 = 0;
  int _countPlayer2 = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Tic Tac Toe'),),
        body: Column(
          children: [
            Expanded(
              child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio:1 ,
                  ),
                  itemCount: buttonList.length,
                  itemBuilder: (context,int i){
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 100.0,
                        width: 100.0,
                        child: RaisedButton(
                          onPressed: buttonList[i].enable?()=>PlayGame(buttonList[i]):null,
                          child: Text(buttonList[i].text,style: TextStyle(fontSize: 45,color: Colors.white),),
                          color: buttonList[i].bg,
                          disabledColor: buttonList[i].bg,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: BorderSide(color: Colors.black,width: 3)
                          ),
                        ),
                      ),
                    );
                  }
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                new InkWell(
                  onTap: () => resetGame(),
                  child: new Container(
                    width: 100,
                    height: 40.0,
                    decoration: new BoxDecoration(
                      color: Colors.blue[200],
                      border: new Border.all(color: Colors.black, width: 2.0),
                      borderRadius: new BorderRadius.circular(10.0),
                    ),
                    child: new Center(child: new Text('Reset', style: new TextStyle(fontSize: 20.0, color: Colors.black,fontWeight: FontWeight.w500),),),
                  ),
                ),
                new InkWell(
                  onTap: () { resetGame(); _countPlayer1 = 0;_countPlayer2 = 0;},
                  child: new Container(
                    width: 100,
                    height: 40.0,
                    decoration: new BoxDecoration(
                      color: Colors.blue[200],
                      border: new Border.all(color: Colors.black, width: 2.0),
                      borderRadius: new BorderRadius.circular(10.0),
                    ),
                    child: new Center(child: new Text('Reset All', style: new TextStyle(fontSize: 20.0, color: Colors.black,fontWeight: FontWeight.w500),),),
                  ),
                ),
              ],
            ),

            SizedBox(height: 10.0,),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.purple,width: 2),
                      borderRadius: BorderRadius.circular(10.0)
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Player  1 :",style: TextStyle(fontSize: 20),),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: _countPlayer1 == 0 ? Text("$_countPlayer1",style: TextStyle(fontSize: 25,color: Colors.red,fontWeight: FontWeight.bold),): Text("$_countPlayer1",style: TextStyle(fontSize: 25,color: Colors.green,fontWeight: FontWeight.bold),),
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.purple,width: 2),
                      borderRadius: BorderRadius.circular(10.0)
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Player  2 :",style: TextStyle(fontSize: 20),),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: _countPlayer2 == 0 ? Text("$_countPlayer2",style: TextStyle(fontSize: 25,color: Colors.red,fontWeight: FontWeight.bold),): Text("$_countPlayer2",style: TextStyle(fontSize: 25,color: Colors.green,fontWeight: FontWeight.bold),),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0,),
          ],
        )
    );
  }
}

