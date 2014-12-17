class ResponseFormatter
  def initialize(hash)
    @hash = hash
    generate
  end

  def generate
    arr = []

    methods = [:response_section, :header_section, :cookie_section, :body_section, :error_section]

    methods.each do |method_name|
      # get content array for a request section
      content_array = self.send(method_name, @hash)
      arr.concat(content_array) if content_array

    end

    @content = arr.join("\n")
  end

  def response_section(hash)
    arr = []

    if hash["statusCode"]
      arr << "Status Code:"
      arr << "  #{hash["statusCode"]}"
    end

    if hash["url"]
      arr << "URL:"
      arr << "  #{hash["url"]}"
    end

    arr
  end

  def header_section(hash)
    return nil unless hash[:h]

    arr = []
    arr << "Headers:"
    hash["headers"].each { |k| arr << "  #{k["field"]}: #{k["value"]}" }
    arr
  end

  def cookie_section(hash)
    return nil unless hash["cookies"]

    arr = []
    arr << "Cookies:"
    hash["cookies"].each { |k| arr << "  #{k["name"]}: #{k["value"]}" }
    arr
  end

  def body_section(hash)
    return nil unless hash["body"]

    ["Body:\n  #{hash["body"]}"]
  end

  def error_section(hash)
    return nil unless hash["error"]
    arr = []
    arr << "Error:"
    arr << "  Error Code: #{hash["error"]["errorCode"]}"
    arr << "  Description: #{hash["error"]["localizedDescription"]}"
    arr
  end

  def to_s
    @content
  end
end
