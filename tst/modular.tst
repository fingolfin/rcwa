#############################################################################
##
#W  modular.tst                GAP4 Package `RCWA'                Stefan Kohl
##
#H  @(#)$Id$
##

gap> START_TEST("$Id$");
gap> R := PolynomialRing(GF(2),1);;
gap> x := IndeterminatesOfPolynomialRing(R)[1];; SetName(x,"x");;
gap> e := One(GF(2));; z := Zero(R);;
gap> RcwaMapping(R,One(R),[[x,x,One(R)]]);
Rcwa mapping of GF(2)[x]: P -> x*P + x
gap> r := RcwaMapping( 2, x^2 + e,
>                             [ [ x^2 + x + e, z      , x^2 + e ],
>                               [ x^2 + x + e, x      , x^2 + e ],
>                               [ x^2 + x + e, x^2    , x^2 + e ],
>                               [ x^2 + x + e, x^2 + x, x^2 + e ] ] );
<rcwa mapping of GF(2)[x] with modulus x^2+Z(2)^0>
gap> One(r);
IdentityMapping( GF(2)[x] )
gap> Zero(r);
ZeroMapping( GF(2)[x], GF(2)[x] )
gap> Display(One(r));
Identity rcwa mapping of GF(2)[x]
gap> Display(Zero(r));
Zero rcwa mapping of GF(2)[x]
gap> IsZero(r);
false
gap> IsZero(Zero(r));
true
gap> IsOne(r);
false
gap> IsOne(One(r));
true
gap> r * One(r) = r and One(r) * r = r;
true
gap> r * Zero(r) = Zero(r) and Zero(r) * r = Zero(r);
true
gap> Display(r);

Rcwa mapping of GF(2)[x] with modulus x^2+Z(2)^0

     P mod x^2+Z(2)^0     |                        P^f
--------------------------+---------------------------------------------------
 0*Z(2)                   | (x^2+x+Z(2)^0)*P/(x^2+Z(2)^0)
 Z(2)^0                   | ((x^2+x+Z(2)^0)*P + x)/(x^2+Z(2)^0)
 x                        | ((x^2+x+Z(2)^0)*P + x^2)/(x^2+Z(2)^0)
 x+Z(2)^0                 | ((x^2+x+Z(2)^0)*P + x^2+x)/(x^2+Z(2)^0)

gap> Print(r,"\n");
RcwaMapping( 2, x^2+Z(2)^0, [ [ x^2+x+Z(2)^0, 0*Z(2), x^2+Z(2)^0 ],
  [ x^2+x+Z(2)^0, x, x^2+Z(2)^0 ], [ x^2+x+Z(2)^0, x^2, x^2+Z(2)^0 ],
  [ x^2+x+Z(2)^0, x^2+x, x^2+Z(2)^0 ] ] )
gap> IsBijective(r);
true
gap> (x^2+x+One(R))^r;
x^2+Z(2)^0
gap> PreImage(r,last);
x^2+x+Z(2)^0
gap> r*r^-1 = One(r);
true
gap> r^-1*r = One(r);
true
gap> r^2;
<bijective rcwa mapping of GF(2)[x] with modulus x^4+Z(2)^0>
gap> r+r = Zero(r);
true
gap> -r = r;
true
gap> Modulus(r);
x^2+Z(2)^0
gap> Coefficients(r) = [ [ Z(2)^0+x+x^2, Zero(R), Z(2)^0+x^2 ],
>                        [ Z(2)^0+x+x^2, x, Z(2)^0+x^2 ], 
>                        [ Z(2)^0+x+x^2, x^2, Z(2)^0+x^2 ],
>                        [ Z(2)^0+x+x^2, x+x^2, Z(2)^0+x^2 ] ];
true
gap> PrimeSet(r) = [ Z(2)^0+x, Z(2)^0+x+x^2 ];
true
gap> Multiplier(r);
x^2+x+Z(2)^0
gap> Divisor(r);
x^2+Z(2)^0
gap> IsOne(One(r));
true
gap> TrajectoryModulo(r,x^3,20);
[ x, x+Z(2)^0, 0*Z(2), Z(2)^0, x, x+Z(2)^0, 0*Z(2), Z(2)^0, x, x+Z(2)^0,
  0*Z(2), Z(2)^0, x, x+Z(2)^0, 0*Z(2), Z(2)^0, x, x+Z(2)^0, 0*Z(2), Z(2)^0 ]
