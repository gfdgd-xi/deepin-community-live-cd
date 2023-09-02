#undef _LARGEFILE_SOURCE
#undef _FILE_OFFSET_BITS
#define _LARGEFILE_SOURCE
#define _FILE_OFFSET_BITS 64
#if defined(__PPC__) && !defined(__powerpc__)
#define __powerpc__ 1
#endif

#define GCRYPT_NO_DEPRECATED 1

/* Define to 1 to enable disk cache statistics.  */
#define DISK_CACHE_STATS 0
#define BOOT_TIME_STATS 0
/* Define to 1 to make GRUB quieter at boot time.  */
#define QUIET_BOOT 0

#if defined (GRUB_BUILD)
#undef ENABLE_NLS
#define BUILD_SIZEOF_LONG 8
#define BUILD_SIZEOF_VOID_P 8
#if defined __APPLE__
# if defined __BIG_ENDIAN__
#  define BUILD_WORDS_BIGENDIAN 1
# else
#  define BUILD_WORDS_BIGENDIAN 0
# endif
#else
#define BUILD_WORDS_BIGENDIAN 0
#endif
#elif defined (GRUB_UTIL) || !defined (GRUB_MACHINE)
#include <config-util.h>
#else
#define HAVE_FONT_SOURCE 1
/* Define if C symbols get an underscore after compilation. */
#define HAVE_ASM_USCORE 0
/* Define it to \"addr32\" or \"addr32;\" to make GAS happy.  */
#define ADDR32 addr32
/* Define it to \"data32\" or \"data32;\" to make GAS happy. */
#define DATA32 data32
/* Define it to one of __bss_start, edata and _edata.  */
#define BSS_START_SYMBOL __bss_start
/* Define it to either end or _end.  */
#define END_SYMBOL end
/* Name of package.  */
#define PACKAGE "grub"
/* Version number of package.  */
#define VERSION "2.02~beta2"
/* Define to the full name and version of this package. */
#define PACKAGE_STRING "GRUB 2.02~beta2-57"
/* Define to the version of this package. */
#define PACKAGE_VERSION "2.02~beta2-57"
/* Define to the full name of this package. */
#define PACKAGE_NAME "GRUB"
/* Define to the address where bug reports for this package should be sent. */
#define PACKAGE_BUGREPORT "bug-grub@gnu.org"

#define GRUB_TARGET_CPU "i386"
#define GRUB_PLATFORM "efi"

#define RE_ENABLE_I18N 1

#define _GNU_SOURCE 1

#endif
