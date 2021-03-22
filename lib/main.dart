import 'package:flutter/material.dart';
import 'package:tictactoe/dialog.dart';
import './game_button.dart';

void main()=> runApp(MyApp());

class MyApp extends StatelessWidget{
  Widget build(BuildContext context){
    return MaterialApp(
      title: "Tic Tac Toe",
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.deepOrange,
        accentColor: Colors.deepOrangeAccent,
      ),
      home: MyHome(),
    );
  }
}

class MyHome extends StatefulWidget{
  MyHomeState createState() => MyHomeState();
}

class MyHomeState extends State<MyHome>{

List<gameButton> gameButtonList;
var player1;
var player2;
var activePlayer;

void initState(){
  super.initState();
  gameButtonList = doInit();
}

List<gameButton> doInit(){
  player1 = [];
  player2 = [];
  activePlayer = 1;

  var gameButtons = <gameButton>[
   gameButton(id: 1),
   gameButton(id: 2),
   gameButton(id: 3),
   gameButton(id: 4),
   gameButton(id: 5),
   gameButton(id: 6),
   gameButton(id: 7),
   gameButton(id: 8),
   gameButton(id: 9),
  ];
  return gameButtons;
}

void playGame(gameButton gb){
  setState(() {
    if(activePlayer == 1){
      gb.text = "X";
      gb.bg = Colors.red;
      activePlayer = 2;
      player1.add(gb.id);
    }
    else{
      gb.text = "O";
      gb.bg = Colors.black;
      activePlayer = 1;
      player2.add(gb.id);
    }
    gb.enabled = false;
    int winner = checkWinner();

    if( winner==-1 && gameButtonList.every((p)=>p.text !=""))
  {
    showDialog(
        context: context,
        builder: (_) => CustomDialog("Game Tied","Press the reset button to start again", resetGame)
      );
  }

});

}

int checkWinner(){
  var winner = -1;
  if(player1.contains(1) && player1.contains(2) && player1.contains(3))
  winner = 1;
  if(player1.contains(4) && player1.contains(5) && player1.contains(6))
  winner = 1;
  if(player1.contains(7) && player1.contains(8) && player1.contains(9))
  winner = 1;
  if(player1.contains(1) && player1.contains(4) && player1.contains(7))
  winner = 1;
  if(player1.contains(2) && player1.contains(5) && player1.contains(8))
  winner = 1;
  if(player1.contains(3) && player1.contains(6) && player1.contains(9))
  winner = 1;
  if(player1.contains(1) && player1.contains(5) && player1.contains(9))
  winner = 1;
  if(player1.contains(3) && player1.contains(5) && player1.contains(7))
  winner = 1;
  if(player2.contains(1) && player2.contains(2) && player2.contains(3))
  winner = 2;
  if(player2.contains(4) && player2.contains(5) && player2.contains(6))
  winner = 2;
  if(player2.contains(7) && player2.contains(8) && player2.contains(9))
  winner = 2;
  if(player2.contains(1) && player2.contains(4) && player2.contains(7))
  winner = 2;
  if(player2.contains(2) && player2.contains(5) && player2.contains(8))
  winner = 2;
  if(player2.contains(3) && player2.contains(6) && player2.contains(9))
  winner = 2;
  if(player2.contains(1) && player2.contains(5) && player2.contains(9))
  winner = 2;
  if(player2.contains(3) && player2.contains(5) && player2.contains(7))
  winner = 2;

  if(winner != -1)
  {
    if(winner == 1){
      showDialog(
        context: context,
        builder: (_) => CustomDialog("Player 1 won","Press the reset button to start again", resetGame)
      );
    }else
    {
      showDialog(
        context: context,
        builder: (_) => CustomDialog("Player 2 won","Press the reset button to start again", resetGame)
      );
    }

  }
return winner;
}

void resetGame(){
  if(Navigator.canPop(context)) Navigator.pop(context);
  setState(() {
    gameButtonList = doInit();
  });
}

  Widget build(BuildContext context){
    return  Scaffold(
      appBar:  AppBar(
        title:  Text("Tic Tac Toe"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.refresh),onPressed: resetGame)
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(bottom: 20.0),
          ),
          Center(
            child: Text("Turn of Player $activePlayer", style: TextStyle(
              fontSize: 20.0,color: Colors.red, fontStyle: FontStyle.italic
            ), 
            ),
            ),
         Padding(
            padding: EdgeInsets.only(bottom: 30.0),
          ),
         Expanded(
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1.0,
              crossAxisSpacing: 9.0,
              mainAxisSpacing: 9.0,
            ),
            itemCount: gameButtonList.length,
            itemBuilder: (context,i)=> SizedBox(
              height: 100.0,
              width: 100.0,
              child: ElevatedButton(
                child: Text(gameButtonList[i].text, style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
                ),
                onPressed:gameButtonList[i].enabled? ()=> playGame(gameButtonList[i]) : null,
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(gameButtonList[i].bg),
                ),
                // color: gameButtonList[i].bg,
                // disabledColor: gameButtonList[i].bg,
              ),
            ),
          ),
        ),
        ],
      ),
    );
  }
}
