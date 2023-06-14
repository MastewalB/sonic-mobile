import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../models/RecordFile.dart';
import '../core/constants/colors.dart';

class RecordFiles extends StatelessWidget {
  const RecordFiles({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Container(
        decoration: BoxDecoration(
          color: secondaryColor,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
                width: 300,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Recording",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    Container(
                      padding: EdgeInsets.all(5),
                      height: 80.0,
                      width: 280.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(7)),
                      color: Colors.blueGrey,),
                      
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Recording",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  "Recording",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white),
                                ),
                                Text(
                                  "Recording",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white),
                                ),
                              ],
                            )
                          ]),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "fileInfo.title!",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                        Text(
                          "fileInfo.title!",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ],
                    )
                  ],
                )),
          ],
        ),
      ),
    );
  }
}

DataRow recordFileDataRow(RecordFile fileInfo) {
  return DataRow(
    cells: [
      DataCell(
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                fileInfo.title!,
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
      DataCell(Text(
        fileInfo.duration!,
        style: TextStyle(color: const Color.fromARGB(145, 255, 255, 255)),
      )),
      DataCell(
        IconButton(
          onPressed: () {
            // Add your logic here to delete the audio file
            print('Audio file deleted');
          },
          icon: Icon(
            Icons.delete,
            size: 32,
            color: Colors.red,
          ),
        ),
      ),
    ],
  );
}
