require "open3"

class ProbeListener

  def initialize(name, is_hash)
    @name = name
    @probe_string = probe_string(name)
    @is_hash = is_hash
  end

  def listen
    write_probe
    cmd = "sudo dtrace -s #{trace_file_path}"



    IO.popen(cmd) do |stdout|
      stdout.each do |line|

        if @is_hash
          value = try_parse(line)
          next unless value
        else
          value = line.strip
          next if value.empty?
        end

        puts "\n#{@name.capitalize}----------------------------------------------"
        yield(value)
      end
    end

    clean_up
  end

  private

  def try_parse(string)
    JSON.parse(string)
  rescue
    nil
  end

  def probe_string(name)
    builder = RequestTracer::Builder.new
    builder.add_options(true)

    builder.add_begin_probe
    builder.add_probe(name)
    builder.build
  end

  def write_probe
    @file = Tempfile.new('temp.d')
    @file.write(@probe_string)
    @file.flush
  end

  def clean_up
    @file.unlink
    @file.close
  end

  def trace_file_path
    @file.path
  end

end