class LibstbImage < Formula
  homepage "https://github.com/benswift/stb"
  head 'https://github.com/benswift/stb.git'

  depends_on "cmake" => :build

  def install
    system "cmake", ".", *std_cmake_args
    system "make", "install"
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
