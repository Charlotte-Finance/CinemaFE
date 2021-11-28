import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class LikeButton extends StatelessWidget {
  final bool isLiked;
  final double width;

  const LikeButton({
    Key? key,
    required this.isLiked,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Icon unlikedIcon = Icon(
      Icons.favorite_border,
      color: Colors.red,
      size: width*0.8,
    );
    Icon likedIcon = Icon(
      Icons.favorite,
      color: Colors.red,
      size: width*0.8,
    );
    Icon shadowIcon = Icon(
      Icons.favorite,
      color: Colors.white.withOpacity(0.2),
      size: width*0.8,
    );
    return Stack(
      children: [
        SizedBox(
          height: width,
          width: width,
          child: Center(
            child: shadowIcon,
          ),
        ),
        SizedBox(
          height: width,
          width: width,
          child: Center(
            child: isLiked ? likedIcon : unlikedIcon,
          ),
        ),
      ],
    );
  }
}
