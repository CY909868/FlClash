// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Config _$ConfigFromJson(Map<String, dynamic> json) => Config()
  ..profiles = (json['profiles'] as List<dynamic>?)
          ?.map((e) => Profile.fromJson(e as Map<String, dynamic>))
          .toList() ??
      []
  ..currentProfileId = json['currentProfileId'] as String?
  ..autoLaunch = json['autoLaunch'] as bool? ?? false
  ..silentLaunch = json['silentLaunch'] as bool? ?? false
  ..autoRun = json['autoRun'] as bool? ?? false
  ..themeMode = $enumDecodeNullable(_$ThemeModeEnumMap, json['themeMode']) ??
      ThemeMode.system
  ..openLogs = json['openLogs'] as bool? ?? false
  ..locale = json['locale'] as String?
  ..primaryColor = (json['primaryColor'] as num?)?.toInt()
  ..proxiesSortType =
      $enumDecodeNullable(_$ProxiesSortTypeEnumMap, json['proxiesSortType']) ??
          ProxiesSortType.none
  ..proxiesLayout =
      $enumDecodeNullable(_$ProxiesLayoutEnumMap, json['proxiesLayout']) ??
          ProxiesLayout.standard
  ..isMinimizeOnExit = json['isMinimizeOnExit'] as bool? ?? true
  ..isAccessControl = json['isAccessControl'] as bool? ?? false
  ..accessControl =
      AccessControl.fromJson(json['accessControl'] as Map<String, dynamic>)
  ..dav = json['dav'] == null
      ? null
      : DAV.fromJson(json['dav'] as Map<String, dynamic>)
  ..isAnimateToPage = json['isAnimateToPage'] as bool? ?? true
  ..isCompatible = json['isCompatible'] as bool? ?? true
  ..autoCheckUpdate = json['autoCheckUpdate'] as bool? ?? true
  ..onlyProxy = json['onlyProxy'] as bool? ?? false
  ..prueBlack = json['prueBlack'] as bool? ?? false
  ..isCloseConnections = json['isCloseConnections'] as bool? ?? false
  ..proxiesType = $enumDecodeNullable(_$ProxiesTypeEnumMap, json['proxiesType'],
          unknownValue: ProxiesType.tab) ??
      ProxiesType.tab
  ..proxyCardType =
      $enumDecodeNullable(_$ProxyCardTypeEnumMap, json['proxyCardType']) ??
          ProxyCardType.expand
  ..testUrl =
      json['test-url'] as String? ?? 'https://www.gstatic.com/generate_204'
  ..isExclude = json['isExclude'] as bool? ?? false
  ..windowProps =
      WindowProps.fromJson(json['windowProps'] as Map<String, dynamic>?)
  ..vpnProps = VpnProps.fromJson(json['vpnProps'] as Map<String, dynamic>?)
  ..desktopProps =
      DesktopProps.fromJson(json['desktopProps'] as Map<String, dynamic>?)
  ..showLabel = json['showLabel'] as bool? ?? false;

Map<String, dynamic> _$ConfigToJson(Config instance) => <String, dynamic>{
      'profiles': instance.profiles,
      'currentProfileId': instance.currentProfileId,
      'autoLaunch': instance.autoLaunch,
      'silentLaunch': instance.silentLaunch,
      'autoRun': instance.autoRun,
      'themeMode': _$ThemeModeEnumMap[instance.themeMode]!,
      'openLogs': instance.openLogs,
      'locale': instance.locale,
      'primaryColor': instance.primaryColor,
      'proxiesSortType': _$ProxiesSortTypeEnumMap[instance.proxiesSortType]!,
      'proxiesLayout': _$ProxiesLayoutEnumMap[instance.proxiesLayout]!,
      'isMinimizeOnExit': instance.isMinimizeOnExit,
      'isAccessControl': instance.isAccessControl,
      'accessControl': instance.accessControl,
      'dav': instance.dav,
      'isAnimateToPage': instance.isAnimateToPage,
      'isCompatible': instance.isCompatible,
      'autoCheckUpdate': instance.autoCheckUpdate,
      'onlyProxy': instance.onlyProxy,
      'prueBlack': instance.prueBlack,
      'isCloseConnections': instance.isCloseConnections,
      'proxiesType': _$ProxiesTypeEnumMap[instance.proxiesType]!,
      'proxyCardType': _$ProxyCardTypeEnumMap[instance.proxyCardType]!,
      'test-url': instance.testUrl,
      'isExclude': instance.isExclude,
      'windowProps': instance.windowProps,
      'vpnProps': instance.vpnProps,
      'desktopProps': instance.desktopProps,
      'showLabel': instance.showLabel,
    };

const _$ThemeModeEnumMap = {
  ThemeMode.system: 'system',
  ThemeMode.light: 'light',
  ThemeMode.dark: 'dark',
};

