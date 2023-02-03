# Shadow

A jailbreak detection bypass for modern iOS jailbreaks.

## Known Issues

### palera1n (rooted)

While Shadow does work fine on palera1n, please note the following potential issues:

* Re-jailbreaking does not reactivate `libSandy` due to the lack of userspace rebooting. This may be fixed in a future update to the jailbreak itself. You will need to reinstall the `libSandy` package otherwise Shadow will not function.
* On 16.2 (and probably future versions), Substitute appears to have issues hooking C functions. This may be fixed in a future update to the jailbreak if/when it switches to ElleKit. For now, please use the `fishhook` hooking library.
* You may see `shdw: Killed: 9` upon installation of Shadow and subsequently other tweaks. This is due to (a lack of?) codesigning on palera1n. This does not affect functionality. `AutoSign` can be installed to fix this.

### Xina (iOS 15)

Make sure Rootless mode is enabled. Shadow may or may not work. There are no guarantees.

## Submitting Issues

I only offer support in English.

Before submitting a new issue, please ensure the following details are provided:

* iOS version
* Jailbreak type (Taurine, unc0ver, palera1n, etc...)
* Code substitution platform (libhooker, Substitute, Substrate, ElleKit)
* Options used
* Apps affected

Please do not submit issues about detection, unless it **currently** works on a previous version of Shadow.

If a certain option is causing apps to crash, please include the name of the option.

## Troubleshooting

Some ideas to try:

* Use a different hooking library. `fishhook` is a safe option.
* Disable all tweaks except Shadow. You can use Choicy or libhooker Configurator to do this per-app.
* Use vnodebypass, if supported on your system.
* If semi-(un)tethered, reboot into normal jailed iOS and use the app.
* Use another bypass tweak, ideally an app-specific bypass tweak. Be wary of enabling multiple bypass tweaks in case of conflicts.
* Downgrade the app. Sometimes, newer versions have updated detection methods.

## Contributing

Pull requests are welcome. For translations, please refer to the [English translation](ShadowSettings.bundle/Resources/en.lproj/) within the preference bundle resource files.

## Installation

Add my [repo](https://ios.jjolano.me) to your package manager and install the Shadow (`me.jjolano.shadow`) package. Alternatively, download the [latest release](https://github.com/jjolano/shadow/releases/latest) directly from GitHub and open the file with your package manager.

You may need additional repositories for dependencies - these are the current dependencies:

* `libSandy` from [opa334's Repo](https://opa334.github.io)
* `AltList` from [opa334‘s Repo](https://opa334.github.io)
* `HookKit Framework`

A recommended (but not required) package is `Injection Foundation` from PoomSmart's Repo (`https://poomsmart.github.io/repo`). This package ensures that Shadow is injected properly into certain apps.

## Usage

After installation, settings are available in the Settings app. You may configure global defaults, or add an app-specific configuration. Shadow allows fine-grained control of its bypass strength, so there will be many options available to configure.

## Legal

*Copyright Act*, RSC 1985, c C-42, s 41.12.
