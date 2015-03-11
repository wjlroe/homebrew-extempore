class LibstbImage < Formula
  homepage "https://github.com/nothings/stb"
  url "https://raw.githubusercontent.com/nothings/stb/master/stb_image.h"
  sha256 "37c9f8d3bf2e121bcab3a55ad5f01fd380365c67bbae69dc2b7c7eed7364291d"

  def install
    # split the header-only file into header and body parts (messy)
    system "split -p \"ifdef STB_IMAGE_IMPLEMENTATION\" stb_image.h"
    File.rename "xaa", "stb_image.h"
    File.rename "xab", "stb_image.c"
    # add the #include "stb_image.h" line to the new .c file
    system "ed -s stb_image.c <<< $'1i\n#include \"stb_image.h\"\n.\nwq'"
    # compile the shared lib
    system ENV.cc, "-DSTB_IMAGE_IMPLEMENTATION", "-DSTBI_FAILURE_USERMSG", "-dynamiclib", "stb_image.c", "-o", "libstb_image.dylib"
    # install all the things
    include.install "stb_image.h"
    lib.install "libstb_image.dylib"
  end
end
