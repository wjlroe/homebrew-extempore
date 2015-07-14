class Libnanovg < Formula
  homepage "https://github.com/memononen/nanovg"
  head "https://github.com/benswift/nanovg.git"

  depends_on 'premake' => :build
  depends_on 'freetype' => :build

  def install
    # set correct path to freetype
    inreplace "premake4.lua", "includedirs { \"src\" }", "includedirs { \"src\", \"#{Formula["freetype"].include}/freetype2\" }"

    system "premake4", "gmake"
    cd "build"
    system "make", "config=release", "nanovg"
    cd ".."
    include.install ["src/nanovg.h", "src/nanovg_gl.h"]
    lib.install "build/libnanovg.dylib"
  end
end
