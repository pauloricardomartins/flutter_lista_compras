import 'package:flutter/material.dart';
import 'package:lista_crud/models/item.dart';
import 'package:lista_crud/ui/adicionar_item.dart';

class Lista extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Lista de Compras', home: _ListaComprasTelaState());
  }
}

class _ListaComprasTelaState extends StatefulWidget {
  const _ListaComprasTelaState({super.key});

  @override
  State<_ListaComprasTelaState> createState() => __ListaComprasTelaStateState();
}

class __ListaComprasTelaStateState extends State<_ListaComprasTelaState> {
  List<Item> items = [];
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Compras', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blueAccent,
      ),
      body: items.isEmpty
          ? Center(
              child: Text('Nenhum item encontrado...',
                  style: TextStyle(fontSize: 18, color: Colors.grey)),
            )
          : ListView.separated(
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    items[index].nome,
                    style: TextStyle(
                        decoration: items[index].IsDone
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                        color: Colors.blue),
                  ),
                  onTap: () {
                    setState(() {
                      items[index].IsDone = !items[index].IsDone;
                    });
                  },
                  leading: CircleAvatar(
                    backgroundColor: Colors.blueAccent,
                    child: IconTheme(
                      child: Icon(Icons.done),
                      data: IconThemeData(color: Colors.white),
                    ),
                  ),
                  trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        _removerItem(index);
                      }),
                );
              },
              separatorBuilder: (context, index) => Divider(
                color: Colors.blue.shade100,
              ),
              itemCount: items.length,
            ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blue,
          child: Icon(Icons.add, color: Colors.white),
          onPressed: _adicionarItem),
    );
  }

  void _adicionarItem() async {
    final item = await showDialog(
        context: context,
        builder: (context) {
          return AdicionarItem();
        });

    if (item != null) {
      setState(() {
        items.add(item);
      });
    }
  }

  void _removerItem(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Remover Item'),
          content: Text('Tem certeza que deseja remover este item?'),
          actions: [
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Remover'),
              onPressed: () {
                setState(() {
                  items.removeAt(index);
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
