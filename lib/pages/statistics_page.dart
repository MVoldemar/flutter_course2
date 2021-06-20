import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fight_club/resources/fight_club_colors.dart';
import 'package:flutter_fight_club/widgets/secondary_action_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StatisticsPage extends StatelessWidget {

  const StatisticsPage({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int? won;
    int? lost;
    int? draw;
    return Scaffold(
      backgroundColor: FightClubColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(left: 16, right: 16, top: 24),
              child: Text(
                "Statistics",
                style: TextStyle(
                    fontSize: 24, color: FightClubColors.darkGreyText),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: FutureBuilder<int?>(
                future:
                    SharedPreferences.getInstance().then((sharedPreferences) {
                  won = sharedPreferences.getInt("stats_won") == null ? 0
                      : sharedPreferences.getInt("stats_won");
                  lost = sharedPreferences.getInt("stats_lost") == null ? 0
                      : sharedPreferences.getInt("stats_lost");
                  draw = sharedPreferences.getInt("stats_draw") == null ? 0
                      : sharedPreferences.getInt("stats_draw");
                }),
                builder: (context, snapshot) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 40,
                        child: Text(
                          "Won: $won",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color: FightClubColors.darkGreyText,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 6,
                      ),

                      SizedBox(
                        height: 40,
                        child: Text(
                          "Draw: $draw",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color: FightClubColors.darkGreyText,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      SizedBox(
                        height: 40,
                        child: Text(
                          "Lost: $lost",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color: FightClubColors.darkGreyText,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                bottom: 16,
              ),
              child: SecondaryActionButton(
                  text: "Back",
                  onTap: () {
                    Navigator.of(context).pop();
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
