import 'package:flutter/material.dart';
import 'package:play_game_machine_test/controller/screen_db.dart';
import 'package:play_game_machine_test/view/intro.dart';
import 'package:provider/provider.dart';

class PlayScreen extends StatelessWidget {
  final List<String> contents;
  final int rows;
  final int columns;

  const PlayScreen({
    Key? key,
    required this.contents,
    required this.rows,
    required this.columns,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
   final size = MediaQuery.of(context).size;
    TextEditingController controller = TextEditingController();
    return ChangeNotifierProvider(
      create: (_) => PlayScreenProvider(contents, rows, columns),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Play Screen'),
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () {
                Navigator.push(
    context,
    MaterialPageRoute(builder: (context) =>  IntroScreen()),
  );
              },
            ),
          ],
        ),
        body: Column(
          children: [
            Consumer<PlayScreenProvider>(
              builder: (context, provider, _) => TextField(
                controller: controller,
                onChanged: provider.textChanged,
                decoration: const InputDecoration(
                  hintText: 'Search for an alphabet',
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),
            Expanded(
              child: Consumer<PlayScreenProvider>(
                builder: (context, provider, _) => GridView.count(
                  crossAxisCount: provider.columns,
                  children: List.generate(provider.letters.length, (index) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 5, top: 10, right: 5),
                      child: Container(height:size.height*0.01 ,
                        decoration: BoxDecoration(
                          color: provider.success &&
                                  controller.text.contains(provider.letters[index].toLowerCase())
                              ? Colors.teal
                              : controller.text.contains(provider.letters[index].toLowerCase())
                                  ? Colors.cyan
                                  : Colors.grey.shade200,
                          border: Border.all(),
                        ),
                        child: Center(
                          child: Text(
                            provider.letters[index],
                            style: const TextStyle(fontSize: 24),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
