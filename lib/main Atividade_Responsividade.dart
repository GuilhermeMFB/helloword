import 'package:flutter/material.dart';

void main() {
  runApp(const ScrollApp());
}

class ScrollApp extends StatelessWidget {
  const ScrollApp({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  const SizedBox(height: 40),

                  const Icon(Icons.lock, size: 90, color: Colors.blue),

                  const SizedBox(height: 10),

                  const Text("Login", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),

                  const SizedBox(height: 30),

                  SizedBox(
                    width: width * 0.9,
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: "Email",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),

                  const SizedBox(height: 15),

                  SizedBox(
                    width: width * 0.9,
                    child: TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "Senha",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  SizedBox(
                    width: width * 0.9,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: const Text("Entrar"),
                    ),
                  ),

                  const SizedBox(height: 10),

                  TextButton(
                    onPressed: () {},
                    child: const Text("Criar conta"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