gap> MovedPoints(r);
GF(2)[x] \ [ 0*Z(2), Z(2)^0, x, x+Z(2)^0 ]
gap> G := Group(r);
<rcwa group over GF(2)[x] with 1 generator>
gap> T := TrivialSubgroup(G);
Trivial rcwa group over GF(2)[x]
gap> Display(TrivialSubgroup(G));
Trivial rcwa group over GF(2)[x]
gap> Size(T);
1
gap> Display(G);

Rcwa group over GF(2)[x], generated by

[

Bijective rcwa mapping of GF(2)[x] with modulus x^2+Z(2)^0

     P mod x^2+Z(2)^0     |                        P^f
--------------------------+---------------------------------------------------
 0*Z(2)                   | (x^2+x+Z(2)^0)*P/(x^2+Z(2)^0)
 Z(2)^0                   | ((x^2+x+Z(2)^0)*P + x)/(x^2+Z(2)^0)
 x                        | ((x^2+x+Z(2)^0)*P + x^2)/(x^2+Z(2)^0)
 x+Z(2)^0                 | ((x^2+x+Z(2)^0)*P + x^2+x)/(x^2+Z(2)^0)

]

gap> orb6 := ShortOrbits(G,Set(AllGFqPolynomialsModDegree(2,6,x)),20);;
gap> List(orb6,Length);
[ 1, 1, 1, 1, 2, 2, 4, 4, 4, 4, 4, 4, 8, 8, 8, 8 ]
gap> s := RcwaMapping(2,x,[[One(R),Zero(R),One(R)],[x,Zero(R),One(R)]]);
<rcwa mapping of GF(2)[x] with modulus x>
gap> SetName(s,"s");
gap> Display(s);
 
Rcwa mapping of GF(2)[x] with modulus x
 
         P mod x          |                        P^s
--------------------------+---------------------------------------------------
 0*Z(2)                   | P
 Z(2)^0                   | x*P

gap> r*(s^r)*r^-1 = s;  # Does not work in 4.2.
true
gap> One(r) in Group(r);
true
gap> r in Group(r);
true
gap> s := RcwaMapping(2,x,[[One(R),Zero(R),x],[x,Zero(R),One(R)]]);
<rcwa mapping of GF(2)[x] with modulus x>
gap> Display(s);
 
Rcwa mapping of GF(2)[x] with modulus x
 
         P mod x          |                        P^f
--------------------------+---------------------------------------------------
 0*Z(2)                   | P/x
 Z(2)^0                   | x*P
 
gap> Display(s^2);

Rcwa mapping of GF(2)[x] with modulus x^2

        P mod x^2         |                        P^f
--------------------------+---------------------------------------------------
 0*Z(2)                   | P/x^2
 Z(2)^0   x               |
 x+Z(2)^0                 | P

gap> IsInjective(s);
false
gap> IsSurjective(s);
true
gap> (x^2)^s = One(R)^s;
true
gap> Display(s^r);

Surjective rcwa mapping of GF(2)[x] with modulus x^3+x^2+x

     P mod x^3+x^2+x      |                        P^f
--------------------------+---------------------------------------------------
 0*Z(2)                   |
 x                        | P/x
 Z(2)^0                   |
 x^2+x+Z(2)^0             | x*P
 x+Z(2)^0                 |
 x^2+Z(2)^0               | x*P + x
 x^2                      |
 x^2+x                    | (P + x)/x

gap> s := RcwaMapping(2,x^2,[[1,0,1],[x,0,1],[1,0,x],[x,0,1]]*One(R));
<rcwa mapping of GF(2)[x] with modulus x^2>
gap> Order(s);
2
gap> Display(s);
 
