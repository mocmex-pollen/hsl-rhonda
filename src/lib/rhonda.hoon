::
::  A library for producing Rhonda numbers and testing if numbers are Rhonda.
::
::    A number is Rhonda if the product of its digits of in base b equals 
::    the product of the base b and the sum of its prime factors.
::    see also: https://mathworld.wolfram.com/RhondaNumber.html
::
=<
::
|%
::  test whether the number n is Rhonda to base b
::
++  check
  |=  [b=@ud n=@ud]
  ^-  ?
  ?>  (gte b 2)
  .=  (roll (base-digits b n) mul)
  %+  mul
    b
  (roll (prime-factors n) add)
::  produce the first n numbers which are Rhonda in base b
::
::    produce ~ if base b has no Rhonda numbers
::
++  series
  |=  [b=@ud n=@ud]
  ^-  (list @ud)
  ?>  (gte b 2)
  ?:  .=((lent (prime-factors b)) 1)
    ~
  =/  candidate=@ud  2
  =+  rhondas=*(list @ud)
  |-
  ?:  .=(n 0)
    (flop rhondas)
  ?:  (check b candidate)
    $(rhondas [candidate rhondas], n (dec n), candidate +(candidate))
  $(candidate +(candidate))
--
::
|%
::  produce a list of the digits of n represented in base b
::
::    This arm has two behaviors which may be at first surprising, but do not
::    matter for the purposes of the check and series arms, and allow for
::    some simplifications to its implementation.
::    - crashes on n=0
::    - orders the list of digits with least significant digits first
::
::    ex: (base-digits 4 10.206) produces ~[2 3 1 3 3 1 2]
::
++  base-digits
  |=  [b=@ud n=@ud]
  ^-  (list @ud)
  ::  without this guard (base-digits b 0) would produce ~
  ::
  ?<  .=(n 0)
  |-
  ?:  .=(n 0)
    ~
  :-  (mod n b)
  $(n (div n b))
::  produce a list of the prime factors of n
::    
::    n must be >= 2
::    if n is prime, produce ~[n]
::    ex: (prime-factors 10.206) produces ~[7 3 3 3 3 3 3 2]
::
::    TODO: can this be made tail-recursive? clearer?
::
++  prime-factors
  |=  [n=@ud]
  ^-  (list @ud)
  ?>  (gte n 2)
  =/  candidate=@ud  2
  =+  factors=*(list @ud)
  |-
  ?.  (lte (mul candidate candidate) n)
    ?:((gth n 1) [n factors] factors)
  |-
  ?:  .=((mod n candidate) 0)
    $(factors [candidate factors], n (div n candidate))
  ^$(candidate +(candidate))
--
