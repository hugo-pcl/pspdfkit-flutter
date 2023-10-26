part of pspdfkit;

class PspdfkitConfiguration {
  final ScrollDirection? _scrollDirection;
  final PageTransition? _pageTransition;
  final bool? _enableTextSelection;
  final bool? _disableAutosave;

  final PageMode? _pageMode;
  final SpreadFitting? _spreadFitting;
  final bool? _showPageLabels;
  final int? _startPage;
  final bool? _documentLabelEnabled;
  final bool? _firstPageAlwaysSingle;
  final bool? _invertColors;
  final String? _password;
  final bool? _androidGrayScale;

  final bool? _inlineSearch;
  final String? _toolbarTitle;
  final bool? _showActionNavigationButtons;
  final UserInterfaceViewMode? _userInterfaceViewMode;
  final bool? _immersiveMode;
  final AppearanceMode? _appearanceMode;
  final List<SettingsMenuItem>? _settingsMenuItems;
  final bool? _androidShowSearchAction;
  final bool? _androidShowOutlineAction;
  final bool? _androidShowBookmarksAction;
  final bool? _androidEnableDocumentEditor;
  final bool? _androidShowShareAction;
  final bool? _androidShowPrintAction;
  final bool? _androidShowDocumentInfoView;
  final String? _androidDarkThemeResource;
  final String? _androidDefaultThemeResource;
  final List<IOSBarButtonsItem>? _iOSLeftBarButtonItems;
  final List<IOSBarButtonsItem>? _iOSRightBarButtonItems;
  final bool? _iOSAllowToolbarTitleChange;

  final ShowThumbnailBar? _showThumbnailBar;
  final bool? _androidShowThumbnailGridAction;

  final bool? _enableAnnotationEditing;
  final bool? _androidShowAnnotationListAction;

  final bool? _enableInstantComments;

  const PspdfkitConfiguration({
    ScrollDirection? scrollDirection,
    PageTransition? pageTransition,
    bool? enableTextSelection,
    bool? disableAutosave,
    PageMode? pageMode,
    SpreadFitting? spreadFitting,
    bool? showPageLabels,
    int? startPage,
    bool? documentLabelEnabled,
    bool? firstPageAlwaysSingle,
    bool? invertColors,
    String? password,
    bool? androidGrayScale,
    bool? inlineSearch,
    String? toolbarTitle,
    bool? showActionNavigationButtons,
    UserInterfaceViewMode? userInterfaceViewMode,
    bool? immersiveMode,
    AppearanceMode? appearanceMode,
    List<SettingsMenuItem>? settingsMenuItems,
    bool? androidShowSearchAction,
    bool? androidShowOutlineAction,
    bool? androidShowBookmarksAction,
    bool? androidEnableDocumentEditor,
    bool? androidShowShareAction,
    bool? androidShowPrintAction,
    bool? androidShowDocumentInfoView,
    String? androidDarkThemeResource,
    String? androidDefaultThemeResource,
    List<IOSBarButtonsItem>? iOSLeftBarButtonItems,
    List<IOSBarButtonsItem>? iOSRightBarButtonItems,
    bool? iOSAllowToolbarTitleChange,
    ShowThumbnailBar? showThumbnailBar,
    bool? androidShowThumbnailGridAction,
    bool? enableAnnotationEditing,
    bool? androidShowAnnotationListAction,
    bool? enableInstantComments,
  })  : _scrollDirection = scrollDirection,
        _pageTransition = pageTransition,
        _enableTextSelection = enableTextSelection,
        _disableAutosave = disableAutosave,
        _pageMode = pageMode,
        _spreadFitting = spreadFitting,
        _showPageLabels = showPageLabels,
        _startPage = startPage,
        _documentLabelEnabled = documentLabelEnabled,
        _firstPageAlwaysSingle = firstPageAlwaysSingle,
        _invertColors = invertColors,
        _password = password,
        _androidGrayScale = androidGrayScale,
        _inlineSearch = inlineSearch,
        _toolbarTitle = toolbarTitle,
        _showActionNavigationButtons = showActionNavigationButtons,
        _userInterfaceViewMode = userInterfaceViewMode,
        _immersiveMode = immersiveMode,
        _appearanceMode = appearanceMode,
        _settingsMenuItems = settingsMenuItems,
        _androidShowSearchAction = androidShowSearchAction,
        _androidShowOutlineAction = androidShowOutlineAction,
        _androidShowBookmarksAction = androidShowBookmarksAction,
        _androidEnableDocumentEditor = androidEnableDocumentEditor,
        _androidShowShareAction = androidShowShareAction,
        _androidShowPrintAction = androidShowPrintAction,
        _androidShowDocumentInfoView = androidShowDocumentInfoView,
        _androidDarkThemeResource = androidDarkThemeResource,
        _androidDefaultThemeResource = androidDefaultThemeResource,
        _iOSLeftBarButtonItems = iOSLeftBarButtonItems,
        _iOSRightBarButtonItems = iOSRightBarButtonItems,
        _iOSAllowToolbarTitleChange = iOSAllowToolbarTitleChange,
        _showThumbnailBar = showThumbnailBar,
        _androidShowThumbnailGridAction = androidShowThumbnailGridAction,
        _enableAnnotationEditing = enableAnnotationEditing,
        _androidShowAnnotationListAction = androidShowAnnotationListAction,
        _enableInstantComments = enableInstantComments;

  Map<String, dynamic> toMap() {
    return {
      scrollDirection: _scrollDirection?.name,
      pageTransition: _pageTransition?.name,
      enableTextSelection: _enableTextSelection,
      disableAutosave: _disableAutosave,
      pageMode: _pageMode?.name,
      spreadFitting: _spreadFitting?.name,
      showPageLabels: _showPageLabels,
      startPage: _startPage,
      documentLabelEnabled: _documentLabelEnabled,
      firstPageAlwaysSingle: _firstPageAlwaysSingle,
      invertColors: _invertColors,
      password: _password,
      androidGrayScale: _androidGrayScale,
      inlineSearch: _inlineSearch,
      toolbarTitle: _toolbarTitle,
      showActionNavigationButtons: _showActionNavigationButtons,
      userInterfaceViewMode: _userInterfaceViewMode?.name,
      immersiveMode: _immersiveMode,
      appearanceMode: _appearanceMode?.name,
      settingsMenuItems: _settingsMenuItems?.map((e) => e.name).toList(),
      androidShowSearchAction: _androidShowSearchAction,
      androidShowOutlineAction: _androidShowOutlineAction,
      androidShowBookmarksAction: _androidShowBookmarksAction,
      androidEnableDocumentEditor: _androidEnableDocumentEditor,
      androidShowShareAction: _androidShowShareAction,
      androidShowPrintAction: _androidShowPrintAction,
      androidShowDocumentInfoView: _androidShowDocumentInfoView,
      androidDarkThemeResource: _androidDarkThemeResource,
      androidDefaultThemeResource: _androidDefaultThemeResource,
      iOSLeftBarButtonItems:
          _iOSLeftBarButtonItems?.map((e) => e.name).toList(),
      iOSRightBarButtonItems:
          _iOSRightBarButtonItems?.map((e) => e.name).toList(),
      iOSAllowToolbarTitleChange: _iOSAllowToolbarTitleChange,
      showThumbnailBar: _showThumbnailBar?.name,
      androidShowThumbnailGridAction: _androidShowThumbnailGridAction,
      enableAnnotationEditing: _enableAnnotationEditing,
      androidShowAnnotationListAction: _androidShowAnnotationListAction,
      enableInstantComments: _enableInstantComments,
    }..removeWhere((key, value) => value == null);
  }
}
