#import "hooks.h"

// %group shadowhook_objc
// %hookf(IMP, method_getImplementation, Method m) {
//     IMP result = %orig;

//     if(!isCallerTweak() && result) {
//         const char* image_name = dyld_image_path_containing_address(result);

//         if([_shadow isCPathRestricted:image_name]) {
//             return nil;
//         }
//     }

//     return result;
// }

// %hookf(Method, class_getInstanceMethod, Class cls, SEL name) {
//     Method result = %orig;

//     if(!isCallerTweak() && result) {
//         IMP impl = method_getImplementation(result);

//         if(impl) {
//             const char* image_name = dyld_image_path_containing_address(impl);

//             if([_shadow isCPathRestricted:image_name]) {
//                 return nil;
//             }
//         }
//     }

//     return result;
// }
// %end

static const char* (*original_class_getImageName)(Class cls);
static const char* replaced_class_getImageName(Class cls) {
    const char* result = original_class_getImageName(cls);

    if(isCallerTweak() || ![_shadow isCPathRestricted:result]) {
        return result;
    }

    return [[Shadow getExecutablePath] fileSystemRepresentation];
}

// static Class (*original_objc_lookUpClass)(const char* name);
// static Class replaced_objc_lookUpClass(const char* name) {
//     Class result = original_objc_lookUpClass(name);

//     if(result) {
//         if(!isCallerTweak() && [_shadow isAddrRestricted:(void *)result]) {
//             return nil;
//         }
//     }

//     return result;
// }

// static id (*original_objc_getClass)(const char* name);
// static id replaced_objc_getClass(const char* name) {
//     id result = original_objc_getClass(name);

//     if(result) {
//         if(!isCallerTweak() && [_shadow isAddrRestricted:(void *)result]) {
//             return nil;
//         }
//     }

//     return result;
// }

// static Class (*original_objc_getMetaClass)(const char* name);
// static Class replaced_objc_getMetaClass(const char* name) {
//     Class result = original_objc_getMetaClass(name);

//     if(result) {
//         if(!isCallerTweak() && [_shadow isAddrRestricted:(void *)result]) {
//             return nil;
//         }
//     }

//     return result;
// }

static const char * _Nonnull * (*original_objc_copyImageNames)(unsigned int *outCount);
static const char * _Nonnull * replaced_objc_copyImageNames(unsigned int *outCount) {
    const char * _Nonnull * result = original_objc_copyImageNames(outCount);

    if(isCallerTweak() || !result || !outCount) {
        return result;
    }

    const char* exec_name = _dyld_get_image_name(0);
    unsigned int i;

    for(i = 0; i < *outCount; i++) {
        if(strcmp(result[i], exec_name) == 0) {
            // Stop after app executable.
            // todo: improve this to filter instead
            *outCount = (i + 1);
            break;
        }
    }

    return result;
}

static const char * _Nonnull * (*original_objc_copyClassNamesForImage)(const char* image, unsigned int *outCount);
static const char * _Nonnull * replaced_objc_copyClassNamesForImage(const char* image, unsigned int *outCount) {
    if(isCallerTweak() || ![_shadow isCPathRestricted:image]) {
        return original_objc_copyClassNamesForImage(image, outCount);
    }

    return NULL;
}

static Class (*original_NSClassFromString)(NSString* aClassName);
static Class replaced_NSClassFromString(NSString* aClassName) {
    Class result = original_NSClassFromString(aClassName);

    if(isCallerTweak() || ![_shadow isAddrRestricted:(__bridge const void *)result]) {
        return result;
    }

    return nil;
}

void shadowhook_objc(HKSubstitutor* hooks) {
    // %init(shadowhook_objc);
    MSHookFunction(class_getImageName, replaced_class_getImageName, (void **) &original_class_getImageName);
    MSHookFunction(objc_copyClassNamesForImage, replaced_objc_copyClassNamesForImage, (void **) &original_objc_copyClassNamesForImage);
    MSHookFunction(objc_copyImageNames, replaced_objc_copyImageNames, (void **) &original_objc_copyImageNames);
}

void shadowhook_objc_hidetweakclasses(HKSubstitutor* hooks) {
    MSHookFunction(NSClassFromString, replaced_NSClassFromString, (void **) &original_NSClassFromString);
    // MSHookFunction(objc_getMetaClass, replaced_objc_getMetaClass, (void **) &original_objc_getMetaClass);
    // MSHookFunction(objc_getClass, replaced_objc_getClass, (void **) &original_objc_getClass);
    // MSHookFunction(objc_lookUpClass, replaced_objc_lookUpClass, (void **) &original_objc_lookUpClass);
}
