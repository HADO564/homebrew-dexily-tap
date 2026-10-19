class Dexily < Formula
  desc "Track your projects from the terminal: the command line for Project Indexer"
  homepage "https://github.com/HADO564/project-indexer"
  version "0.2.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/HADO564/project-indexer/releases/download/dexily-v0.2.1/dexily-aarch64-apple-darwin.tar.xz"
      sha256 "1ea647f001571664a873166167cf042df11e0cb2ca42bcbd1508c24b98f465ce"
    end
    if Hardware::CPU.intel?
      url "https://github.com/HADO564/project-indexer/releases/download/dexily-v0.2.1/dexily-x86_64-apple-darwin.tar.xz"
      sha256 "64f8290c49ff8e38440efefd77d24e014d772fbca6a27532590b0fef0a298961"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/HADO564/project-indexer/releases/download/dexily-v0.2.1/dexily-aarch64-unknown-linux-musl.tar.xz"
      sha256 "5c90eabecd2a3b018c04afaf972ca0be459992cb8366959ae768e769f4e5fa93"
    end
    if Hardware::CPU.intel?
      url "https://github.com/HADO564/project-indexer/releases/download/dexily-v0.2.1/dexily-x86_64-unknown-linux-musl.tar.xz"
      sha256 "2e5a0590412d6f63fbcd911e480d9d2cecd71b71d7034b2e770b9a0c63a4777f"
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
