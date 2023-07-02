import 'package:audioplayers/audioplayers.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'itemModel.dart';

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final player = AudioPlayer();
  late List<ItemModel> items;
  late List<ItemModel> items2;
  late int score;
  late bool gameOver;
  late String final_animation;
  initGame() {
    gameOver = false;
    score = 0;
    items = [
      ItemModel(
          value: 'crying',
          name: 'Game_Crying'.tr(),
          img: Lottie.asset(
            'assets/Animations/crying-emoji.json',
            width: 60,
            height: 60,
            fit: BoxFit.fill,
          )),
      ItemModel(
          value: 'sad',
          name: 'Game_Sad'.tr(),
          img: Lottie.asset(
            'assets/Animations/sad-emoji.json',
            width: 60,
            height: 60,
            fit: BoxFit.fill,
          )),
      ItemModel(
          value: 'happy',
          name: 'Game_Happy'.tr(),
          img: Lottie.asset(
            'assets/Animations/happy-emoji.json',
            width: 60,
            height: 60,
            fit: BoxFit.fill,
          )),
      ItemModel(
          value: 'Laugh',
          name: 'Game_Laughing'.tr(),
          img: Lottie.asset(
            'assets/Animations/laugh-emoji.json',
            width: 60,
            height: 60,
            fit: BoxFit.fill,
          )),
      ItemModel(
          value: 'love',
          name: 'Game_love'.tr(),
          img: Lottie.asset(
            'assets/Animations/love-emoji.json',
            width: 60,
            height: 60,
            fit: BoxFit.fill,
          )),
      ItemModel(
          value: 'sleepy',
          name: 'Game_Sleepy'.tr(),
          img: Lottie.asset(
            'assets/Animations/sleep-emoji.json',
            width: 75,
            height: 75,
            fit: BoxFit.fill,
          )),
      ItemModel(
          value: 'Fear',
          name: 'Game_Fear'.tr(),
          img: Lottie.asset(
            'assets/Animations/fear-emoji.json',
            width: 65,
            height: 65,
            fit: BoxFit.fill,
          )),
      ItemModel(
          value: 'angry',
          name: 'Game_Angry'.tr(),
          img: Lottie.asset(
            'assets/Animations/angry-emoji.json',
            width: 60,
            height: 60,
            fit: BoxFit.fill,
          )),
    ];
    items2 = List<ItemModel>.from(items);

    items.shuffle();
    items2.shuffle();
  }

  @override
  void initState() {
    super.initState();
    initGame();
  }

  @override
  Widget build(BuildContext context) {
    if (items.length == 0) gameOver = true;
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Color(0xFF537895),
        centerTitle: true,
        //backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          'Game_appbar'.tr(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                          text: 'Game_Score'.tr(),
                          style: TextStyle(
                            fontSize: 25.0,
                          )),
                      TextSpan(
                          text: '$score',
                          style: const TextStyle(
                              fontSize: 30.0,
                              color: Colors.teal,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
              if (!gameOver)
                Row(
                  children: [
                    Spacer(),
                    Column(
                      children: items.map((item) {
                        return Container(
                          margin: EdgeInsets.all(5),
                          child: Draggable<ItemModel>(
                            data: item,
                            childWhenDragging: item.img,
                            feedback: item.img,
                            child: item.img,
                          ),
                        );
                      }).toList(),
                    ),
                    Spacer(flex: 2),
                    Column(
                      children: items2.map((item) {
                        return DragTarget<ItemModel>(
                          onAccept: (receivedItem) {
                            if (item.value == receivedItem.value) {
                              setState(() {
                                items.remove(receivedItem);
                                items2.remove(item);
                              });
                              score += 10;
                              item.accepting = false;
                              player.play(AssetSource('Game/true2.wav'));
                            } else {
                              setState(() {
                                score -= 10;
                                item.accepting = false;
                                player.play(AssetSource('Game/wrong.wav'));
                              });
                            }
                          },
                          onWillAccept: (receivedItem) {
                            setState(() {
                              item.accepting = true;
                            });
                            return true;
                          },
                          onLeave: (receivedItem) {
                            setState(() {
                              item.accepting = false;
                            });
                          },
                          builder: (context, acceptedItems, rejectedItems) =>
                              Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: item.accepting
                                        ? Theme.of(context).colorScheme.primary
                                        : Theme.of(context).colorScheme.primary,
                                  ),
                                  alignment: Alignment.center,
                                  height:
                                      MediaQuery.of(context).size.width / 6.5,
                                  width: MediaQuery.of(context).size.width / 3,
                                  margin: EdgeInsets.all(8),
                                  child: Text(
                                    item.name,
                                   style: TextStyle(fontSize: 18,color: Colors.white),


                                  )),
                        );
                      }).toList(),
                    ),
                    Spacer(),
                  ],
                ),
              if (gameOver)
                Center(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Game_Game_over'.tr(),
                          style: Theme.of(context)
                              .textTheme
                              .headline6!
                              .copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red),
                        ),
                      ),
                      const SizedBox(height: 40.0),
                      // Padding(
                      //   padding: const EdgeInsets.all(20.0),
                      //   child: Text(
                      //     result(),
                      //     style: const TextStyle(
                      //         fontSize: 25.0, fontWeight: FontWeight.bold),
                      //   ),
                      // ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Lottie.asset(
                          result() as String,
                        ),
                      ),
                    ],
                  ),
                ),
              if (gameOver)
                Container(
                  height: MediaQuery.of(context).size.width / 10,
                  width: MediaQuery.of(context).size.width / 2,
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(8)),
                  child: TextButton(
                      onPressed: () {
                        setState(() {
                          initGame();
                        });
                      },
                      child: Text(
                        'Game_New_Game'.tr(),
                        style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      )),
                )
            ],
          ),
        ),
      ),
    );
  }

  //Functions:

  result() {
    if (score == 80) {
      player.play(AssetSource('Game/yay.wav'));
      final_animation = 'assets/Animations/game-congrats.json';
      //return 'Game_Awesome'.tr();
      return final_animation;
    } else {
      player.play(AssetSource('Game/fail.wav'));
      final_animation = 'assets/Animations/game-you-can-do-it.json';
      //return 'Game_Can_do_better'.tr();
      return final_animation;
    }
  }
}
