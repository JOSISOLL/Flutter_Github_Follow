import 'package:flutter/material.dart';
import 'package:github_follow_flutter/pages/following_page.dart';
import 'package:provider/provider.dart';
import 'providers/user_provider.dart';

void main() => runApp(
      ChangeNotifierProvider<UserProvider>(
        create: (_) => UserProvider(),
        lazy: false,
        child: MaterialApp(
          home: MyApp(),
          debugShowCheckedModeBanner: false,
        ),
      ),
    );

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController _controller = TextEditingController();

  void _getUser() {
    if (_controller.text == '') {
      Provider.of<UserProvider>(context, listen: false)
          .setMessage("Please enter your username.");
    } else {
      Provider.of<UserProvider>(context, listen: false)
          .fetchUser(_controller.text)
          .then((value) {
        if (value) {
          print(value);
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => FollowingPage()));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black87,
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 100,
              ),
              Container(
                width: 80,
                height: 80,
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  backgroundImage: NetworkImage(
                      'https://icon-library.net/images/github-icon-png/github-icon-png-29.jpg'),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "Github",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 150,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white.withOpacity(.1)),
                child: TextField(
                  onChanged: (value) {
                    Provider.of<UserProvider>(context).setMessage(null);
                  },
                  controller: _controller,
                  enabled: !Provider.of<UserProvider>(context).isLoading(),
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    errorText: Provider.of<UserProvider>(context).getMessage(),
                    border: InputBorder.none,
                    hintText: "Github Username",
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              MaterialButton(
                onPressed: () {
                  _getUser();
                },
                padding: EdgeInsets.all(20),
                color: Colors.deepOrange,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Align(
                  child: Provider.of<UserProvider>(context).isLoading()
                      ? CircularProgressIndicator(
                          backgroundColor: Colors.orange,
                          strokeWidth: 2,
                        )
                      : Text(
                          "Get Your Following Now",
                          style: TextStyle(color: Colors.white),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
