import 'package:flutter/material.dart';
import '../../constants/colors.dart';

Widget postPart() {
  return SizedBox(
    height: 150,
    child: Card(
      elevation: 10,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: TextFormField(
                    decoration: InputDecoration(
                        fillColor: MyColors.myGray,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        hintText: "What do you think name !?"),
                  ),
                )),
                const CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage("assets/photo.jpg"),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 1,
              color: MyColors.myGray,
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: const [
                Expanded(
                    child: Center(
                        child: Text(
                  "Felling/Activation 😮",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                ))),
                Expanded(
                    child: Center(
                        child: Text(
                  "Share Friends 🤝",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                ))),
                Expanded(
                    child: Center(
                        child: Text(
                  "Image/Videos 🎞",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                ))),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
