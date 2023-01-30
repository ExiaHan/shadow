#import "hooks.h"

%group shadowhook_NSFileVersion
%hook NSFileVersion
+ (NSFileVersion *)currentVersionOfItemAtURL:(NSURL *)url {
    if([_shadow isURLRestricted:url] && !isCallerTweak()) {
        return nil;
    }

    return %orig;
}

+ (NSArray<NSFileVersion *> *)otherVersionsOfItemAtURL:(NSURL *)url {
    if([_shadow isURLRestricted:url] && !isCallerTweak()) {
        return nil;
    }

    return %orig;
}

+ (NSFileVersion *)versionOfItemAtURL:(NSURL *)url forPersistentIdentifier:(id)persistentIdentifier {
    if([_shadow isURLRestricted:url] && !isCallerTweak()) {
        return nil;
    }

    return %orig;
}

+ (NSURL *)temporaryDirectoryURLForNewVersionOfItemAtURL:(NSURL *)url {
    if([_shadow isURLRestricted:url] && !isCallerTweak()) {
        return nil;
    }

    return %orig;
}

+ (NSFileVersion *)addVersionOfItemAtURL:(NSURL *)url withContentsOfURL:(NSURL *)contentsURL options:(NSFileVersionAddingOptions)options error:(NSError * _Nullable *)outError {
    if(([_shadow isURLRestricted:url] || [_shadow isURLRestricted:contentsURL]) && !isCallerTweak()) {
        if(outError) {
            *outError = [NSError errorWithDomain:NSURLErrorDomain code:NSURLErrorFileDoesNotExist userInfo:nil];
        }

        return nil;
    }

    return %orig;
}

+ (NSArray<NSFileVersion *> *)unresolvedConflictVersionsOfItemAtURL:(NSURL *)url {
    if([_shadow isURLRestricted:url] && !isCallerTweak()) {
        return nil;
    }

    return %orig;
}

- (NSURL *)replaceItemAtURL:(NSURL *)url options:(NSFileVersionReplacingOptions)options error:(NSError * _Nullable *)error {
    if([_shadow isURLRestricted:url] && !isCallerTweak()) {
        if(error) {
            *error = [NSError errorWithDomain:NSURLErrorDomain code:NSURLErrorFileDoesNotExist userInfo:nil];
        }

        return nil;
    }

    return %orig;
}

+ (BOOL)removeOtherVersionsOfItemAtURL:(NSURL *)url error:(NSError * _Nullable *)outError {
    if([_shadow isURLRestricted:url] && !isCallerTweak()) {
        return NO;
    }

    return %orig;
}

+ (void)getNonlocalVersionsOfItemAtURL:(NSURL *)url completionHandler:(void (^)(NSArray<NSFileVersion *> *nonlocalFileVersions, NSError *error))completionHandler {
    if([_shadow isURLRestricted:url] && !isCallerTweak()) {
        if(completionHandler) {
            completionHandler(nil, [NSError errorWithDomain:NSURLErrorDomain code:NSURLErrorFileDoesNotExist userInfo:nil]);
        }

        return;
    }

    %orig;
}
%end
%end

void shadowhook_NSFileVersion(HKSubstitutor* hooks) {
    %init(shadowhook_NSFileVersion);
}
