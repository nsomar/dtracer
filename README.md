# DTracer

DTracer is part ruby gem, part iOS pod, that helps the sending and receiving of DTrace commands.
The `dtracer` gem will listen to the DTrace commands that are sent from the [OADTraceSender]() pod.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'dtracer'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install dtracer

## Usage

1. Incorporate the `OADTraceSender` in your iOS project ([how to?]())
2. Use `OADTraceSender` in your iOS app, to send a dtrace command.
3. Run the iOS app to register the probes.
4. Use `dtracer` gem command line to register a probe.

Any dtrace command you send will be received on your terminal.   

Note: registering a probe using DTrace requires admin privileges, running any dtracer command will ask for that.

### Type of probes

One good usage of DTrace is to log the network communicate instead of polluting the Xcode console.

Using DTrace to log network communication has the following benefits:

- Avoids Xcode console pollution with network logs.
- Extremely cheap; probes that are not being listened do not add any overhead.

To check how to implement OADtraceSender in your iOS project, check [OADtraceSender pod]().

Using `dtracer` command you can register 3 types of tracers.

#### Request probes
These are probes that listens to dtrace command sent from `[OADTracer traceRequest:]` objc method. 

##### Curl

	dtracer curl
	
Outputs the the `NSURLRequest` send with the dtrace event as a curl command.

##### Details

	dtracer details
	
Outputs the the `NSURLRequest` send with the dtrace event as a formatted string. You can pass it multiple flags to decide what to print from the request.

run `dtracer help details` to check how to customize the output.


Using the `-r` flag with both of the above commands will add a response probe output.

#### Response probes

	dtracer response

dtracer response adds a probe that outputs the `NSURLResponse`, `NSData` and `NSError` combination, sent using `[OADTracer traceResponse:data:error:]` objc method. 

#### String probes

	dtracer custom

In case you have the need to send any arbitrary string, then use `dtracer custom`; This command adds a probe that prints any string sent using `[OADTracer traceString:]` objc method. 

## Contributing

1. Fork it ( https://github.com/oarrabi/dtracer/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Tests
[Yes! ](https://github.com/oarrabi/dtracer/tree/master/spec)