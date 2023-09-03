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
    return Container(
      margin: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(url),
              ),
              const SizedBox(
                width: 10.0,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        name,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  Text(
                    abra,
                    style: const TextStyle(color: Color(0xff737B7E)),
                  )
                ],
              )
            ],
          ),
          Stack(
            alignment: const Alignment(0.0, 0.0),
            children: [
              const Icon(
                Icons.favorite_rounded,
                size: 35.0,
                color: Color(0xffF1B7D0),
              ),
              const Icon(
                Icons.favorite_border_rounded,
                size: 38.0,
                color: Color(0xffD488B7),
              ),
              Stack(
                children: [
                  Text(
                    like.toString(),
                    style: TextStyle(
                        fontSize: 15.0,
                        foreground: Paint()
                          ..style = PaintingStyle.stroke
                          ..strokeWidth = 1.2
                          ..color = Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    like.toString(),
                    style: const TextStyle(
                        fontSize: 15.0, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
