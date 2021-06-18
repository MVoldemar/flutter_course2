import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fight_club/resources/fight_club_colors.dart';
import 'package:flutter_fight_club/widgets/secondary_action_button.dart';

class StatisticsPage extends StatelessWidget {
  const StatisticsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FightClubColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(left: 16, right: 16, top: 24),
              child: Text("Statistics", style: TextStyle(fontSize: 24, color: FightClubColors.darkGreyText), textAlign: TextAlign.center,),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 40,
                    child: Text("1", textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: FightClubColors.darkGreyText,),),
                  ),
                  SizedBox(height: 6,),
                  SizedBox(
                    height: 40,
                    child: Text("2", textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: FightClubColors.darkGreyText, ),),
                  ),
                  SizedBox(height: 6,),
                  SizedBox(
                    child: Text("3", textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: FightClubColors.darkGreyText, ),),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16,),
              child: SecondaryActionButton(text: "Back", onTap:(){
                Navigator.of(context).pop();
              }),
            ),
          ],
        ),
      ),
    );
  }
}
