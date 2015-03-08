 /********* Cordova Plugin Header *******/

#import <Cordova/CDV.h>
#import <AVFoundation/AVFoundation.h>

@interface CDVAudioSession : CDVPlugin

/*
Cordova interface to calling AVAudioSession setCategory: withOptions: error:
*/
- (void)setCategoryAndOptions:(CDVInvokedUrlCommand*)command;

/*
Converts an NSString representing a AVAudioSessionCategoryOptions enum/bitmask to an actual AVAudioSessionCategoryOptions
The options string should look like a standard Objective C enum assignment, i.e.
"AVAudioSessionCategoryOptionDefaultToSpeaker|AVAudioSessionCategoryOptionAllowBluetooth"
*/
+ (AVAudioSessionCategoryOptions)audioSessionCategoryFromString:(NSString*)options;

@end
