import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bem-vindo(a) ao Flutter',
      home: PalavrasRandomicas(),
    );
  }
}

class PalavrasRandomicas extends StatefulWidget {
  @override
  PalavrasRandomicasState createState() => PalavrasRandomicasState();
}

class PalavrasRandomicasState extends State<PalavrasRandomicas> {
  final List<WordPair> _sugestoes = <WordPair>[];
  final Set<WordPair> _salvos = Set<WordPair>();
  final TextStyle _tamanhoDaFonte = const TextStyle(fontSize: 18);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bem-vindo(a) ao Flutter'),
      ),
      body: _construirSugestoes(),
    );
  }

  Widget _construirSugestoes() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      // A função de retorno itemBuild é chamada uma vez para cada
      // par de sugestão de palavras e coloca cada sugestão dentro
      // de uma linha do ListView. Nas linhas pares, a função adiciona
      // uma linha na ListView para o par de palavras. Para as linhas
      // ímpares, a função adiciona um widget chamado Divider para
      // você visualizar um separador entre os pares de palavras.
      // Perceba que o divisor pode ser difícil de ver em
      // dispositivos com telas menores.
      itemBuilder: (BuildContext _context, int i) {
        // Adiciona um dividor de um pixel antes de cada
        // linha da ListView.
        if (i.isOdd) {
          return Divider();
        }

        // A sintaxe "i ~/ 2" efetua a divisão do valor da
        // variável i por 2 e retorna um resultado inteiro.
        // Por exemplo: 1, 2, 3, 4, 5 passam a ser 0, 1, 1, 2, 2.
        // Isto calcula o número corrente de pares de palavras
        // na ListView, menos os widgets divisores.
        final int index = i ~/ 2;
        // Se você já chegou ao fim da lista de pares de
        // palavras disponíveis...
        if (index >= _sugestoes.length) {
          // ... então são gerados mais 10 pares de palavras
          // e adicionados na lista de sugestão.
          _sugestoes.addAll(generateWordPairs().take(10));
        }
        return _construirLinha(_sugestoes[index]);
      },
    );
  }

  Widget _construirLinha(WordPair par) {
    final bool jaFoiSalva = _salvos.contains(par);
    return ListTile(
      title: Text(
        par.asPascalCase,
        style: _tamanhoDaFonte,
      ),
      trailing: Icon(
        jaFoiSalva ? Icons.favorite : Icons.favorite_border,
        color: jaFoiSalva ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          if (jaFoiSalva) {
            _salvos.remove(par);
          } else {
            _salvos.add(par);
          }
        });
      },
    );
  }
}
