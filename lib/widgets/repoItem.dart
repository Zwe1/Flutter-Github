import 'package:flutter/material.dart';
import 'package:startup_namer/models/index.dart';

class RepoIetm extends StatefulWidget {
  final Repo repo;

  RepoIetm(this.repo) : super(key: ValueKey(repo.id));

  @override
  _RepoItemState createState() => _RepoItemState();
}

class _RepoItemState extends State<RepoIetm> {
  @override
  Widget build(BuildContext context) {
    var subTitle;

    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Material(
        color: Colors.white,
        shape: BorderDirectional(
            bottom:
                BorderSide(color: Theme.of(context).dividerColor, width: .5)),
        child: Padding(
          padding: const EdgeInsets.only(top: 0.0, bottom: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ListTile(
                dense: true,
                title: Text(
                  widget.repo.owner.login,
                  textScaleFactor: .9,
                ),
                subtitle: subTitle,
                trailing: Text(widget.repo.language ?? ''),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(widget.repo.fork
                        ? widget.repo.full_name
                        : widget.repo.name),
                  ],
                ),
              ),
              // 构建底部widget
              _buildBottom(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottom() {
    const paddingWidth = 10;

    return IconTheme(
      data: IconThemeData(color: Colors.grey, size: 15),
      child: DefaultTextStyle(
        style: TextStyle(color: Colors.grey, fontSize: 12),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Builder(
            builder: (context) {
              var children = <Widget>[
                Icon(Icons.star),
                Text(widget.repo.stargazers_count
                    .toString()
                    .padRight(paddingWidth)),
                Icon(Icons.star_half),
                Text(widget.repo.forks_count.toString().padRight(paddingWidth))
              ];
              return Row(
                children: children,
              );
            },
          ),
        ),
      ),
    );
  }
}
