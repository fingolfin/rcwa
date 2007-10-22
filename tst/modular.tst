#############################################################################
##
#W  modular.tst                GAP4 Package `RCWA'                Stefan Kohl
##
#H  @(#)$Id$
##
##  This file contains automated tests of RCWA's functionality for
##  rcwa mappings of and rcwa groups over polynomial rings GF(q)[x].
##
gap> START_TEST("$Id$");
gap> RCWADoThingsToBeDoneBeforeTest();
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
gap> Trajectory(r,x^3,20,Modulus(r));
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

gap> r*(s^r)*r^-1 = s;
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
gap> Trajectory(r,x^3+x^2,[(x^3+x^2)^(r^-1)],"AllCoeffs");
[ [ Z(2)^0, 0*Z(2), Z(2)^0 ], [ x^2+x+Z(2)^0, x^2+x, x^2+Z(2)^0 ],
  [ x^4+x^2+Z(2)^0, x^4+x, x^4+Z(2)^0 ],
  [ x^6+x^5+x^3+x+Z(2)^0, x^6+x^4+x^3+x^2, x^6+x^4+x^2+Z(2)^0 ] ]
gap> rc := function(r,m) return ResidueClass(DefaultRing(m),m,r); end;;
gap> f := RcwaMapping([[ResidueClass(R,x^2,Zero(R)),
>                       ResidueClass(R,x^3,One(R)),
>                       ResidueClass(R,x^2,x)]]);
<bijective rcwa mapping of GF(2)[x] with modulus x^3, of order 3>
gap> G := Group(r);
<rcwa group over GF(2)[x] with 1 generator>
gap> IsTransitive(G,R);
false
gap> R := PolynomialRing(GF(9),1);;
gap> x := IndeterminatesOfPolynomialRing(R)[1];; SetName(x,"x");;
gap> e := One(GF(9));; z := Zero(R);; z9 := Z(9);;
gap> f := RcwaMapping(9,One(R),[[0,x^2+One(R),One(R)]]*One(R));
Constant rcwa mapping of GF(3^2)[x] with value x^2+Z(3)^0
gap> Display(f);
Constant rcwa mapping of GF(3^2)[x] with value x^2+Z(3)^0
gap> String(f);
"RcwaMapping( 9, Z(3)^0, [ [ 0*Z(3), x^2+Z(3)^0, Z(3)^0 ] ] )"
gap> a := RcwaMapping( 9, One(R), [ [ z9, 0, 1 ] ] * One(R) );
Rcwa mapping of GF(3^2)[x]: P -> Z(3^2)*P
gap> ClassReflection(R);
ClassReflection(0*Z(3),Z(3)^0)
gap> last^2;
IdentityMapping( GF(3^2)[x] )
gap> cr := ClassReflection([R]);
ClassReflection(0*Z(3),Z(3)^0)
gap> Order(cr);
2
gap> Support(cr);
GF(3^2)[x] \ [ 0*Z(3) ]
gap> Display(cr);
Bijective rcwa mapping of GF(3^2)[x]: P -> -P
gap> ClassReflection(x,x^2);
ClassReflection(x,x^2)
gap> cr := ClassReflection([x,x^2]);
ClassReflection(x,x^2)
gap> x^cr;
x
gap> (x^2+x)^cr;
-x^2+x
gap> Support(cr);
x(mod x^2) \ [ x ]
gap> Order(cr);
2
gap> LargestSourcesOfAffineMappings(cr);
[ GF(3)[x] \ x(mod x^2), x(mod x^2) ]
gap> cr := ClassReflection(ResidueClass(R,x^2,x));
ClassReflection(x,x^2)
gap> UnderlyingRing(FamilyObj(cr));
GF(3^2)[x]
gap> LargestSourcesOfAffineMappings(cr);
[ GF(3^2)[x] \ x(mod x^2), x(mod x^2) ]
gap> LargestSourcesOfAffineMappings(r);
[ 0*Z(2)(mod x^2+Z(2)^0), Z(2)^0(mod x^2+Z(2)^0), x(mod x^2+Z(2)^0), 
  x+Z(2)^0(mod x^2+Z(2)^0) ]
gap> LargestSourcesOfAffineMappings(One(r));
[ GF(2)[x] ]
gap> R := PolynomialRing(GF(2),1);;
gap> x := IndeterminatesOfPolynomialRing(R)[1];; SetName(x,"x");;
gap> cs1 := ClassShift(R);
ClassShift(0*Z(2),Z(2)^0)
gap> Display(cs1);
Bijective rcwa mapping of GF(2)[x]: P -> P + Z(2)^0
gap> Order(cs1);
2
gap> cs1^2;
IdentityMapping( GF(2)[x] )
gap> cs2 := ClassShift(ResidueClass(R,x,Zero(R)));
ClassShift(0*Z(2),x)
gap> Display(cs2);

Bijective rcwa mapping of GF(2)[x] with modulus x, of order 2

         P mod x          |              P^ClassShift(0*Z(2),x)
--------------------------+---------------------------------------------------
 0*Z(2)                   | P + x
 Z(2)^0                   | P

gap> cs2^2;
IdentityMapping( GF(2)[x] )
gap> Display(cs1*cs2);

