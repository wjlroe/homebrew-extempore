class LibstbImage < Formula
  homepage "https://github.com/nothings/stb"
  head 'https://github.com/nothings/stb.git'

  def install
    # split the header-only files into header and body parts (messy)
    files = ["stb_image.h", "stb_image_resize.h", "stb_image_write.h"]

    files.each { |f|
      cfile = f.gsub("\.h","\.c")
      system "split -p \"ifdef STB_IMAGE_.*IMPLEMENTATION\" #{f}"
      File.rename("xaa", f)
      File.rename("xab", cfile)
      # add the #include <header> line to the new .c file
      system "ed -s #{cfile} <<< $'1i\n#include \"#{f}\"\n.\nwq'"
    }
    # compile the shared lib
    system ENV.cc, "-DSTB_IMAGE_IMPLEMENTATION", "-DSTB_IMAGE_RESIZE_IMPLEMENTATION", "-DSTB_IMAGE_WRITE_IMPLEMENTATION", "-DSTBI_FAILURE_USERMSG", "-dynamiclib", *files.map{ |h| h.gsub("\.h","\.c") }, "-o", "libstb_image.dylib"
    # install all the things
    include.install files
    lib.install "libstb_image.dylib"
  end

  def caveats
    s = ''
    s += <<-EOS.undent

      This formula builds a shared-library version of the
      image-related utilities from Sean T. Barrett's stb libraries.
      It includes the API from

      - stb_image.h
      - stb_image_resize.h
      - stb_image_write.h

      It's probably most useful to Extempore users, but if you find it
      helpful in other cases then go nuts.
    EOS
  end
end
