require 'rspec'
require 'dtracer/request_formatters'

describe 'RequestCurlFormatter' do

  it 'should correctly convert method and url' do
    f = RequestCurlFormatter.new(HASH_WITHOUT_BODY)
    expect(f.to_s).to eq(CURL_WITHOUT_BODY)
  end

  it 'should correctly convert the http body' do
    f = RequestCurlFormatter.new(HASH_WITH_BODY)
    expect(f.to_s).to eq(CURL_WITH_BODY)
  end

  it 'should correctly convert the headers' do
    f = RequestCurlFormatter.new(HASH_WITH_HEADERS)
    expect(f.to_s).to eq(CURL_WITH_HEADER)
  end

  it 'should correctly convert http with body and cookies' do
    f = RequestCurlFormatter.new(HASH_WITH_BODY_AND_COOKIES)
    expect(f.to_s).to eq(CURL_WITH_BODY_AND_COOKIES)
  end

  it 'should correctly convert http with body header and cookies' do
    f = RequestCurlFormatter.new(HASH_WITH_BODY_HEADER_AND_COOKIES)
    expect(f.to_s).to eq(CURL_WITH_BODY_HEADER_AND_COOKIES)
  end

end

ALL_OPTIONS = {:m => true, :b => true, :c => true, :h => true, :u => true}
describe 'RequestDetailsFormatter' do

  it 'should correctly convert method and url' do
    f = RequestDetailsFormatter.new(HASH_WITHOUT_BODY, ALL_OPTIONS)
    expect(f.to_s).to eq(DETAIL_WITHOUT_BODY)
  end

  it 'should correctly convert the http body' do
    f = RequestDetailsFormatter.new(HASH_WITH_BODY, ALL_OPTIONS)
    expect(f.to_s).to eq(DETAIL_WITH_BODY)
  end

  it 'should correctly convert the headers' do
    f = RequestDetailsFormatter.new(HASH_WITH_HEADERS, ALL_OPTIONS)
    expect(f.to_s).to eq(DETAIL_WITH_HEADER)
  end

  it 'should correctly convert http with body and cookies' do
    f = RequestDetailsFormatter.new(HASH_WITH_BODY_AND_COOKIES, ALL_OPTIONS)
    expect(f.to_s).to eq(DETAIL_WITH_BODY_AND_COOKIES)
  end

  it 'should correctly convert http with body header and cookies' do
    f = RequestDetailsFormatter.new(HASH_WITH_BODY_HEADER_AND_COOKIES, ALL_OPTIONS)
    expect(f.to_s).to eq(DETAIL_WITH_BODY_HEADER_AND_COOKIES)
  end

  context 'Parsing options' do

    it 'should display only method when m is passed' do
      options = {:m => true}
      f = RequestDetailsFormatter.new(HASH_WITH_BODY_HEADER_AND_COOKIES, options)
      expect(f.to_s).to eq("Method:\n  POST")
    end

    it 'should display only body when b is passed' do
      options = {:b => true}
      f = RequestDetailsFormatter.new(HASH_WITH_BODY_HEADER_AND_COOKIES, options)
      expect(f.to_s).to eq("Body:\n  Body is test test")
    end

    it 'should display header and cookies when h and c are passed' do
      options = {:c => true, :h => true}
      f = RequestDetailsFormatter.new(HASH_WITH_BODY_HEADER_AND_COOKIES, options)
      expect(f.to_s).to eq("Cookies:\n  cookie1: v1\n  cookie2: v2\nHeaders:\n  k1: v1\n  k2: v2")
    end

  end

end

# Mock data

HASH_WITHOUT_BODY =
    {"url" => "https:\/\/www.google.com", "method" => "GET"}
HASH_WITH_BODY =
    {"url" => "https:\/\/www.google.com", "method" => "POST",
     "body" => "Body is test test"}
HASH_WITH_HEADERS =
    {"url" => "https:\/\/www.google.com", "method" => "POST",
     "headers" => {"k1" => "v1", "k2" => "v2"}}
HASH_WITH_BODY_AND_COOKIES =
    {"url" => "https:\/\/www.google.com", "method" => "POST",
     "body" => "Body is test test",
     "cookies" => {"cookie1" => "v1", "cookie2" => "v2"}}
HASH_WITH_BODY_HEADER_AND_COOKIES =
    {"url" => "https:\/\/www.google.com", "method" => "POST",
     "body" => "Body is test test",
     "cookies" => {"cookie1" => "v1", "cookie2" => "v2"},
     "headers" => {"k1" => "v1", "k2" => "v2"}}


CURL_WITHOUT_BODY = "curl \\ \n-X GET \\ \n\"https://www.google.com\""
CURL_WITH_BODY = "curl \\ \n-X POST \\ \n-d Body is test test \\ \n\"https://www.google.com\""
CURL_WITH_HEADER = "curl \\ \n-X POST \\ \n-H 'k1: v1' \\ \n-H 'k2: v2' \\ \n\"https://www.google.com\""
CURL_WITH_BODY_AND_COOKIES = "curl \\ \n-X POST \\ \n-d Body is test test \\ \n--cookie \"cookie1=v1\" \\ \n--cookie \"cookie2=v2\" \\ \n\"https://www.google.com\""
CURL_WITH_BODY_HEADER_AND_COOKIES = "curl \\ \n-X POST \\ \n-d Body is test test \\ \n--cookie \"cookie1=v1\" \\ \n--cookie \"cookie2=v2\" \\ \n-H 'k1: v1' \\ \n-H 'k2: v2' \\ \n\"https://www.google.com\""


DETAIL_WITHOUT_BODY = "Method:\n  GET\nURL:\n  https://www.google.com"
DETAIL_WITH_BODY = "Method:\n  POST\nBody:\n  Body is test test\nURL:\n  https://www.google.com"
DETAIL_WITH_HEADER = "Method:\n  POST\nHeaders:\n  k1: v1\n  k2: v2\nURL:\n  https://www.google.com"
DETAIL_WITH_BODY_AND_COOKIES = "Method:\n  POST\nBody:\n  Body is test test\nCookies:\n  cookie1: v1\n  cookie2: v2\nURL:\n  https://www.google.com"
DETAIL_WITH_BODY_HEADER_AND_COOKIES = "Method:\n  POST\nBody:\n  Body is test test\nCookies:\n  cookie1: v1\n  cookie2: v2\nHeaders:\n  k1: v1\n  k2: v2\nURL:\n  https://www.google.com"