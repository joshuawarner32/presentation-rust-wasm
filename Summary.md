# Rust and WebAssembly

Joshua Warner, Denver/Boulder Rust meetup, 2016-09-21

## First, what is WebAssembly?

Before we look to deeply into WebAssembly, it's important to consider what it's not:

* A replacement for JavaScript
* A way to run JavaScript
* An assembly language
* Access to web APIs from native code
* Specific to the Web

WebAssembly is a bit of a contradiction on both fronts: it's very high-level for an assembly language, and lacking any (default) access to web APIs.

It's pre-1.0, but with astonishing cross-browser support: Chrome, Firefox, and Edge all have support behind a flag and/or in nightly or canary builds - and Safari has it marked as In-Development.

So what is it, then?

* A way to run portable native code in the browser
* A pre-1.0 W3C spec
* A compile target for C/C++, many more languages to come
* A binary format for the web (!)

What does it look like?

```
TODO!!!!!!
```

Here's what that looks like when "disassembled" (the text format is still in flux):

```
TODO!!!!!!
```

I bet you can guess what that does...

```
$ ./wasm hello.wasm
Hello World!
```

There are some really large applications already working in WebAssembly too: [Demo](https://webassembly.github.io/demo/).

# Rust in WebAssembly

The big question in the room is: "Can you compile Rust to WebAssembly?"

Yes!

At least, if you want to run off a not-yet-merged pull request or restrict yourself to a very limited subset of the language.

The area is very active:
* TODO
* TODO
* TODO

Here's a quick look at mir2wasm:

TODO

Likely, the go-to solution for running Rust on WebAssembly will be LLVM's backend.

TODO (more)

# What can we do with it?

Games are the obvious first target. TODO (more)

But I think WebAssembly as a lot of potential beyond the web.

Take, for example, the rust compiler bootstrapping process.  `rustc` is written in Rust, so there's an obvious chicken-and-egg problem.  Which came first, the language, or the compiler?
