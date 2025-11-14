import 'package:flutter/material.dart';
import 'flashcard.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int nextId = 1;

  List<Flashcard> cards = [];
  List<Flashcard> learned = [];

  void _addCard() {
    setState(() {
      cards.insert(0, Flashcard(nextId++, "New Q", "New A"));
    });
  }

  @override
  Widget build(BuildContext context) {
    int total = cards.length + learned.length;
    int done = learned.length;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            expandedHeight: 120,
            flexibleSpace:
            FlexibleSpaceBar(title: Text("$done of $total learned")),
          ),

          // MAIN LIST
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (ctx, i) {
                var card = cards[i];
                bool show = false;

                return Dismissible(
                  key: ValueKey(card.id),
                  onDismissed: (_) {
                    setState(() {
                      learned.add(card);
                      cards.removeAt(i);
                    });
                  },
                  background: Container(color: Colors.green),
                  child: StatefulBuilder(
                    builder: (ctx, setInner) => ListTile(
                      title: Text(show ? card.answer : card.question),
                      onTap: () => setInner(() => show = !show),
                    ),
                  ),
                );
              },
              childCount: cards.length,
            ),
          ),
        ],
      ),

      floatingActionButton:
      FloatingActionButton(onPressed: _addCard, child: const Icon(Icons.add)),
    );
  }
}
