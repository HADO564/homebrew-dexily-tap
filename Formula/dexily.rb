class Dexily < Formula
  desc "Track your projects from the terminal: the command line for Project Indexer"
  homepage "https://github.com/HADO564/project-indexer"
  version "0.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/HADO564/project-indexer/releases/download/dexily-v0.3.0/dexily-aarch64-apple-darwin.tar.xz"
      sha256 "66c60634cb09f7dc7c2b112da9bcf9ea5bb2a90726d61b9b2eb20648363cdc99"
    end
    if Hardware::CPU.intel?
      url "https://github.com/HADO564/project-indexer/releases/download/dexily-v0.3.0/dexily-x86_64-apple-darwin.tar.xz"
      sha256 "48df294ed0bc2544cb388a271b763ae88826928d82ddcc1e60c33ccfc4333a65"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/HADO564/project-indexer/releases/download/dexily-v0.3.0/dexily-aarch64-unknown-linux-musl.tar.xz"
      sha256 "12a893fe1e2ded4261f778ff8ffa002fef1c1ec74b90930b2db2d5a0dc54b15f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/HADO564/project-indexer/releases/download/dexily-v0.3.0/dexily-x86_64-unknown-linux-musl.tar.xz"
      sha256 "7d0d446d21f4fbd987abe4dcfb4bed95f543835588e1391b9192a52e137a38be"
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
