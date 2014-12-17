
class RequestTracer::Builder

  def initialize
    @s = []
  end

  def add_options(is_quite, string_size = 102400)
    @s << "#pragma D option quiet" if is_quite
    @s << "#pragma D option strsize=#{string_size}"
    @s << ''
  end

  def add_begin_probe
    @s << 'BEGIN {'
    @s << '  printf("Tracing started\n");'
    @s << '}'
    @s << ''
  end

  def add_request_probe
    add_probe("request")
  end

  def add_response_probe
    add_probe("response")
  end

  def add_custom_probe
    add_probe("custom")
  end

  def build
    @s.join("\n")
  end

  def add_probe(probe_type)
    @s << "oadprobe*:::#{probe_type} {"
    @s << '  printf("%s\n\n", copyinstr(arg0));'
    @s << '}'
    @s << ''
  end

end
