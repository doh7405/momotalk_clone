import 'package:flutter/material.dart';

class OptionDialogForChat extends StatefulWidget {
  const OptionDialogForChat({super.key, required this.changeState});
  final Function changeState;

  @override
  State<OptionDialogForChat> createState() => _OptionDialogForChatState();
}

class _OptionDialogForChatState extends State<OptionDialogForChat> {
  List<bool> selectColor = [false, false];
  String selectedOption = "chatTime";
  String selectedCondition = "최신";

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 0.0,
      insetPadding: EdgeInsets.only(
          top: 101.0,
          bottom: MediaQuery.of(context).size.height / 1.8,
          right: 10.0,
          left: 10.0),
      contentPadding: const EdgeInsets.all(0.0),
      content: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.shade500,
                    blurRadius: 2.0,
                    spreadRadius: 0.5,
                    offset: const Offset(0, 1.5))
              ]),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                    height: 50,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 10.0),
                              child: Text(
                                "정렬",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: const Icon(
                                  Icons.close,
                                  color: Color(0xff2B4463),
                                ))
                          ],
                        ),
                        const Divider(
                          color: Color(0xffE4EAEA),
                          height: 1.0,
                        )
                      ],
                    )),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _makeButton("최신", 0),
                          const SizedBox(
                            width: 5.0,
                          ),
                          _makeButton("안 읽음", 1),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                    height: 57.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Divider(
                          color: Color(0xffE4EAEA),
                          height: 1.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0, top: 8.0),
                          child: SizedBox(
                              height: 37,
                              width:
                                  MediaQuery.of(context).size.width / 1.15 + 5,
                              child: OutlinedButton(
                                  onPressed: () {
                                    widget.changeState(
                                        selectedOption, selectedCondition);
                                    Navigator.pop(context);
                                  },
                                  style: OutlinedButton.styleFrom(
                                    side: const BorderSide(
                                        color: Color(0xffE0E0DE)),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(3),
                                    ),
                                  ),
                                  child: const Center(
                                      child: Text(
                                    "확인",
                                    style: TextStyle(
                                        color: Color(0xff46617E),
                                        fontWeight: FontWeight.bold),
                                  )))),
                        ),
                      ],
                    ))
              ])),
    );
  }

  Widget _makeButton(String text, int idx) {
    return SizedBox(
        height: 40,
        width: MediaQuery.of(context).size.width / 2.3,
        child: OutlinedButton(
            onPressed: () {
              if (idx == 0) {
                selectedOption = "chatTime";
                selectedCondition = "최신";
              } else {
                selectedOption = "isRead";
                selectedCondition = "안 읽음";
              }
              setState(() {
                selectColor = [false, false];
                selectColor[idx] = true;
              });
            },
            style: OutlinedButton.styleFrom(
              backgroundColor:
                  selectColor[idx] ? const Color(0xffF46F8C) : Colors.white,
              side: const BorderSide(color: Color(0xffF2F4F3)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(3),
              ),
            ),
            child: Center(
                child: Text(
              text,
              style: TextStyle(
                  color:
                      selectColor[idx] ? Colors.white : const Color(0xffB9BABE),
                  fontWeight: FontWeight.bold),
            ))));
  }
}
