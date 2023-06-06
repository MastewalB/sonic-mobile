import 'package:flutter/material.dart';
import '../core/constants/colors.dart';
import '../features/profile/presentation/responsive.dart';
import '../models/FollowerLists.dart';
import 'follower_info_card.dart';

class FollowerLists extends StatelessWidget {
  const FollowerLists({
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
                
                "My Followers",
                style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: Colors.white
                    ),
                
                
              ),
            ),
          
            
          ],
        ),
        SizedBox(height: defaultPadding),
        Responsive(
          mobile: FollowerInfoCardGridView(
            crossAxisCount: _size.width < 650 ? 2 : 4,
            childAspectRatio: _size.width < 650 && _size.width > 350 ? 1.3 : 1,
          ),
          tablet: FollowerInfoCardGridView(),
          desktop: FollowerInfoCardGridView(
            childAspectRatio: _size.width < 1400 ? 1.1 : 1.4,
          ),
        ),
      ],
    );
  }
}

class FollowerInfoCardGridView extends StatelessWidget {
  const FollowerInfoCardGridView({
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
        itemCount: demoMyFollowers.length,
        // gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        //   maxCrossAxisExtent: 200,
        //   crossAxisSpacing: 20,
        //   mainAxisSpacing: 10,
        //   childAspectRatio: 1,
        // ),
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(horizontal:4.0),
          child: FollowerInfoCard(info: demoMyFollowers[index]),
        ),
      ),
    );
  }
}