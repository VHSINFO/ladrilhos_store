import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
void main() => runApp(LojaVirtualApp());
class LojaVirtualApp extends StatelessWidget {
  const LojaVirtualApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Minha Loja',
      home: ProdutosPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
class ProdutosPage extends StatelessWidget {
  ProdutosPage({super.key});

  final List<Map<String, dynamic>> produtos = [
    {
      'nome': 'Camiseta Preta',
      'preco': 49.99,
      'imagem': 'https://via.placeholder.com/150',
    },
    {
      'nome': 'Boné Azul',
      'preco': 29.90,
      'imagem': 'https://via.placeholder.com/150',
    },
  ];

  void comprar(String nomeProduto) async {
    final mensagem = Uri.encodeComponent("Olá! Tenho interesse no produto: $nomeProduto");
    final url = Uri.parse("https://wa.me/5511999999999?text=$mensagem");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Não foi possível abrir o WhatsApp';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Produtos'),
      ),
      body: ListView.builder(
        itemCount: produtos.length,
        itemBuilder: (context, index) {
          final produto = produtos[index];
          return Card(
            margin: EdgeInsets.all(8),
            child: ListTile(
              leading: Image.network(produto['imagem']),
              title: Text(produto['nome']),
              subtitle: Text('R\$ ${produto['preco'].toStringAsFixed(2)}'),
              trailing: ElevatedButton(
                onPressed: () => comprar(produto['nome']),
                child: Text('Comprar'),
              ),
            ),
          );
        },
      ),
    );
  }
}