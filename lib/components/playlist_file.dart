
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../models/playlist_details.dart';
import '../core/constants/colors.dart';

class PlaylistFiles extends StatelessWidget {
  const PlaylistFiles({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: Colors.black,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding
                  (padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                    
                      child: IconButton(
                        onPressed: (){},
                        icon: const Icon(Icons.play_circle_fill_outlined ,
                        color: Color.fromARGB(179, 78, 161, 213),),
                        iconSize: 65,
            ),
                    
                  ),
          
          SizedBox(
            width: double.infinity,
            child: DataTable(
              columnSpacing: defaultPadding,
              // minWidth: 600,
              columns: [
                DataColumn(
                  label: Text("#",
                  style: TextStyle(
                    color: Color.fromRGBO(255, 255, 255, 0.604),
                  ),)
                  ,
                ),
                DataColumn(
                  label: Text("Title",
                  style: TextStyle(
                    color: Color.fromRGBO(255, 255, 255, 0.604),
                  ),),
                ),
                DataColumn(
                  label: Text("Date",
                  style: TextStyle(
                    color: Color.fromRGBO(255, 255, 255, 0.604),
                  ),),
                ),
                DataColumn(
                  label: Text("Duration",
                  style: TextStyle(
                    color: Color.fromRGBO(255, 255, 255, 0.604),
                  ),),
                ),
              ],
              rows: List.generate(
                demoRecentFiles.length,
                (index) => recentFileDataRow(demoRecentFiles[index]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

DataRow recentFileDataRow(PlaylistDetails fileInfo) {
  return DataRow(
    cells: [
      DataCell(Text("1",
      style: TextStyle(
                    color: Colors.white,
                  ),)),
      DataCell(
        Row(
          children: [
            SvgPicture.asset(
              fileInfo.icon!,
              height: 30,
              width: 30,
              color: Colors.white,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Text(fileInfo.title!,
              style: TextStyle(
                    color: Colors.white,
                  ),),
            ),
          ],
        ),
      ),
      DataCell(Text(fileInfo.date!,
      style: TextStyle(
                    color: Colors.white,
                  ),)),
      DataCell(Text(fileInfo.duration!,
      style: TextStyle(
                    color: Colors.white,
                  ),)),
    ],
  );
}