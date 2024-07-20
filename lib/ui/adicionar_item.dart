import 'package:flutter/material.dart'; 
import 'package:lista_crud/models/item.dart';

class AdicionarItem extends StatelessWidget {
  final textoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Adicionar Item'),
      content: TextField(
        autofocus:
            true,
        controller:
            textoController, 
        decoration: InputDecoration(
          hintText:
              'Digite o nome do item', // Texto que será exibido como dica no campo de texto.
          border:
              OutlineInputBorder(), // Adiciona uma borda ao redor do campo de texto.
        ),
      ),
// Botões de ação na parte inferior do diálogo.
      actions: [
// Botão para cancelar a adição do item.
        TextButton(
          child: Text('Cancelar'),
          onPressed: () => Navigator.of(context)
              .pop(), // Fecha o diálogo quando pressionado.
        ),
// Botão para adicionar o item.
        TextButton(
            child: Text('Adicionar'),
            onPressed: () {
// Cria um novo item com o texto digitado.
              final item = Item(nome: textoController.value.text);
              textoController.clear(); // Limpa o texto do campo após a adição.
              Navigator.of(context)
                  .pop(item); // Fecha o diálogo e retorna o item criado.
            }),
      ],
    );
  }
}
