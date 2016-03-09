require "spec_setup"
require "pm" # local
require "pm/package/npm" # local

have_npm = program_exists?("npm")
if !have_npm
  Cabin::Channel.get("rspec") \
    .warn("Skipping NPM tests because 'npm' isn't in your PATH")
end

describe PM::Package::NPM do
  after do
    subject.cleanup
  end

  describe "::default_prefix", :if => have_npm do
    it "should provide a valid default_prefix" do
      stat = File.stat(PM::Package::NPM.default_prefix)
      insist { stat }.directory?
    end
  end
end # describe PM::Package::NPM
