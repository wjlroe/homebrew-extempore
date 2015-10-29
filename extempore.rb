class Extempore < Formula
  homepage "http://extempore.moso.com.au"
  url      "https://github.com/digego/extempore/archive/0.6.0.tar.gz"
  sha256   "dab818af3277ee17394ebbb8beaa406f56fda7309146b42263956553593af692"
  head     "https://github.com/digego/extempore.git"

  option "without-aot", "ahead-of-time-compile the libraries for faster startup"
  option "with-extended", "download additional libraries for added functionality"

  depends_on "cmake" => :build
  depends_on "extempore-llvm"
  # stdlib dependencies
  depends_on "assimp" if build.with? "extended"
  depends_on "glfw3" if build.with? "extended"
  depends_on "libkiss-fft" if build.with? "extended"
  depends_on "libnanovg" if build.with? "extended"
  depends_on "libsndfile" if build.with? "extended"
  depends_on "libstb-image" if build.with? "extended"
  depends_on "portmidi" if build.with? "extended"

  def install
    ENV["EXT_LLVM_DIR"] = "#{HOMEBREW_PREFIX}/Cellar/extempore-llvm/3.7.0"
    system "cmake", "-DIN_TREE=OFF", ".", *std_cmake_args
    system "make", "install"

    if build.with? "aot"
      ohai "AOT-compiling the Extempore standard library.  This may take several minutes..."
      system "make", "aot"
    end

    if build.with? "extended"
      ohai "AOT-compiling the (extended) Extempore standard library.  This may take several minutes..."
      system "make", "aot_extended" if build.with? "aot"
      ohai "downloading Extempore assets..."
      system "make", "assets"
    end
  end

  def caveats
    s = ''
    s += <<-EOS.undent
    Extempore now lives in "#{HOMEBREW_PREFIX}/bin, so you no longer
    have to cd into #{prefix} to use it.

    If you have any problems, raise them on extemporelang@googlegroups.com
    EOS
  end
end
