import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // LOADING STATE VARIABLE
  bool isLoading = false;
  // NUMBER OF PAGINATION CALLS
  int counter = 0;

  // PAGINATION FUNCTION
  Future<void> loadMore() async {
    setState(() {
      isLoading = true;
    });
    await Future.delayed(const Duration(seconds: 2));
    counter += 1;
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Total pagination calls: $counter'),
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: NotificationListener<ScrollNotification>(
                onNotification: (ScrollNotification scrollInfo) {
                  //! TO AVOID MULTIPLE CALLS
                  // CHECK IF ALREADY LOADING OR NOT
                  if (!isLoading) {
                    loadMore();
                  }
                  return true;
                },
                child: ListView.builder(
                  itemBuilder: (ctx, i) => ListTile(
                    title: Text(i.toString()),
                  ),
                  itemCount: 15,
                ),
              ),
            ),
            SizedBox(
              height: isLoading ? 50.0 : 0.0,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
