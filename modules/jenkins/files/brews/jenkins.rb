require "formula"

class Jenkins < Formula
  homepage "http://jenkins-ci.org"
  url "http://mirrors.jenkins-ci.org/war-stable/1.580.3/jenkins.war"
  sha1 "18a8e6ea4a7723b10027ae51ed0196a0d994f622"
  version "1.580.3-boxen1"

  skip_clean :all

  def install
    libexec.install "jenkins.war"
    bin.write_jar_script libexec/"jenkins.war", "jenkins"
  end
end
