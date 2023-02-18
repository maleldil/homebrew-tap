class Surreal < Formula
  
  desc "A scalable, distributed, collaborative, document-graph database"
  homepage "https://surrealdb.com"

  version "{RELEASE}"
  url "https://download.surrealdb.com/{VERSION}/surreal-{VERSION}.darwin-universal.tgz"
  sha256 "{VERHASH}"

  def install
    bin.install "surreal"
  end

  def caveats; <<~EOS
    For local development only, this formula ships a launchd config
    to start a single-node cluster that stores its data under:
      #{var}/
    The database is available on the default port of 8000:
      #{Formatter.url("http://localhost:8000")}
  EOS
  end

  service do
    run [opt_bin/"surreal", "start", "--user", "root", "--pass", "root", "--log", "debug", "file://#{var}/surreal.db"]
    working_dir var
    keep_alive true
    run_type :immediate
  end

  test do
    system "#{bin}/surreal version"
  end

end
