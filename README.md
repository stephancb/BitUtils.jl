# BitUtils.jl

BitUtils.jl provides convenience functions for extracting and manipulating single bits of
integer variables. The LSB is bit nr 0. For completeness also bitvectors are supported. In
this case bit nr 0 is the last bit, indexed by `...[end]`. I.e., after applying functions of
`BitUtils.jl`, `bitstring(a)` returns the same string regardless whether `a` is an
integer variable or a bitvector.

All functionality of BitUtils.jl can be achieved with the `<<`shift left and other bitwise
operators in Base. But by using functions code can be clearer and more readable.
For comparison, MATLAB has
[`bitset`](https://se.mathworks.com/help/matlab/ref/bitset.html) to set a bit at a
specific location.

The functions are:

* `setbit(b, T=UInt)` returns a value of type `T` where bit nr `b` is set, all other bits
  are zero. Equivalent to `T(1) << 3` and `T(2)^b`:

    ```julia
    setbit(3) --> 0x0000000000000008
    setbit(3, Int8) --> 8
    ```

* `setbit(x, b)` returns a copy of `x`, but where bit nr `b` is set. All other bits are
  untouched:

    ```julia
    bitstring(setbit(UInt8(3), 4)) --> "00010011"
    ```

* `setbit!(x, b)` sets bit nr `b` of the bitvector `x` or the dereferenced `x`:

    ```julia
    x=Ref(3) --> Base.RefValue{Int64}(3)
    setbit!(x, 4) --> 19
    x[] --> 19
    ```

    Note that
    ```julia
    y=3;
    setbit!(Ref(y), 4) --> 19
    ```
    does not change the value of variable `y` (more precisely, neither the value to which `y`
    is bound, nor the binding of `y`):
    ```julia
    y   --> 3
    ```
    Generally, Julia functions cannot change the values of scalar variables (except references).

* `bitset(x, b)` returns `true` if bit nr `b` of `x` is set, otherwise false.

* `setbits(b...)`, `setbits(::Type{T}, b...)`, `setbits(b, ::Type{T}=UInt)` all return a
  value of type `T` (default `UInt`) where bits nr `b...` or collection `b` are set (and
  other bits are zero). For bitvectors use `setbits!`

* `setbits!(x, b...)`, `setbits!(x, b)` sets the bits nr `b...` in `x`.

* `anybit(x, b)`, `anybit(x, b...)` return `true` if in `x` any of the bits nr `b...` is
  set, otherwise `false`.
