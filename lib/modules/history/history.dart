import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class ExampleParallax extends StatefulWidget {
  const ExampleParallax({
    super.key,
  });
  @override
  State<ExampleParallax> createState() => _ExampleParallaxState();
}

class _ExampleParallaxState extends State<ExampleParallax> {
  final String uid = FirebaseAuth.instance.currentUser!.uid;
  @override
  void initState() {
    getHistory();
    super.initState();
  }

  Future getHistory() async {
    try {
      await FirebaseFirestore.instance
          .collection('Plants')
          .where("uid",isEqualTo: uid)
          .get().then((value){
        plants=[];
        List<QueryDocumentSnapshot<Map<String, dynamic>>> snapshot = value.docs;
        for (var doc in snapshot) {
          plants.add(History.fromJson(doc.data()));
        }
        print(plants.length);
      });
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error Getting User Data ${e}!'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: double.infinity,
        color: Colors.green.shade100,
        child: Column(
          children: [
            Column(
              children: [
                for (final location in plants)
                  HistoryScreen(
                    imageUrl: location.imageUrl!,
                    name: location.name!,
                  ),
              ],
            ),
          ],
        ),

      ),
    );
  }
}

class HistoryScreen extends StatefulWidget {

  HistoryScreen({
    super.key,
    required this.imageUrl,
    required this.name,
  });

  final String imageUrl;
  final String name;

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {

  final label_cont=TextEditingController();
  final Iurl_cont=TextEditingController();

  FirebaseAuth instance = FirebaseAuth.instance;

  final CollectionReference usersCollection =
  FirebaseFirestore.instance.collection('Plants');

  final String uid = FirebaseAuth.instance.currentUser!.uid;

  Future<dynamic> getUserProfileField(String fieldName) async {
    final DocumentSnapshot<Object?> snapshot =
    await usersCollection.doc(uid).get();
    return snapshot.get(fieldName);
  }


  final GlobalKey _backgroundImageKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            children: [
              _buildParallaxBackground(context),
              _buildGradient(),
              _buildTitleAndSubtitle(),
            ],
          ),
        ),
      ),
    );

  }

  Widget _buildParallaxBackground(BuildContext context) {
    return Flow(
      delegate: ParallaxFlowDelegate(
        scrollable: Scrollable.of(context),
        listItemContext: context,
        backgroundImageKey: _backgroundImageKey,
      ),
      children: [
        Image.network(
          widget.imageUrl,
          key: _backgroundImageKey,
          fit: BoxFit.cover,
        ),
      ],
    );
  }

  Widget _buildGradient() {
    return Positioned.fill(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: const [0.6, 0.95],
          ),
        ),
      ),
    );
  }

  Widget _buildTitleAndSubtitle() {
    return Positioned(
      left: 20,
      bottom: 20,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.name,
            style: const TextStyle(
              decoration: TextDecoration.none,
              color: Color(0xff19AC20),
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class ParallaxFlowDelegate extends FlowDelegate {
  ParallaxFlowDelegate({
    required this.scrollable,
    required this.listItemContext,
    required this.backgroundImageKey,
  }) : super(repaint: scrollable.position);


  final ScrollableState scrollable;
  final BuildContext listItemContext;
  final GlobalKey backgroundImageKey;

  @override
  BoxConstraints getConstraintsForChild(int i, BoxConstraints constraints) {
    return BoxConstraints.tightFor(
      width: constraints.maxWidth,
    );
  }

  @override
  void paintChildren(FlowPaintingContext context) {

    final scrollableBox = scrollable.context.findRenderObject() as RenderBox;
    final listItemBox = listItemContext.findRenderObject() as RenderBox;
    final listItemOffset = listItemBox.localToGlobal(
        listItemBox.size.centerLeft(Offset.zero),
        ancestor: scrollableBox);


    final viewportDimension = scrollable.position.viewportDimension;
    final scrollFraction =
    (listItemOffset.dy / viewportDimension).clamp(0.0, 1.0);

    final verticalAlignment = Alignment(0.0, scrollFraction * 2 - 1);


    final backgroundSize =
        (backgroundImageKey.currentContext!.findRenderObject() as RenderBox)
            .size;
    final listItemSize = context.size;
    final childRect =
    verticalAlignment.inscribe(backgroundSize, Offset.zero & listItemSize);

    context.paintChild(
      0,
      transform:
      Transform.translate(offset: Offset(0.0, childRect.top)).transform,
    );
  }

  @override
  bool shouldRepaint(ParallaxFlowDelegate oldDelegate) {
    return scrollable != oldDelegate.scrollable ||
        listItemContext != oldDelegate.listItemContext ||
        backgroundImageKey != oldDelegate.backgroundImageKey;
  }
}

class Parallax extends SingleChildRenderObjectWidget {
  const Parallax({
    super.key,
    required Widget background,
  }) : super(child: background);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderParallax(scrollable: Scrollable.of(context));
  }

  @override
  void updateRenderObject(
      BuildContext context, covariant RenderParallax renderObject) {
    renderObject.scrollable = Scrollable.of(context);
  }
}

class ParallaxParentData extends ContainerBoxParentData<RenderBox> {}

class RenderParallax extends RenderBox
    with RenderObjectWithChildMixin<RenderBox>, RenderProxyBoxMixin {
  RenderParallax({
    required ScrollableState scrollable,
  }) : _scrollable = scrollable;

  ScrollableState _scrollable;

  ScrollableState get scrollable => _scrollable;

  set scrollable(ScrollableState value) {
    if (value != _scrollable) {
      if (attached) {
        _scrollable.position.removeListener(markNeedsLayout);
      }
      _scrollable = value;
      if (attached) {
        _scrollable.position.addListener(markNeedsLayout);
      }
    }
  }

  @override
  void attach(covariant PipelineOwner owner) {
    super.attach(owner);
    _scrollable.position.addListener(markNeedsLayout);
  }

  @override
  void detach() {
    _scrollable.position.removeListener(markNeedsLayout);
    super.detach();
  }

  @override
  void setupParentData(covariant RenderObject child) {
    if (child.parentData is! ParallaxParentData) {
      child.parentData = ParallaxParentData();
    }
  }

  @override
  void performLayout() {
    size = constraints.biggest;

    final background = child!;
    final backgroundImageConstraints =
    BoxConstraints.tightFor(width: size.width);
    background.layout(backgroundImageConstraints, parentUsesSize: true);

    (background.parentData as ParallaxParentData).offset = Offset.zero;
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final viewportDimension = scrollable.position.viewportDimension;

    final scrollableBox = scrollable.context.findRenderObject() as RenderBox;
    final backgroundOffset =
    localToGlobal(size.centerLeft(Offset.zero), ancestor: scrollableBox);

    final scrollFraction =
    (backgroundOffset.dy / viewportDimension).clamp(0.0, 1.0);

    final verticalAlignment = Alignment(0.0, scrollFraction * 2 - 1);

    final background = child!;
    final backgroundSize = background.size;
    final listItemSize = size;
    final childRect =
    verticalAlignment.inscribe(backgroundSize, Offset.zero & listItemSize);

    context.paintChild(
        background,
        (background.parentData as ParallaxParentData).offset +
            offset +
            Offset(0.0, childRect.top));
  }
}

class History {
   History({
     this.name,
     this.uid,
     this.imageUrl,
  });
   String? name;
   String ?uid;
   String ?imageUrl;
  History.fromJson(Map<String, dynamic> json) {
    name = json['label'];
    uid = json['uid'];
    imageUrl = json['image_link'];

  }
}


List<History> plants = [

];