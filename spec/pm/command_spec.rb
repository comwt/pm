require "spec_setup"
require "stud/temporary"
require "pm" # local
require "pm/command" # local
require "fixtures/mockpackage"

describe PM::Command do
  describe "--prefix"
  describe "-C"
  describe "-p / --package"
  describe "-f"
  describe "-n"
  describe "-v"
  describe "--iteration"
  describe "--epoch"
  describe "--license"
  describe "--vendor"
  describe "--category"
  describe "-d / --depends"
  describe "--no-depends"
  describe "--provides"
  describe "--conflicts"
  describe "--replaces"
  describe "--config-files"
  describe "--directories"
  describe "-a | --architecture"

  describe "-p | --package" do
    context "when given a directory" do
      it "should write the package to the given directory." do
        Stud::Temporary.directory do |path|
          cmd = PM::Command.new("pm")
          cmd.run(["-s", "empty", "-t", "deb", "-n", "example", "-p", path])
          files = Dir.new(path).to_a - [".", ".."]

          insist { files.size } == 1
          insist { files[0] } =~ /^example_/
        end
      end
    end

    context "when not set" do
      it "should write the package to the current directory." do
        Stud::Temporary.directory do |path|
          Dir.chdir(path) do
            cmd = PM::Command.new("pm")
            cmd.run(["-s", "empty", "-t", "deb", "-n", "example"])
          end
          files = Dir.new(path).to_a - ['.', '..']
          insist { files.size } == 1
          insist { files[0] } =~ /example_/
        end
      end
    end
  end

  describe "--log" do
    subject { PM::Command.new("pm") }
    let (:args) { [ "-s", "mock", "-t", "mock" ] }

    context "when not given" do
      it "should not raise an exception" do
        subject.parse(args)
      end
    end
    context "when given a valid log level" do
      it "should not raise an exception" do
        subject.parse(args + ["--log", "error"])
        subject.parse(args + ["--log", "warn"])
        subject.parse(args + ["--log", "info"])
        subject.parse(args + ["--log", "debug"])
      end
    end
    context "when given an invalid log level" do
      it "should raise an exception" do
        insist { subject.parse(args + ["--log", ""]) }.raises PM::Package::InvalidArgument
        insist { subject.parse(args + ["--log", "whatever"]) }.raises PM::Package::InvalidArgument
        insist { subject.parse(args + ["--log", "fatal"]) }.raises PM::Package::InvalidArgument
      end
    end
  end
end
