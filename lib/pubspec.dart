import 'dart:io';

Future<void> changePubspec({
  String? version,
  bool? remoteConfigReaderDep,
}) async {
  final file = File('pubspec.yaml');
  final lastAndroidVersionString = file.readAsLinesSync().firstWhere((element) => element.contains('version:'));
  file.writeAsStringSync('''
name: news
description: A new Flutter project.

# publish_to: "none"

${version != null ? "version: $version" : lastAndroidVersionString}

environment:
  sdk: '>=3.0.5 <4.0.0'

dependencies:
  flutter:
    sdk: flutter
  flutter_localizations:
    sdk: flutter

  file_picker: ^5.3.3
  get_it: ^7.6.0
  shared_preferences: ^2.2.0
  after_layout: ^1.2.0
  rect_getter: ^1.1.0
  flutter_hex_color: ^2.0.0
  mobx: ^2.2.0
  flutter_mobx: ^2.0.6+5
  conditional_builder_null_safety: ^0.0.6
  #  dart_json_mapper: ^1.5.24
  flutter_advanced_networkimage_2: ^2.0.1
  bloc: ^7.0.0
  flutter_bloc: ^7.2.0
  assets_audio_player: ^3.0.6
  dartz: ^0.10.1
  freezed_annotation: ^2.4.1
  flutter_funding_choices: ^1.0.0+1
  json_annotation: ^4.8.1
  fluttertoast: ^8.2.2
  url_launcher: ^6.1.12
  image_picker: ^1.0.1
  smooth_page_indicator: ^1.1.0
  dotted_border: ^2.0.0+3
  http: ^0.13.5
  # flutter_fawry_pay: ^0.0.6+1
  youtube_player_flutter: ^8.1.2
  font_awesome_flutter: ^10.5.0
  country_pickers: ^2.0.0
  flutter_multi_formatter: ^2.11.5
  recase: ^4.1.0
  firebase_crashlytics: ^3.3.4
  cached_network_image: ^3.2.3
  mailer: ^6.0.1
  package_info_plus: ^4.1.0
  device_info_plus: ^9.0.3
  shimmer: ^3.0.0
  http_interceptor: ^1.0.0
  share: ^2.0.4
  #file_picker: ^2.0.11
  firebase_messaging: ^14.6.5
  flutter_svg: ^2.0.7
  store_redirect: ^2.0.1
  flutter_i18n: ^0.33.0
  path_provider: ^2.0.15
#  firebase_admob: ^0.10.0+1
  # admob_flutter: ^3.0.0
  dio: ^5.3.0
  page_transition: ^2.0.9
  flutter_staggered_grid_view: ^0.4.0
  flash: ^3.0.5+2
  flutter_share: ^2.0.0
  in_app_review: ^2.0.6
  flare_flutter: ^3.0.2
  implicitly_animated_reorderable_list_2: ^0.5.1
  html: ^0.15.4
  connectivity: ^3.0.6
  expandable: ^5.0.1
  extended_text: ^11.0.1
  flutter_widget_from_html: ^0.10.3
  flutter_widget_from_html_core: ^0.10.3
  webview_flutter: ^4.2.3
  extended_nested_scroll_view: ^6.0.0
  extended_sliver: ^2.1.3
  carousel_slider: ^4.2.1
  animated_size_and_fade: ^3.0.1
  flutter_sticky_header: ^0.6.5
  flutter_hooks: ^0.20.0
  google_fonts: ^4.0.0
  launch_review: ^3.0.1
  flutter_facebook_auth: ^5.0.0
  google_sign_in: ^6.1.4
  video_player: ^2.7.0
  provider: ^6.0.0
  uni_links: ^0.5.1
  #  flutter_recaptcha_v2: ^0.1.0
  super_tooltip: ^2.0.4
  flutter_rating_bar: ^4.0.1
  chewie_audio: ^1.5.0
  dotted_line: ^3.2.2
  drop_cap_text: ^1.1.3
  sign_in_with_apple: ^5.0.0
  firebase_auth: ^4.7.1
  firebase_core: ^2.15.0
#  firebase_auth_oauth: ^0.2.0
  twitter_login: ^4.0.0
  badges: ^3.1.1
  notification_permissions: ^0.6.1
  flutter_tts: ^3.7.0
  html_unescape: ^2.0.0
  flutter_highlight: ^0.7.0
  # google_mobile_ads: ^3.0.0
  rxdart: ^0.27.0
  flutter_app_badger: ^1.5.0
  app_tracking_transparency: ^2.0.4
  google_mobile_ads: ^3.0.0
  flutter_math_fork: ^0.7.1
  mailto: ^2.0.0
  # flutter_inappwebview: ^5.7.2+3
  flutter_statusbarcolor_ns: ^0.5.0
  lecle_system_shortcuts: ^0.0.1+1
  avoid_keyboard: ^0.3.0
  sliver_tools: ^0.2.12
  infinity_page_view_astro: ^1.0.0
  flutter_colorpicker: ^1.0.3
  visibility_detector: ^0.3.3
  
dependency_overrides:
  flutter_svg: ^2.0.7
  recaptcha_enterprise_flutter: ^18.4.2

dev_dependencies:
  flutter_test:
    sdk: flutter
  build_runner: ^2.4.6
  freezed: ^2.4.1
  json_serializable: ^6.7.1
  flutter_launcher_icons: ^0.13.1
  flutter_native_splash: ^2.3.1
  rename: ^2.1.1
  change_app_package_name: ^1.1.0
  lints: ^2.1.1
  ${remoteConfigReaderDep == true ? '''
config_reader:
    git:
      url: https://github.com/ourcoteam/config_reader
      ref: config_reader_nullsafety''' : '''
config_reader:
    path: C:/Users/user/StudioProjects/config_reader'''}
  custom_flutter_launcher_name:
    git:
      url: https://github.com/ourcoteam/custom_flutter_launcher_name
      ref: custom_flutter_launcher_name_nullsafety

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
