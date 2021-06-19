import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_fight_club/fight_result.dart';
import 'package:flutter_fight_club/resources/fight_club_colors.dart';
import 'package:flutter_fight_club/resources/fight_club_icons.dart';
import 'package:flutter_fight_club/resources/fight_club_images.dart';
import 'package:flutter_fight_club/widgets/action_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FightPage extends StatefulWidget {
  const FightPage({Key? key}) : super(key: key);

  @override
  FightPageState createState() => FightPageState();
}

class FightPageState extends State<FightPage> {
  BodyPart? defendingBodyPart;
  BodyPart? attackingBodyPart;

  BodyPart whatEnemyAttacks = BodyPart.random();
  BodyPart whatEnemyDefends = BodyPart.random();

  static const maxLives = 5;

  int yourLives = maxLives;
  int enemysLives = maxLives;
  String textMoveResult = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: FightClubColors.background ,
        body: SafeArea(
          child: Column(
            children: [
              FightersInfo(maxLivesCount: maxLives,
                yourLivesCount: yourLives,
                enemyLivesCount: enemysLives,
              ),
              //SizedBox(height: 30,),
              Expanded(child: Padding(padding: EdgeInsets.only(left: 16, right: 16, bottom: 30, top: 30),
                child: SizedBox(height: double.infinity, width: double.infinity,
                  child: ColoredBox(color: Color(0xFFC5D1EA,
                  ),child: Center(child: Text(textMoveResult, textAlign: TextAlign.center,),),),
                ),
              )
              ),

              //SizedBox(height: 30,),
              ControlsWidget(
                  defendingBodyPart: defendingBodyPart,
                  selectDefendingBodyPart: _selectDefendingBodyPart,
                  attackingBodyPart: attackingBodyPart,
                  selectAttackingBodyPart: _selectAttackingBodyPart),
              SizedBox(height: 14,),
              ActionButton(text: yourLives == 0 || enemysLives == 0 ? "Back": "Go",
                onTap: _onGoButtonClicked,
                color: getGoButtonColor(),
              ),

              SizedBox(height: 16 ,),
            ],
          ),
        ));
  }

  Color getGoButtonColor() {
    if (yourLives == 0 || enemysLives == 0) {
      return FightClubColors.blackButton;
    }
    else if (attackingBodyPart == null || defendingBodyPart == null) {
      return FightClubColors.greyButton;
    }
    else {
      return FightClubColors.blackButton;
    }
  }

  void _onGoButtonClicked()
  {
    if(enemysLives == 0 || yourLives == 0) {
        Navigator.of(context).pop();
    }
    else if(attackingBodyPart != null && defendingBodyPart != null) {
      setState(() {
        final bool enemyLoseLife = attackingBodyPart != whatEnemyDefends;
        final bool youLoseLife = defendingBodyPart != whatEnemyAttacks;
        if(enemyLoseLife) {
          enemysLives = enemysLives - 1;
        }
        if(youLoseLife){
          yourLives = yourLives - 1;
        }
        final FightResult? fightResult = FightResult.calculateResult(yourLives, enemysLives);
        if(fightResult != null){
          SharedPreferences.getInstance().then((sharedPreferences) {
              sharedPreferences.setString("last_fight_result", fightResult.result);
          });
          }
        textMoveResult = _calculateCenterText(youLoseLife, enemyLoseLife);
        whatEnemyDefends = BodyPart.random();
        whatEnemyAttacks = BodyPart.random();
        attackingBodyPart = null;
        defendingBodyPart = null;
      });
    }
  }

  void _selectDefendingBodyPart(final BodyPart value) {
    if(yourLives == 0 || enemysLives == 0  ){
      return;
    }
    setState(() {
      defendingBodyPart = value;
    });
  }



  void _selectAttackingBodyPart(final BodyPart value) {
    if(yourLives == 0 || enemysLives == 0){
      return;
    }
    setState(() {
      attackingBodyPart = value;
    });
  }

  String _calculateCenterText(final bool youLoseLife, final bool enemyLoseLife ) {
    if(enemysLives == 0 && yourLives == 0){
      return "Draw";
    }
    else if (enemysLives == 0)
      return "You won";
    else if (yourLives == 0)
      return "You lost";
    final String first = enemyLoseLife
    ? "You hit enemy's ${attackingBodyPart!.name.toLowerCase()}."
        : "Your attack was blocked.";
    final String second = youLoseLife
    ? "You hit enemy's ${attackingBodyPart!.name.toLowerCase()}."
        : "Enemy's attack was blocked.";
    return "$first\n$second";
  }
}

class FightersInfo extends StatelessWidget {
  final int maxLivesCount;
  final int yourLivesCount;
  final int enemyLivesCount;

  const FightersInfo({
    Key? key,
    required this.maxLivesCount,
    required this.yourLivesCount,
    required this.enemyLivesCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: Stack(
          children: [
            Row(crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(child: ColoredBox(color: Colors.white)),
                Expanded(child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.white, FightClubColors.darkPurple,],
                    ),
                  ),
                ),
                ),
                Expanded(child: ColoredBox(color: FightClubColors.darkPurple))],),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                LivesWidget(overallLivesCount: maxLivesCount,
                    currentLivesCount: yourLivesCount),

                Column(
                  children: [
                    SizedBox(height: 16,),
                    Text("You", style: TextStyle(color: FightClubColors.darkGreyText),),
                    SizedBox(height: 12,),
                    SizedBox(child: Image.asset(FightClubImages.youAvatar), height: 92, width: 92,),
                  ],
                ),
                SizedBox(height: 44, width: 44, child: DecoratedBox(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: FightClubColors.blueButton,

                  ), child: Center(child: Text("vs", style: TextStyle(color: Colors.white, fontSize: 16 ),)),
                ),
                ),
                Column(
                  children: [
                    SizedBox(height: 16,),
                    Text("Enemy", style: TextStyle(color: FightClubColors.darkGreyText),),
                    SizedBox(height: 12,),
                    SizedBox(child: Image.asset(FightClubImages.enemyAvatar), height: 92, width: 92,),
                  ],
                ),
                LivesWidget(overallLivesCount: maxLivesCount,
                    currentLivesCount: enemyLivesCount),
              ],
            ),
          ]),
    );
  }
}


