import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
void main() => runApp(MyApp());


class MyApp extends StatefulWidget {
  @override
  MyAppState createState() => MyAppState();
}
class MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  bool isAuthenticated = false;
  String textValue = "Hello World!!";
  FirebaseMessaging firebaseMessaging = new FirebaseMessaging();
  @override
  void initState() {
    firebaseMessaging.configure(
      onLaunch: (Map<String, dynamic> msg) {
        print("onLaunch called");
      },
      onResume: (Map<String, dynamic> msg) {
        print("onResume called");
      },
      onMessage: (Map<String, dynamic> msg) {
        print("onMessage called"+msg.values.join());
      }
    );
    firebaseMessaging.requestNotificationPermissions(
      const IosNotificationSettings(
        sound: true,
        alert: true,
        badge: true
      )
    );
    firebaseMessaging.onIosSettingsRegistered.listen((IosNotificationSettings iosnotificationSetting) {
      print("IOS SETTINGS REGISTERED");
    });
    firebaseMessaging.getToken().then((token) {
      update(token);
    });
  }

  update(String token) {
    print(token);
    textValue =  token;
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        canvasColor: Colors.white,
        primaryColor: Color(0xFF354BA5),
      ),
      // home: isAuthenticated ? Home() : Login());
      home: Scaffold(
        appBar: AppBar(title: Text('Login')),
        body: Login(),
      ),
    );
  }
}



class Login extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(
              'Welcome',
              style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(
              'Sign in to continue',
              style: TextStyle(
                  fontSize: 30.0,
                  color: Color(0xAA354BA5),
                  fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: TextFormField(
              decoration: InputDecoration(
                  labelText: 'Username',
                  // labelStyle: TextStyle(fontSize: 20.0, fontWeight: FontWeight.normal)
                ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter some text';
                }
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: TextFormField(
              decoration: InputDecoration(
                  labelText: 'Password',
                  // labelStyle: TextStyle(fontSize: 20.0, fontWeight: FontWeight.normal)
                      ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter some text';
                }
              },
            ),
          ),
          Center(
            child: ButtonTheme(
              padding: EdgeInsets.symmetric(vertical: 15),
              minWidth: 400,
              height: 30,
              buttonColor: Color(0xFF354BA5),
              
                child: RaisedButton(
              onPressed: () {
                // Validate will return true if the form is valid, or false if
                // the form is invalid.
                if (_formKey.currentState.validate()) {
                  // Process data.
                }
              },
              child: Text('Submit',
                  style:
                      TextStyle(fontSize: 20.0, color: Colors.white, fontWeight: FontWeight.w500)),
            )),
          ),
          Center(
            child: ButtonTheme(
              padding: EdgeInsets.symmetric(vertical: 15),
              minWidth: 400,
              height: 30,
              buttonColor: Color(0xFFFFFFFF),
              child: RaisedButton(
              onPressed: () {
              Scaffold.of(context).showSnackBar(new SnackBar(
                content: new Text("Redirecting To Login"),
              ));
              },
              child: Text("New User? SignUp",style:
                      TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),),
            ),
            )
          ),
        ],
      ),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Home',
        home: Scaffold(
            appBar: AppBar(
              title: Text('Home'),
            ),
            body: Text('Home')));
  }
}
