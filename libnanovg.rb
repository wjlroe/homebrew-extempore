class Libnanovg < Formula
  homepage "https://github.com/memononen/nanovg"
  head "https://github.com/benswift/nanovg.git"

  depends_on "freetype" => :build
  depends_on "cmake" => :build

  def install
    system "cmake", ".", *std_cmake_args
    system "make", "install"
  end
end
