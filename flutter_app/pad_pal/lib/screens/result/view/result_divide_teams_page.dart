import 'package:drag_and_drop_lists_fork_robin/drag_and_drop_lists.dart';
import 'package:flutter/material.dart';
import 'package:pad_pal/components/app_bar/app_bar.dart';
import 'package:pad_pal/components/components.dart';
import 'package:pad_pal/theme.dart';

class ResultDivideTeamsPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => ResultDivideTeamsPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: "Result",
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: ResultDivideTeamsView(),
      ),
    );
  }
}

class ResultDivideTeamsView extends StatefulWidget {
  ResultDivideTeamsView({Key key}) : super(key: key);

  @override
  _ResultDivideTeamsViewState createState() => _ResultDivideTeamsViewState();
}

class _ResultDivideTeamsViewState extends State<ResultDivideTeamsView> {
  List<DragAndDropList> _contents;

  @override
  void initState() {
    super.initState();

    _contents = List.generate(3, (index) {
      return DragAndDropList(
        canDrag: false,
        children: <DragAndDropItem>[
          DragAndDropItem(
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: DottedAvatar(radius: 24),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Asd"),
                      Text("asd"),
                    ],
                  ),
                ),
              ],
            ),
          ),
          DragAndDropItem(
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  child: Text(
                    'Sub $index.2',
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    });
  }

  _onItemReorder(int oldItemIndex, int oldListIndex, int newItemIndex, int newListIndex) {
    setState(() {
      var movedItem = _contents[oldListIndex].children.removeAt(oldItemIndex);
      _contents[newListIndex].children.insert(newItemIndex, movedItem);
    });
  }

  @override
  Widget build(BuildContext context) {
    _contents = List.generate(2, (index) {
      return DragAndDropList(
        leftSide: Padding(
          padding: const EdgeInsets.only(right: 24),
          child: Container(
            width: 40,
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
        ),
        canDrag: false,
        children: <DragAndDropItem>[
          DragAndDropItem(
            child: PlayerListTile(),
          ),
          DragAndDropItem(
            child: PlayerListTile(),
          ),
        ],
      );
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TitleAndSubtitle(
          title: "Divide into teams",
          subtitle: "Lorem ipsum dolor sit amet",
        ),
        const SizedBox(height: 36),
        Expanded(
          child: DragAndDropLists(
            listDivider: Divider(
              thickness: 1,
              height: 25,
              indent: 100,
              color: AppTheme.grayBorder,
            ),
            itemDivider: SizedBox(height: 25),
            listDividerOnLastChild: false,
            children: _contents,
            onItemReorder: _onItemReorder,
            lastItemTargetHeight: 8,
            lastListTargetSize: 40,
            dragHandle: Padding(
              padding: EdgeInsets.only(right: 10),
              child: Icon(
                Icons.menu,
                color: Colors.black26,
              ),
            ),
          ),
        ),
        Button.primary(child: Text("Next"), onPressed: () => {})
      ],
    );
  }
}

class PlayerListTile extends StatelessWidget {
  const PlayerListTile({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Padding(
          padding: EdgeInsets.only(right: 10),
          child: Avatar(
              url: 'https://www.fakepersongenerator.com/Face/female/female20161025116292694.jpg',
              name: "Alfie Wood",
              elevation: 0,
              borderWidth: 0,
              radius: 24),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Alfie Wood",
                style: theme.textTheme.headline4,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
