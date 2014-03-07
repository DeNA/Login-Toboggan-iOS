//
//  MB_WW_MobageWeb+Internal.h
//  NGMobageUS
//
//  Created by Chris Toliver on 8/12/13.
//  Copyright (c) 2013 ngmoco:). All rights reserved.
//

#import "MB_WW_MobageWeb.h"

#define MB_WEB_CONTENTS_TIME_OUT 15

@interface MB_WW_MobageWeb () {
    NSTimer *__webContentsTimer;
}
#if OS_OBJECT_USE_OBJC
@property (nonatomic, strong) dispatch_queue_t openMobageWebQ; // this is for Xcode 4.5 with LLVM 4.1 and iOS 6 SDK
#else
@property (nonatomic, assign) dispatch_queue_t openMobageWebQ; // this is for older Xcodes with older SDKs
#endif
@property (nonatomic, copy) void(^closeCallback)(MBDismissableAPIStatus, NSObject<MBError>*, NSDictionary*);
@property (nonatomic, assign) BOOL showing;
@property (nonatomic, assign) BOOL showNativeSpinner;

+(MB_WW_MobageWeb*)sharedInstance;
+(NSString*)urlEncode:(id)obj;
+(NSString*)urlEncodedStringFromDictionary:(NSDictionary*)dict;
+(NSString*)urlDecode:(NSString*)str;
+(void)popNetworkErrorDialogForActionsWithoutACallback;
-(void)initHostsWith:(NSString**)sandboxPrefix dotSandboxPrefix:(NSString**)dotSandboxPrefix stagePrefix:(NSString**)stagePrefix;
-(NSString*)apiHost;
-(NSString*)webViewHost;
-(void)setRect;
-(void)closeWithError:(NSError*)error;

-(void)startWebContentsTimer;
-(void)stopWebContentsTimer;

@end