class ControlsWidget extends StatelessWidget {
  final BodyPart? defendingBodyPart;
  final ValueSetter<BodyPart> selectDefendingBodyPart;
  final BodyPart? attackingBodyPart;
  final ValueSetter<BodyPart> selectAttackingBodyPart;

  const ControlsWidget({Key? key,
    required this.defendingBodyPart,
    required this.selectDefendingBodyPart,
    required this.attackingBodyPart,
    required this.selectAttackingBodyPart})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 16,
        ),
        Expanded(
          child: Column(
            children: [
              Text("Defend".toUpperCase(), style: TextStyle(color: FightClubColors.darkGreyText),),
              SizedBox(
                height: 13,
              ),
              BodyPartButton(
                bodyPart: BodyPart.head,
                selected: defendingBodyPart == BodyPart.head,
                bodyPartSetter: selectDefendingBodyPart,
              ),
              SizedBox(
                height: 14,
              ),
              BodyPartButton(
                  bodyPart: BodyPart.torso,
                  selected: defendingBodyPart == BodyPart.torso,
                  bodyPartSetter: selectDefendingBodyPart),
              SizedBox(
                height: 14,
              ),
              BodyPartButton(
                  bodyPart: BodyPart.legs,
                  selected: defendingBodyPart == BodyPart.legs,
                  bodyPartSetter: selectDefendingBodyPart),
            ],
          ),
        ),
        SizedBox(
          width: 12,
        ),
        Expanded(
          child: Column(
            children: [
              Text("Attack".toUpperCase(), style: TextStyle(color: FightClubColors.darkGreyText),),
              SizedBox(
                height: 13,
              ),
              BodyPartButton(
                bodyPart: BodyPart.head,
                selected: attackingBodyPart == BodyPart.head,
                bodyPartSetter: selectAttackingBodyPart,
              ),
              SizedBox(
                height: 14,
              ),
              BodyPartButton(
                bodyPart: BodyPart.torso,
                selected: attackingBodyPart == BodyPart.torso,
                bodyPartSetter: selectAttackingBodyPart,
              ),
              SizedBox(
                height: 14,
              ),
              BodyPartButton(
                bodyPart: BodyPart.legs,
                selected: attackingBodyPart == BodyPart.legs,
                bodyPartSetter: selectAttackingBodyPart,
              ),
            ],
          ),
        ),
        SizedBox(
          width: 16,
        ),
      ],
    );
  }
}




class LivesWidget extends StatelessWidget {
  final int overallLivesCount;
  final int currentLivesCount;
  const LivesWidget({
    Key? key,
    required this.overallLivesCount,
    required this.currentLivesCount,
  }) : assert(overallLivesCount >= 1),
        assert(currentLivesCount >= 0),
        assert(currentLivesCount <= overallLivesCount),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(overallLivesCount, (index) {
        if(index<currentLivesCount && index < overallLivesCount-1)
        {
          return Column(
            children: [
              Image.asset(FightClubIcons.heartFull, width: 18, height: 18,),
              SizedBox(height: 4, width: 4,)
            ],);
          // else  if(index == (overallLivesCount-1)) return Image.asset(FightClubIcons.heartFull, width: 18, height: 18,);
        }
        else if(index<currentLivesCount && index == overallLivesCount-1)
        {
          return Image.asset(FightClubIcons.heartFull, width: 18, height: 18,);
          // else  if(index == (overallLivesCount-1)) return Image.asset(FightClubIcons.heartFull, width: 18, height: 18,);
        }
        else {
          if(index < overallLivesCount-1){
            return Column(
              children: [
                Image.asset(FightClubIcons.heartEmpty, width: 18, height: 18,),
                SizedBox(height: 4, width: 4,)
              ],);
          }
          else return Image.asset(FightClubIcons.heartEmpty, width: 18, height: 18,);
        }
      }),
    );
  }
}

class BodyPart {
  final String name;

  const BodyPart._(this.name);

  static const head = BodyPart._("Head");
  static const torso = BodyPart._("Torso");
  static const legs = BodyPart._("Legs");

  @override
  String toString() {
    return 'BodyPart{name: $name}';
  }

  static const List<BodyPart> _values = [head, torso, legs];
  static BodyPart random()
  {
    return _values[Random().nextInt(_values.length)];

  }
}

class BodyPartButton extends StatelessWidget {
  final BodyPart bodyPart;
  final bool selected;
  final ValueSetter<BodyPart> bodyPartSetter;

  const BodyPartButton({
    Key? key,
    required this.bodyPart,
    required this.selected,
    required this.bodyPartSetter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => bodyPartSetter(bodyPart),
        child: SizedBox(
          height: 40,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: selected ? FightClubColors.blueButton: Colors.transparent,
              border: !selected ? Border.all(color: FightClubColors.darkGreyText, width: 2) : null,
            ),

            child: Center(child: Text(bodyPart.name.toUpperCase(),
                style: TextStyle(color: selected ? FightClubColors.whiteText : FightClubColors.darkGreyText,)),
            ),
          ),
        )
    );
  }
}
