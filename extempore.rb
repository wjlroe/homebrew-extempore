require 'formula'

class Extempore < Formula
  homepage 'http://extempore.moso.com.au'
  url 'http://extempore.moso.com.au/extras/extempore-Darwin-20130621.tar.gz'
  sha1 '9338ac634adf4a2e447e1a3f84e4d100a773e67e'
  keg_only "See 'Caveats' below."

  depends_on 'pcre'
  depends_on 'portaudio'
  depends_on 'extempore-llvm' => :build
  # you'll need all these libraries at runtime to use the stdlib
  depends_on 'assimp' => :recommended
  depends_on 'libdrawtext' => :recommended
  depends_on 'libsndfile' => :recommended
  depends_on 'libsoil' => :recommended
  depends_on 'shivavg' => :recommended

  def install
    # for building from source
    system "EXT_LLVM_DIR=#{HOMEBREW_PREFIX}/Cellar/extempore-llvm/3.2 ./all.bash"

  end

  def caveats
    s = ''
    s += <<-EOS.undent
      Extempore is now installed in #{prefix}

      For Extempore documentation, see http://benswift.me/extempore-docs/
    EOS
  end

end
