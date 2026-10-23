class Dexily < Formula
  desc "Track your projects from the terminal: the command line for Project Indexer"
  homepage "https://github.com/HADO564/project-indexer"
  version "0.3.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/HADO564/project-indexer/releases/download/dexily-v0.3.2/dexily-aarch64-apple-darwin.tar.xz"
      sha256 "d87ca8303a5d690d7ca14e322a32b28ee201e4f2e6cf46b008403c32df2c1a60"
    end
    if Hardware::CPU.intel?
      url "https://github.com/HADO564/project-indexer/releases/download/dexily-v0.3.2/dexily-x86_64-apple-darwin.tar.xz"
      sha256 "b423d6a5a594eab8a7056c46cdf675838fd339ea5b026610478c7b6bba643760"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/HADO564/project-indexer/releases/download/dexily-v0.3.2/dexily-aarch64-unknown-linux-musl.tar.xz"
      sha256 "0f6d4023f8fbd4ee140474691594936812fd3789755475fcff5a400deeec2109"
    end
    if Hardware::CPU.intel?
      url "https://github.com/HADO564/project-indexer/releases/download/dexily-v0.3.2/dexily-x86_64-unknown-linux-musl.tar.xz"
      sha256 "1adae0afb0341a657d1d2cd3704d9e7f7c8740a141bfc7882dca1dc4f1ae911a"
    end
  end

  BINARY_ALIASES = {
    "aarch64-apple-darwin":               {},
    "aarch64-unknown-linux-gnu":          {},
    "aarch64-unknown-linux-musl-dynamic": {},
    "aarch64-unknown-linux-musl-static":  {},
    "x86_64-apple-darwin":                {},
    "x86_64-pc-windows-gnu":              {},
    "x86_64-unknown-linux-gnu":           {},
    "x86_64-unknown-linux-musl-dynamic":  {},
    "x86_64-unknown-linux-musl-static":   {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "dexily"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "dexily"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "dexily"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "dexily"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
