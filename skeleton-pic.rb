require "formula"

class SkeletonPic < Formula
  homepage "https://idre.ucla.edu/hpc/parallel-plasma-pic-codes"
  url "https://github.com/benswift/skeleton-pic/archive/0.2.0.zip"
  sha256 "06ce2bfd477793e7b096d4b9a71645c04a107f1bf3ec82569b7ef342bbbcb004"

  depends_on "open-mpi"
  depends_on "cmake" => :build
  
  def install
    system "cmake", ".", *std_cmake_args
    system "make", "install"
  end

end
