import 'package:flutter/material.dart';
import 'package:flutter_fight_club/fight_result.dart';
import 'package:flutter_fight_club/resources/fight_club_colors.dart';
import 'package:flutter_fight_club/resources/fight_club_images.dart';

class  FightResultWidget extends StatelessWidget {
  final FightResult  fightResult;
  const  FightResultWidget({Key? key, required this.fightResult}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140,
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
                Column(
                  children: [
                    SizedBox(height: 12,),
                    Text("You", style: TextStyle(color: FightClubColors.darkGreyText),),
                    SizedBox(height: 10,),
                    SizedBox(child: Image.asset(FightClubImages.youAvatar), height: 92, width: 92,),
                  ],
                ),
                Center(child: Container(
                  margin: EdgeInsets.only(bottom: 43, top: 53),
                  alignment: Alignment.center,
                  height: 44,
                  padding: EdgeInsets.only(left: 12, right: 12, bottom: 4, top: 4),
                  decoration: BoxDecoration(
                    color: _getColor(fightResult),
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: Text(fightResult.result,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 16 ),
                  ),
                ),
                ),
                Column(
                  children: [
                    SizedBox(height: 12,),
                    Text("Enemy", style: TextStyle(color: FightClubColors.darkGreyText),),
                    SizedBox(height: 10,),
                    SizedBox(child: Image.asset(FightClubImages.enemyAvatar), height: 92, width: 92,),
                  ],
                ),
                              ],
            ),
          ]),
    );
  }

  _getColor(FightResult fightResult) {
    switch(fightResult) {
      case FightResult.won:
        {
            return Colors.green;
        }
      case FightResult.lost:
        {
            return Colors.red;
        }
      case FightResult.draw:
        {
            return Colors.blue;
        }
      default:
        return Colors.transparent;
    }
  }
}
