import 'package:flutter/material.dart';

class EditFavoritesView extends StatelessWidget {
  const EditFavoritesView({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.fromLTRB(32, 40, 32, 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Edit Favorites",
                style: Theme.of(context).textTheme.headline3,
              ),
              GestureDetector(
                onTap: () {
                  //TODO implement routing to home view
                  print("Done tapped");
                },
                child: Text(
                  "Done",
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(41)),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(32, 28, 32, 0),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Category 1",
                          style: Theme.of(context).textTheme.headline2,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 0,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(16, 13.5, 16, 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(height: 8.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "CO\u2082 Removal",
                                  style: Theme.of(context).textTheme.headline4,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    //TODO implement toggleable star buttons
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Icon(
                                      Icons.star,
                                      size: 20,
                                      color: Theme.of(context)
                                          .toggleableActiveColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 16, 0, 16),
                              child: Divider(),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "Flow Rate",
                                  style: Theme.of(context).textTheme.headline4,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    //TODO implement toggleable star buttons
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Icon(
                                      Icons.star,
                                      size: 20,
                                      color: Theme.of(context)
                                          .toggleableActiveColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 16, 0, 16),
                              child: Divider(),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "Item 3",
                                  style: Theme.of(context).textTheme.headline4,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    //TODO implement toggleable star buttons
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Icon(
                                      Icons.star_border,
                                      size: 20,
                                      color: Theme.of(context)
                                          .toggleableActiveColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 16, 0, 16),
                              child: Divider(),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "Item 4",
                                  style: Theme.of(context).textTheme.headline4,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    //TODO implement toggleable star buttons
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Icon(
                                      Icons.star_border,
                                      size: 20,
                                      color: Theme.of(context)
                                          .toggleableActiveColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
