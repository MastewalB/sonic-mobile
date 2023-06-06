import 'package:flutter/material.dart';
import '../core/constants/colors.dart';
import '../features/profile/presentation/responsive.dart';
import '../models/files.dart';
import 'profile_info_card.dart';

class ProfileLists extends StatelessWidget {
  const ProfileLists({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding
            (
              padding: EdgeInsets.all(10),
              child: Text(
                
                "My Playlists",
                style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                
                
              ),
            ),
          
            
          ],
        ),
        SizedBox(height: defaultPadding),
        Responsive(
          mobile: ProfileInfoCardGridView(
            crossAxisCount: _size.width < 650 ? 2 : 4,
            childAspectRatio: _size.width < 650 && _size.width > 350 ? 1.3 : 1,
          ),
          tablet: ProfileInfoCardGridView(),
          desktop: ProfileInfoCardGridView(
            childAspectRatio: _size.width < 1400 ? 1.1 : 1.4,
          ),
        ),
      ],
    );
  }
}

class ProfileInfoCardGridView extends StatelessWidget {
  const ProfileInfoCardGridView({
    Key? key,
    this.crossAxisCount = 4,
    this.childAspectRatio = 1,
  }) : super(key: key);

  final int crossAxisCount;
  final double childAspectRatio;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: demoMyFiles.length,
        // gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        //   maxCrossAxisExtent: 200,
        //   crossAxisSpacing: 20,
        //   mainAxisSpacing: 10,
        //   childAspectRatio: 1,
        // ),
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(horizontal:4.0),
          child: ProfileInfoCard(info: demoMyFiles[index]),
        ),
      ),
    );
  }
}