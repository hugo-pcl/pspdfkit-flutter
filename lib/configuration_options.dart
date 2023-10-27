///
///  Copyright © 2018-2023 PSPDFKit GmbH. All rights reserved.
///
///  THIS SOURCE CODE AND ANY ACCOMPANYING DOCUMENTATION ARE PROTECTED BY INTERNATIONAL COPYRIGHT LAW
///  AND MAY NOT BE RESOLD OR REDISTRIBUTED. USAGE IS BOUND TO THE PSPDFKIT LICENSE AGREEMENT.
///  UNAUTHORIZED REPRODUCTION OR DISTRIBUTION IS SUBJECT TO CIVIL AND CRIMINAL PENALTIES.
///  This notice may not be removed from this file.
///
part of pspdfkit;

/// Configuration options available that can be set by the Flutter plugin.

/// Document Interaction Options

const String scrollDirection = 'scrollDirection';
const String pageTransition = 'pageTransition';
const String enableTextSelection = 'enableTextSelection';
const String disableAutosave = 'disableAutosave';

/// Document Presentation Options

const String pageMode = 'pageMode';
const String spreadFitting = 'spreadFitting';
const String showPageLabels = 'showPageLabels';
const String startPage = 'startPage';
const String documentLabelEnabled = 'documentLabelEnabled';
const String firstPageAlwaysSingle = 'firstPageAlwaysSingle';
const String invertColors = 'invertColors';
const String password = 'password';
const String androidGrayScale = 'androidGrayScale';

/// User Interface Options

const String inlineSearch = 'inlineSearch';
const String toolbarTitle = 'toolbarTitle';
const String showActionNavigationButtons = 'showActionNavigationButtons';
const String userInterfaceViewMode = 'userInterfaceViewMode';
const String immersiveMode = 'immersiveMode';
const String appearanceMode = 'appearanceMode';
const String settingsMenuItems = 'settingsMenuItems';
const String androidShowSearchAction = 'androidShowSearchAction';
const String androidShowOutlineAction = 'androidShowOutlineAction';
const String androidShowBookmarksAction = 'androidShowBookmarksAction';
const String androidEnableDocumentEditor = 'androidEnableDocumentEditor';
const String androidShowShareAction = 'androidShowShareAction';
const String androidShowPrintAction = 'androidShowPrintAction';
const String androidShowDocumentInfoView = 'androidShowDocumentInfoView';
const String androidDarkThemeResource = 'androidDarkThemeResource';
const String androidDefaultThemeResource = 'androidDefaultThemeResource';
const String iOSLeftBarButtonItems = 'iOSLeftBarButtonItems';
const String iOSRightBarButtonItems = 'iOSRightBarButtonItems';
const String iOSAllowToolbarTitleChange = 'iOSAllowToolbarTitleChange';
const String iOSDocumentInfoOptions = 'iOSDocumentInfoOptions';

/// Thumbnail Options

const String showThumbnailBar = 'showThumbnailBar';
const String androidShowThumbnailGridAction = 'androidShowThumbnailGridAction';

/// Annotation, Forms and Bookmark Options

const String enableAnnotationEditing = 'enableAnnotationEditing';
const String androidShowAnnotationListAction =
    'androidShowAnnotationListAction';

// Instant options
const String enableInstantComments = 'enableInstantComments';

/// Deprecated Options - These options will be removed in a future release.
/// Please use the suggested alternatives instead.

@Deprecated('Use scrollDirection instead.')
const String pageScrollDirection = 'pageScrollDirection';

@Deprecated('Use pageTransition instead.')
const String pageScrollContinuous = 'scrollContinuously';

@Deprecated('Use pageMode instead.')
const String pageLayoutMode = 'pageLayoutMode';

@Deprecated('Use spreadFitting instead.')
const String fitPageToWidth = 'fitPageToWidth';

@Deprecated('Use showPageLabels instead.')
const String showPageNumberOverlay = 'showPageNumberOverlay';

@Deprecated('Use documentLabelEnabled instead.')
const String showDocumentLabel = 'showDocumentLabel';

@Deprecated('Use firstPageAlwaysSingle instead.')
const String isFirstPageAlwaysSingle = 'isFirstPageAlwaysSingle';

@Deprecated('Use androidGrayScale instead.')
const String grayScale = 'grayScale';

@Deprecated('Use immersiveMode instead.')
const String androidImmersiveMode = 'immersiveMode';

@Deprecated('Use androidShowBookmarksAction instead.')
const String androidEnableBookmarkList = 'androidEnableBookmarkList';

@Deprecated('Use androidShowDocumentInfoView instead.')
const String showDocumentInfoView = 'showDocumentInfoView';

@Deprecated('Use settingsMenuItems instead.')
const String androidSettingsMenuItems = 'androidSettingsMenuItems';

@Deprecated('Use settingsMenuItems instead.')
const String iOSSettingsMenuItems = 'iOSSettingsMenuItems';

