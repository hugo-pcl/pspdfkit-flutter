//
//  Copyright © 2018-2023 PSPDFKit GmbH. All rights reserved.
//
//  THIS SOURCE CODE AND ANY ACCOMPANYING DOCUMENTATION ARE PROTECTED BY INTERNATIONAL COPYRIGHT LAW
//  AND MAY NOT BE RESOLD OR REDISTRIBUTED. USAGE IS BOUND TO THE PSPDFKIT LICENSE AGREEMENT.
//  UNAUTHORIZED REPRODUCTION OR DISTRIBUTION IS SUBJECT TO CIVIL AND CRIMINAL PENALTIES.
//  This notice may not be removed from this file.
//
#import "PspdfkitPlugin.h"
#import "PspdfPlatformViewFactory.h"
#import "PspdfkitFlutterHelper.h"
#import "PspdfkitFlutterConverter.h"
#import "pspdfkit_flutter-Swift.h"

@import PSPDFKit;
@import PSPDFKitUI;
@import Instant;

static FlutterMethodChannel *channel;

@interface CustomAnalyticsClient : NSObject<PSPDFAnalyticsClient>

PSPDF_EXPORT PSPDFAnalyticsEventName const PSPDFAnalyticsEventNameDocumentFullyLoaded;

- (void)logEvent:(PSPDFAnalyticsEventName)event attributes:(nullable NSDictionary<NSString *, id> *)attributes;

@end

@implementation CustomAnalyticsClient

PSPDFAnalyticsEventName const PSPDFAnalyticsEventNameDocumentFullyLoaded = @"fully_loaded";

- (void)logEvent:(PSPDFAnalyticsEventName)event attributes:(NSDictionary<NSString *, id> * _Nullable)attributes {
    if (event == PSPDFAnalyticsEventNameSpreadChange) {
        NSDictionary *arguments = @{
            @"oldPageIndex": [attributes objectForKey:@"previous_spread_index"],
            @"newPageIndex": [attributes objectForKey:@"new_spread_index"]
        };
        dispatch_async(dispatch_get_main_queue(), ^{
            [channel invokeMethod:@"pspdfkitPageChanged" arguments:arguments];
        });
    }
    if (event == PSPDFAnalyticsEventNameDocumentFullyLoaded) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSDictionary *arguments = @{
                @"uid": [attributes objectForKey:@"uid"],
                @"pageCount": [attributes objectForKey:@"pageCount"]
            };
            [channel invokeMethod:@"pspdfkitDocumentLoaded" arguments:arguments];
        });
    }
    if (event == PSPDFAnalyticsEventNameBookmarkSelect) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [channel invokeMethod:@"pspdfkitBookmarkTapped" arguments:nil];
        });
    }
    if (event == PSPDFAnalyticsEventNameBookmarkAdd) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [channel invokeMethod:@"pspdfkitBookmarkAdded" arguments:nil];
        });
    }
    if (event == PSPDFAnalyticsEventNameBookmarkEdit) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [channel invokeMethod:@"pspdfkitBookmarkEdited" arguments:nil];
        });
    }
    if (event == PSPDFAnalyticsEventNameBookmarkRemove) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [channel invokeMethod:@"pspdfkitBookmarkRemoved" arguments:nil];
        });
    }
    if (event == PSPDFAnalyticsEventNameBookmarkRename) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [channel invokeMethod:@"pspdfkitBookmarkRenamed" arguments:nil];
        });
    }
    if (event == PSPDFAnalyticsEventNameBookmarkSort) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [channel invokeMethod:@"pspdfkitBookmarksSorted" arguments:nil];
        });
    }
}
@end

@interface PspdfkitPlugin() <PSPDFViewControllerDelegate, PSPDFInstantClientDelegate>
@property (nonatomic) PSPDFViewController *pdfViewController;
@end

@implementation PspdfkitPlugin

