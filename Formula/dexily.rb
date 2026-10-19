class Dexily < Formula
  desc "Track your projects from the terminal: the command line for Project Indexer"
  homepage "https://github.com/HADO564/project-indexer"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/HADO564/project-indexer/releases/download/dexily-v0.2.0/dexily-aarch64-apple-darwin.tar.xz"
      sha256 "226c0272ddb069fbf9485999fdf2ffd65bb65a1e2a1128ae0a6bb10ee1448064"
    end
    if Hardware::CPU.intel?
      url "https://github.com/HADO564/project-indexer/releases/download/dexily-v0.2.0/dexily-x86_64-apple-darwin.tar.xz"
      sha256 "252d2b08c2f27a18abe6a9df2d231179ecdba2e49ffdfbff67c1b30e38d27ceb"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/HADO564/project-indexer/releases/download/dexily-v0.2.0/dexily-aarch64-unknown-linux-musl.tar.xz"
      sha256 "ca2d0570456b93bbc606d8901ca6d8849a8c976e28d6923476b158e54a4a9545"
    end
    if Hardware::CPU.intel?
      url "https://github.com/HADO564/project-indexer/releases/download/dexily-v0.2.0/dexily-x86_64-unknown-linux-musl.tar.xz"
      sha256 "c1117f4294346d16ad4405b8b565470ccc3bc2c53b6eb17d7c87d22c022d3289"
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
