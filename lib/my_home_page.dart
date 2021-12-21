import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // LIST OF DATA ( [1, 2, 3,...,9 ,10] )
  List<int> data = List.generate(10, (index) => index + 1);

  // LOADING STATE VARIABLE
  bool isLoading = false;

  // NUMBER OF PAGINATION CALLS
  int counter = 0;

  //? PAGINATION FUNCTION
  Future<void> loadMore() async {
    // SET LOADING TRUE
    setState(() {
      isLoading = true;
    });

    // PRETENDING API CALL
    await Future.delayed(const Duration(seconds: 2));

    // ADD DATA
    for (var i = 0; i < 10; i++) {
      data.add(data.last + 1);
    }

    // INCREMENT PAGINATION CALL
    counter += 1;

    // SET LOADING FALSE
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
                  // AND
                  // CHECK IF SCROLL POSITION IS AT THE END
                  if (!isLoading &&
                      scrollInfo.metrics.pixels ==
                          scrollInfo.metrics.maxScrollExtent) {
                    loadMore();
                  }
                  return true;
                },

                // LIST VIEW
                child: ListView.builder(
                  itemBuilder: (ctx, i) => ListTile(
                    title: Text(data[i].toString()),
                  ),
                  itemCount: data.length,
                ),
              ),
            ),

            // LOADER
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
