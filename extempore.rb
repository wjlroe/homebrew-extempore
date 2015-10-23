class Extempore < Formula
  homepage "http://extempore.moso.com.au"
  url      "https://github.com/digego/extempore/archive/0.6.0.tar.gz"
  # sha256   "TODO"
  head     "https://github.com/digego/extempore.git"

  option "with-stdlib", "AOT-compile the standard library"

  depends_on "cmake" => :build
  depends_on "extempore-llvm"
  # stdlib dependencies
  depends_on "assimp" if build.with? "stdlib"
  depends_on "glfw3" if build.with? "stdlib"
  depends_on "libkiss-fft" if build.with? "stdlib"
  depends_on "libnanovg" if build.with? "stdlib"
  depends_on "libsndfile" if build.with? "stdlib"
  depends_on "libstb-image" if build.with? "stdlib"
  depends_on "portmidi" if build.with? "stdlib"

  def install
    ENV["EXT_LLVM_DIR"] = "#{HOMEBREW_PREFIX}/Cellar/extempore-llvm/3.7.0"
    system "cmake", "-DIN_TREE=OFF", ".", *std_cmake_args
    system "make", "install"
    system "make", "aot_stdlib"
    system "make", "assets" if build.with? "stdlib"
  end

  def caveats; <<-EOS.undent
    Extempore now lives in "#{HOMEBREW_PREFIX}/bin, so you no longer
    have to cd into #{prefix} to use it.

    If you have any problems, raise them on extemporelang@googlegroups.com
    EOS
  end
end
