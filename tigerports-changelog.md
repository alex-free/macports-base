v2.12.6.001 - 10/9/2026

* Based on v2.12.6 release with patches for 10.4.

* bootstrap_configure.sh now downloads bootstrap software (curl, openssl, gzip, libarchive, make, etc.) via tigerports.com over http using system curl (so it doesn't add size to the tigerports-base release tarballs.

* bootstrap_configure.sh now works on 10.5-10.12 (and possibly a bit higher as well).

v2.12.04.004 - 9/27/2026

* Updated base, archives, and ports to use new signify keys. This breaks selfupdate from lower versions of tigerports-base for this version, so you must use the tarball to get to this release (future versions are not affected).

* Removed obsolete tiger system libcurl code in src/pextlib1.0/curl.c (we use our own curl). 

* Removed obsolete tar code for tiger system tar (we use our own tar/libarchive now).

* Bootstrap uses bzip2 v1.0.8 on tiger.

* Bootstrap uses gzip v1.15 on Tiger.

* Bootstrap uses gnutar v1.15.1 on tiger.

* Bootstrap uses gnumake-119 (straight from open source apple for leopard: https://web.archive.org/web/20110707153724/https://opensource.apple.com/release/mac-os-x-1058/) as system make. This fixes ports that need an apple patch gnumake to build, and keeps us at parity with even sierra in capability (as Apple never moved off gnumake v3.81 even then because of not wanting GPL v3).

* New build instructions/selfupdate functions implemented. Now do:

./bootstrap_configure.sh && make && sudo make install

To setup your $PATH and envars, you can now do:

./upath.sh

* bootstrap_configure.sh: now supports custom prefixes (pass --prefix=/whatever/you/want). 

* bootstrap_configure.sh: now doesn't run everything as root blindly, and preserves privleges. It will prompt you with sudo automatically when/if neccesary depending on what the specified prefix is for base.

* Restored gnumake 3.80 compatibility for base (it just makes sense to keep base itself working on 3.80, as moving to use bootstrap gnumake3.81 from leopard to build base itself adds alot of complexity).

v2.12.04.003 - 9/22/2026

* BUILD INSTRUCTIONS HAVE CHANGED. Everything is now handled by one script, run sudo ./installer to build the bootstrap, configure the base, build the base, and install the base, all in one command.

* The installer command configures your $PATH and other shell envars.

* GNU Make v4.4.1 is now part of the bootstrap. Base is configured to use this as the system level Make.

* Bootstrap now has smarter detection and will rebuild if any of the target software is missing (to make sure upgrades such as including new software in the bootstrap is detected automatically).

* Removed Tiger specific GNU Make v3.80 workaround from base Makefile (no longer needed).

v2.12.04.002 - 8/26/2026

* Fixed bootstrap ppc detection.

* Improved bootstrap rebuild detection so that it will not rebuild only if curl successfully was built (and -f wasn't given, and its not set to false for version bump via selfupdate).

* Bootstrap now extracts tarballs instead of copying extracted source directories. This not only makes diffing this against other macports-base projects easier, but fixes issues related to copying extracted sources after they have been uploaded to git.

v2.12.04.001 - 8/26/2026

* Now at parity with MacPorts v2.12.04, specificially we are at: https://github.com/macports/macports-base/commit/227a37b749dc2991bbaf7c600dd56e46174f8206. This enables a ton of new base features and functionallity, and gets TigerPorts-base up to date with MacPorts-base as of 4/10/2026.

* New bootstrap system has been implemented. It gets Tiger able to connect and fetch software with https up to TLSv1.2, which github and gitlab still support. This means many more distfiles can be downloaded by default, lowering the burden on me keeping up hosting them on tigerports.com. Tigerports.com will still offer distfiles from the http server as backups in case any go down or are missing or if for some reasons it's faster then other mirrors it will be automatically used.

* Selfupdate has been changed to use tigerports.com server rather then macports. It also is aware of and uses the new bootstrap system.

* Further clean up, getting base as close to upstream as possible to make this easier to maintain.

v1.2.1 - 8/16/2026

* Only apply should_add_stdlib for 10.6 or less.

v1.2.0 - 8/16/2026

* Fixed launchagents on Tiger.

* Fixed proc portconfigure::should_add_stdlib {} in src/port1.0/portconfigure for gcc16 and new ppcports style toolchain.

v1.1.9 - 8/7/2026

* Updated toolchains and compilers to match PowerPC ports upstream. Intel is now at parity with PowerPC at gcc16/libgcc16.

v1.1.8 - 8/2/2026

* Update toolchains and compilers.

* Fix get_tar_flags to detect .gz and .bz2, correcting http self update for base fetch.

* Intel toolchain now configured for gcc14/libgcc14. PowerPC is configured for gcc16/libgcc16.

v1.1.7 - 8/1/2026

* Restore build_arch auto-detect.

v1.1.6 - 7/31/2026

* Rebase on tiger_upd PPCPorts-Base branch.
