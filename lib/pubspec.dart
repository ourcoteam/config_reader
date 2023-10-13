import 'dart:io';

Future<void> changePubspec({
  String version,
  bool remoteConfigReaderDep,
}) async {
  final file = File('pubspec.yaml');
  final lastAndroidVersionString = file.readAsLinesSync().firstWhere((element) => element.contains('version:'));
  file.writeAsStringSync('''
name: news
description: A new Flutter project.

# publish_to: "none"

${version != null ? "version: $version" : lastAndroidVersionString}

environment:
  sdk: ">=2.7.0 <3.0.0"

dependencies:
  flutter:
    sdk: flutter
  flutter_localizations:
    sdk: flutter

  file_picker: ^2.0.6
  get_it: ^5.0.1
  shared_preferences: ^0.5.12
  after_layout: ^1.0.7+2
  rect_getter: ^0.1.0
  flutter_hex_color: ^1.0.2
  mobx: ^1.2.1+2
  flutter_mobx: ^1.1.0+2
  conditional_builder: ^1.0.2
  #  dart_json_mapper: ^1.5.24
  flutter_advanced_networkimage: ^0.7.0
  bloc: ^6.0.3
  flutter_bloc: ^6.0.6
  assets_audio_player: ^2.0.15
  dartz: ^0.9.2
  freezed_annotation: 0.12.0
  flutter_funding_choices: ^0.1.1+3
  json_annotation: 3.1.1
  fluttertoast: ^7.1.1
  url_launcher: ^5.7.2
  image_picker: ^0.6.7+11
  smooth_page_indicator: ^0.2.0
  flutter_icons: ^1.1.0
  dotted_border: ^1.0.6
  http:
  flutter_fawry_pay: ^0.0.1+1
  # youtube_player_flutter: ^6.1.1
  flutter_youtube_view: ^1.1.10
  youtube_player_webview: ^1.0.0+1
  font_awesome_flutter: ^8.11.0
  country_pickers: ^1.3.0
  flutter_multi_formatter: ^1.1.8
  recase: ^3.0.1
  firebase_crashlytics: ^0.4.0+1
  cached_network_image: ^2.5.1
  mailer: ^3.2.1
  device_info: 1.0.0
  shimmer: ^1.1.1
  http_interceptor: ^0.3.2
  infinity_page_view: ^1.0.0
  share: ^0.6.5+4
  flutter_statusbarcolor: ^0.2.3
  #file_picker: ^2.0.11
  firebase_messaging: ^8.0.0-dev.11
  app_review: ^2.0.1
  flutter_svg: ^0.18.0
  store_redirect: ^1.0.2
  flutter_i18n: ^0.19.4
  path_provider: ^1.6.18
#  firebase_admob: ^0.10.0+1
  admob_flutter: ^1.0.1
  dio: ^3.0.10
  page_transition: ^1.1.7+2
  flutter_staggered_grid_view: ^0.3.2
  flash: ^1.3.1
  flutter_share: ^1.0.2+1
  in_app_review: ^0.2.1
  flare_flutter: ^2.0.6
  implicitly_animated_reorderable_list: ^0.2.3
  system_shortcuts: ^1.0.0
  html: ^0.14.0+4
  connectivity: ^0.4.9+3
  expandable: ^4.1.4
  extended_text: ^4.0.0
  # flutter_widget_from_html: ^0.5.2+1
  flutter_widget_from_html_core: 0.5.1+4
  webview_flutter: ^1.0.1
  extended_nested_scroll_view: ^1.0.1
  extended_sliver: ^1.0.1
  keyboard_avoider: ^0.1.2
  carousel_slider: ^2.2.1
  animated_size_and_fade: ^1.1.2
  flutter_sticky_header: ^0.5.0
  flutter_hooks: ^0.14.1
  google_fonts: ^1.1.0
  launch_review: ^2.0.0
  flutter_facebook_login: ^3.0.0
  google_sign_in: ^4.5.4
  video_player: ^0.10.12
  provider: ^4.3.2+2
  uni_links: ^0.4.0
  #  flutter_recaptcha_v2: ^0.1.0
  super_tooltip: ^0.9.0
  flutter_rating_bar: ^3.0.1+1
  chewie_audio: ^1.0.0+1
  dotted_line: ^2.0.1
  drop_cap_text: ^1.0.7
  sign_in_with_apple:
    git:
      url: https://github.com/ourcoteam/sign_in_with_apple_v2.git
      ref: master
  firebase_auth: ^0.20.1
  firebase_core: ^0.7.0
#  firebase_auth_oauth: ^0.2.0
  twitter_login: ^2.1.4
  badges: ^1.1.4
  notification_permissions: ^0.4.8
  flutter_tts: ^2.0.0
  html_unescape: ^1.0.2
  flutter_highlight: ^0.6.0
#   webview_flutter:
#     git:
#       url: https://github.com/ourcoteam/custom_web_view.git
#       ref: master
  rxdart: ^0.25.0
  flutter_app_badger: ^1.1.2
  app_tracking_transparency: ^1.1.0+1
#  google_mobile_ads: ^0.11.0+4
  flutter_math: 0.2.1
  mailto: 1.1.0
  permission_handler: ^5.1.0+2
  
dependency_overrides:
  flutter_svg: ^0.18.0
  build_runner_core: 6.1.7
  flutter_inappwebview:
    git:
      url: https://github.com/hosain-mohamed/custom_webview.git
      ref: main
#  analyzer: 0.39.11

dev_dependencies:
  flutter_test:
    sdk: flutter
  build_runner: 1.11.1
  freezed: 0.12.7
  json_serializable: 3.5.1
  flutter_launcher_icons: ^0.8.1
  flutter_native_splash: ^0.1.9
  flutter_launcher_name: ^0.0.1
  rename: ^1.2.0
  change_app_package_name: ^0.1.2
  ${
  remoteConfigReaderDep?'''
config_reader:
    git:
      url: https://github.com/ourcoteam/config_reader
      ref: master''':'''
config_reader:
    path: C:/Users/user/StudioProjects/config_reader'''
  }
  custom_flutter_launcher_name:
    git:
      url: https://github.com/ourcoteam/custom_flutter_launcher_name
      ref: master

flutter:
  uses-material-design: true
  assets:
    - assets/langs/en.json
    - assets/langs/ar.json
    - assets/config.json
    - assets/static_config.json
    - assets/images/
    - assets/icons/
    - assets/anim/

  fonts:
    - family: Spotlayer
      fonts:
        - asset: assets/fonts/Spotlayer.ttf
    - family: SFProDisplay
      fonts:
        - asset: assets/fonts/SFProDisplay-Regular.otf
          weight: 400
        - asset: assets/fonts/SFProDisplay-Medium.otf
          weight: 500
        - asset: assets/fonts/SFProDisplay-Semibold.otf
          weight: 600
''');
}
