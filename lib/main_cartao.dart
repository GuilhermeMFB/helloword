import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color(0xFF121212),
        appBar: AppBar(
          title: const Text('Meus Cartões'),
          centerTitle: false,
          backgroundColor: const Color(0xFF1E1E1E),
          elevation: 0,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              criarCartao(
                cor: const Color(0xFF1565C0),
                banco: 'SENAI BANK',
                numero: '4829 3157 6048 2916',
                validade: '10/31',
                titular: 'GUILHERME BARRETO',
              ),

              const SizedBox(height: 25),

              criarCartao(
                cor: const Color(0xFF00897B),
                banco: 'SESI BANK',
                numero: '7391 8264 5017 3642',
                validade: '05/29',
                titular: 'GUILHERME BARRETO',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget criarCartao({
    required Color cor,
    required String banco,
    required String numero,
    required String validade,
    required String titular,
  }) {
    return Container(
      width: 340,
      height: 200,
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 18,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            cor,
            cor.withOpacity(0.75),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Colors.black45,
            blurRadius: 15,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                banco,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Icon(
                Icons.contactless,
                color: Colors.white,
                size: 28,
              ),
            ],
          ),

          const Spacer(),

          const Icon(
            Icons.credit_card,
            color: Colors.white70,
            size: 32,
          ),

          const SizedBox(height: 8),

          Text(
            numero,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 19,
              letterSpacing: 1.5,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 12),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'VALIDADE $validade',
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 11,
                ),
              ),
              Text(
                titular,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}