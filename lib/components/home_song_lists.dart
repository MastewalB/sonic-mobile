import 'package:flutter/material.dart';
import '../core/constants/colors.dart';
import '../features/profile/presentation/responsive.dart';
import '../models/files.dart';
import 'home_song_card.dart';

class HomeSongLists extends StatelessWidget {
  const HomeSongLists({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return Column(
      children: [
        
        SizedBox(height: defaultPadding),
        Responsive(
          mobile: HomeSongInfoCardGridView(
            crossAxisCount: _size.width < 650 ? 2 : 4,
            childAspectRatio: _size.width < 650 && _size.width > 350 ? 1.3 : 1,
          ),
          tablet: HomeSongInfoCardGridView(),
          desktop: HomeSongInfoCardGridView(
            childAspectRatio: _size.width < 1400 ? 1.1 : 1.4,
          ),
        ),
      ],
    );
  }
}

class HomeSongInfoCardGridView extends StatelessWidget {
  const HomeSongInfoCardGridView({
    Key? key,
    this.crossAxisCount = 8,
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
          child: HomeSongInfoCard(info: demoMyFiles[index]),
        ),
      ),
    );
  }
}