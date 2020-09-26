import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'settings_viewmodel.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SettingsViewModel>.reactive(
      builder: (context, model, child) => Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(32, 40, 32, 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Settings",
                  style: Theme.of(context).textTheme.headline3,
                ),
                GestureDetector(
                  onTap: () {
                    model.navigateToHome();
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
                    borderRadius:
                        BorderRadius.only(topLeft: Radius.circular(41)),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(32, 28, 32, 0),
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: 150,
                        height: 150,
                        child: Center(),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.secondary,
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        "FirstName LastName",
                        style: Theme.of(context).textTheme.headline2,
                      ),
                      SizedBox(height: 16),
                      Card(
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(16, 13.5, 16, 24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(
                                height: 8.0,
                              ),
                              Divider(color: Colors.transparent),
                              Text(
                                "Health Profile",
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Card(
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(16, 13.5, 16, 24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(height: 8.0),
                              Text(
                                "Export Data",
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 16, 0, 16),
                                child: Divider(),
                              ),
                              Text(
                                "Change User Type",
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 16, 0, 16),
                                child: Divider(),
                              ),
                              Text(
                                "Item 3",
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 16, 0, 16),
                                child: Divider(),
                              ),
                              Text(
                                "Item 4",
                                style: Theme.of(context).textTheme.bodyText1,
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
      ),
      viewModelBuilder: () => SettingsViewModel(),
    );
  }
}