PSPDFSettingKey const PSPDFSettingKeyHybridEnvironment = @"com.pspdfkit.hybrid-environment";

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    PspdfPlatformViewFactory *platformViewFactory = [[PspdfPlatformViewFactory alloc] initWithMessenger:[registrar messenger]];
    [registrar registerViewFactory:platformViewFactory withId:@"com.pspdfkit.widget"];
    
    channel = [FlutterMethodChannel methodChannelWithName:@"com.pspdfkit.global" binaryMessenger:[registrar messenger]];
    PspdfkitPlugin* instance = [[PspdfkitPlugin alloc] init];
    [registrar addMethodCallDelegate:instance channel:channel];
    
    PSPDFKitGlobal.sharedInstance.analytics.enabled = YES;
    id<PSPDFAnalyticsClient> analyticsClient = [[CustomAnalyticsClient alloc] init];
    [PSPDFKitGlobal.sharedInstance.analytics addAnalyticsClient:analyticsClient];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
    if ([@"frameworkVersion" isEqualToString:call.method]) {
        result([@"iOS " stringByAppendingString:PSPDFKitGlobal.versionNumber]);
    } else if ([@"setLicenseKey" isEqualToString:call.method]) {
        NSString *licenseKey = call.arguments[@"licenseKey"];
        [PSPDFKitGlobal setLicenseKey:licenseKey options:@{PSPDFSettingKeyHybridEnvironment: @"Flutter"}];
    } else if ([@"setLicenseKeys" isEqualToString:call.method]) {
        NSString *iOSLicenseKey = call.arguments[@"iOSLicenseKey"];
        [PSPDFKitGlobal setLicenseKey:iOSLicenseKey options:@{PSPDFSettingKeyHybridEnvironment: @"Flutter"}];
    }else if ([@"present" isEqualToString:call.method]) {
        
        NSString *documentPath = call.arguments[@"document"];

        if (documentPath == nil || documentPath.length <= 0) {
            FlutterError *error = [FlutterError errorWithCode:@"" message:@"Document path may not be nil or empty." details:nil];
            result(error);
            return;
        }
        
        NSDictionary *configurationDictionary = [PspdfkitFlutterConverter processConfigurationOptionsDictionaryForPrefix:call.arguments[@"configuration"]];
        
        PSPDFDocument *document = [PspdfkitFlutterHelper documentFromPath:documentPath];
        if (document == nil) {
            FlutterError *error = [FlutterError errorWithCode:@"" message:@"Document is missing or invalid." details:nil];
            result(error);
            return;
        }
        
        // Add page count in custom document loaded event
        PSPDFPageCount count = [document pageCount];
        NSDictionary *arguments = @{
            @"uid": [document UID],
            @"pageCount": @(count),
        };
        
        [PSPDFKitGlobal.sharedInstance.analytics logEvent:PSPDFAnalyticsEventNameDocumentFullyLoaded attributes:arguments];
        
        NSDictionary *measurementScale = call.arguments[@"measurementScale"];
        if (measurementScale){
            PSPDFMeasurementScale *scale = [PspdfkitMeasurementConvertor convertScaleWithMeasurement:measurementScale];
            if (scale != nil) {
                document.measurementScale = scale;
            }
        }
        
        NSString *measurementPrecision = call.arguments[@"measurementPrecision"];
        
        if (measurementPrecision){
            PSPDFMeasurementPrecision precision = [PspdfkitMeasurementConvertor convertPrecisionWithPrecision:measurementPrecision];
            document.measurementPrecision = precision;
        }
       
        [PspdfkitFlutterHelper unlockWithPasswordIfNeeded:document dictionary:configurationDictionary];
        
        BOOL isImageDocument = [PspdfkitFlutterHelper isImageDocument:documentPath];
        PSPDFConfiguration *configuration = [PspdfkitFlutterConverter configuration:configurationDictionary isImageDocument:isImageDocument];
        
        self.pdfViewController = [[PSPDFViewController alloc] initWithDocument:document configuration:configuration];
        [self setupViewController:configurationDictionary result:result];

    }else if([@"presentInstant" isEqualToString:call.method]){
        NSString *jwt = call.arguments[@"jwt"];
        NSString *serverUrlString = call.arguments[@"serverUrl"];
        NSURL *serverUrl = [[NSURL alloc] initWithString:serverUrlString];
        
        if (serverUrlString == nil || serverUrlString.length <= 0) {
            FlutterError *error = [FlutterError errorWithCode:@"" message:@"Server URL path may not be nil or empty." details:nil];
            result(error);
            return;
        }

         if (jwt == nil || jwt.length <= 0) {
            FlutterError *error = [FlutterError errorWithCode:@"" message:@"JWT may not be nil or empty." details:nil];
            result(error);
            return;
        }
        
        NSDictionary *configurationDictionary = [PspdfkitFlutterConverter processConfigurationOptionsDictionaryForPrefix:call.arguments[@"configuration"]];
       
        BOOL enableInstantComments = [configurationDictionary[@"enableInstantComments"] boolValue];
        PSPDFConfiguration *configuration = [PspdfkitFlutterConverter configuration:configurationDictionary isImageDocument:false];
        InstantDocumentInfo *documentInfo = [[InstantDocumentInfo alloc] initWithServerURL:serverUrl url:serverUrl jwt:jwt];
        
        InstantDocumentViewController *instantViewController = [[InstantDocumentViewController alloc] initWithDocumentInfo:documentInfo configurations:[(PSPDFBaseConfiguration *) configuration configurationUpdatedWithBuilder:^(PSPDFConfigurationBuilder *builder) {
            // Add `PSPDFAnnotationStringInstantCommentMarker` to the `editableAnnotationTypes` to enable editing of Instant Comments.
            if (enableInstantComments) {
                NSMutableSet *editableAnnotationTypes = [builder.editableAnnotationTypes mutableCopy];
                [editableAnnotationTypes addObject:PSPDFAnnotationStringInstantCommentMarker];
                builder.editableAnnotationTypes = editableAnnotationTypes;
            }
        }] error:nil];
        
        // Set the Instant client delegate to receive events from the Instant client.
        PSPDFInstantClient *client = instantViewController.client;
        client.delegate = self;

        self.pdfViewController = instantViewController;
        [self setupViewController:configurationDictionary result:result];
        
    } else if ([@"getTemporaryDirectory" isEqualToString:call.method]) {
        result([self getTemporaryDirectory]);
    }else if ([@"setAnnotationPresetConfigurations" isEqualToString:call.method]) {
        [AnnotationsPresetConfigurations setConfigurationsWithAnnotationPreset:call.arguments[@"annotationConfigurations"]];
        result(nil);
    } else {
        [PspdfkitFlutterHelper processMethodCall:call result:result forViewController:self.pdfViewController];
    }
}

