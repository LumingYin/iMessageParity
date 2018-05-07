@import AppKit;
#import "ZKSwizzle.h"

@interface IMMessageItem: NSObject {
    NSString *_expressiveSendStyleID;
}
@property(retain, nonatomic) NSString *expressiveSendStyleID;
@end

@interface ChatViewController : NSViewController
- (void)_sendMessage;
- (void)_sendMessage:(BOOL)arg1 forceSend:(BOOL)arg2;
- (void)_sendMessage:(IMMessageItem *)arg1;
- (void)sendFile:(IMMessageItem *)arg1;
- (void)inputLineDidEnter:(id)arg1 isAudioMessage:(BOOL)arg2 expressiveSendStyleID:(NSString *)arg3;
@end

ChatViewController *chatView;
NSMutableArray *styleIDs;

@interface iMessageParity : NSObject
@end

@implementation iMessageParity

+(void)load {
    styleIDs = [[NSMutableArray alloc] init];
    [styleIDs addObjectsFromArray:@[@"", @"com.apple.MobileSMS.expressivesend.impact", @"com.apple.MobileSMS.expressivesend.loud", @"com.apple.MobileSMS.expressivesend.gentle", @"com.apple.MobileSMS.expressivesend.invisibleink", @"com.apple.messages.effect.CKEchoEffect", @"com.apple.messages.effect.CKSpotlightEffect", @"com.apple.messages.effect.CKHappyBirthdayEffect", @"com.apple.messages.effect.CKConfettiEffect", @"com.apple.messages.effect.CKHeartEffect", @"com.apple.messages.effect.CKLasersEffect", @"com.apple.messages.effect.CKFireworksEffect", @"com.apple.messages.effect.CKShootingStarEffect", @"com.apple.messages.effect.CKSparklesEffect"]];
    
    NSLog(@"WE CARE: loaded iMessageParity");
}

@end


ZKSwizzleInterface(_WB_SOInputLineViewController, SOInputLineViewController, NSViewController)
@implementation _WB_SOInputLineViewController

- (void)sendButtonClick:(NSButton *)sender {
    NSString *effectString = styleIDs[sender.tag];
    [chatView inputLineDidEnter:chatView isAudioMessage:false expressiveSendStyleID:effectString];
}

- (void)partyButtonClick:(NSButton *)sender {
    // Create view controller
    NSViewController *viewController = [[NSViewController alloc] init];
    viewController = [[NSViewController alloc] initWithNibName:@"partyView" bundle:[NSBundle bundleWithIdentifier:@"com.sky.imessageParity"]];

    // Setup buttons
    for (NSButton* btn in viewController.view.subviews) {
        if (btn.class == NSClassFromString(@"NSButton")) {
            [btn setTarget:self];
            [btn setAction:@selector(sendButtonClick:)];
        }
    }

    // Create popover
    NSPopover *entryPopover = [[NSPopover alloc] init];
    [entryPopover setContentSize:viewController.view.frame.size];
    [entryPopover setBehavior:NSPopoverBehaviorTransient];
    [entryPopover setAnimates:YES];
    [entryPopover setContentViewController:viewController];
    
    // Convert point to main window coordinates
    NSRect entryRect = [sender convertRect:sender.bounds
                                    toView:[[NSApp mainWindow] contentView]];
    
    // Show popover
    [entryPopover showRelativeToRect:entryRect
                              ofView:[[NSApp mainWindow] contentView]
                       preferredEdge:NSMaxXEdge];
}

- (void)viewDidAppear {
    static dispatch_once_t once;
    dispatch_once(&once, ^ {
        NSButton *smile = [self valueForKey:@"_smileyButton"];
        NSRect newFrame = smile.frame;
        newFrame.origin.x -= 20;
        NSString *bundlePath = [[NSBundle bundleWithIdentifier:@"com.sky.imessageParity"] bundlePath];
        NSImage *partyTime = [[NSImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/Contents/Resources/party.pdf", bundlePath]];
        NSButton *effectsButton = [[NSButton alloc] init];
        [effectsButton setFrame:newFrame];
        [effectsButton setTarget:self];
        [effectsButton setTitle:@"🎉"];
        [effectsButton setAction:@selector(partyButtonClick:)];
        [effectsButton setBezelStyle:NSShadowlessSquareBezelStyle];
        [effectsButton setImage:partyTime];
        [effectsButton setImageScaling:NSImageScaleProportionallyUpOrDown];
        [effectsButton setBordered:false];
        [effectsButton setHidden:NO];
        [effectsButton setAutoresizingMask:NSViewMinXMargin];
        [smile.superview addSubview:effectsButton];
    });
    ZKOrig(void);
}

@end

ZKSwizzleInterface(_WB_ChatViewController, ChatViewController, NSViewController)
@implementation _WB_ChatViewController

- (void)viewDidAppear {
    chatView = (ChatViewController*)self;
    NSLog(@"WE CARE: Hooked");
    ZKOrig(void);
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
    NSLog(@"WE CARE: Trying to send a message! %@ : %hhd: %@", arg1, arg2, arg3);
    ZKOrig(void, arg1, arg2, arg3);
}

@end
