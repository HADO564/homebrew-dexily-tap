class Dexily < Formula
  desc "Track your projects from the terminal: the command line for Project Indexer"
  homepage "https://github.com/HADO564/project-indexer"
  version "0.3.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/HADO564/project-indexer/releases/download/dexily-v0.3.1/dexily-aarch64-apple-darwin.tar.xz"
      sha256 "3e5d4cf3efdfa8176beee14c2ef612a8c9ea52d72a3244816c25675bee345537"
    end
    if Hardware::CPU.intel?
      url "https://github.com/HADO564/project-indexer/releases/download/dexily-v0.3.1/dexily-x86_64-apple-darwin.tar.xz"
      sha256 "9c12f64d0488b5a9e35666f4ea22d457683d26d7ebbb4b4f009b24d56fff7b84"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/HADO564/project-indexer/releases/download/dexily-v0.3.1/dexily-aarch64-unknown-linux-musl.tar.xz"
      sha256 "562a8d113fcd9e9189fd74c43591c9c357ec6caf17384681b7b1c4cdd8618b36"
    end
    if Hardware::CPU.intel?
      url "https://github.com/HADO564/project-indexer/releases/download/dexily-v0.3.1/dexily-x86_64-unknown-linux-musl.tar.xz"
      sha256 "f9b2f15a64fa7c66dbca1432b02442cbc2965088f5c3883c147d54f703b9877f"
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
