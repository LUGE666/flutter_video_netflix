import 'package:flutter/material.dart';
import 'package:flutter_video_netflix/models/models.dart';
import 'package:flutter_video_netflix/widgets/widgets.dart';
import 'package:video_player/video_player.dart';

class ContentHeader extends StatelessWidget {
  final Content featuredContent;

  const ContentHeader({Key key, this.featuredContent}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Responsive(
      mobile: _ContentHeaderMobile(featuredContent: featuredContent),
      desktop: _ContentHeaderDesktop(featuredContent: featuredContent),
    );
  }
}

class _ContentHeaderMobile extends StatefulWidget {
  final Content featuredContent;

  const _ContentHeaderMobile({Key key, this.featuredContent}) : super(key: key);

  @override
  __ContentHeaderMobileState createState() => __ContentHeaderMobileState();
}

class __ContentHeaderMobileState extends State<_ContentHeaderMobile> {
  VideoPlayerController _videoController;
  bool _isMuted = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _videoController =
        VideoPlayerController.network(widget.featuredContent.videoUrl)
          ..initialize().then((_) => setState(() {}))
          ..setVolume(0)
          ..play();
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _videoController.value.isPlaying,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // AspectRatio(
          //   aspectRatio: _videoController.value.initialized
          //       ? _videoController.value.aspectRatio
          //       : 2.344,
          //   child: _videoController.value.initialized
          //       ? VideoPlayer(_videoController)
          //       : Container(
          //           height: 500.0,
          //           decoration: BoxDecoration(
          //             image: DecorationImage(
          //               image: AssetImage(widget.featuredContent.imageUrl),
          //               fit: BoxFit.cover,
          //             ),
          //           ),
          //         ),
          // ),
          // Positioned(
          //   bottom: -1,
          //   left: 0,
          //   right: 0,
          //   child: AspectRatio(
          //     aspectRatio: _videoController.value.initialized
          //         ? _videoController.value.aspectRatio
          //         : 2.344,
          //     child: Container(
          //       height: 500.0,
          //       decoration: const BoxDecoration(
          //           gradient: LinearGradient(
          //               colors: [Colors.black, Colors.transparent],
          //               begin: Alignment.bottomCenter,
          //               end: Alignment.topCenter)),
          //     ),
          //   ),
          // ),
          // Container(
          //   child: _videoController.value.initialized
          //       ? _play(_videoController, _isMuted, widget.featuredContent)
          //       : _stopPlay(),
          // )
        ],
      ),
    );
  }

  Widget _stopPlay() {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 40.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          VerticalIconButton(
            icon: Icons.add,
            title: 'List',
            onTap: () => {print('list')},
          ),
          _PlayButton(),
          VerticalIconButton(
            icon: Icons.info_outline,
            title: 'Info',
            onTap: () => {print('info')},
          )
        ],
      ),
    );
  }

  Widget _play(_videoController, _isMuted, featuredContent) {
    return Positioned(
      left: 60.0,
      right: 60.0,
      bottom: 150.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 250.0,
            child: Image.asset(featuredContent.titleImageUrl),
          ),
          SizedBox(
            height: 15.0,
          ),
          Text(
            widget.featuredContent.description,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
              fontWeight: FontWeight.w500,
              shadows: [
                Shadow(
                    color: Colors.black,
                    offset: Offset(2.0, 4.0),
                    blurRadius: 6.0),
              ],
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Row(
            children: [
              _PlayButton(),
              SizedBox(
                width: 16.0,
              ),
              FlatButton.icon(
                padding: EdgeInsets.fromLTRB(25.0, 10.0, 30.0, 10.0),
                onPressed: () => print('more info'),
                color: Colors.white,
                icon: Icon(
                  Icons.info_outline,
                  size: 30.0,
                ),
                label: Text(
                  'more info',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(
                width: 20.0,
              ),
              if (_videoController.value.initialized)
                IconButton(
                  icon: Icon(_isMuted ? Icons.volume_off : Icons.volume_up),
                  onPressed: () => setState(() {
                    _isMuted
                        ? _videoController.setVolume(100)
                        : _videoController.setVolume(0);
                    _isMuted = _videoController.value.volume == 0;
                  }),
                )
            ],
          )
        ],
      ),
    );
  }
}

class _ContentHeaderDesktop extends StatefulWidget {
  final Content featuredContent;

  const _ContentHeaderDesktop({Key key, this.featuredContent})
      : super(key: key);

  @override
  __ContentHeaderDesktopState createState() => __ContentHeaderDesktopState();
}

class __ContentHeaderDesktopState extends State<_ContentHeaderDesktop> {
  VideoPlayerController _videoController;
  bool _isMuted = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _videoController =
        VideoPlayerController.network(widget.featuredContent.videoUrl)
          ..initialize().then((_) => setState(() {}))
          ..setVolume(0)
          ..play();
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _videoController.value.isPlaying
          ? _videoController.pause()
          : _videoController.play(),
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          AspectRatio(
            aspectRatio: _videoController.value.initialized
                ? _videoController.value.aspectRatio
                : 2.344,
            child: _videoController.value.initialized
                ? VideoPlayer(_videoController)
                : Image.asset(
                    widget.featuredContent.imageUrl,
                    fit: BoxFit.cover,
                  ),
          ),
          Positioned(
            bottom: -1,
            left: 0,
            right: 0,
            child: AspectRatio(
              aspectRatio: _videoController.value.initialized
                  ? _videoController.value.aspectRatio
                  : 2.344,
              child: Container(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Colors.black, Colors.transparent],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter)),
              ),
            ),
          ),
          Positioned(
            left: 60.0,
            right: 60.0,
            bottom: 150.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 250.0,
                  child: Image.asset(widget.featuredContent.titleImageUrl),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Text(
                  widget.featuredContent.description,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                    shadows: [
                      Shadow(
                          color: Colors.black,
                          offset: Offset(2.0, 4.0),
                          blurRadius: 6.0),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: [
                    _PlayButton(),
                    SizedBox(
                      width: 16.0,
                    ),
                    FlatButton.icon(
                      padding: EdgeInsets.fromLTRB(25.0, 10.0, 30.0, 10.0),
                      onPressed: () => print('more info'),
                      color: Colors.white,
                      icon: Icon(
                        Icons.info_outline,
                        size: 30.0,
                      ),
                      label: Text(
                        'more info',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    if (_videoController.value.initialized)
                      IconButton(
                        icon: Icon(
                            _isMuted ? Icons.volume_off : Icons.volume_up,
                            color: Colors.white,
                            size: 30.0),
                        onPressed: () => setState(() {
                          _isMuted
                              ? _videoController.setVolume(100)
                              : _videoController.setVolume(0);
                          _isMuted = _videoController.value.volume == 0;
                        }),
                      )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PlayButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlatButton.icon(
      padding: !Responsive.isDesktop(context)
          ? EdgeInsets.fromLTRB(15.0, 5.0, 20.0, 5.0)
          : EdgeInsets.fromLTRB(25.0, 10.0, 30.0, 10.0),
      onPressed: () => {print('play')},
      color: Colors.white,
      icon: Icon(
        Icons.play_arrow,
        size: 30.0,
      ),
      label: Text(
        'Play',
        style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
      ),
    );
  }
}
