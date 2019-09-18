import 'chat.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controllerNickname = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            SafeArea(
              top: true,
              child: Image.asset('assets/Flutter-Firebase.png'),
            ),
            Row(
              children: <Widget>[
                Icon(Icons.person, color: Color(0xFF808080), size: 28),
                SizedBox(width: 20),
                Expanded(
                  child: Form(
                    key: _formKey,
                    child: TextFormField(
                      controller: _controllerNickname,
                      style: TextStyle(fontSize: 18),
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintText: 'Nickname',
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Digite seu nome';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
              ],
            ),
            ButtonTheme(
              height: 44,
              minWidth: MediaQuery.of(context).size.width,
              child: RaisedButton(
                child: Text('INICIAR CHAT', style: TextStyle(fontSize: 18)),
                textColor: Colors.white,
                color: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.horizontal(
                    left: Radius.circular(20),
                    right: Radius.circular(20),
                  ),
                ),
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Chat(_controllerNickname.text)));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