@Deprecated('Use showActionNavigationButtons instead.')
const String iOSShowActionNavigationButtonLabels =
    'iOSShowActionNavigationButtonLabels';

/// Deprecated Strings

@Deprecated('Directly use the String value instead.')
const String horizontal = 'horizontal';

@Deprecated('Directly use the String value instead.')
const String vertical = 'vertical';

@Deprecated('Directly use the String value instead.')
const String pageScrollDirectionVertical = 'vertical';

@Deprecated('Directly use the String value instead.')
const String pageScrollDirectionHorizontal = 'vertical';

@Deprecated('Directly use the String value instead.')
const String scrollPerSpread = 'scrollPerSpread';

@Deprecated('Directly use the String value instead.')
const String scrollContinuous = 'scrollContinuous';

@Deprecated('Directly use the String value instead.')
const String pageLayoutModeAutomatic = 'automatic';

@Deprecated('Directly use the String value instead.')
const String pageLayoutModeSingle = 'single';

@Deprecated('Directly use the String value instead.')
const String pageLayoutModeDouble = 'double';

@Deprecated('Directly use the String value instead.')
const String userInterfaceViewModeAutomatic = 'automatic';

@Deprecated('Directly use the String value instead.')
const String userInterfaceViewModeAutomaticBorderPages = 'automaticBorderPages';

@Deprecated('Directly use the String value instead.')
const String userInterfaceViewModeAlwaysVisible = 'alwaysVisible';

@Deprecated('Directly use the String value instead.')
const String userInterfaceViewModeAlwaysHidden = 'alwaysHidden';

@Deprecated('Directly use the String value instead.')
const String appearanceModeDefault = 'default';

@Deprecated('Directly use the String value instead.')
const String appearanceModeNight = 'night';

@Deprecated('Directly use the String value instead.')
const String appearanceModeSepia =
    'sepia'; // Sepia mode is only supported on iOS.

@Deprecated('Directly use the String value instead.')
const String showThumbnailBarFloating = 'floating';

@Deprecated('Directly use the String value instead.')
const String showThumbnailBarPinned = 'pinned';

@Deprecated('Directly use the String value instead.')
const String showThumbnailBarScrollable = 'scrollable';

@Deprecated('Directly use the String value instead.')
const String showThumbnailBarNone = 'none';

const String pdfGenerationConfigurationName = 'name';

const String pdfGenerationConfigurationWidth = 'width';

const String pdfGenerationConfigurationHeight = 'height';

const String pdfGenerationConfigurationOverride = 'override';

const String pdfGenerationConfigurationImagePath = 'imagePath';

const String measurementUnit = 'measurementUnit';

const String enableMeasurementMagnifier = 'enableMagnifier';

const String enableMeasurementTools = 'enableMeasurementTools';

const String enableMeasurementToolSnapping = 'enableMeasurementToolSnapping';

enum ScrollDirection { horizontal, vertical }

enum PageTransition { scrollPerSpread, scrollContinuous, curl }

enum PageMode { automatic, single, double }

enum SpreadFitting { fit, fill, adaptive }

enum UserInterfaceViewMode {
  automatic,
  automaticBorderPages,
  automaticNoFirstLastPage,
  always,
  alwaysVisible,
  alwaysHidden,
  never
}

enum AppearanceMode {
  defaultMode,
  night,
  sepia;

  String get name {
    switch (this) {
      case defaultMode:
        return 'default';
      case night:
        return 'night';
      case sepia:
        return 'sepia';
      default:
        return 'default';
    }
  }
}

enum SettingsMenuItem {
  pageTransition,
  scrollDirection,
  androidTheme,
  iOSAppearance,
  androidPageLayout,
  iOSPageMode,
  iOSSpreadFitting,
  androidScreenAwake,
  iOSBrightness,
}

enum ShowThumbnailBar {
  none,
  defaultBar,
  floating,
  pinned,
  scrubberBar,
  scrollable;

  String get name {
    switch (this) {
      case none:
        return 'none';
      case defaultBar:
        return 'default';
      case floating:
        return 'floating';
      case pinned:
        return 'pinned';
      case scrubberBar:
        return 'scrubberBar';
      case scrollable:
        return 'scrollable';
      default:
        return 'default';
    }
  }
}

enum IOSBarButtonsItem {
  closeButtonItem,
  outlineButtonItem,
  searchButtonItem,
  thumbnailsButtonItem,
  documentEditorButtonItem,
  printButtonItem,
  openInButtonItem,
  emailButtonItem,
  messageButtonItem,
  annotationButtonItem,
  bookmarkButtonItem,
  brightnessButtonItem,
  activityButtonItem,
  settingsButtonItem,
  readerViewButtonItem,
}

enum IOSDocumentInfoOption {
  outline,
  annotations,
  bookmarks,
  embeddedFiles,
  documentInfo,
  security,
}