Bijective rcwa mapping of GF(2)[x] with modulus x

         P mod x          |                        P^f
--------------------------+---------------------------------------------------
 0*Z(2)                   | P + Z(2)^0
 Z(2)^0                   | P + x+Z(2)^0

gap> (cs1*cs2)^2;
Bijective rcwa mapping of GF(2)[x]: P -> P + x
gap> (cs1*cs2)^4;
IdentityMapping( GF(2)[x] )
gap> Order(cs1*cs2);
4
gap> ClassReflection(R);
IdentityMapping( GF(2)[x] )
gap> ClassReflection([R]);
IdentityMapping( GF(2)[x] )
gap> ClassReflection(Zero(R),x);
IdentityMapping( GF(2)[x] )
gap> ClassReflection([Zero(R),x]);
IdentityMapping( GF(2)[x] )
gap> ct := ClassTransposition(ResidueClass(R,x,One(x)),
>                             ResidueClass(R,x^2+x,x));
ClassTransposition(Z(2)^0,x,x,x^2+x)
gap> Order(ct);
2
gap> ct^2;
IdentityMapping( GF(2)[x] )
gap> Display(ct);

Bijective rcwa mapping of GF(2)[x] with modulus x^2+x, of order 2

       P mod x^2+x        |     P^(ClassTransposition(Z(2)^0,x,x,x^2+x))
--------------------------+---------------------------------------------------
 0*Z(2)                   | P
 Z(2)^0   x+Z(2)^0        | (x+Z(2)^0)*P + Z(2)^0
 x                        | (P + Z(2)^0)/(x+Z(2)^0)

gap> prod1 := ct*cs1;
<bijective rcwa mapping of GF(2)[x] with modulus x^2+x>
gap> RCWAInfo(3);
gap> IsTame(prod1);
#I  `IsTame' for an rcwa mapping <f> of GF(2)[x].
#I  IsTame: Loop Criterion.
#I  IsTame: <f> is wild, by loop criterion.
false
gap> RCWAInfo(0);
gap> prod1^2;
<wild bijective rcwa mapping of GF(2)[x] with modulus x^3+x>
gap> prod1^3;
<wild bijective rcwa mapping of GF(2)[x] with modulus x^4+x^3+x^2+x>
gap> prod1^4;
<wild bijective rcwa mapping of GF(2)[x] with modulus x^5+x>
gap> prod2 := ct*cs2;
<bijective rcwa mapping of GF(2)[x] with modulus x^2+x>
gap> IsTame(prod2);
true
gap> Order(prod2);
3
gap> prod2^2;
<bijective rcwa mapping of GF(2)[x] with modulus x^2+x, of order 3>
gap> prod2^3;
IdentityMapping( GF(2)[x] )
gap> StructureDescription(Group(ClassTransposition(Zero(R),x,One(R),x^2)));
"C2"
gap> IsomorphismRcwaGroup(Group(()),R);
[ () ] -> [ IdentityMapping( GF(2)[x] ) ]
gap> IsomorphismRcwaGroup(SmallGroup(1,1),R);
[ <identity> of ... ] -> [ IdentityMapping( GF(2)[x] ) ]
gap> IsomorphismRcwaGroup(SmallGroup(6,1),R);
[ f1, f2 ] -> [ <bijective rcwa mapping of GF(2)[x] with modulus x^2>, 
  <bijective rcwa mapping of GF(2)[x] with modulus x^3> ]
gap> StructureDescription(Image(last));
"S3"
gap> IsomorphismRcwaGroup(MathieuGroup(11),R);
[ (1,2,3,4,5,6,7,8,9,10,11), (3,7,11,8)(4,10,5,6) ] -> 
[ <bijective rcwa mapping of GF(2)[x] with modulus x^4, of order 11>, 
  <bijective rcwa mapping of GF(2)[x] with modulus x^4, of order 4> ]
gap> a := ClassTransposition(0,x,1,x);;
gap> b := ClassTransposition(0,x^2+1,1,x^2+1);;
gap> c := ClassTransposition(1,x,0,x^2+x);;
gap> G := Group(a,b,c);
<rcwa group over GF(2)[x] with 3 generators>
gap> ab := a*b;; SetName(ab,"ab");
gap> ac := a*c;; SetName(ac,"ac");
gap> H  := Subgroup(G,[ab,ac]);
<rcwa group over GF(2)[x] with 2 generators>
gap> IsNormal(G,H);
true
gap> Index(G,H);
2
gap> G/H;
Group([ (1,2), (1,2), (1,2) ])
gap> phi := EpimorphismFromFreeGroup(H);
[ ab, ac ] -> [ ab, ac ]
gap> F := Source(phi);;
gap> H2 := Subgroup(G,[a*b*c,a*c]);;
gap> IsNormal(G,H2);
true
gap> elm := First(G,g->not IsTame(g));
<wild bijective rcwa mapping of GF(2)[x] with modulus x^2+x>
gap> elm in H;
true
gap> elm in H2;
true
gap> PreImagesRepresentative(phi,elm);
ac^-1
gap> RCWADoThingsToBeDoneAfterTest();
gap> STOP_TEST( "modular.tst", 1500000000 );

#############################################################################
##
#E  modular.tst . . . . . . . . . . . . . . . . . . . . . . . . . . ends here