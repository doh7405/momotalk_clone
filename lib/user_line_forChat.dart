import 'package:flutter/material.dart';

class UserLineForChat extends StatelessWidget {
  const UserLineForChat({
    super.key,
    required this.name,
    required this.url,
    required this.lastMessage,
  });
  final String name;
  final String url;
  final String lastMessage;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xffF3F7F8),
      padding: const EdgeInsets.all(8),
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
                    lastMessage,
                    style: const TextStyle(color: Color(0xff737B7E)),
                  )
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
