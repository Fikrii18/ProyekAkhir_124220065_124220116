import 'package:finpro/views/home.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPages extends StatefulWidget {
  const LoginPages({super.key});

  @override
  State<LoginPages> createState() => _LoginPagesState();
}

bool isLoginSuccess = true;

class _LoginPagesState extends State<LoginPages> {
  String username = "";
  String password = "";

  @override
  void initState() {
    super.initState();
    loadLoginData();
  }


  Future<void> loadLoginData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedUsername = prefs.getString('username');  

    if (storedUsername != null) {
      setState(() {
        username = storedUsername;  
      });
      print('Username loaded: $storedUsername');
    } else {
      print('No username found');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset('logo.png', width: 100, height: 100),
                const SizedBox(height: 20),
                _usernameField(),
                const SizedBox(height: 20),
                _passwordField(),
                const SizedBox(height: 20),
                _loginButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _usernameField() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: TextField(
        onChanged: (value) {
          setState(() {
            username = value;
          });
        },
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.person, color: Colors.grey[700]),
          labelText: 'Nama Pengguna',
          hintText: 'Masukkan nama pengguna Anda',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(
              color: isLoginSuccess && username.isNotEmpty
                  ? const Color.fromARGB(255, 92, 190, 95)
                  : Colors.red,
              width: 1.5,
            ),
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        ),
      ),
    );
  }

  Widget _passwordField() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: TextField(
        onChanged: (value) {
          setState(() {
            password = value;
          });
        },
        obscureText: true,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.lock, color: Colors.grey[700]),
          labelText: 'Kata Sandi',
          hintText: 'Masukkan kata sandi Anda',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(
              color: isLoginSuccess && password.isNotEmpty
                  ? const Color.fromARGB(255, 92, 190, 95)
                  : Colors.red,
              width: 1.5,
            ),
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        ),
      ),
    );
  }

  Widget _loginButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: isLoginSuccess
              ? const Color.fromARGB(255, 92, 190, 95)
              : Colors.red,
        ),
        onPressed: () async {
          String text = "";
          if (username.isEmpty || password.isEmpty) {
            setState(() {
              isLoginSuccess = false;
            });
            text = "Username dan password tidak boleh kosong";
          } else if (password == "123" && username == "fikri") {
            setState(() {
              text = "Login successful";
              isLoginSuccess = true;
            });
            await saveLoginData(username); 

            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) {
              return HomePage(username: username); // Pass username to HomePage
            }));
          }
          else if (password == "123" && username == "nadia") {
            setState(() {
              text = "Login successful";
              isLoginSuccess = true;
            });
            await saveLoginData(username); 

            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) {
              return HomePage(username: username); // Pass username to HomePage
            }));
          }  else {
            setState(() {
              text = "Login failed";
              isLoginSuccess = false;
            });
          }
          SnackBar snackBar = SnackBar(content: Text(text));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        },
        child: const Text('Log In', style: TextStyle(color: Colors.white)),
      ),
    );
  }

  Future<void> saveLoginData(String username) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', username); 
    print("Username berhasil disimpan: $username"); 
  }
}
