import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CO2SensorScreen extends StatefulWidget {
  const CO2SensorScreen({Key key}) : super(key: key);

  @override
  _CO2SensorScreenState createState() => _CO2SensorScreenState();
}

class _CO2SensorScreenState extends State<CO2SensorScreen> {
  var _co2isOn = false;
  var _flowisOn = false;
  var _airpumpisOn = false;
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(middle: Text('Control Settings')),
      child: SafeArea(
        child: Scaffold(
          body: ListView(
            physics: NeverScrollableScrollPhysics(),
            children: <Widget>[
              Card(
                child: Column(
                  children: <Widget>[
                    CupertinoSwitchListTile(
                      title: Text("Co2 Sensor"),
                      value: _co2isOn,
                      activeColor: CupertinoColors.activeGreen,
                      onChanged: (changed) {
                        //print("Switch changed");
                        setState(() {
                          _co2isOn = changed;
                        });
                      },
                    ),
                    ListTile(
                      title: Text("Co2 (%)"),
                      trailing: Text("%"),
                    ),
                  ],
                ),
              ),
              Divider(),
              Card(
                child: Column(
                  children: <Widget>[
                    CupertinoSwitchListTile(
                      title: Text("Flow Sensor"),
                      value: _flowisOn,
                      activeColor: CupertinoColors.activeGreen,
                      onChanged: (changed) {
                        //print("Switch changed");
                        setState(() {
                          _flowisOn = changed;
                        });
                      },
                    ),
                    ListTile(
                      title: Text("Voltage (V)"),
                      trailing: Text(" V"),
                    ),
                    ListTile(
                      title: Text("Flow (LPM)"),
                      trailing: Text("###"),
                    ),
                  ],
                ),
              ),
              Divider(),
              Card(
                child: Column(
                  children: <Widget>[
                    CupertinoSwitchListTile(
                      title: Text("Air Pump Control"),
                      value: _airpumpisOn,
                      activeColor: CupertinoColors.activeGreen,
                      onChanged: (changed) {
                        //print("Switch changed");
                        setState(() {
                          _airpumpisOn = changed;
                        });
                      },
                    ),
                    ListTile(
                      title: Text("Current (A)"),
                      trailing: Text(" A"),
                    ),
                    ListTile(
                      title: Text("Voltage (V)"),
                      trailing: Text(" V"),
                    ),
                    ListTile(
                      title: Text("Power (W)"),
                      trailing: Text(" W"),
                    ),
                    ListTile(
                      title: Text("Estimated Flow (SLPM)"),
                      trailing: Text("###"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// old
class _CO2SensorScreenState2 extends State<CO2SensorScreen> {
  var _taps = "disabled";
  bool _co2sensorbool = false;
  Color _currentColor = Colors.red[300];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            height: 100.0,
            color: Colors.white,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Co2 Sensor",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.topRight,
                      child: buildCo2Switch(),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Co2 %",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Container(
                      alignment: Alignment.topRight,
                      child: Text(
                        "%",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w300),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            color: _currentColor,
            child: Center(
                child: Text(
              _taps.toString(),
              style: TextStyle(fontSize: 18.0),
            )),
          ),
        ],
      ),
    );
  }

  Switch buildCo2Switch() {
    return Switch.adaptive(
        value: _co2sensorbool,
        onChanged: (bool newval) {
          setState(() {
            _co2sensorbool = newval;
            if (newval) {
              _taps = "enabled";
              _currentColor = Colors.green[300];
              // send message to enable co2 sensor
            } else if (!newval) {
              _taps = "disabled";
              _currentColor = Colors.red[300];
              // send message to disable co2 sensor
            }
          });
        });
  }
}

// switch tile for lists
class CupertinoSwitchListTile extends StatelessWidget {
  const CupertinoSwitchListTile({
    Key key,
    @required this.value,
    @required this.onChanged,
    this.activeColor,
    this.title,
    this.subtitle,
    this.isThreeLine: false,
    this.dense,
    this.secondary,
    this.selected: false,
  })  : assert(value != null),
        assert(isThreeLine != null),
        assert(!isThreeLine || subtitle != null),
        assert(selected != null),
        super(key: key);

  /// Whether this switch is checked.
  ///
  /// This property must not be null.
  final bool value;

  /// Called when the user toggles the switch on or off.
  ///
  /// The switch passes the new value to the callback but does not actually
  /// change state until the parent widget rebuilds the switch tile with the
  /// new value.
  ///
  /// If null, the switch will be displayed as disabled.
  final ValueChanged<bool> onChanged;

  /// The color to use when this switch is on.
  ///
  /// Defaults to accent color of the current [Theme].
  final Color activeColor;

  /// The primary content of the list tile.
  ///
  /// Typically a [Text] widget.
  final Widget title;

  /// Additional content displayed below the title.
  ///
  /// Typically a [Text] widget.
  final Widget subtitle;

  /// A widget to display on the opposite side of the tile from the switch.
  ///
  /// Typically an [Icon] widget.
  final Widget secondary;

  /// Whether this list tile is intended to display three lines of text.
  ///
  /// If false, the list tile is treated as having one line if the subtitle is
  /// null and treated as having two lines if the subtitle is non-null.
  final bool isThreeLine;

  /// Whether this list tile is part of a vertically dense list.
  ///
  /// If this property is null then its value is based on [ListTileTheme.dense].
  final bool dense;

  /// Whether to render icons and text in the [activeColor].
  ///
  /// No effort is made to automatically coordinate the [selected] state and the
  /// [value] state. To have the list tile appear selected when the switch is
  /// on, pass the same value to both.
  ///
  /// Normally, this property is left to its default value, false.
  final bool selected;

  @override
  Widget build(BuildContext context) {
    var color = activeColor ?? Theme.of(context).accentColor;
    print("Active color: ${color.red} ${color.green} ${color.blue}");
    final Widget control = new CupertinoSwitch(
      value: value,
      onChanged: onChanged,
      activeColor: activeColor ?? CupertinoColors.activeGreen,
    );
    return new MergeSemantics(
      child: ListTileTheme.merge(
        selectedColor: activeColor ?? CupertinoColors.activeGreen,
        child: new ListTile(
          leading: secondary,
          title: title,
          subtitle: subtitle,
          trailing: control,
          isThreeLine: isThreeLine,
          dense: dense,
          enabled: onChanged != null,
          onTap: onChanged != null
              ? () {
                  onChanged(!value);
                }
              : null,
          selected: selected,
        ),
      ),
    );
  }
}
