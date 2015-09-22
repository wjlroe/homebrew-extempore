class LibkissFft < Formula
  homepage "http://kissfft.sourceforge.net/"
  url "https://github.com/benswift/kiss_fft/archive/1.3.0.zip"
  sha256 "c3e162c0627b1e5e77a1ac6d07e56ddc751e93735c3b5eacc8ffae41f53bf40f"

  depends_on "cmake" => :build

  def install
    system "cmake", ".", *std_cmake_args
    system "make", "install"
  end
end
