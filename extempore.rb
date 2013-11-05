require 'formula'

class Extempore < Formula
  homepage 'http://extempore.moso.com.au'
  head 'https://github.com/digego/extempore.git'
  keg_only "See 'Caveats' below."

  depends_on 'pcre'
  depends_on 'portaudio'
  depends_on 'extempore-llvm' => :build
  # you'll need all these libraries at runtime to use the stdlib
  depends_on 'assimp' => :recommended
  depends_on 'kissfft' => :recommended
  depends_on 'libdrawtext' => :recommended
  depends_on 'libsndfile' => :recommended
  depends_on 'libsoil' => :recommended
  depends_on 'rtmidi-c' => :recommended
  depends_on 'shivavg' => :recommended

  def install
    ENV['EXT_LLVM_DIR'] = "#{HOMEBREW_PREFIX}/Cellar/extempore-llvm/3.2"
    system "./all.bash"
    prefix.install Dir['*']
  end

  def caveats
    s = ''
    s += <<-EOS.undent
      Extempore is now installed in #{prefix}. It has not been placed
      on the path, since it expects to be run in its home directory with the
      runtime/ subdirectory.  If you would like to run extempore from 
      somewhere else, you can specify the location of the runtime/ dir
      with the --runtime command line argument.

      If you're an emacs user, you'll want to set

      (setq user-extempore-directory \"#{prefix}\")

      in your .emacs, and probably have a look at the extras/.emacs file 
      as well.

      For Extempore documentation, see http://benswift.me/extempore-docs/
    EOS
  end

end
