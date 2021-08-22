module BitUtils

export setbits,setbits!,setbit,setbit!,bitset,anybit

"""
    setbit(b, T::Type{T}=UInt)

 returns a value of type `T` where bit nr `b` is set (and all other bits are zero).
"""
setbit(b, ::Type{T}=UInt) where T = one(T) << b
"""
    setbit(x, b)

returns a copy of x, but with bit nr `b` set. Other bits are not touched.
"""
setbit(x::T, b) where {T} = x | (one(T) << b)
function setbit(x::BitVector, b)
    r = copy(x)
    r[end-b] = 1
    r
end
"""
    function setbit!(x, b)

sets bit nr `b` of the dereferenced `x[]` or the bitvector `x`. 
"""
function setbit!(x::Ref{T}, b) where T
    x[] |= setbit(b, T)
end
function setbit!(x::BitVector, b)
    x[end-b]=1
end

"""
    bitset(x, b)

returns whether bit nr `b` of `x` is set or zero.
"""
bitset(x::T, b) where T = (setbit(b, T) & x)!=0
bitset(x::BitVector, b) = x[end-b]==1

"""
    setbits(b...),setbits(::Type{T}, b...),setbits(b, ::Type{T}=UInt)

all return a value of type `T` (default `UInt`) where bits nr b... (e.g.
2,5,7,31) are set (and other bits are zero). For bitvectors use `setbits!`.
"""
setbits(b...) = setbits(UInt, b...)
function setbits(::Type{T}, b...) where T
    r = zero(T)
    for k in b
        r |= setbit(k, T)
    end
    r
end
function setbits(b, ::Type{T}=UInt) where T
    r = zero(T)
    for k in b
        r |= setbit(k, T)
    end
    r
end
"""
    setbits!(x, b...),setbits!(x, b)

sets the bits nr `b...` in `x`.
"""
function setbits!(x::Union{Ref, BitVector}, b...)
    for k in b
        setbit!(x, k)
    end
end
function setbits!(x::Union{Ref, BitVector}, b)
    for k in b
        setbit!(x, k)
    end
end
"""
    anybit(x, b),anybit(x, b...)

return `true` if in `x` any of the bits nr `b...` is set, otherwise `false`.
"""
function anybit(x::T, b...) where T
    a = setbits(T, b...)
    (x & a) != 0
end
function anybit(x::T, b) where T
    a = setbits(T, b)
    (x & a) != 0
end
function anybit(x::BitVector, b...) 
   for k in b
       bitset(x, k) && return true
   end
   return false
end
function anybit(x::BitVector, b) 
   for k in b
       bitset(x, k) && return true
   end
   return false
end

end # module
