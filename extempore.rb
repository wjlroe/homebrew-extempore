class Extempore < Formula
  homepage "http://extempore.moso.com.au"
  url      "https://github.com/digego/extempore/archive/0.6.0.tar.gz"
  # sha256   "TODO"
  head     "https://github.com/digego/extempore.git"

  option "with-aot", "AOT-compile the standard library"
  option "with-aot-extended", "AOT-compile the extended standard library"

  depends_on "cmake" => :build
  depends_on "extempore-llvm"
  # stdlib dependencies
  depends_on "assimp" if build.with? "aot-extended"
  depends_on "glfw3" if build.with? "aot-extended"
  depends_on "libkiss-fft" if build.with? "aot-extended"
  depends_on "libnanovg" if build.with? "aot-extended"
  depends_on "libsndfile" if build.with? "aot-extended"
  depends_on "libstb-image" if build.with? "aot-extended"
  depends_on "portmidi" if build.with? "aot-extended"

  def install
    ENV["EXT_LLVM_DIR"] = "#{HOMEBREW_PREFIX}/Cellar/extempore-llvm/3.7.0"
    system "cmake", "-DIN_TREE=OFF", ".", *std_cmake_args
    system "make", "install"
    system "make", "aot" if build.with? "aot"
    system "make", "aot-extended" if build.with? "aot-extended"
    system "make", "assets" if build.with? "aot-extended"
  end

  def caveats; <<-EOS.undent
    Extempore now lives in "#{HOMEBREW_PREFIX}/bin, so you no longer
    have to cd into #{prefix} to use it.

    If you have any problems, raise them on extemporelang@googlegroups.com
    EOS
  end
end
