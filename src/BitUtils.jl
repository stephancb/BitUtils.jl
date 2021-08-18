module BitUtils

export setbits,setbit,bitset,anybit

"""
    setbits(b...)

returns an UInt where bits nr b... (e.g. 2,5,7,31) are set (and other bits are not set).
"""
function setbits(b...)
    r = UInt(0)
    for k in b
        r |= UInt(1) << k
    end
    r
end
function setbits(b)
    r = UInt(0)
    for k in b
        r |= UInt(1) << k
    end
    r
end

"""
    setbit(b)

 returns a UInt where bit nr `b` is set (and all other bits are zero).
"""
setbit(b) = UInt(1) << b
setbit(x, b)  = x | (UInt(1) << b)
function setbit!(x, b)
    x[] |= (UInt(1) << b)
end

bitset(x, b) = ((UInt(1) << b) & x)!=0
function anybit(x, b...)
    a = setbits(b...)
    (x & a) != 0
end

end # module
