require 'formula'

class Extempore059 < Formula
  homepage 'http://extempore.moso.com.au'
  url 'https://github.com/digego/extempore/archive/0.5.9.tar.gz'
  sha256 'a5060f94cdab1d44c1c865c11d938e88f73d75345d74def66407501c7b3d5d14'
  keg_only ""

  option "without-aot", "ahead-of-time-compile the libraries for faster startup"
  option "with-extended", "download additional libraries for added functionality"

  depends_on 'pcre' => :build
  depends_on 'portaudio' => :build
  depends_on 'extempore-llvm341' => :build
  # you'll need all these libraries at runtime to use the extended stdlib
  depends_on 'assimp' => :recommended if build.with? "extended"
  depends_on 'kissfft' => :recommended if build.with? "extended"
  depends_on 'libsndfile' => :recommended if build.with? "extended"
  depends_on 'libsoil' => :recommended if build.with? "extended"
  depends_on 'rtmidi-c' => :recommended if build.with? "extended"
  depends_on 'shivavg' => :recommended if build.with? "extended"
  depends_on 'libnanovg' => :recommended if build.with? "extended"
  depends_on 'libstb-image' => :recommended if build.with? "extended"

  def install
    ENV['EXT_LLVM_DIR'] = "#{HOMEBREW_PREFIX}/Cellar/extempore-llvm/3.4.1"
    system "./all.bash"

    if build.with? "aot"
      ohai "AOT-compiling the Extempore standard library.  This may take a few minutes..."
      if build.with? "extended"
        system "./compile-stdlib.sh"
      else
        system "./compile-stdlib-core.sh"
      end
    end

    if build.with? "extended"
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
