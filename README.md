# BitUtils.jl

BitUtils.jl provides convenience functions for extracting and manipulating
single bits of Integer variables. The MSB is bit nr 0.

The functions complement the `<<`shift left and other bitwise operators in Base. For
comparison, MATLAB has [`bitset`](https://se.mathworks.com/help/matlab/ref/bitset.html) to
set a bit at a specific location.

`setbit(b, T=UInt)` returns a value of type `T` where bit nr `b` is set, all other bits are not
set. Equivalent to `T(1) << 3` and `T(2)^b`.

```julia
setbit(3) --> 0x0000000000000008
setbit(3, Int8) --> 8
```

`setbit(x, b)` returns a copy of `x`, but where bit nr `b` is set. All other bits
are untouched.

```julia
setbit(8, 4) -->
```
