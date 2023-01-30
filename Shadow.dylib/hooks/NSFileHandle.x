#import "hooks.h"

%group shadowhook_NSFileHandle
%hook NSFileHandle
+ (instancetype)fileHandleForReadingAtPath:(NSString *)path {
    if([_shadow isPathRestricted:path] && !isCallerTweak()) {
        return nil;
    }
    
    return %orig;
}

+ (instancetype)fileHandleForReadingFromURL:(NSURL *)url error:(NSError * _Nullable *)error {
    if([_shadow isURLRestricted:url] && !isCallerTweak()) {
        if(error) {
            *error = [NSError errorWithDomain:NSURLErrorDomain code:NSURLErrorFileDoesNotExist userInfo:nil];
        }
        
        return nil;
    }
    
    return %orig;
}

+ (instancetype)fileHandleForWritingAtPath:(NSString *)path {
    if([_shadow isPathRestricted:path] && !isCallerTweak()) {
        return nil;
    }
    
    return %orig;
}

+ (instancetype)fileHandleForWritingToURL:(NSURL *)url error:(NSError * _Nullable *)error {
    if([_shadow isURLRestricted:url] && !isCallerTweak()) {
        if(error) {
            *error = [NSError errorWithDomain:NSURLErrorDomain code:NSURLErrorFileDoesNotExist userInfo:nil];
        }
        
        return nil;
    }
    
    return %orig;
}

+ (instancetype)fileHandleForUpdatingAtPath:(NSString *)path {
    if([_shadow isPathRestricted:path] && !isCallerTweak()) {
        return nil;
    }
    
    return %orig;
}

+ (instancetype)fileHandleForUpdatingURL:(NSURL *)url error:(NSError * _Nullable *)error {
    if([_shadow isURLRestricted:url] && !isCallerTweak()) {
        if(error) {
            *error = [NSError errorWithDomain:NSURLErrorDomain code:NSURLErrorFileDoesNotExist userInfo:nil];
        }
        
        return nil;
    }
    
    return %orig;
}
%end
%end

void shadowhook_NSFileHandle(HKSubstitutor* hooks) {
    %init(shadowhook_NSFileHandle);
}
