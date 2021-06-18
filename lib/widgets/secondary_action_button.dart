
import 'package:flutter/material.dart';
import 'package:flutter_fight_club/resources/fight_club_colors.dart';

class SecondaryActionButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  const SecondaryActionButton ({Key? key, required this.text, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(color: FightClubColors.darkGreyText, width: 2),
          ),
          margin: const EdgeInsets.only(left: 16, right: 16,),
          height: 40,
          alignment: Alignment.center,
          child: Text(
            text.toUpperCase(),
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 13,
                color: FightClubColors.darkGreyText,
            ),
          ),
        ),
    );
  }
}
