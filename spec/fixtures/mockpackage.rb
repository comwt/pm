require "pm/namespace"
require "pm/package"

class PM::Package::Mock < PM::Package
  def input(*args); end
  def output(*args); end
end