const _$ProxiesSortTypeEnumMap = {
  ProxiesSortType.none: 'none',
  ProxiesSortType.delay: 'delay',
  ProxiesSortType.name: 'name',
};

const _$ProxiesLayoutEnumMap = {
  ProxiesLayout.loose: 'loose',
  ProxiesLayout.standard: 'standard',
  ProxiesLayout.tight: 'tight',
};

const _$ProxiesTypeEnumMap = {
  ProxiesType.tab: 'tab',
  ProxiesType.list: 'list',
};

const _$ProxyCardTypeEnumMap = {
  ProxyCardType.expand: 'expand',
  ProxyCardType.shrink: 'shrink',
  ProxyCardType.min: 'min',
};

_$AccessControlImpl _$$AccessControlImplFromJson(Map<String, dynamic> json) =>
    _$AccessControlImpl(
      mode: $enumDecodeNullable(_$AccessControlModeEnumMap, json['mode']) ??
          AccessControlMode.rejectSelected,
      acceptList: (json['acceptList'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      rejectList: (json['rejectList'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      sort: $enumDecodeNullable(_$AccessSortTypeEnumMap, json['sort']) ??
          AccessSortType.none,
      isFilterSystemApp: json['isFilterSystemApp'] as bool? ?? true,
    );

Map<String, dynamic> _$$AccessControlImplToJson(_$AccessControlImpl instance) =>
    <String, dynamic>{
      'mode': _$AccessControlModeEnumMap[instance.mode]!,
      'acceptList': instance.acceptList,
      'rejectList': instance.rejectList,
      'sort': _$AccessSortTypeEnumMap[instance.sort]!,
      'isFilterSystemApp': instance.isFilterSystemApp,
    };

const _$AccessControlModeEnumMap = {
  AccessControlMode.acceptSelected: 'acceptSelected',
  AccessControlMode.rejectSelected: 'rejectSelected',
};

const _$AccessSortTypeEnumMap = {
  AccessSortType.none: 'none',
  AccessSortType.name: 'name',
  AccessSortType.time: 'time',
};

_$CoreStateImpl _$$CoreStateImplFromJson(Map<String, dynamic> json) =>
    _$CoreStateImpl(
      accessControl: json['accessControl'] == null
          ? null
          : AccessControl.fromJson(
              json['accessControl'] as Map<String, dynamic>),
      currentProfileName: json['currentProfileName'] as String,
      enable: json['enable'] as bool,
      allowBypass: json['allowBypass'] as bool,
      systemProxy: json['systemProxy'] as bool,
      mixedPort: (json['mixedPort'] as num).toInt(),
      onlyProxy: json['onlyProxy'] as bool,
    );

Map<String, dynamic> _$$CoreStateImplToJson(_$CoreStateImpl instance) =>
    <String, dynamic>{
      'accessControl': instance.accessControl,
      'currentProfileName': instance.currentProfileName,
      'enable': instance.enable,
      'allowBypass': instance.allowBypass,
      'systemProxy': instance.systemProxy,
      'mixedPort': instance.mixedPort,
      'onlyProxy': instance.onlyProxy,
    };

_$WindowPropsImpl _$$WindowPropsImplFromJson(Map<String, dynamic> json) =>
    _$WindowPropsImpl(
      width: (json['width'] as num?)?.toDouble() ?? 1000,
      height: (json['height'] as num?)?.toDouble() ?? 600,
      top: (json['top'] as num?)?.toDouble(),
      left: (json['left'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$WindowPropsImplToJson(_$WindowPropsImpl instance) =>
    <String, dynamic>{
      'width': instance.width,
      'height': instance.height,
      'top': instance.top,
      'left': instance.left,
    };

_$VpnPropsImpl _$$VpnPropsImplFromJson(Map<String, dynamic> json) =>
    _$VpnPropsImpl(
      enable: json['enable'] as bool? ?? true,
      systemProxy: json['systemProxy'] as bool? ?? false,
      allowBypass: json['allowBypass'] as bool? ?? true,
    );

Map<String, dynamic> _$$VpnPropsImplToJson(_$VpnPropsImpl instance) =>
    <String, dynamic>{
      'enable': instance.enable,
      'systemProxy': instance.systemProxy,
      'allowBypass': instance.allowBypass,
    };

_$DesktopPropsImpl _$$DesktopPropsImplFromJson(Map<String, dynamic> json) =>
    _$DesktopPropsImpl(
      systemProxy: json['systemProxy'] as bool? ?? true,
    );

Map<String, dynamic> _$$DesktopPropsImplToJson(_$DesktopPropsImpl instance) =>
    <String, dynamic>{
      'systemProxy': instance.systemProxy,
    };