- (void) setupViewController:(NSDictionary *)configurationDictionary result:(FlutterResult)result  {
    
        self.pdfViewController.appearanceModeManager.appearanceMode = [PspdfkitFlutterConverter appearanceMode:configurationDictionary];
        self.pdfViewController.pageIndex = [PspdfkitFlutterConverter pageIndex:configurationDictionary];
        self.pdfViewController.delegate = self;
        
        if ((id)configurationDictionary != NSNull.null) {
            NSString *key;
            
            key = @"leftBarButtonItems";
            if (configurationDictionary[key]) {
                [PspdfkitFlutterHelper setLeftBarButtonItems:configurationDictionary[key] forViewController:self.pdfViewController];
            }
            key = @"rightBarButtonItems";
            if (configurationDictionary[key]) {
                [PspdfkitFlutterHelper setRightBarButtonItems:configurationDictionary[key] forViewController:self.pdfViewController];
            }
            key = @"invertColors";
            if (configurationDictionary[key]) {
                self.pdfViewController.appearanceModeManager.appearanceMode = [configurationDictionary[key] boolValue] ? PSPDFAppearanceModeNight : PSPDFAppearanceModeDefault;
            }
            key = @"toolbarTitle";
            if (configurationDictionary[key]) {
                [PspdfkitFlutterHelper setToolbarTitle:configurationDictionary[key] forViewController:self.pdfViewController];
            }
            key = @"documentInfoOptions";
            if (configurationDictionary[key]) {
                [PspdfkitFlutterHelper setDocumentInfoOptions:configurationDictionary[key] forViewController:self.pdfViewController];
            }
            
        }
            
        PSPDFNavigationController *navigationController = [[PSPDFNavigationController alloc] initWithRootViewController:self.pdfViewController];
        navigationController.modalPresentationStyle = UIModalPresentationFullScreen;
        UIViewController *presentingViewController = [UIApplication sharedApplication].delegate.window.rootViewController;
        [presentingViewController presentViewController:navigationController animated:YES completion:nil];
        result(@(YES));
 }

