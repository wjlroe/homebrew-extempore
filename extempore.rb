require 'formula'

class Extempore < Formula
  homepage 'http://extempore.moso.com.au'
  url 'https://github.com/digego/extempore/archive/0.53.zip'
  sha1 '1d6a0f37341e5a03f11286c63c923fdd956757ce'
  head 'https://github.com/digego/extempore.git'
  keg_only ""

  depends_on 'pcre' => :build
  depends_on 'portaudio' => :build
  depends_on 'extempore-llvm' => :build
  # you'll need all these libraries at runtime to use the stdlib
  depends_on 'assimp' => :recommended
  depends_on 'kissfft' => :recommended
  depends_on 'libsndfile' => :recommended
  depends_on 'libsoil' => :recommended
  depends_on 'rtmidi-c' => :recommended
  depends_on 'shivavg' => :recommended

  option "with-stdlib", "(pre)compile the Extempore standard library"

  def install
    ENV['EXT_LLVM_DIR'] = "#{HOMEBREW_PREFIX}/Cellar/extempore-llvm/3.4.1"
    system "./all.bash"

    if build.with? "stdlib"
      ohai "(pre)compiling the Extempore standard library.  This may take a few minutes..."
      system "./compile-stdlib.sh"
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
