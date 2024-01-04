import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:melakago_web/view/redeem.dart';
import '../Model/tourismService.dart';



void main(){
  runApp(const MaterialApp(
    home:signIn(),
  ));
}

class signIn extends StatefulWidget {
  const signIn({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<signIn> {
  late final tourismService company;
  TextEditingController emailController = TextEditingController();

  void _checkAdmin() async{

    final List<tourismService> services= [];

    final String email = emailController.text.trim();

    //oii wafir
    if ( email.isNotEmpty) {

      //_AlertMessage("success");

      tourismService company = tourismService.getEmail (email);

      if (await company.checkCompanyExistence()){
        setState(() {
          emailController.clear();
        });

        _showMessage("LogIn Successful");

          Navigator.push(context, MaterialPageRoute(builder: (context)=>Redeem(company:company, initialIndex: 1)));
      }
      else{
        _AlertMessage("EMAIL OR PASSWORD WRONG!");
      }
    }
    else{
      _AlertMessage("Please Insert All The Information Needed");
      setState(() {

        emailController.clear();

      });

    }
  }


  void _AlertMessage(String msg) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Message"),
          content: Text(msg),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  void _showMessage(String msg){
    if(mounted){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(msg),
        ),
      );
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90,
        title: Center(
          child: const Text(
            'Welcome To MelakaGo',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35.0),
          ),
        ),
        backgroundColor: Colors.lightGreen.shade700,
        automaticallyImplyLeading: false, // Add this line to remove the back button
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 40),
              ClipOval(
                child: Image.asset(
                  'assets/MelakaGo.png',
                  width: 200,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 50),
              Container(
                width: 500,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical:8.0, horizontal:16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Email Address',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5.0),
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        child: TextField(
                          controller: emailController,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 5), // Add some spacing
              ElevatedButton(
                onPressed: _checkAdmin,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightGreen.shade700, // Set your desired background color here
                ),
                child: const Text('Login',
                    style: TextStyle(fontSize: 18.0,
                        fontWeight: FontWeight.bold, color: Colors.white)),
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}