- (NSString*)getTemporaryDirectory {
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    return paths.firstObject;
}

// MARK: - PSPDFViewControllerDelegate

- (void)pdfViewControllerWillDismiss:(PSPDFViewController *)pdfController {
    [channel invokeMethod:@"pdfViewControllerWillDismiss" arguments:nil];
}

- (void)pdfViewControllerDidDismiss:(PSPDFViewController *)pdfController {
    [channel invokeMethod:@"pdfViewControllerDidDismiss" arguments:nil];
}

- (void)instantClient:(nonnull PSPDFInstantClient *)instantClient didFailAuthenticationForDocumentDescriptor:(nonnull id<PSPDFInstantDocumentDescriptor>)documentDescriptor {
    NSDictionary *arguments = @{
        @"error": @"Authentication failed",
        @"documentId": documentDescriptor.identifier
    };
    [channel invokeMethod:@"pspdfkitInstantAuthenticationFailed" arguments:arguments];
}

- (void)instantClient:(nonnull PSPDFInstantClient *)instantClient documentDescriptor:(nonnull id<PSPDFInstantDocumentDescriptor>)documentDescriptor didFailReauthenticationWithError:(nonnull NSError *)error {
    NSDictionary *arguments = @{
        @"documentId": documentDescriptor.identifier,
        @"error": error.localizedDescription
    };
    [channel invokeMethod:@"pspdfkitInstantAuthenticationFailed" arguments:arguments];
}

- (void)instantClient:(PSPDFInstantClient *)instantClient documentDescriptor:(id<PSPDFInstantDocumentDescriptor>)documentDescriptor didFinishReauthenticationWithJWT:(NSString *)validJWT{
    NSDictionary *arguments = @{
        @"documentId": documentDescriptor.identifier,
        @"jwt": validJWT
    };
    [channel invokeMethod:@"pspdfkitInstantAuthenticationFinished" arguments:arguments];
}

- (void)instantClient:(PSPDFInstantClient *)instantClient didBeginSyncForDocumentDescriptor:(id<PSPDFInstantDocumentDescriptor>)documentDescriptor {
    [channel invokeMethod:@"pspdfkitInstantSyncStarted" arguments:documentDescriptor.identifier];
}

- (void)instantClient:(PSPDFInstantClient *)instantClient didFinishSyncForDocumentDescriptor:(id<PSPDFInstantDocumentDescriptor>)documentDescriptor{
    [channel invokeMethod:@"pspdfkitInstantSyncFinished" arguments:documentDescriptor.identifier];
}

- (void)instantClient:(PSPDFInstantClient *)instantClient documentDescriptor:(id<PSPDFInstantDocumentDescriptor>)documentDescriptor didFailSyncWithError:(NSError *)error{
    NSDictionary *arguments = @{
        @"documentId": documentDescriptor.identifier,
        @"error": error.localizedDescription
    };
    [channel invokeMethod:@"pspdfkitInstantSyncFailed" arguments:arguments];
}

- (void)instantClient:(nonnull PSPDFInstantClient *)instantClient didFinishDownloadForDocumentDescriptor:(nonnull id<PSPDFInstantDocumentDescriptor>)documentDescriptor {
    [channel invokeMethod:@"pspdfkitInstantDownloadFinished" arguments:documentDescriptor.identifier];
}

- (void)instantClient:(nonnull PSPDFInstantClient *)instantClient documentDescriptor:(nonnull id<PSPDFInstantDocumentDescriptor>)documentDescriptor didFailDownloadWithError:(nonnull NSError *)error {
    NSDictionary *arguments = @{
        @"documentId": documentDescriptor.identifier,
        @"error": error.localizedDescription
    };
    [channel invokeMethod:@"pspdfkitInstantDownloadFailed" arguments:arguments];
}

- (void)dealloc {
    self.pdfViewController = nil;
}

@end
