require 'thor'
require 'dtracer'
require 'tempfile'
require 'json'

class DTracer::CLI < Thor
  package_name :dtracer

  option :r, :aliases => ["--response"], :type => :boolean, desc: "include the request response"
  desc "curl", "register a curl probe"

  def curl
    say "Starting dtrace", :green

    t1 = Thread.new do
      ProbeListener.new("request", true).listen do |hash|
        puts RequestCurlFormatter.new(hash).to_s
      end
    end

    t2 = Thread.new do
      sleep(0.3)
      add_response_probe if options[:r]
    end

    t1.join
    t2.join

  rescue Exception => ex
    say ex.message, :red
  end

  option :b, :aliases => ["--body"], :type => :boolean, desc: "show the http body"
  option :m, :aliases => ["--method"], :type => :boolean, desc: "show the http method"
  option :u, :aliases => ["--url"], :type => :boolean, desc: "show the http url"
  option :h, :aliases => ["--headers"], :type => :boolean, desc: "show the http headers"
  option :c, :aliases => ["--cookies"], :type => :boolean, desc: "show the http cookies"
  option :r, :aliases => ["--response"], :type => :boolean, desc: "include the request response"
  desc "details", "register a curl probe"

  def details
    options_without_response = options.dup
    options_without_response.delete(:r)

    raise "Select any option from -b, -c, -h, -u (you can combine them for more info)" if options_without_response.empty?

    say "Starting dtrace", :green

    t1 = Thread.new do
      ProbeListener.new("request", true).listen do |hash|
        puts RequestDetailsFormatter.new(hash, options || {}).to_s
      end
    end

    t2 = Thread.new do
      sleep(0.3)
      add_response_probe if options[:r]
    end

    t1.join
    t2.join

  rescue Exception => ex
    say ex.message, :red
  end

  desc "response", "register a custom probe"

  def response
    say "Starting dtrace", :green

    add_response_probe

  rescue Exception => ex
    say ex.message, :red
  end

  desc "custom", "register a custom probe"

  def custom
    say "Starting dtrace", :green

    probe = ProbeListener.new("custom", false)

    probe.listen do |string|
      puts string
    end

  rescue Exception => ex
    say ex.message, :red
  end


  private

  def add_response_probe
    probe = ProbeListener.new("response", true)
    probe.listen do |hash|
      formatter = ResponseFormatter.new(hash)
      puts formatter.to_s
    end
  end

end