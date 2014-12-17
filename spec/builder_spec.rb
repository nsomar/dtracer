require 'rspec'
require 'request_tracer/builder'


describe RequestTracer::Builder do
  before(:each) do

  end

  it "should add options" do
    b = RequestTracer::Builder.new
    b.add_options(true)

    expect(b.build).to eq "#pragma D option quiet\n#pragma D option strsize=102400\n"
  end

  it "should add begin probe" do
    b = RequestTracer::Builder.new
    b.add_begin_probe

    expect(b.build).to eq "BEGIN {\n  printf(\"Tracing started\\n\");\n}\n"
  end

  it "should add curl probe" do
    b = RequestTracer::Builder.new
    b.add_curl_probe

    expect(b.build).to eq "oanetworking*:::curl {\n  printf(\"%s\\n\\n\", copyinstr(arg0));\n}\n"
  end

  it "should add json probe" do
    b = RequestTracer::Builder.new
    b.add_json_probe

    expect(b.build).to eq "oanetworking*:::json {\n  printf(\"%s\\n\\n\", copyinstr(arg0));\n}\n"
  end

  it "raises an exception if method is not recognized" do
    b = RequestTracer::Builder.new
    expect{ b.add_test_test }.to raise_error
  end

  it "raises an exception if trying to add a non supported probe" do
    b = RequestTracer::Builder.new
    expect{ b.add_test_probe }.to raise_error
  end

  it "does not raise error if probe is supported" do
    b = RequestTracer::Builder.new
    expect{ b.add_json_probe }.not_to raise_error
  end

end