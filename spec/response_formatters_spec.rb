require 'rspec'
require 'dtracer/response_formatters'

describe 'ResponseFormatter' do

  it 'should correctly convert the http response with status' do
    f = ResponseFormatter.new(HASH_WITH_STATUS)
    expect(f.to_s).to eq(RESPONSE_WITH_STATUS)
  end

  it 'should correctly convert the http response with status and headers' do
    f = ResponseFormatter.new(HASH_WITH_STATUS_HEADERS)
    expect(f.to_s).to eq(RESPONSE_WITH_STATUS_HEADERS)
  end

  it 'should correctly convert the http response with status headers and body' do
    f = ResponseFormatter.new(HASH_WITH_STATUS_HEADERS_BODY)
    expect(f.to_s).to eq(RESPONSE_WITH_STATUS_HEADERS_BODY)
  end

  it 'should correctly convert the http response with errors' do
    f = ResponseFormatter.new(HASH_WITH_ERROR)
    expect(f.to_s).to eq(RESPONSE_WITH_ERROR)
  end

  it 'should correctly convert the http response with errors and body' do
    f = ResponseFormatter.new(HASH_WITH_ERROR_BODY)
    expect(f.to_s).to eq(RESPONSE_WITH_ERROR_BODY)
  end

  it 'should correctly convert the http response with errors body and headers' do
    f = ResponseFormatter.new(HASH_WITH_ERROR_BODY_HEADER)
    expect(f.to_s).to eq(RESPONSE_WITH_ERROR_BODY_HEADER)
  end

end

HASH_WITH_STATUS =
    {"statusCode" => "2", "url" => "http://google.com"}
HASH_WITH_STATUS_HEADERS =
    {"statusCode" => "2", "url" => "http://google.com",
     "cookies" => {"cookie1" => "v1", "cookie2" => "v2"},
     "headers" => {"k1" => "v1", "k2" => "v2"}}
HASH_WITH_STATUS_HEADERS_BODY =
    {"statusCode" => "2", "url" => "http://google.com",
     "cookies" => {"cookie1" => "v1", "cookie2" => "v2"},
     "headers" => {"k1" => "v1", "k2" => "v2"},
     "body" => "Some body"}
HASH_WITH_ERROR =
    {"statusCode" => "500", "url" => "http://google.com",
     "error" => {"errorCode" => "123", "localizedDescription" => "bad thing"}}
HASH_WITH_ERROR_BODY =
    {"statusCode" => "500", "url" => "http://google.com",
     "error" => {"errorCode" => "123", "localizedDescription" => "bad thing"},
     "body" => "Some body"}
HASH_WITH_ERROR_BODY_HEADER =
    {"statusCode" => "500", "url" => "http://google.com",
     "error" => {"errorCode" => "123", "localizedDescription" => "bad thing"},
     "headers" => {"k1" => "v1", "k2" => "v2"},
     "body" => "Some body"}


RESPONSE_WITH_STATUS = "Status Code:\n  2\nURL:\n  http://google.com"
RESPONSE_WITH_STATUS_HEADERS = "Status Code:\n  2\nURL:\n  http://google.com\nHeaders:\n  k1: v1\n  k2: v2\nCookies:\n  cookie1: v1\n  cookie2: v2"
RESPONSE_WITH_STATUS_HEADERS_BODY = "Status Code:\n  2\nURL:\n  http://google.com\nHeaders:\n  k1: v1\n  k2: v2\nCookies:\n  cookie1: v1\n  cookie2: v2\nBody:\n  Some body"
RESPONSE_WITH_ERROR = "Status Code:\n  500\nURL:\n  http://google.com\nError:\n  Error Code: 123\n  Description: bad thing"
RESPONSE_WITH_ERROR_BODY = "Status Code:\n  500\nURL:\n  http://google.com\nBody:\n  Some body\nError:\n  Error Code: 123\n  Description: bad thing"
RESPONSE_WITH_ERROR_BODY_HEADER = "Status Code:\n  500\nURL:\n  http://google.com\nHeaders:\n  k1: v1\n  k2: v2\nBody:\n  Some body\nError:\n  Error Code: 123\n  Description: bad thing"
