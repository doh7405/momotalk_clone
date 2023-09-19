import 'package:flutter/material.dart';

class OptionDialog extends StatefulWidget {
  const OptionDialog({super.key});

  @override
  State<OptionDialog> createState() => _OptionDialogState();
}

class _OptionDialogState extends State<OptionDialog> {
  List<bool> selectColor = [false, false, false, false];

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
                    color: Colors.grey.shade300,
                    blurRadius: 0.5,
                    spreadRadius: 0.5,
                    offset: const Offset(0, 1.5))
              ]),
          child: Column(children: [
            const SizedBox(
                height: 50,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Text("정렬"), Icon(Icons.close)],
                    ),
                    Divider(
                      color: Color(0xffE4EAEA),
                      height: 1.0,
                    )
                  ],
                )),
            Expanded(
                child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _makeButton("이름", 0),
                    _makeButton("학원", 1),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _makeButton("인연랭크", 2),
                    _makeButton("셀렉트", 3),
                  ],
                )
              ],
            )),
            SizedBox(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Divider(
                  color: Color(0xffE4EAEA),
                  height: 1.0,
                ),
                SizedBox(
                    height: 30,
                    width: MediaQuery.of(context).size.width - 70,
                    child: OutlinedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Color(0xffE0E0DE)),
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
              ],
            ))
          ])),
    );
  }

  Widget _makeButton(String text, int idx) {
    return SizedBox(
        height: 30,
        width: 120,
        child: OutlinedButton(
            onPressed: () {
              setState(() {
                selectColor = [false, false, false, false];
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
