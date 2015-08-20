class Libxtract < Formula
  homepage "http://jamiebullock.github.io/LibXtract/documentation/"
  head "https://github.com/jamiebullock/LibXtract.git"

  def install
    ENV["LIBRARY"] = "shared"
    system "make", "src"
    include.install "include/xtract"
    lib.install "src/libxtract.dylib"
  end
end
