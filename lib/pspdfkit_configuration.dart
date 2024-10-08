part of pspdfkit;

/// {@template pspdfkit_configuration}
/// Options:
/// * [scrollDirection] - Configures the direction of page scrolling in the document view.
/// * [pageTransition] - Configures the page transition style used when changing pages.
/// * [enableTextSelection] - Enables text selection in the document.
/// * [disableAutosave] - Disables automatic saving of the document.
/// * [pageMode] - Configures the page mode used when the document is opened.
/// * [spreadFitting] - Configures the spread fitting mode used when the document is opened. `adaptive` is not supported on Android.
/// * [showPageLabels] - Displays the current page number over the document view.
/// * [startPage] - Sets the page that should be visible when the document is opened.
/// * [documentLabelEnabled] - Shows an overlay displaying the document name.
/// * [firstPageAlwaysSingle] - Option to show the first page separately.
/// * [invertColors] - Inverts the colors of the document.
/// * [password] - Sets the password used to decrypt the document.
/// * [androidGrayScale] - Renders the document in grayscale. Only available on Android.
/// * [inlineSearch] - Sets the type of search bar to be inline or modular.
/// * [toolbarTitle] - Sets the title of the toolbar. For iOS, you need to set documentLabelEnabled, iOSUseParentNavigationBar, and iOSAllowToolbarTitleChange to false in your configuration before setting the custom title.
/// * [showActionNavigationButtons] - Shows or hides the navigation buttons in the toolbar.
/// * [userInterfaceViewMode] - Configures the user interface view mode.
/// * [immersiveMode] - Hides the user interface if set to true.
/// * [appearanceMode] - Configures the appearance mode used when the document is opened.
/// * [settingsMenuItems] - Options that will be presented in the settings menu. The options prefixed with iOS or Android only work on the respective platform. Options without any prefix work on both platforms.
/// * [androidShowSearchAction] - Enables / disables document search functionality. For iOS, add searchButtonItem to iOSLeftBarButtonItems or iOSRightBarButtonItems to achieve the same functionality.
/// * [androidShowOutlineAction] - Enables / disables outline functionality. For iOS, add outlineButtonItem to iOSLeftBarButtonItems or iOSRightBarButtonItems to achieve the same functionality.
/// * [androidShowBookmarksAction] - Enables / disables bookmark functionality. For iOS, add bookmarkButtonItem to iOSLeftBarButtonItems or iOSRightBarButtonItems to achieve the same functionality.
/// * [androidEnableDocumentEditor] - Enables / disables document editor functionality. For iOS, add documentEditorButtonItem to iOSLeftBarButtonItems or iOSRightBarButtonItems to achieve the same functionality.
/// * [androidShowShareAction] - Enables / disables share functionality. For iOS, add activityButtonItem to iOSLeftBarButtonItems or iOSRightBarButtonItems to achieve the same functionality.
/// * [androidShowPrintAction] - Enables / disables print functionality. For iOS, add printButtonItem to iOSLeftBarButtonItems or iOSRightBarButtonItems to achieve the same functionality.
/// * [androidShowDocumentInfoView] - Enables / disables document info functionality. For iOS, add outlineButtonItem to iOSLeftBarButtonItems or iOSRightBarButtonItems to achieve the same functionality.
/// * [androidDarkThemeResource] - Sets the dark theme resource name. Only available on Android.
/// * [androidDefaultThemeResource] - Sets the default theme resource name. Only available on Android.
/// * [iOSLeftBarButtonItems] - Sets the left bar button items. Only available on iOS. Android, set individual options such as androidShowOutlineAction, androidShowSearchAction, etc. to achieve the same functionality.
/// * [iOSRightBarButtonItems] - Sets the right bar button items. Only available on iOS. Android, set individual options such as androidShowOutlineAction, androidShowSearchAction, etc. to achieve the same functionality.
/// * [iOSDocumentInfoOptions] - Sets the document info view options.
/// * [iOSAllowToolbarTitleChange] - Allow PSPDFKit to change the title of this view controller.
/// * [showThumbnailBar] - Thumbnail bar mode controls the display of page thumbnails viewing a document.
/// * [androidShowThumbnailGridAction] - Enables / disables thumbnail grid functionality. For iOS, add thumbnailsButtonItem to iOSLeftBarButtonItems or iOSRightBarButtonItems to achieve the same functionality.
/// * [enableAnnotationEditing] - Enables / disables annotation editing functionality.
/// * [androidShowAnnotationListAction] - Enables / disables annotation list functionality. For iOS, add outlineButtonItem to iOSLeftBarButtonItems or iOSRightBarButtonItems to achieve the same functionality.
/// * [enableInstantComments] - Enables / disables instant comments functionality.
/// {@endtemplate}
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
  final bool? _androidEnableContentEditing;
  final bool? _androidShowShareAction;
  final bool? _androidShowPrintAction;
  final bool? _androidShowDocumentInfoView;
  final String? _androidDarkThemeResource;
  final String? _androidDefaultThemeResource;
  final List<IOSBarButtonsItem>? _iOSLeftBarButtonItems;
  final List<IOSBarButtonsItem>? _iOSRightBarButtonItems;
  final List<IOSDocumentInfoOption>? _iOSDocumentInfoOptions;
  final bool? _iOSAllowToolbarTitleChange;

  final ShowThumbnailBar? _showThumbnailBar;
  final bool? _androidShowThumbnailGridAction;

  final bool? _enableAnnotationEditing;
  final bool? _androidShowAnnotationListAction;

  final bool? _enableInstantComments;

  /// {@macro pspdfkit_configuration}
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
    bool? androidEnableContentEditing,
    bool? androidShowShareAction,
    bool? androidShowPrintAction,
    bool? androidShowDocumentInfoView,
    String? androidDarkThemeResource,
    String? androidDefaultThemeResource,
    List<IOSBarButtonsItem>? iOSLeftBarButtonItems,
    List<IOSBarButtonsItem>? iOSRightBarButtonItems,
    List<IOSDocumentInfoOption>? iOSDocumentInfoOptions,
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
        _androidEnableContentEditing = androidEnableContentEditing,
        _androidShowShareAction = androidShowShareAction,
        _androidShowPrintAction = androidShowPrintAction,
        _androidShowDocumentInfoView = androidShowDocumentInfoView,
        _androidDarkThemeResource = androidDarkThemeResource,
        _androidDefaultThemeResource = androidDefaultThemeResource,
        _iOSLeftBarButtonItems = iOSLeftBarButtonItems,
        _iOSRightBarButtonItems = iOSRightBarButtonItems,
        _iOSDocumentInfoOptions = iOSDocumentInfoOptions,
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
      androidEnableContentEditing: _androidEnableContentEditing,
      androidShowShareAction: _androidShowShareAction,
      androidShowPrintAction: _androidShowPrintAction,
      androidShowDocumentInfoView: _androidShowDocumentInfoView,
      androidDarkThemeResource: _androidDarkThemeResource,
      androidDefaultThemeResource: _androidDefaultThemeResource,
      iOSLeftBarButtonItems:
          _iOSLeftBarButtonItems?.map((e) => e.name).toList(),
      iOSRightBarButtonItems:
          _iOSRightBarButtonItems?.map((e) => e.name).toList(),
      iOSDocumentInfoOptions:
          _iOSDocumentInfoOptions?.map((e) => e.name).toList(),
      iOSAllowToolbarTitleChange: _iOSAllowToolbarTitleChange,
      showThumbnailBar: _showThumbnailBar?.name,
      androidShowThumbnailGridAction: _androidShowThumbnailGridAction,
      enableAnnotationEditing: _enableAnnotationEditing,
      androidShowAnnotationListAction: _androidShowAnnotationListAction,
      enableInstantComments: _enableInstantComments,
    }..removeWhere((key, value) => value == null);
  }
}
