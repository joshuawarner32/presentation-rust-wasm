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

# Rust on WebAssembly

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

Right now, rustc solves this by hosting pre-built versions of the previous version of the rustc compiler, built for a variety of architectures and OSes.  The build process downloads these pre-built binaries and uses these to build the current version.  If you go back far enough, you'll find binaries for the original OCAML version of the compiler.

But what happens if rustc didn't happen to build binaries for your platform?  All of the sudden, you can't do a full from-source bootstrap process on your machine.  At some point, you have to cross-compile.

Imagine instead of these rustc binaries were actually just properly packaged .wasm binaries.  Instead of having to cross-compile the first stage of the compiler, all you need to bootstrap the rustc compiler is a wasm interpreter - which is relatively easy to build and incredibly portable.  What's more, wasm interpreters / compilers should shortly be practically universal, so this could work out-of-the-box on a huge variety of systems.

TODO (more)

# WebAssembly on Rust

As with most things, one of the best ways to learn something in software is to re-implement it yourself.  Here's what I learned, not just about WebAssembly, but also Rust:

* NaN behavior is notoriously inconsistent
* Zero-copy parsing
* Generics over lifetime parameters/ownership
* Memory pooling would be nice, but painful/difficult
  * Mutable OUTER container, with immutable inner data not (currently) possible (?)

# Extras

Long-term vision:

* Platform for running well-sandboxed, perfectly deterministic mini-build tasks
* Built-in to version control system
* Useful for e.g. 100% portable pre-commit checks
* Good for isolated, reproducible, verifiable builds of critical components (e.g. bitcoin wallets)

HexFloats

* Good for well-spec'd parsing
* Parsing and printing decimal floats is a *huge* pain in the ass (nobody does it consistently)

Splitting enums

* Sometimes you want a function to only accept a subset of enum variants
* Rust type system doesn't currently support this
* Hack/workaround: use a tree of nested enums
