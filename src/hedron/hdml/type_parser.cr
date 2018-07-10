require "../any.cr"

module Hedron::HDML
  private class TypeParser
    def self.parse(var : String) : Any
      return case var
      when .match(/^".*"$/)
        var[1...-1]
      when .match(/^[0-9]+\.[0-9]+$/)
        var.to_f
      when .match(/^[0-9]+/)
        var.to_i
      when .match(/^(true|false)$/)
        var == "true" ? true : false
      else
        raise TypeParseError.new("Could not parse type")
      end
    end
  end
end
