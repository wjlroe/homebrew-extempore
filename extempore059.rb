require 'formula'

class Extempore < Formula
  homepage 'http://extempore.moso.com.au'
  url 'https://github.com/digego/extempore/archive/0.5.9.zip'
  sha1 '5795bd984399e7368d528166e18f6b71adb12b47'
  keg_only ""

  depends_on 'pcre' => :build
  depends_on 'portaudio' => :build
  depends_on 'extempore-llvm' => :build
  # you'll need all these libraries at runtime to use the extended stdlib
  depends_on 'assimp' => :recommended
  depends_on 'kissfft' => :recommended
  depends_on 'libsndfile' => :recommended
  depends_on 'libsoil' => :recommended
  depends_on 'rtmidi-c' => :recommended
  depends_on 'shivavg' => :recommended
  depends_on 'libnanovg' => :recommended
  depends_on 'libstb-image' => :recommended

  option "with-aot", "AOT-compile the (extended) Extempore standard library"
  option "with-assets", "download the assets used in the example files"

  def install
    ENV['EXT_LLVM_DIR'] = "#{HOMEBREW_PREFIX}/Cellar/extempore-llvm/3.4.1"
    system "./all.bash"

    if build.with? "aot"
      ohai "AOT-compiling the Extempore standard library.  This may take a few minutes..."
      system "./compile-stdlib.sh"
    end

    if build.with? "assets"
      system "curl", "-O", "http://extempore.moso.com.au/extras/assets.tgz"
      system "tar", "-xf", "assets.tgz"
      rm("assets.tgz")
    end

    prefix.install Dir['*']
  end

  def caveats
    s = ''
    s += <<-EOS.undent
      Extempore is now installed in #{prefix}

      It has not been linked into #{HOMEBREW_PREFIX} (and is therefore
      probably not on your $PATH) since it expects to be run in its
      home directory. If you would like to run extempore from
      somewhere else, you can specify the location of the runtime/ dir
      with the --runtime command line argument.

      It's a good idea to build the standard library at this point: you
      can do this (in a shell) with:

      > cd #{prefix}
      > ./compile-stdlib.sh

      For Extempore documentation, see http://benswift.me/extempore-docs/
    EOS
  end

end
