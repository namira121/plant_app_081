import 'package:flutter/material.dart';
import 'package:plant_app_081/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plant_app_081/screens/details/components/icon_card.dart';

class ImageAndIcon extends StatelessWidget {
  const ImageAndIcon({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: kDefaultPadding * 3),
      child: SizedBox(
        height: size.height*0.8,
        child: Row(
          children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: kDefaultPadding*3),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                      onPressed: (){
                        Navigator.pop(context);
                      }, 
                      icon: SvgPicture.asset("assets/icons/back_arrow.svg"),
                      ),
                  ),
                  Spacer(),
                  IconCard(icon: "assets/icons/sun.svg",),
                  IconCard(icon: "assets/icons/icon_2.svg",),
                  IconCard(icon: "assets/icons/icon_3.svg",),
                  IconCard(icon: "assets/icons/icon_4.svg",),
                ],
              ),
            )
          ),
          Container(
            height: size.height *0.8,
            width: size.width*0.75,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(63),
                bottomLeft: Radius.circular(63)
              ),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 10),
                  blurRadius: 60,
                  color: kPrimaryColor.withAlpha((255*0.29).round())
                )
              ],
              image: DecorationImage(
                alignment: Alignment.centerLeft,
                fit: BoxFit.cover,
                image: AssetImage("assets/images/img.png"))
            ),
          )
        ],
        ),
      ),
    );
  }
}