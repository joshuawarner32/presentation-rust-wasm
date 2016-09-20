(module
  (memory 1 1 (segment 0 "Hello"))
  (import $puts "env" "puts" (param i32 i32))
  (func $main
    (call_import $puts (i32.const 0) (i32.const 5))
  )

  (export "main" $main)
)
