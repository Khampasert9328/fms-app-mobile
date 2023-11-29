import 'package:flutter/material.dart';

import 'package:shimmer/shimmer.dart';

class TeamItemShimmer extends StatelessWidget {
  const TeamItemShimmer({super.key});



  @override
  Widget build(BuildContext context) => Shimmer.fromColors(
      baseColor: Color(0xFFBDBDBD),
      highlightColor: Color(0xFFE0E0E0),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                          width: 50,
                          height: 50,
                          decoration: ShapeDecoration(
                              color: Colors.grey[400]!, shape: CircleBorder())),
                      SizedBox(
                        width: 15,
                      ),
                      Center(
                          child: Container(
                        alignment: Alignment.centerLeft,
                        // color: Colors.red,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                width: 250,
                                height: 10,
                                decoration: ShapeDecoration(
                                    color: Colors.grey[400]!,
                                    shape: RoundedRectangleBorder())),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                                    width: 250,
                                height: 10,
                                decoration: ShapeDecoration(
                                    color: Colors.grey[400]!,
                                    shape: RoundedRectangleBorder())),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                                 width: 250,
                                height: 10,
                                decoration: ShapeDecoration(
                                    color: Colors.grey[400]!,
                                    shape: RoundedRectangleBorder())),
                          ],
                        ),
                      )),
                    ],
                  ),
                ],
              ),
            ),
         
          ],
        ),
      ));
}
