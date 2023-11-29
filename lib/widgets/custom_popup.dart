import 'package:flutter/material.dart';

class CustomPopup extends StatefulWidget {


@override
  State<StatefulWidget> createState() {
    return CustomPopupState();
  }
}
class CustomPopupState extends State<CustomPopup> {


@override
  void initState() {
    super.initState();
   
  }
@override
  Widget build(BuildContext context) {
    return _buildDialogContent();
  }
Container _buildDialogContent() {
    return Container(
    padding: EdgeInsets.all(5.0),
      width: 279.0,
      height: 256.0,
      child: Stack(
        children: <Widget>[
     _buildVideoContainer(),
          Container(
             margin: const EdgeInsets.only(top: 159.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
             //   _buildAvatar(),
                _buildNameAndLocation(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVideoContainer() {
    return Container(
      color: Colors.white,
      height: 172.0,
      child: Stack(
        children: <Widget>[
        
          GestureDetector(
            onTap: () {
            
            },
            child: Stack(
              children: <Widget>[
                Center(
                  child: Image.network('https://scontent.fvte2-2.fna.fbcdn.net/v/t39.30808-6/308603157_639399164189236_9216271096700594871_n.png?_nc_cat=100&ccb=1-7&_nc_sid=e3f864&_nc_eui2=AeESXo1xM2X3lt09hWKbjj9bW-Q5LtWHyN9b5Dku1YfI34qrFv953QgDXkrha7-gYmtHp_iwj6wlXT50e8ALh3G-&_nc_ohc=wccMQwHRyFoAX8FLiY8&_nc_ht=scontent.fvte2-2.fna&oh=00_AfDAXsEAqCGrcKh8p7xfEXE9twQk9P-fNqddGQYPF9LRxg&oe=63EF936D'),
                ),
              
              ],
            ),
          )
        ],
      ),
    );
  }

Expanded _buildNameAndLocation() {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(left: 6.0, top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
        
            Row(
              children: <Widget>[
                    SizedBox(width: 10),
                Icon(
                  Icons.location_on,
                  color: Colors.red,
                  size: 30.0,
                ),
                SizedBox(width: 10),
                Text("Archineer Associates"),
            
              ],
            ),
          ],
        ),
      ),
    );
  }
}