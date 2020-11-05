import 'package:flutter/material.dart';
import 'package:flutter_reorderable_list/flutter_reorderable_list.dart';
import 'package:pad_pal/components/app_bar/app_bar.dart';
import 'package:pad_pal/theme.dart';

class PlaygroundPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => PlaygroundPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MyHomePage(),
    );
  }
}

class TeamName extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 24),
      child: Container(
        width: 40,
        height: 105,
        decoration: BoxDecoration(
          color: AppTheme.lightGrayBackground,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Center(
            child: Text(
          "A",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 24,
          ),
        )),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class ItemData {
  ItemData(this.title, this.key);

  final String title;

  // Each item in reorderable list needs stable and unique key
  final Key key;
}

class _MyHomePageState extends State<MyHomePage> {
  List<ItemData> _items;

  _MyHomePageState() {
    _items = List();
    for (int i = 0; i < 4; ++i) {
      String label = "List item $i";
      if (i == 5) {
        label += ". This item has a long label and will be wrapped.";
      }
      _items.add(ItemData(label, ValueKey(i)));
    }
  }

  // Returns index of item with given key
  int _indexOfKey(Key key) {
    return _items.indexWhere((ItemData d) => d.key == key);
  }

  bool _reorderCallback(Key item, Key newPosition) {
    int draggingIndex = _indexOfKey(item);
    int newPositionIndex = _indexOfKey(newPosition);

    // Uncomment to allow only even target reorder possition
    // if (newPositionIndex % 2 == 1)
    //   return false;

    final draggedItem = _items[draggingIndex];
    setState(() {
      debugPrint("Reordering $item -> $newPosition");
      _items.removeAt(draggingIndex);
      _items.insert(newPositionIndex, draggedItem);
    });
    return true;
  }

  void _reorderDone(Key item) {
    final draggedItem = _items[_indexOfKey(item)];
    debugPrint("Reordering finished for ${draggedItem.title}}");
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      appBar: CustomAppBar(title: "asd"),
      body: Row(
        children: [
          Column(
            children: [
              TeamName(),
              const SizedBox(height: 46),
              TeamName(),
            ],
          ),
          Expanded(
            child: ReorderableList(
              onReorder: this._reorderCallback,
              onReorderDone: this._reorderDone,
              child: ListView.builder(
                itemCount: _items.length + 1,
                itemBuilder: (context, i) {
                  if (i == 2) {
                    return Divider(
                      thickness: 2,
                      height: 24 * 2.0,
                      color: AppTheme.grayBorder,
                    );
                  }
                  final index = i > 2 ? i - 1 : i;

                  return Item(
                    data: _items[index],
                    // first and last attributes affect border drawn during dragging
                    isFirst: index == 0,
                    isLast: index == _items.length - 1,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Item extends StatelessWidget {
  Item({
    this.data,
    this.isFirst,
    this.isLast,
  });

  final ItemData data;
  final bool isFirst;
  final bool isLast;

  Widget _buildChild(BuildContext context, ReorderableItemState state) {
    BoxDecoration decoration;

    if (state == ReorderableItemState.dragProxy || state == ReorderableItemState.dragProxyFinished) {
      // slightly transparent background white dragging (just like on iOS)
      decoration = BoxDecoration(color: Color(0xD0FFFFFF));
    } else {
      bool placeholder = state == ReorderableItemState.placeholder;
      decoration = BoxDecoration(
          border: Border(
              top: isFirst && !placeholder
                  ? Divider.createBorderSide(context) //
                  : BorderSide.none,
              bottom: isLast && placeholder
                  ? BorderSide.none //
                  : Divider.createBorderSide(context)),
          color: placeholder ? null : Colors.white);
    }

    return Container(
      // decoration: decoration,
      child: SafeArea(
        top: false,
        bottom: false,
        child: Opacity(
          // hide content for placeholder
          opacity: state == ReorderableItemState.placeholder ? 0.0 : 1.0,
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 14.0),
                    child: Text(data.title, style: Theme.of(context).textTheme.subtitle1),
                  ),
                ),
                ReorderableListener(
                  child: Container(
                    padding: EdgeInsets.only(right: 18.0, left: 18.0),
                    color: Color(0x08000000),
                    child: Center(
                      child: Icon(Icons.reorder, color: Color(0xFF888888)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ReorderableItem(key: data.key, childBuilder: _buildChild);
  }
}
