<p align="center">
  <img src="https://raw.githubusercontent.com/MohamadGreatWarrior/resources/refs/heads/main/cover.jpg" alt="tiktok_double_tap_like" style="border-radius: 20px;" /> <br /><br />
  <span>TikTok Double Tap Like</span>
</p>

## About

TikTok Double Tap Like is a Flutter package that provides a widget that can be used to like a video by double tapping on it, just like TikTok.

## Example

<img src="https://raw.githubusercontent.com/MohamadGreatWarrior/resources/refs/heads/main/2024-10-12%2007.36.16.gif" alt="tiktok_double_tap_like" width="250"/>

<br>
<br>

```dart
DoubleTapLikeWidget(
      onLike: (likeCount) {
        //Do something when the user double taps
      },
      likeWidget: const Image(image: AssetImage('assets/icons/heart.png')),
      likeWidth: 200,
      likeHeight: 200,
      child: VideoPlayer(),
    )
```

## Notes

* You have to provide a widget that will be displayed when the user double taps on the screen, whether `Text`, `Icon`...etc. You can use the `likeWidget` property to provide that widget.


* You can also provide the width and height of the widget using the `likeWidth` and `likeHeight` properties. The default values are 200 each.


* You have the `likeCount` param in `onLike` in case you want to know how many times the user has liked the video.


* It's pretty efficient and performant, I've created the animation explicitly using `AnimationController`, `Animation`, `Tween` and `AnimatedBuilder`. Also, there's an applied mechanism to removing the added hearts off of the screen.


## Help me

If you like this package you can support me on <br><br> <a href="https://www.buymeacoffee.com/tayan" target="_blank"><img src="https://www.buymeacoffee.com/assets/img/custom_images/orange_img.png" alt="Buy Me A Coffee" style="height: 41px !important;width: 174px !important;box-shadow: 0px 3px 2px 0px rgba(190, 190, 190, 0.5) !important;-webkit-box-shadow: 0px 3px 2px 0px rgba(190, 190, 190, 0.5) !important;" ></a>

