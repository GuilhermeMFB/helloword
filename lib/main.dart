import 'package:flutter/material.dart';

void main() => runApp(const SupermercadoApp());

class SupermercadoApp extends StatelessWidget {
  const SupermercadoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de Supermercado',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFF0E1410),
        fontFamily: 'Segoe UI',
        colorScheme: ColorScheme.dark(
          primary: const Color(0xFF3ECF6E),
        ),
      ),
      home: const ListaSupermercadoScreen(),
    );
  }
}

class ItemCompra {
  String nome;
  String categoria;
  double preco;
  int quantidade;
  bool concluido;

  ItemCompra({
    required this.nome,
    required this.categoria,
    required this.preco,
    this.quantidade = 1,
    this.concluido = false,
  });
}

class ListaSupermercadoScreen extends StatefulWidget {
  const ListaSupermercadoScreen({super.key});

  @override
  State<ListaSupermercadoScreen> createState() => _ListaSupermercadoScreenState();
}

class _ListaSupermercadoScreenState extends State<ListaSupermercadoScreen> {
  String categoriaAtiva = 'Todos';

  final List<String> categorias = [
    'Todos',
    'Frutas',
    'Carnes',
    'Higiene',
    'Limpeza',
  ];

  final List<ItemCompra> itens = [
    ItemCompra(nome: 'Arroz 5kg', categoria: 'Mercearia', preco: 24.90, quantidade: 1),
    ItemCompra(nome: 'Feijão 1kg', categoria: 'Mercearia', preco: 8.49, quantidade: 2),
    ItemCompra(nome: 'Leite 1L', categoria: 'Bebidas', preco: 6.29, quantidade: 3),
    ItemCompra(nome: 'Papel Higiênico 12un', categoria: 'Higiene', preco: 19.90, quantidade: 1),
    ItemCompra(nome: 'Óleo de Soja 900ml', categoria: 'Mercearia', preco: 6.29, concluido: true),
    ItemCompra(nome: 'Detergente', categoria: 'Limpeza', preco: 3.49, concluido: true),
  ];

  static const Color bg = Color(0xFF0E1410);
  static const Color card = Color(0xFF161F19);
  static const Color card2 = Color(0xFF1B261F);
  static const Color green = Color(0xFF3ECF6E);
  static const Color greenDark = Color(0xFF27A854);
  static const Color textColor = Color(0xFFF3F6F3);
  static const Color muted = Color(0xFF8AA093);
  static const Color line = Color(0xFF26352C);

  double get total => itens.fold(0, (s, i) => s + i.preco * i.quantidade);
  int get restantes => itens.where((i) => !i.concluido).length;

  void _alterarQuantidade(ItemCompra item, int delta) {
    setState(() {
      item.quantidade = (item.quantidade + delta).clamp(1, 99);
    });
  }

  void _alternarConcluido(ItemCompra item) {
    setState(() {
      item.concluido = !item.concluido;
    });
  }

