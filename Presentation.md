<!-- $size: 16:9 -->

# Rust and WebAssembly

Joshua Warner - Rust Denver/Boulder meetup - 2016-09-21

---

# What is WebAssembly

(and why should I care)

---

WebAssembly or wasm is a new portable, size- and load-time-efficient format suitable for compilation to the web.

\- webassembly.github.io

---

# What it's not

* A replacement for JavaScript
* A way to run JavaScript
* An assembly language
* Access to web APIs from native code
* Specific to the Web

---

# What is it, really?

* A way to run portable native code in the browser
* A pre-1.0 W3C spec
* A compile target for C/C++, many more languages to come
* A binary format for the web (!)

---

# A taste

```
00000000  00 01 01 01 01 02 02 00  01 01 00 00 02 02 03 00  |................|
00000010  00 43 00 00 00 48 00 00  00 4c 00 00 00 09 01 00  |.C...H...L......|
00000020  51 00 00 00 56 00 00 00  07 00 00 00 09 00 09 05  |Q...V...........|
00000030  12 00 ff 04 01 00 00 00  00 5b 00 00 00 05 00 00  |.........[......|
00000040  00 01 06 70 75 74 73 00  65 6e 76 00 70 75 74 73  |...puts.env.puts|
00000050  00 6d 61 69 6e 00 6d 61  69 6e 00 48 65 6c 6c 6f  |.main.main.Hello|
```

---

# Disassembled

```
(module
  (memory 1 1 (segment 0 "Hello"))
  (import $puts "env" "puts" (param i32 i32))
  (func $main
    (call_import $puts (i32.const 0) (i32.const 5))
  )

  (export "main" $main)
)

```

NOTE: the text format is not yet finalized

---

# I bet you can't guess what that does...

---

```
$ ./wasm hello.wasm
Hello
```

---

```
(module
	; ...
)
```

As WebAssembly _module_ is very similar to a rust _crate_

---

```
(memory 1 1 (segment 0 "Hello\00"))
```

1 page (64k) of initial memory
1 page maximum
Initialize the 5 bytes starting at 0 with the string "Hello"

---

## Memory is contiguous
## It starts at 0 -> null is actually a valid address!
## It's always bounds checked

---

```
(import $puts "env" "puts" (param i32 i32))
```

Import `"puts"` from module `"env"`, and call it `$puts` locally.

---

## `$puts` is just for readability.

It's actually just an integer ID in the compile binary

---

## `"puts"` is what other modules need to import.

It's becomes a verbatum string in the binary

---

```
(func $main
  ; ...
)
```

Declare a function with ID `$main` with no parameters and no return value

---

```
(call_import $puts (i32.const 0) (i32.const 5))
```

Call the import with local ID `$puts`, passing `0` and `5` as arguments

---

```
(export "main" $main)
```

Export the function with ID `$main` as `"main"`

---

# TODO!!!!!!!!
More.

---

# Really large applications: [Demo](https://webassembly.github.io/demo/).

---

# Rust on WebAssembly

---

# Can I compile Rust to WebAssembly?

---

# TODO!!!!!!
More.

---

# Applications

---

# Web games

TODO: Image

---

# Deploying large apps to the web

---

# But what if it didn't have to run on the web?

---

# Aside: bootstrapping `rustc`

---

```
$ rustc --print target-list | pr -3 -tw100
aarch64-apple-ios      		 i686-linux-android    		  x86_64-apple-darwin
aarch64-linux-android  		 i686-pc-windows-gnu   		  x86_64-apple-ios
aarch64-unknown-linux-gnu      	 i686-pc-windows-msvc  		  x86_64-pc-windows-gnu
arm-linux-androideabi  		 i686-unknown-dragonfly		  x86_64-pc-windows-msvc
arm-unknown-linux-gnueabi      	 i686-unknown-freebsd  		  x86_64-rumprun-netbsd
arm-unknown-linux-gnueabihf    	 i686-unknown-linux-gnu		  x86_64-sun-solaris
armv7-apple-ios			 i686-unknown-linux-musl       	  x86_64-unknown-bitrig
armv7-linux-androideabi		 le32-unknown-nacl     		  x86_64-unknown-dragonfly
armv7-unknown-linux-gnueabihf  	 mips-unknown-linux-gnu		  x86_64-unknown-freebsd
armv7s-apple-ios       		 mips-unknown-linux-musl       	  x86_64-unknown-linux-gnu
asmjs-unknown-emscripten       	 mipsel-unknown-linux-gnu      	  x86_64-unknown-linux-musl
i386-apple-ios 			 mipsel-unknown-linux-musl     	  x86_64-unknown-netbsd
i586-pc-windows-msvc   		 powerpc-unknown-linux-gnu     	  x86_64-unknown-openbsd
i586-unknown-linux-gnu 		 powerpc64-unknown-linux-gnu
i686-apple-darwin      		 powerpc64le-unknown-linux-gnu
```

---

# Aside: compiling bitcoin

---

Confession:
# I wrote a WebAssembly interpreter
## Here's what I learned.

---

# Zero-copy parsing

Works really well in rust

TODO: code sample

---

# Wrapping integers

Painful if you don't do it rust's way

TODO: code sample

---

# NaN handling

Again: painful

TODO: code sample

---

# Writable zero-copy structures?

---

Writable zero-copy

# Possible solution: arenas

TODO: code sample

---

Writable zero-copy

# My solution: generify ownership

TODO: code sample

---

# Demo

---

# Questions?

---

Extra: It'd be cool if...

# Pre-commit checks actually worked in practice?

(Enter WebAssembly)

---

Extra

# Hexfloat

TODO: code sample

---

# The End.  For real this time.

---

# Just trolling.