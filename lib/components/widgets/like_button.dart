import 'package:cinema_fe/utils/sizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Icon unlikedIcon = Icon(
  Icons.favorite_border,
  color: Colors.red,
  size: iconSize,
);
Icon likedIcon = Icon(
  Icons.favorite,
  color: Colors.red,
  size: iconSize,
);

Icon shadowIcon = Icon(
  Icons.favorite,
  color: Colors.white.withOpacity(0.2),
  size: iconSize,
);

class LikeButton extends StatelessWidget {
  final bool isLiked;

  const LikeButton({
    Key? key,
    required this.isLiked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: iconContainerSize,
          width: iconContainerSize,
          child: Center(
            child: shadowIcon,
          ),
        ),
        SizedBox(
          height: iconContainerSize,
          width: iconContainerSize,
          child: Center(
            child: isLiked ? likedIcon : unlikedIcon,
          ),
        ),
      ],
    );
  }
}
