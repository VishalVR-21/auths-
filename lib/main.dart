import 'package:flexit/hello.dart';
import 'package:flexit/phoneauth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const Mainsceen());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or press Run > Flutter Hot Reload in a Flutter IDE). Notice that the
        // counter didn't reset back to zero; the application is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController mobile = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(10),
            child: TextField(
              controller: email,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(hintText: 'Enter your email id'),
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: TextField(
              controller: password,
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(hintText: 'Enter your password'),
            ),
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.all(5),
                  child: ElevatedButton(
                      onPressed: () async {
                        try {
                          var res = await FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                                  email: email.text, password: password.text);
                          if (res == Null) {
                            AlertDialog(
                              title: Text("User cannot be auth"),
                            );
                          } else {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MyWidget()));
                          }
                        } catch (e) {
                          print(e);
                        }
                      },
                      child: Text('Email auth')),
                ),
                ElevatedButton(
                    onPressed: () async {
                      try {
                        var res = await FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                                email: email.text, password: password.text);
                        if (res == Null) {
                          AlertDialog(
                            title: Text("User cannot be auth"),
                          );
                        } else {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MyWidget()));
                        }
                      } catch (e) {
                        print(e);
                      }
                    },
                    child: Text('Create  account')),
              ]),
          // TextField(
          //   keyboardType: TextInputType.number,
          //   controller: mobile,
          //   decoration: InputDecoration(hintText: 'Enter your mobile_number'),
          // ),
        ],
      )),
    );
  }
}

// class GoogleSignIn extends StatefulWidget {
//   GoogleSignIn({Key? key}) : super(key: key);

//   @override
//   _GoogleSignInState createState() => _GoogleSignInState();
// }

// class _GoogleSignInState extends State<GoogleSignIn> {
//   bool isLoading = false;

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return  !isLoading? SizedBox(
//       width: size.width * 0.8,
//       child: OutlinedButton.icon(
//         icon: Icon(Icons.headphones),
//         onPressed: () async {
//           setState(() {
//             isLoading = true;
//           });
//           FirebaseService service = new FirebaseService();
//           try {
//            await service.signInwithGoogle();

//           } catch(e){
//             if(e is FirebaseAuthException){

//             }
//           }
//           setState(() {
//             isLoading = false;
//           });
//         },
//         label: Text(
//           "Authethiacated"
//         ),
//         style: ButtonStyle(
//             backgroundColor:
//                 MaterialStateProperty.all<Color>(Colors.grey),
//             side: MaterialStateProperty.all<BorderSide>(BorderSide.none)),
//       ),
//     ) : CircularProgressIndicator();
//   }
// }

class Mainsceen extends StatelessWidget {
  const Mainsceen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
                child: Text("Email auth"),
                onPressed: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MyHomePage(
                                title: 'Email authertication',
                              )));
                  //   try {
                  //     FirebaseAuth auth = FirebaseAuth.instance;
                  //     await auth.verifyPhoneNumber(
                  //         phoneNumber: "+91" + mobile.text,
                  //         verificationFailed: (error) => print(error),
                  //         codeAutoRetrievalTimeout: (verificationId) => (5),
                  //         verificationCompleted:
                  //             (PhoneAuthCredential credential) async {

                  //         },
                  //         codeSent:
                  //             (String verificationId, int? resendToken) async {
                  //         },
                  //         autoRetrievedSmsCodeForTesting: "True");
                  //   } catch (e) {
                  //     print(e);
                  //   }
                  // }
                }),
            ElevatedButton(
                onPressed: () {
                  var res = GoogleAuthProvider().providerId;
                  var provideed = FirebaseAuth.instance
                      .signInWithProvider(GoogleAuthProvider());
                  if (res == Null) {
                    AlertDialog(
                      title: Text("User cannot be auth"),
                    );
                  } else {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MyWidget()));
                  }
                },
                child: Text('Google auth')),
            ElevatedButton(
                child: Text("Mobile auth"),
                onPressed: () async {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                })
          ]),
    );
  }
}
