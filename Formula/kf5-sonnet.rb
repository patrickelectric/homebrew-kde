class Kf5Sonnet < Formula
  desc "Spelling framework for Qt5"
  homepage "https://www.kde.org"
  url "https://download.kde.org/stable/frameworks/5.52/sonnet-5.52.0.tar.xz"
  sha256 "11037f2ca098dd389fd22fdf6ce2bf13f6429895e85dbfb740cc289e590be1a8"

  head "git://anongit.kde.org/sonnet.git"

  depends_on "cmake" => :build
  depends_on "doxygen" => :build
  depends_on "graphviz" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build
  depends_on "qt"
  depends_on "aspell" => :optional
  depends_on "aspell" => :optional
  depends_on "hspell" => :optional
  depends_on "libvoikko" => :optional

  conflicts_with "hunspell", :because => "fatal error: 'hunspell.hxx' file not found"

  patch :DATA

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

  def caveats; <<~EOS
    You need to take some manual steps in order to make this formula work:
      ln -sfv "$(brew --prefix)/share/kf5" "$HOME/Library/Application Support"
  EOS
  end
end

__END__
diff --git a/src/plugins/nsspellchecker/CMakeLists.txt b/src/plugins/nsspellchecker/CMakeLists.txt
index 5e80a10..b1e590d 100644
--- a/src/plugins/nsspellchecker/CMakeLists.txt
+++ b/src/plugins/nsspellchecker/CMakeLists.txt
@@ -7,5 +7,7 @@ add_library(sonnet_nsspellchecker MODULE ${sonnet_nsspellchecker_PART_SRCS})
 
 target_link_libraries(sonnet_nsspellchecker PRIVATE KF5::SonnetCore "-framework Cocoa")
 
+target_compile_definitions(sonnet_nsspellchecker PRIVATE "QT_NO_EXCEPTIONS")
+
 install(TARGETS sonnet_nsspellchecker  DESTINATION ${KDE_INSTALL_PLUGINDIR}/kf5/sonnet/)
 
