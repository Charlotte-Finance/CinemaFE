import 'package:cinema_fe/utils/styles/sizes.dart';
import 'package:cinema_fe/utils/styles/sizes/movies.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class LikeButton extends StatelessWidget {
  final bool isLiked;

  const LikeButton({
    Key? key,
    required this.isLiked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Icon unlikedIcon = Icon(
      Icons.favorite_border,
      color: Colors.red,
      size: iconSize(context),
    );
    Icon likedIcon = Icon(
      Icons.favorite,
      color: Colors.red,
      size: iconSize(context),
    );

    Icon shadowIcon = Icon(
      Icons.favorite,
      color: Colors.white.withOpacity(0.2),
      size: iconSize(context),
    );
    return Stack(
      children: [
        SizedBox(
          height: iconContainerSize(context),
          width: iconContainerSize(context),
          child: Center(
            child: shadowIcon,
          ),
        ),
        SizedBox(
          height: iconContainerSize(context),
          width: iconContainerSize(context),
          child: Center(
            child: isLiked ? likedIcon : unlikedIcon,
          ),
        ),
      ],
    );
  }
}
