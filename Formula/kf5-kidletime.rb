class Kf5Kidletime < Formula
  desc "Monitoring user activity"
  homepage "https://www.kde.org"
  url "https://download.kde.org/stable/frameworks/5.52/kidletime-5.52.0.tar.xz"
  sha256 "d72a6f4a33e8d496fe5f029ac407a7b26f445500a83ed978d03765cc4b4048e9"

  head "git://anongit.kde.org/kidletime.git"

  depends_on "cmake" => :build
  depends_on "doxygen" => :build
  depends_on "graphviz" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build

  depends_on "qt"

  def install
    args = std_cmake_args
    args << "-DBUILD_TESTING=OFF"
    args << "-DBUILD_QCH=ON"
    args << "-DKDE_INSTALL_QMLDIR=lib/qt5/qml"
    args << "-DKDE_INSTALL_PLUGINDIR=lib/qt5/plugins"

    mkdir "build" do
      system "cmake", "..", *args
      system "make", "install"
      prefix.install "install_manifest.txt"
    end
  end
end
