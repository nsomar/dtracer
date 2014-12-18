class DTracer::Builder

  def initialize
    @content = []
  end

  def add_options(is_quite, string_size = 102400)
    @content << "#pragma D option quiet" if is_quite
    @content << "#pragma D option strsize=#{string_size}"
    @content << ''
  end

  def add_begin_probe
    @content << 'BEGIN {'
    @content << '  printf("Tracing started\n");'
    @content << '}'
    @content << ''
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
    @content.join("\n")
  end

  def add_probe(probe_type)
    @content << "oadprobe*:::#{probe_type} {"
    @content << '  printf("%s\n\n", copyinstr(arg0));'
    @content << '}'
    @content << ''
  end

end
