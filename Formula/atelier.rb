class Atelier < Formula
  desc "3D printing host"
  homepage "https://atelier.kde.org"
  head "git://anongit.kde.org/atelier.git"

  depends_on "cmake" => :build
  depends_on "kde-mac/kde/kf5-extra-cmake-modules" => :build
  depends_on "kde-mac/kde/atcore"
  depends_on "kde-mac/kde/kf5-kconfigwidgets"
  depends_on "kde-mac/kde/kf5-ki18n"
  depends_on "kde-mac/kde/kf5-knewstuff"
  depends_on "kde-mac/kde/kf5-ktexteditor"
  depends_on "kde-mac/kde/kf5-kxmlgui"
  depends_on "qwt"

  def install
    args = std_cmake_args
    args << "-DQWT_INCLUDE_DIR=lib/qwt.framework/Versions/6/Headers"
    args << "-DQWT_LIBRARY=lib/qwt.framework/qwt"
    mkdir "build" do
      system "cmake", "..", *args
      system "make", "install"
      prefix.install "install_manifest.txt"
    end
  end
end
