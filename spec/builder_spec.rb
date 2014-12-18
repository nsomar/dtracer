require 'rspec'
require 'dtracer/builder'


describe DTracer::Builder do
  before(:each) do

  end

  it "should add options" do
    b = DTracer::Builder.new
    b.add_options(true)

    expect(b.build).to eq "#pragma D option quiet\n#pragma D option strsize=102400\n"
  end

  it "should add begin probe" do
    b = DTracer::Builder.new
    b.add_begin_probe

    expect(b.build).to eq "BEGIN {\n  printf(\"Tracing started\\n\");\n}\n"
  end

  it "should add request probe" do
    b = DTracer::Builder.new
    b.add_request_probe

    expect(b.build).to eq "oadprobe*:::request {\n  printf(\"%s\\n\\n\", copyinstr(arg0));\n}\n"
  end

  it "should add response probe" do
    b = DTracer::Builder.new
    b.add_response_probe

    expect(b.build).to eq "oadprobe*:::response {\n  printf(\"%s\\n\\n\", copyinstr(arg0));\n}\n"
  end

  it "should add custom probe" do
    b = DTracer::Builder.new
    b.add_custom_probe

    expect(b.build).to eq "oadprobe*:::custom {\n  printf(\"%s\\n\\n\", copyinstr(arg0));\n}\n"
  end

end