module RequestFormattable

  def initialize(hash)
    @hash = hash
    generate
  end

  def to_s
    @content
  end

  def generate
    arr = []

    methods = [:begin_section, :method_section, :body_section,
               :cookie_section, :header_section, :url_section]

    methods.each do |method_name|
      # get content array for a request section
      content_array = self.send(method_name, @hash)
      arr.concat(content_array) if content_array

    end

    @content = arr.join(joining_string)
  end

end

class RequestCurlFormatter

  include RequestFormattable

  def joining_string
    " \\ \n"
  end

  def begin_section(_)
    ["curl"]
  end

  def method_section(hash)
    ["-X #{hash["method"]}"]
  end

  def url_section(hash)
    ["\"#{hash["url"]}\""]
  end

  def header_section(hash)
    return nil unless hash["headers"]

    arr = []
    hash["headers"].each do |key, value|
      arr << "-H '#{key}: #{value}'"
    end
    arr
  end

  def cookie_section(hash)
    return nil unless hash["cookies"]

    arr = []
    hash["cookies"].each do |name, value|
      arr << "--cookie \"#{name}=#{value}\""
    end
    arr
  end

  def body_section(hash)
    return nil unless hash["body"]

    ["-d #{hash["body"]}"]
  end

end

class RequestDetailsFormatter

  include RequestFormattable

  def initialize(hash, options)
    @options = options
    super(hash)
  end

  def joining_string
    "\n"
  end

  def begin_section(_)
    []
  end

  def method_section(hash)
    return nil unless @options[:m] && hash["method"]

    ["Method:\n  #{hash["method"]}"]
  end

  def url_section(hash)
    return nil unless @options[:u] && hash["url"]
    ["URL:\n  #{hash["url"]}"]
  end

  def header_section(hash)
    return nil unless @options[:h] && hash["headers"]

    arr = []
    arr << "Headers:"
    hash["headers"].each { |k| arr << "  #{k["field"]}: #{k["value"]}" }
    arr
  end

  def cookie_section(hash)
    return nil unless @options[:c] && hash["cookies"]

    arr = []
    arr << "Cookies:"
    hash["cookies"].each { |k| arr << "  #{k["name"]}: #{k["value"]}" }
    arr
  end

  def body_section(hash)
    return nil unless @options[:b] && hash["body"]
    ["Body:\n  #{hash["body"]}"]
  end

end