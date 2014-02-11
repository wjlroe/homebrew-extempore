require 'formula'

class Extempore < Formula
  homepage 'http://extempore.moso.com.au'
  url 'https://github.com/digego/extempore/archive/0.48.zip'
  sha1 '5901282e2334f5f5ebc3e03f18fa4d892fb8c4cf'
  head 'https://github.com/digego/extempore.git'
  keg_only "See 'Caveats' below."

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

  def install
    ENV['EXT_LLVM_DIR'] = "#{HOMEBREW_PREFIX}/Cellar/extempore-llvm/3.2"
    system "./all.bash"
    prefix.install Dir['*']
  end

  def caveats
    s = ''
    s += <<-EOS.undent
      Extempore is now installed in #{prefix}. 

      It has not been linked into #{HOMEBREW_PREFIX} (and is therefore
      probably not on your $PATH) since it expects to be run in its
      home directory. If you would like to run extempore from
      somewhere else, you can specify the location of the runtime/ dir
      with the --runtime command line argument.

      If you're an emacs user, you'll want to set

      (setq user-extempore-directory \"#{prefix}\"/)

      in your .emacs, and probably have a look at the extras/.emacs file 
      as well.

      For Extempore documentation, see http://benswift.me/extempore-docs/
    EOS
  end

end