Bijective rcwa mapping of GF(2)[x] with modulus x^2, of order 2

        P mod x^2         |                        P^f
--------------------------+---------------------------------------------------
 0*Z(2)                   | P
 Z(2)^0   x+Z(2)^0        | x*P
 x                        | P/x

gap> G := Group(r,s);
<rcwa group over GF(2)[x] with 2 generators>
gap> orb := Orbit(G,x^2+One(R));
[ x^2+Z(2)^0, x^2+x+Z(2)^0, x^3+x, x^3+x^2+x, x^3, x^3+x^2 ]
gap> H := Action(G,orb);
Group([ (1,2)(3,4,5,6), (1,3)(2,4) ])
gap> c := Comm(r,s);
<bijective rcwa mapping of GF(2)[x] with modulus x^4+x^3+x^2>
gap> Display(c);

Bijective rcwa mapping of GF(2)[x] with modulus x^4+x^3+x^2

    P mod x^4+x^3+x^2     |                        P^f
--------------------------+---------------------------------------------------
 0*Z(2)                   |
 Z(2)^0                   |
 x                        |
 x^2+x+Z(2)^0             |
 x^3+Z(2)^0               |
 x^3+x^2                  |
 x^3+x^2+x                |
 x^3+x^2+x+Z(2)^0         | P
 x+Z(2)^0                 |
 x^2+Z(2)^0               |
 x^3+x+Z(2)^0             |
 x^3+x^2+Z(2)^0           | x*P + x
 x^2                      |
 x^3                      | P + x
 x^2+x                    |
 x^3+x                    | P/x

gap> Order(c);
3 
gap> t := RcwaMapping(2,One(R),[[1,x,1]]*One(R));
Rcwa mapping of GF(2)[x]: P -> P + x
gap> Order(t);
2
gap> CoefficientsOnTrajectory(r,x^3+x^2,x^3+x^2,"stop",true);
[ [ Z(2)^0, 0*Z(2), Z(2)^0 ], [ x^2+x+Z(2)^0, x^2+x, x^2+Z(2)^0 ], 
  [ x^4+x^2+Z(2)^0, x^4+x, x^4+Z(2)^0 ], 
  [ x^6+x^5+x^3+x+Z(2)^0, x^6+x^4+x^3+x^2, x^6+x^4+x^2+Z(2)^0 ], 
  [ x^8+x^4+Z(2)^0, x^7+x^6, x^8+Z(2)^0 ] ]
gap> rc := function(r,m) return ResidueClass(DefaultRing(m),m,r); end;;
gap> f := RcwaMapping([[rc(Zero(R),x^2),rc(One(R),x^3),rc(x,x^2)]]);
<rcwa mapping of GF(2)[x] with modulus x^3>
gap> Order(f);
3
gap> G := Group(r);
<rcwa group over GF(2)[x] with 1 generator>
gap> IsTransitive(G,R);
false
gap> R := PolynomialRing(GF(9),1);;
gap> x := IndeterminatesOfPolynomialRing(R)[1];; SetName(x,"x");;
gap> e := One(GF(9));; z := Zero(R);; z9 := Z(9);;
gap> f := RcwaMapping(9,One(R),[[0,x^2+One(R),One(R)]]*One(R));
Constant rcwa mapping of GF(9)[x] with value x^2+Z(3)^0
gap> Display(f);
Constant rcwa mapping of GF(9)[x] with value x^2+Z(3)^0
gap> String(f);
"RcwaMapping( 9, Z(3)^0, [ [ 0*Z(3), x^2+Z(3)^0, Z(3)^0 ] ] )"
gap> a := RcwaMapping( 9, One(R), [ [ z9, 0, 1 ] ] * One(R) );
Rcwa mapping of GF(9)[x]: P -> Z(3^2)*P
gap> STOP_TEST( "modular.tst", 1500000000 );

#############################################################################
##
#E  modular.tst . . . . . . . . . . . . . . . . . . . . . . . . . . ends here