  void _adicionarItem() {
    final nomeController = TextEditingController();
    final precoController = TextEditingController();
    showModalBottomSheet(
      context: context,
      backgroundColor: card,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Novo item',
                style: TextStyle(color: textColor, fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: nomeController,
                style: const TextStyle(color: textColor),
                decoration: InputDecoration(
                  hintText: 'Nome do produto',
                  hintStyle: const TextStyle(color: muted),
                  filled: true,
                  fillColor: card2,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: precoController,
                keyboardType: TextInputType.number,
                style: const TextStyle(color: textColor),
                decoration: InputDecoration(
                  hintText: 'Preço (ex: 9.90)',
                  hintStyle: const TextStyle(color: muted),
                  filled: true,
                  fillColor: card2,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: green,
                    foregroundColor: const Color(0xFF06210F),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    if (nomeController.text.trim().isEmpty) return;
                    setState(() {
                      itens.insert(
                        0,
                        ItemCompra(
                          nome: nomeController.text.trim(),
                          categoria: 'Outros',
                          preco: double.tryParse(precoController.text.replaceAll(',', '.')) ?? 0,
                        ),
                      );
                    });
                    Navigator.pop(context);
                  },
                  child: const Text('Adicionar', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final pendentes = itens.where((i) => !i.concluido).toList();
    final concluidos = itens.where((i) => i.concluido).toList();

    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(22, 10, 22, 6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Lista de Supermercado',
                    style: TextStyle(color: textColor, fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'Segunda-feira, 16 de junho',
                    style: TextStyle(color: muted, fontSize: 13),
                  ),
                ],
              ),
            ),

            // Search
            Padding(
              padding: const EdgeInsets.fromLTRB(22, 8, 22, 14),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                decoration: BoxDecoration(
                  color: card,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: line),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.search, color: muted, size: 20),
                    SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        style: TextStyle(color: textColor, fontSize: 14),
                        decoration: InputDecoration(
                          hintText: 'Buscar produto...',
                          hintStyle: TextStyle(color: muted),
                          border: InputBorder.none,
                          isDense: true,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Categories
            SizedBox(
              height: 40,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 22),
                itemCount: categorias.length,
                separatorBuilder: (_, __) => const SizedBox(width: 10),
                itemBuilder: (context, index) {
                  final cat = categorias[index];
                  final ativo = cat == categoriaAtiva;
                  return GestureDetector(
                    onTap: () => setState(() => categoriaAtiva = cat),
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      decoration: BoxDecoration(
                        color: ativo ? green : card,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: ativo ? green : line),
                      ),
                      child: Text(
                        cat,
                        style: TextStyle(
                          color: ativo ? const Color(0xFF06210F) : muted,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 8),

            // List
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(22, 8, 22, 8),
                children: [
                  _sectionTitle('Pendentes (${pendentes.length})'),
                  ...pendentes.map((item) => _itemCard(item)),
                  const SizedBox(height: 6),
                  _sectionTitle('Concluídos (${concluidos.length})'),
                  ...concluidos.map((item) => _itemCard(item)),
                ],
              ),
            ),

            // Summary
            Container(
              margin: const EdgeInsets.fromLTRB(22, 0, 22, 14),
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [greenDark, Color(0xFF1C7E3E)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Itens (${itens.length})',
                          style: const TextStyle(color: Color(0xFFD6F5E1), fontSize: 12, fontWeight: FontWeight.w600)),
                      const SizedBox(height: 2),
                      Text('$restantes restantes',
                          style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w800)),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text('Total',
                          style: TextStyle(color: Color(0xFFD6F5E1), fontSize: 12, fontWeight: FontWeight.w600)),
                      const SizedBox(height: 2),
                      Text('R\$ ${total.toStringAsFixed(2).replaceAll('.', ',')}',
                          style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w800)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: _adicionarItem,
        backgroundColor: green,
        foregroundColor: const Color(0xFF06210F),
        child: const Icon(Icons.add),
      ),

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: card,
        currentIndex: 0,
        selectedItemColor: green,
        unselectedItemColor: muted,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
        unselectedLabelStyle: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart_outlined), label: 'Lista'),
          BottomNavigationBarItem(icon: Icon(Icons.grid_view_outlined), label: 'Categorias'),
          BottomNavigationBarItem(icon: Icon(Icons.history_outlined), label: 'Histórico'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Perfil'),
        ],
      ),
    );
  }

  Widget _sectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, top: 6),
      child: Text(
        text.toUpperCase(),
        style: const TextStyle(
          color: muted,
          fontSize: 12,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.8,
        ),
      ),
    );
  }

  Widget _itemCard(ItemCompra item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: card,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: line),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => _alternarConcluido(item),
            child: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: item.concluido ? green : Colors.transparent,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: item.concluido ? green : muted,
                  width: 2,
                ),
              ),
              child: item.concluido
                  ? const Icon(Icons.check, size: 16, color: Color(0xFF06210F))
                  : null,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.nome,
                  style: TextStyle(
                    color: item.concluido ? muted : textColor,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    decoration: item.concluido ? TextDecoration.lineThrough : null,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '${item.categoria} • R\$ ${item.preco.toStringAsFixed(2).replaceAll('.', ',')}',
                  style: const TextStyle(color: muted, fontSize: 12),
                ),
              ],
            ),
          ),
          if (!item.concluido)
            Row(
              children: [
                _qtyButton(Icons.remove, () => _alterarQuantidade(item, -1)),
                SizedBox(
                  width: 22,
                  child: Text(
                    '${item.quantidade}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: textColor, fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                ),
                _qtyButton(Icons.add, () => _alterarQuantidade(item, 1)),
              ],
            ),
        ],
      ),
    );
  }

  Widget _qtyButton(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 26,
        height: 26,
        decoration: BoxDecoration(
          color: card2,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: line),
        ),
        child: Icon(icon, size: 14, color: textColor),
      ),
    );
  }
}