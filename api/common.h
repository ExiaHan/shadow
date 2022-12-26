#define BYPASS_VERSION      "5.1"
#define API_VERSION         "6.0"

#define BUNDLE_ID           "me.jjolano.shadow"
#define MACH_SERVICE_NAME   BUNDLE_ID ".service"
#define SHADOW_DB_PLIST     "/Library/Shadow/rulesets/dpkgInstalled.plist"
#define SHADOW_PREFS_PLIST  "/var/mobile/Library/Preferences/" BUNDLE_ID ".plist"

#ifdef DEBUG
#define NSLog(...) NSLog(__VA_ARGS__)
#else
#define NSLog(...) (void)0
#endif