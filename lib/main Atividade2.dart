import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: ContadorCurtida());
  }
}

class ContadorCurtida extends StatefulWidget {
  const ContadorCurtida({super.key});

  @override
  _ContadorCurtidaState createState() => _ContadorCurtidaState();
}

class _ContadorCurtidaState extends State<ContadorCurtida> {
  int contador = 0;

  void incrementar() {
    setState(() {
      contador++;
    });
  }

  void decrementar() {
    setState(() {
      if (contador > 0) {
        contador--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/fundo.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar( centerTitle: true, title: Text("Widget + State")
          ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.favorite, size: 60, color: Colors.redAccent),

              SizedBox(width: 10, height: 10),

              Text(
                "D.S, melhor curso SENAI, sim ou claro?",
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(width: 10, height: 10),

              Text(
                "$contador Curtidas",
                style: TextStyle(
                  fontSize: 30,
                  color: const Color.fromARGB(255, 0, 101, 183),
                ),
              ),

              SizedBox(width: 20, height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: incrementar,
                    child: Text("👍Curtir"),
                  ),
                  SizedBox(width: 10, height: 10),
                  ElevatedButton(
                    onPressed: decrementar,
                    child: Text("👎Descurtir"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
