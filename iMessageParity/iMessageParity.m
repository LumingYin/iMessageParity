@import AppKit;
#import "ZKSwizzle.h"

@interface IMMessageItem: NSObject {
    NSString *_expressiveSendStyleID;
}
@property(retain, nonatomic) NSString *expressiveSendStyleID; // @synthesize expressiveSendStyleID=_expressiveSendStyleID;
@end


@interface ChatViewController : NSViewController
- (void)_sendMessage;
- (void)_sendMessage:(BOOL)arg1 forceSend:(BOOL)arg2;
- (void)_sendMessage:(IMMessageItem *)arg1;
- (void)sendFile:(IMMessageItem *)arg1;
- (void)inputLineDidEnter:(id)arg1 isAudioMessage:(BOOL)arg2 expressiveSendStyleID:(NSString *)arg3;
@end

@interface _WB_ChatViewController: NSViewController
@end


@implementation _WB_ChatViewController

+(void)load
{
    ZKSwizzle(_WB_ChatViewController, ChatViewController);
}

- (void)_sendMessage:(BOOL)arg1 forceSend:(BOOL)arg2 {
    NSLog(@"WE CARE: Trying to send a message! _sendMessage:(BOOL)arg1 forceSend:(BOOL)arg2");
    ZKOrig(void, arg1, arg2);
}

- (void)_sendMessage {
    NSLog(@"WE CARE: Trying to send a message! _sendMessage");
    ZKOrig(void);
}

- (void)inputLineDidEnter:(id)arg1 isAudioMessage:(BOOL)arg2 expressiveSendStyleID:(NSString *)arg3 {
    NSAlert *alert = [[NSAlert alloc] init];
    
    [alert addButtonWithTitle:@"No effect"];
    [alert addButtonWithTitle:@"Slam"];
    [alert addButtonWithTitle:@"Loud"];
    [alert addButtonWithTitle:@"Gentle"];
    [alert addButtonWithTitle:@"Invisible Ink"];
    
    [alert addButtonWithTitle:@"Echo"];
    [alert addButtonWithTitle:@"Spotlight"];
    [alert addButtonWithTitle:@"Balloons"];
    [alert addButtonWithTitle:@"Confetti"];
    [alert addButtonWithTitle:@"Love"];
    [alert addButtonWithTitle:@"Lasers"];
    [alert addButtonWithTitle:@"Fireworks"];
    [alert addButtonWithTitle:@"Shooting Star"];
    [alert addButtonWithTitle:@"Celebration"];
    
    [alert setMessageText:@"Send with effect"];
    [alert setInformativeText:@"Select a bubble effect or full screen effect. All effects, except Invisible Ink, are only visible if the receiver is viewing the message on an iOS device."];
    [alert setAlertStyle:NSAlertStyleWarning];
    NSUInteger runResult = [alert runModal];
    if (runResult == 1001) {
        arg3 = @"com.apple.MobileSMS.expressivesend.impact";
    } else if (runResult == 1002) {
        arg3 = @"com.apple.MobileSMS.expressivesend.loud";
    } else if (runResult == 1003) {
        arg3 = @"com.apple.MobileSMS.expressivesend.gentle";
    } else if (runResult == 1004) {
        arg3 = @"com.apple.MobileSMS.expressivesend.invisibleink";
    } else if (runResult == 1005) {
        arg3 = @"com.apple.messages.effect.CKEchoEffect";
    } else if (runResult == 1006) {
        arg3 = @"com.apple.messages.effect.CKSpotlightEffect";
    } else if (runResult == 1007) {
        arg3 = @"com.apple.messages.effect.CKHappyBirthdayEffect";
    } else if (runResult == 1008) {
        arg3 = @"com.apple.messages.effect.CKConfettiEffect";
    } else if (runResult == 1009) {
        arg3 = @"com.apple.messages.effect.CKHeartEffect";
    } else if (runResult == 1010) {
        arg3 = @"com.apple.messages.effect.CKLasersEffect";
    } else if (runResult == 1011) {
        arg3 = @"com.apple.messages.effect.CKFireworksEffect";
    } else if (runResult == 1012) {
        arg3 = @"com.apple.messages.effect.CKShootingStarEffect";
    } else if (runResult == 1013) {
        arg3 = @"com.apple.messages.effect.CKSparklesEffect";
    }

    ZKOrig(void, arg1, arg2, arg3);
}

@end
