#import "CDVAudioSession.h"
#import <Cordova/CDV.h>

@implementation CDVAudioSession

- (void)setCategoryAndOptions:(CDVInvokedUrlCommand*)command;
{
    CDVPluginResult *pluginResult    = nil;
    NSString        *category        = nil;
    NSString        *categoryOptions = nil;
    NSString        *errorMessage    = @"Invalid number of parameters";

    if (command.arguments.count == 1){
      category        = [command.arguments objectAtIndex:0];
    } else if (command.arguments.count == 2){
      category        = [command.arguments objectAtIndex:0];
      categoryOptions = [command.arguments objectAtIndex:1];
    }

    if (category != nil && category.length != 0){
        AVAudioSession *audioSession      = [AVAudioSession sharedInstance];
        NSError        *setCategoryError  = nil;
        BOOL           setSession         = NO;

        AVAudioSessionCategoryOptions options = [CDVAudioSession audioSessionCategoryFromString:categoryOptions];

        //0 indicates we don't have an options value
        if (options != 0){
            [audioSession setCategory:category
                          withOptions:options
                                error:&setCategoryError];
        } else {
            [audioSession setCategory:category
                                error:&setCategoryError];        
        }
      
        if (setCategoryError != nil || !setSession){
            errorMessage = setCategoryError != nil ? setCategoryError.description :
                                                     @"AVAudioSession returned NO but did not provide an NSError";
            NSLog(@"Unable to set Audio Session values %@ to %@: %@",
                  category,
                  categoryOptions,
                  errorMessage);
        } else {
          pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK]; 
        }
    }

    // Assume we have an error if we didn't set a success message
    if (pluginResult == nil){
      pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:errorMessage];
    }
  
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

+ (AVAudioSessionCategoryOptions)audioSessionCategoryFromString:(NSString*)options
{
    AVAudioSessionCategoryOptions retVal = 0;

    if (options != nil && options.length != 0){
      NSArray *parsedOptions = [options componentsSeparatedByString:@"|"];
      
      foreach (NSString *option in parsedOptions){
        NSString *cleanedOption = [option stringByReplacingOccurrencesOfString:@" " withString:@""];
  
        if ([cleanedOption isEqualToString:"AVAudioSessionCategoryOptionMixWithOthers"]){
          retVal = retVal | AVAudioSessionCategoryOptionMixWithOthers;
        } else if ([cleanedOption isEqualToString:"AVAudioSessionCategoryOptionDuckOthers"]){
          retVal = retVal | AVAudioSessionCategoryOptionDuckOthers;
        } else if ([cleanedOption isEqualToString:"AVAudioSessionCategoryOptionAllowBluetooth"]){
          retVal = retVal | AVAudioSessionCategoryOptionAllowBluetooth;
        } else if ([cleanedOption isEqualToString:"AVAudioSessionCategoryOptionDefaultToSpeaker"]){
          retVal = retVal | AVAudioSessionCategoryOptionDefaultToSpeaker;
        }
      }
    }
    
    return retVal;
}

@end
