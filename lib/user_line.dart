import 'package:flutter/material.dart';

class UserLine extends StatelessWidget {
  const UserLine(
      {super.key,
      required this.abra,
      required this.like,
      required this.name,
      required this.url});
  final String abra;
  final int like;
  final String name;
  final String url;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(url),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [Text(name)],
                ),
                Text(abra)
              ],
            )
          ],
        ),
        Text(like.toString())
      ],
    );
  }
}
