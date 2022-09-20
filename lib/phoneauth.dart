import 'package:firebase_auth/firebase_auth.dart';
import 'package:flexit/hello.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController otpController = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  bool otpVisibility = false;
  User? user;
  String verificationID = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: (() => {Navigator.pop(context)}))
        ],
        backgroundColor: Colors.blue,
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: phoneController,
              decoration: InputDecoration(
                hintText: 'Phone Number',
                prefix: Padding(
                  padding: EdgeInsets.all(4),
                  child: Text('+91'),
                ),
              ),
              maxLength: 10,
              keyboardType: TextInputType.phone,
            ),
            Visibility(
              child: TextField(
                controller: otpController,
                decoration: InputDecoration(
                  hintText: 'OTP',
                  prefix: Padding(
                    padding: EdgeInsets.all(4),
                    child: Text(''),
                  ),
                ),
                maxLength: 6,
                keyboardType: TextInputType.number,
              ),
              visible: otpVisibility,
            ),
            SizedBox(
              height: 10,
            ),
            MaterialButton(
              color: Colors.blue,
              onPressed: () {
                if (otpVisibility) {
                  verifyOTP();
                } else {
                  loginWithPhone();
                }
              },
              child: Text(
                otpVisibility ? "Verify" : "Login",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void loginWithPhone() async {
    auth.verifyPhoneNumber(
      phoneNumber: "+91" + phoneController.text,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await auth.signInWithCredential(credential).then((value) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => MyWidget()));
          print("You are logged in successfully");
        });
      },
      verificationFailed: (FirebaseAuthException e) {
        print(e.message);
      },
      codeSent: (String verificationId, int? resendToken) {
        otpVisibility = true;
        verificationID = verificationId;
        setState(() {});
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  void verifyOTP() async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationID, smsCode: otpController.text);

    await auth.signInWithCredential(credential).then(
      (value) {
        setState(() {
          user = FirebaseAuth.instance.currentUser;
        });
      },
    ).whenComplete(
      () {
        if (user != null) {
          AlertDialog(title: Text("You are logged in successfully"));
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const MyWidget()));
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const MyWidget(),
            ),
          );
        } else {}
      },
    );
  }
}
