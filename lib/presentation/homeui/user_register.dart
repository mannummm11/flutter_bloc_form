import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class UserRegister extends StatefulWidget {
  const UserRegister({super.key});

  @override
  State<UserRegister> createState() => _UserRegisterState();
}

bool isEmailValid(String email) {
  final RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  return emailRegex.hasMatch(email);
}

class _UserRegisterState extends State<UserRegister> {
  final GlobalKey<FormState> _globalKey = GlobalKey();
  bool isTermConditionChecked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.deepOrangeAccent,),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _globalKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if(value!.isEmpty) return "Please mention your name";
                  else if(value.length <=5 ) return "Name should be more then 5 characters";
                  return null;
                },
                decoration: InputDecoration(
                  label: Text("Enter Name"),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25)
                  ),
                ),

              ),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value){
                  if(value!.isEmpty) {
                    return "Email cant be empty";
                  } else if(!isEmailValid(value)) {
                    return "Email is invalid";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  label: Text("Enter E-Mail"),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25)
                  )
                ),
              ),
              Row(
                children: [
                  Checkbox(value: isTermConditionChecked, onChanged: (val){
                    setState(() {
                      isTermConditionChecked = !isTermConditionChecked;
                    });
                  }),
                  Text("Term & Conditions")
                ],
              ),
              SizedBox(
                width: Size.infinite.width,
                child: ElevatedButton(onPressed: (){
                  if(_globalKey.currentState!.validate()) {
                    if(!isTermConditionChecked) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Please agree terms and condition"))
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Submitted"))
                      );
                    }
                  }
                }, child: Text("Validate")),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
