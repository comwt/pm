require "pm/package"
require "backports"

# Empty Package type. For strict/meta/virtual package creation

class PM::Package::Empty < PM::Package
  def output(output_path)
    logger.warn("Your package has gone into the void.")
  end
  def to_s(fmt)
    return ""
  end
end
