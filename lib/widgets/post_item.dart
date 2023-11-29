import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fms_mobile_app/theme/color.dart';
import 'package:fms_mobile_app/widgets/custom_image.dart';
import 'package:line_icons/line_icons.dart';

class PostItem extends StatefulWidget {
  final String profileImg;
  final String checkin;
  final String checkout;
  final String name;
  final String postImg;

  const PostItem({
    Key? key,
    required this.profileImg,
    required this.name,
    required this.checkin,
    required this.checkout,
    required this.postImg,
  }) : super(key: key);

  @override
  State<PostItem> createState() => _PostItemState();
}

class _PostItemState extends State<PostItem> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(NetworkImage(widget.postImg), context);
    precacheImage(NetworkImage(widget.profileImg), context);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  // Container(
                  //   width: 50,
                  //   height: 50,
                  //   decoration: BoxDecoration(
                  //       shape: BoxShape.circle,
                  //       image: DecorationImage(
                  //           image: NetworkImage(widget.profileImg) ,
                  //           fit: BoxFit.cover)),
                  // ),
                  CustomImage(
                    widget.profileImg,
                    width: 50,
                    height: 50,
                    radius: 20,
                  ),
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
                        Text(
                          widget.name,
                          style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w700,
                              color: primary),
                        ),
                        Text(
                          'ເວລາເຂົ້າວຽກ:   ' + widget.checkin,
                          style: TextStyle(fontSize: 10.sp, color: primary),
                        ),
                        Text(
                          'ເວລາເລີກວຽກ:  ' + widget.checkout,
                          style: TextStyle(fontSize: 10.sp, color: red),
                        ),
                      ],
                    ),
                  )),
                ],
              ),
            ],
          ),
        ),
        Container(
          height: 400,
          decoration: BoxDecoration(
              // image: DecorationImage(
              //     image: NetworkImage(postImg), fit: BoxFit.cover)
              ),
          child: 
          // Image.network(
          //   widget.postImg,
          //   height: 200.h,
          //   width: double.infinity,
          //   fit: BoxFit.cover,
          // ),
               CustomImage(
            widget.postImg,
            width: double.infinity,
            // height: 70,
            radius: 0,
          ),
        ),
      ],
    );
  }
}
