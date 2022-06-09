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
  !!
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
::    TODO: will using +dvr instead of +div and +mod cause any noticable
::    speeup to either +check or +series?
::
++  base-digits
  |=  [b=@ud n=@ud]
  ^-  (list @ud)
  :: without this guard (base-digits b 0) would produce the empty list
  ::
  ?<  .=(n 0)
  |-
  ?:  .=(n 0)
    ~
  :-  (mod n b)
  $(n (div n b))
::  produce a list of the prime factors of n
::
++  prime-factors
  |=  [n=@ud]
  ^-  (list @ud)
  ~[2 3 3 3 3 3 3 7]
--
