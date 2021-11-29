import 'package:cinema_fe/models/user.dart';
import 'package:cinema_fe/utils/styles/icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserPage extends StatefulWidget {
  final User user;

  const UserPage({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {

  @override
  Widget build(BuildContext context) {
    double profileWidth = 200;
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Profile"),
        leading: IconButton(
          icon: backArrow,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              widget.user.character != null
                  ? Container(
                      width: profileWidth,
                      height: profileWidth,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: AssetImage('lib/assets/characters/${widget.user.character!}.jpg'),
                            fit: BoxFit.cover,
                        ),
                      ),
                    )
                  : Container(
                      height: profileWidth,
                      width: profileWidth,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(profileWidth),
                        border: Border.all(
                          width: 3,
                          color: Colors.orange,
                          style: BorderStyle.solid,
                        ),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.person,
                          color: Colors.orange,
                          size: 180,
                        ),
                      ),
                    ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.025,
              ),
              Text(
                widget.user.firstname! + " " + widget.user.name!,
                style: const TextStyle(color: Colors.orange, fontSize: 30),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
