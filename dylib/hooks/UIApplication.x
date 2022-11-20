#import "hooks.h"

%group shadowhook_UIApplication
%hook UIApplication
- (BOOL)canOpenURL:(NSURL *)url {
    HBLogDebug(@"%@: %@", @"canOpenURL", url);
    
    if([_shadow isURLRestricted:url] && ![_shadow isCallerTweak:[NSThread callStackReturnAddresses]]) {
        return NO;
    }

    return %orig;
}
%end
%end

void shadowhook_UIApplication(void) {
    %init(shadowhook_UIApplication);
}