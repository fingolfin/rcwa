#############################################################################
##
#W  integral.tst               GAP4 Package `RCWA'                Stefan Kohl
##
#H  @(#)$Id$
##

gap> START_TEST("$Id$");
gap> IdentityIntegralRcwaMapping;
<identity integral rcwa mapping>
gap> ZeroIntegralRcwaMapping;
<zero integral rcwa mapping>
gap> Order(IdentityIntegralRcwaMapping);
1
gap> f := RcwaMapping((1,2,3)(8,9),[4..20]);
<integral rcwa mapping with modulus 17>
gap> Action(Group(f),[4..20]) = Group([(5,6)]);
true
gap> IsIdenticalObj(f!.coeffs,Coefficients(f));
true
gap> T := RcwaMapping([[1,0,2],[3,1,2]]);
<integral rcwa mapping with modulus 2>
gap> Print(T,"\n");
IntegralRcwaMapping( [ [ 1, 0, 2 ], [ 3, 1, 2 ] ] )
gap> IsInjective(T);
false
gap> IsSurjective(T);
true
gap> Coefficients(T);
[ [ 1, 0, 2 ], [ 3, 1, 2 ] ]
gap> Display(T^3);

Surjective integral rcwa mapping with modulus 8

                n mod 8                |                 n^f
---------------------------------------+--------------------------------------
  0                                    | n/8
  1                                    | (9n + 7)/8
  2                                    | (3n + 2)/8
  3                                    | (9n + 5)/8
  4                                    | (3n + 4)/8
  5                                    | (3n + 1)/8
  6                                    | (9n + 10)/8
  7                                    | (27n + 19)/8

gap> t := RcwaMapping([[-1,0,1]]);
<integral rcwa mapping: n -> -n>
gap> Order(t);
2
gap> k := RcwaMapping([[-4,-8,1]]);;
gap> IsBijective(k);
false
gap> k := RcwaMapping([[-2,0,1]]);
<integral rcwa mapping: n -> -2n>
gap> Display(k);
Integral rcwa mapping: n -> -2n
gap> IsInjective(k);
true
gap> IsSurjective(k);
false
gap> k := RcwaMapping([[-2,0,1],[1,0,1]]);;
gap> IsInjective(k);
true
gap> IsSurjective(k);
false
gap> k := RcwaMapping([[-2,0,1],[-1,1,1]]);;
gap> IsSurjective(k);
false
gap> IsInjective(k);
false
gap> k := RcwaMapping([[2,3,1]]);
<integral rcwa mapping: n -> 2n + 3>
gap> Display(k);
Integral rcwa mapping: n -> 2n + 3
gap> k := RcwaMapping([[-2,3,1]]);
<integral rcwa mapping: n -> -2n + 3>
gap> Display(k);
Integral rcwa mapping: n -> -2n + 3
gap> k := RcwaMapping([[-1,3,1]]);
<integral rcwa mapping: n -> -n + 3>
gap> Display(k);
Integral rcwa mapping: n -> -n + 3
gap> k := RcwaMapping([[-1,-3,1]]);
<integral rcwa mapping: n -> -n - 3>
gap> Display(k);
Integral rcwa mapping: n -> -n - 3
gap> u := RcwaMapping([[3,0,5],[9,1,5],[3,-1,5],[9,-2,5],[9,4,5]]);;
gap> IsBijective(u);
true
gap> Modulus(u);
5
gap> Display(u^-1);

Bijective integral rcwa mapping with modulus 9

                n mod 9                |                 n^f
---------------------------------------+--------------------------------------
  0 3 6                                | 5n/3
  1 4 7                                | (5n + 1)/3
  2                                    | (5n - 1)/9
  5                                    | (5n + 2)/9
  8                                    | (5n - 4)/9

gap> Modulus(T^u);
18
gap> PrimeSet(T^(u^-1));
[ 2, 3, 5 ]
gap> Order(u);
infinity
gap> 15^T; 
23 
gap> PreImageElm(u,8);
4
gap> PreImagesElm(T,8);
[ 16, 5 ]
gap> PreImagesElm(ZeroIntegralRcwaMapping,0);
Integers
gap> d := RcwaMapping([[0,0,1],[0,1,1]]);;
gap> PreImagesRepresentative(d,1);
1
gap> G := RCWA(Integers);
RCWA(Z)
gap> Size(G);
infinity
gap> IsFinite(G);
false
gap> IsFinitelyGeneratedGroup(G);
false
gap> IsGroup(G);
true
gap> IsNaturalRCWA_Z(G);
true
gap> One(G);
<identity integral rcwa mapping>
gap> Representative(G);
<integral rcwa mapping: n -> -n>
gap> IsSubgroup(RCWA(Integers),TrivialIntegralRcwaGroup);
true
gap> u in G;
true
gap> t in G;
true
gap> T in G;
false
gap> a := RcwaMapping([[3,0,2],[3, 1,4],[3,0,2],[3,-1,4]]);;
gap> b := RcwaMapping([[3,0,2],[3,13,4],[3,0,2],[3,-1,4]]);;
gap> c := RcwaMapping([[3,0,2],[3, 1,4],[3,0,2],[3,11,4]]);;
gap> ab := Comm(a,b);;
gap> ac := Comm(a,c);;
gap> bc := Comm(b,c);;
gap> Order(ab);
6
gap> Order(ac);
6
gap> Order(bc);
12
gap> Display(ab);

Bijective integral rcwa mapping with modulus 18, of order 6

               n mod 18                |                 n^f
---------------------------------------+--------------------------------------
   0  2  3  8  9 11 12 17              | n
   1 10                                | 2n - 5
   4  7 13 16                          | n + 3
   5 14                                | 2n - 4
   6                                   | (n + 2)/2
  15                                   | (n - 5)/2

gap> G := Group(ab,ac);
<integral rcwa group with 2 generators>
gap> Display(G);

Integral rcwa group, generated by

[

Bijective integral rcwa mapping with modulus 18, of order 6

               n mod 18                |                 n^f
---------------------------------------+--------------------------------------
   0  2  3  8  9 11 12 17              | n
   1 10                                | 2n - 5
   4  7 13 16                          | n + 3
   5 14                                | 2n - 4
   6                                   | (n + 2)/2
  15                                   | (n - 5)/2


Bijective integral rcwa mapping with modulus 18, of order 6

               n mod 18                |                 n^f
---------------------------------------+--------------------------------------
   0  1  6  7  9 10 15 16              | n
   2  5 11 14                          | n + 3
   3                                   | (n + 1)/2
   4 13                                | 2n - 5
   8 17                                | 2n - 4
  12                                   | (n - 4)/2

]

gap> TrivialSubgroup(G);
<trivial integral rcwa group>
gap> orb := Orbit(G,1);
[ 1, -3, -4, -12, -1, -5, -6, -2, -15, -7 ]
gap> H := Action(G,orb);;
gap> H = Group([(1,2,3,4,6,8),(3,5,7,6,9,10)]);
true
gap> Size(H);
3628800
gap> Size(G);
3628800
gap> Modulus(G);
18
gap> Order(a);
infinity
gap> Comm(a,t);
<identity integral rcwa mapping>
gap> x := ab*ac*ab^2*ac^3;
<bijective integral rcwa mapping with modulus 18>
gap> x in G;
true
gap> u in G;
false
gap> ShortOrbits(G,[-20..20],100) =
>    [[-51,-48,-42,-39,-25,-23,-22,-20,-19,-17], [-18], 
>     [-33,-30,-24,-21,-16,-14,-13,-11,-10,-8], 
>     [-15,-12,-7,-6,-5,-4,-3,-2,-1,1], [-9], [0], 
>     [2,3,4,5,6,7,8,10,12,15], [9], 
>     [11,13,14,16,17,19,21,24,30,33], [18], 
>     [20,22,23,25,26,28,39,42,48,51]];
true
gap> g := RcwaMapping([[2,2,1],[1, 4,1],[1,0,2],[2,2,1],[1,-4,1],[1,-2,1]]);;
gap> h := RcwaMapping([[2,2,1],[1,-2,1],[1,0,2],[2,2,1],[1,-1,1],[1, 1,1]]);;
gap> Order(g);
7
gap> Order(h);
12
gap> Order(Comm(g,h));
infinity
gap> h in G;
false
gap> std := StandardConjugate(g);
<integral rcwa mapping with modulus 7>
gap> tostd := StandardizingConjugator(g);
<integral rcwa mapping with modulus 12>
gap> g^tostd = std;
true
gap> std := StandardConjugate(ab);
<integral rcwa mapping with modulus 7>
gap> tostd := StandardizingConjugator(ab);
<integral rcwa mapping with modulus 18>
gap> ab^tostd = std;
true
gap> r := g^ab;
<bijective integral rcwa mapping with modulus 36, of order 7>
gap> HasStandardConjugate(r) and HasStandardizingConjugator(r);
true
gap> r^StandardizingConjugator(r)/StandardConjugate(r);
<identity integral rcwa mapping>
gap> k := RcwaMapping([[1,1,1],[1, 4,1],[1,1,1],[2,-2,1],
>                      [1,0,2],[1,-5,1],[1,1,1],[2,-2,1]]);;
gap> std := StandardConjugate(k);
<integral rcwa mapping with modulus 3>
gap> tostd := StandardizingConjugator(k);
<integral rcwa mapping with modulus 16>
gap> k^tostd = std;
true
gap> v := RcwaMapping([[-1,2,1],[1,-1,1],[1,-1,1]]);;
gap> w := RcwaMapping([[-1,3,1],[1,-1,1],[1,-1,1],[1,-1,1]]);;
gap> CycleType(k);
[ [  ], [ 3 ] ]
gap> CycleType(ab);
[ [  ], [ 1, 6 ] ]
gap> CycleType(v);
[ [ 6 ], [  ] ]
gap> CycleType(w);
[ [ 8 ], [  ] ]
gap> CycleType(g);
[ [  ], [ 7 ] ]
gap> CycleType(h);
[ [  ], [ 3, 4 ] ]
gap> k := RcwaMapping([[-1,2,1],[1,-1,1],[1,-1,1],[1,1,1],[1,-1,1]]);;
gap> CycleType(k);
[ [ 6 ], [ 2 ] ]
gap> std := StandardConjugate(k);
<integral rcwa mapping with modulus 5>
gap> tostd := StandardizingConjugator(k);
<integral rcwa mapping with modulus 5>
gap> k^tostd = std;
true
gap> Order(tostd);
2
gap> CompositionMapping(a,b) = b*a;
true
gap> CompositionMapping(g,h) = h*g;
true
gap> x := RcwaMapping([[ 16,  2,  1], [ 16, 18,  1],
>                      [  1, 16,  1], [ 16, 18,  1],
>                      [  1, 16,  1], [ 16, 18,  1],
>                      [  1, 16,  1], [ 16, 18,  1],
>                      [  1, 16,  1], [ 16, 18,  1],
>                      [  1, 16,  1], [ 16, 18,  1],
>                      [  1, 16,  1], [ 16, 18,  1],
>                      [  1, 16,  1], [ 16, 18,  1],
>                      [  1,  0, 16], [ 16, 18,  1],
>                      [  1,-14,  1], [ 16, 18,  1],
>                      [  1,-14,  1], [ 16, 18,  1],
>                      [  1,-14,  1], [ 16, 18,  1],
>                      [  1,-14,  1], [ 16, 18,  1],
>                      [  1,-14,  1], [ 16, 18,  1],
>                      [  1,-14,  1], [ 16, 18,  1],
>                      [  1,-14,  1], [  1,-31,  1]]);
<integral rcwa mapping with modulus 32>
gap> Order(x);
257
gap> 1^x;
34
gap> Display(a + b);

Integral rcwa mapping with modulus 4

                n mod 4                |                 n^f
---------------------------------------+--------------------------------------
  0 2                                  | 3n
  1                                    | (3n + 7)/2
  3                                    | (3n - 1)/2

gap> Display(a - b);

Integral rcwa mapping with modulus 4

                n mod 4                |                 n^f
---------------------------------------+--------------------------------------
  0 2 3                                | 0
  1                                    | -3

gap> RcwaGraph(a) = rec( isGraph := true, order := 4, group := Group(()), 
>                        schreierVector := [ -1, -2, -3, -4 ], 
>                        adjacencies := [ [ 1, 3 ], [ 1, 2, 3, 4 ],
>                                         [ 2, 4 ], [ 1, 2, 3, 4 ] ], 
>                        representatives := [ 1, 2, 3, 4 ],
>                        names := [ 1, 2, 3, 4 ] );
true
gap> a*(bc*f) = (a*bc)*f;
true
gap> h*(a*b) = (h*a)*b;
true
gap> u*(ac^-1*g) = (u*ac^-1)*g;
true
gap> u*g*(u*g)^-1 = IdentityIntegralRcwaMapping;
true
gap> a*(b+c) = a*b + a*c;
true
gap> g*(a+u) = g*a + g*u;
true
gap> h*(b-t) = h*b - h*t;
true
gap> List([0..7],i->Modulus(g^i));
[ 1, 6, 12, 12, 12, 12, 6, 1 ]
gap> List([0..3],i->Modulus(u^i));
[ 1, 5, 25, 125 ]
gap> s := RcwaMapping([[1,0,1],[1,1,1],[3,  6,1],
>                      [1,0,3],[1,1,1],[3,  6,1],
>                      [1,0,1],[1,1,1],[3,-21,1]]);;
gap> List([0..9],i->Modulus(s^i));
[ 1, 9, 9, 27, 27, 27, 27, 27, 27, 1 ]
gap> G := Group(a*b,u^f,Comm(a,b));
<integral rcwa group with 3 generators>
gap> PrimeSet(G);
[ 2, 3, 5, 17 ]
gap> g1 := RcwaMapping((1,2),[1..2]);
<integral rcwa mapping with modulus 2>
gap> g2 := RcwaMapping((1,2,3),[1..3]);
<integral rcwa mapping with modulus 3>
gap> g3 := RcwaMapping((1,2,3,4,5),[1..5]);
<integral rcwa mapping with modulus 5>
gap> G := Group(g1,g2);
<integral rcwa group with 2 generators>
gap> H := NiceObject(G);
Group([ (1,2)(3,4)(5,6), (1,2,3)(4,5,6) ])
gap> phi := NiceMonomorphism(G);  # Produces different output in 4.2.
[ <bijective integral rcwa mapping with modulus 2, of order 2>,
  <bijective integral rcwa mapping with modulus 3, of order 3> ] ->
[ (1,2)(3,4)(5,6), (1,2,3)(4,5,6) ]
gap> IsBijective(phi);
true
gap> phi = IsomorphismPermGroup(G);
true
gap> IdGroup(G);
[ 24, 12 ]
gap> G;
<integral rcwa group with 2 generators, of isomorphism type [ 24, 12 ]>
gap> Modulus(G);
6
gap> A4 := DerivedSubgroup(G);
<integral rcwa group with 3 generators, of size 12>
gap> IsBijective(IsomorphismGroups(AlternatingGroup(4),A4));
true
gap> H := RcwaGroupByPermGroup(Group((1,2),(3,4),(5,6),(7,8),
>                                    (1,3)(2,4),(1,3,5,7)(2,4,6,8)));
<integral rcwa group with 6 generators>
gap> Size(H);
384
gap> IsSolvable(H);
true
gap> List(DerivedSeries(H),Size);
[ 384, 96, 32, 2, 1 ]
gap> Modulus(H);
8
gap> NrConjugacyClassesOfRCWAZOfOrder(2);
infinity
gap> NrConjugacyClassesOfRCWAZOfOrder(105);
218
gap> IsTame(T);
false
gap> IsTame(ab);
true
gap> IsTame(G);
true
gap> IsTame(Group(ab,ac));
true
gap> nu := RcwaMapping([[1,1,1]]);
<integral rcwa mapping: n -> n + 1>
gap> IsTame(nu);
true
gap> IsTame(Group(nu));
true
gap> Size(Group(nu));
infinity
gap> x := RcwaMapping([[-1,2,1],[1,-1,1],[1,-1,1]]);
<integral rcwa mapping with modulus 3>
gap> Order(x);
6
gap> List([-10..10],n->Length(Orbit(Group(x),n)));
[ 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 3, 3, 3, 6, 6, 6, 6, 6, 6, 6, 6 ]
gap> y := RcwaMapping([[-1,3,1],[1,-1,1],[1,-1,1],[1,-1,1]]);
<integral rcwa mapping with modulus 4>
gap> Order(y);
8
gap> List([-10..10],n->Length(Orbit(Group(y),n)));
[ 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 4, 4, 4, 4, 8, 8, 8, 8, 8, 8, 8 ]
gap> Order(x*y);
24
gap> Order(Comm(x,y));
20
gap> IsFlat(f);
true
gap> IsFlat(u);
false
gap> IsFlat(T);
false
gap> IsFlat(nu);
true
gap> IsFlat(nu^a);
false
gap> IsFlat((nu^a)^2);
true
gap> IsFlat(AlternatingGroup(IsIntegralRcwaGroup,5));
true
gap> IsFlat(Group(a,b));
false
gap> IsFlat(Group(g));
false
gap> IsClassWiseOrderPreserving(u);
true
gap> IsClassWiseOrderPreserving(T);
true
gap> IsClassWiseOrderPreserving(t);
false
gap> IsClassWiseOrderPreserving(nu);
true
gap> IsClassWiseOrderPreserving(nu^RcwaMapping([[-1,0,1],[1,0,1]]));
false
gap> IsClassWiseOrderPreserving(Group(a,b));
true
gap> IsClassWiseOrderPreserving(G);
true
gap> IsClassWiseOrderPreserving(Group(t,g,h));
false
gap> y := RcwaMapping([[28,   0, 9], [ 7, -16, 9], [28,   7, 9],
>                      [28,  42, 9], [ 7,   8, 9], [ 7, -17, 9],
>                      [ 7,  12,18], [ 7,  -4, 9], [28, -35, 9],
>                      [28,   0, 9], [ 7, -16, 9], [28,   7, 9],
>                      [28,  42, 9], [ 7,   8, 9], [ 7, -17, 9],
>                      [ 7, -87,18], [ 7,  -4, 9], [28, -35, 9]]);;
gap> ab^y = RcwaMapping((1,2,3,4,5,6),[1..7]);
true
gap> ShortOrbits(Group(u),[-30..30],100) = 
>    [[-13,-8,-7,-5,-4,-3,-2], [-10,-6], [-1], [0], [1,2], [3,5],
>     [24,36,39,40,44,48,60,65,67,71,80,86,93,100,112, 
>      128,138,155,167,187,230,248,312,446,520,803,867,1445]];
true
gap> ShortCycles(u,2);
[ [ 0 ], [ -1 ], [ 1, 2 ], [ 3, 5 ], [ -10, -6 ] ]
gap> ShortCycles(a,1);
[ [ 0 ], [ 1 ], [ -1 ] ]
gap> ShortCycles(a,2);
[ [ 0 ], [ 1 ], [ -1 ], [ 2, 3 ], [ -3, -2 ] ]
gap> DeterminantMat(TransitionMatrix(T,13));
-16
gap> Display(TransitionMatrix(ab,20)*One(GF(2)));
 1 1 . 1 . . . . . . . 1 . . . 1 1 . . .
 . 1 . . 1 . . . 1 . . . . . . . . 1 1 .
 1 . 1 . . 1 . . . . . . 1 . . . . . . 1
 . 1 1 1 . . 1 . . 1 . . . . . . . . . 1
 . . . 1 1 . . 1 . . . . . 1 . . . . . .
 1 . . . . 1 1 . 1 . 1 . . . . . . . . .
 . . . . 1 . 1 1 1 1 . . . . 1 . . . . .
 . 1 . . . . . 1 . 1 1 1 . . . . . . . .
 . . . . . 1 . . 1 . . 1 1 . . 1 . . . .
 . . 1 . . . . . . 1 . . 1 1 1 . . . . .
 . . . . . . 1 . . . 1 . . 1 . 1 1 . . .
 . . . 1 . . . . . . . 1 . 1 1 . . 1 1 .
 1 . . . . . . 1 . . . . 1 . . 1 . 1 . 1
 . 1 1 . 1 . . . . . . . . 1 1 . 1 . . .
 . . . 1 1 . . . 1 . . . . . 1 . . 1 1 .
 . . . . . 1 1 . . . . . . . . 1 . . 1 .
 . . . . . . . 1 1 1 . . . . . . 1 . . 1
 1 . . . . . 1 . . 1 1 . . . . . 1 1 . .
 1 1 . . . . . . . . 1 1 1 . . . . . 1 .
 . . 1 . . . . 1 . . . . . 1 1 . . 1 . 1
gap> C2 := CyclicGroup(IsIntegralRcwaGroup,2);
<integral rcwa group with 1 generator>
gap> IdGroup(C2);
[ 2, 1 ]
gap> G := AbelianGroup(IsIntegralRcwaGroup,[2,3]);
<integral rcwa group with 2 generators>
gap> IdGroup(G);
[ 6, 2 ]
gap> G := ElementaryAbelianGroup(IsIntegralRcwaGroup,8);
<integral rcwa group with 3 generators>
gap> IdGroup(G);
[ 8, 5 ]
gap> G := ExtraspecialGroup(IsIntegralRcwaGroup,27,3);
<integral rcwa group with 3 generators>
gap> Size(G);
27
gap> IsAbelian(G);
false
gap> Exponent(G);
3
gap> D4 := DihedralGroup(IsIntegralRcwaGroup,8);
<integral rcwa group with 2 generators>
gap> IdGroup(D4);
[ 8, 3 ]
gap> S4 := SymmetricGroup(IsIntegralRcwaGroup,4);
<integral rcwa group with 2 generators>
gap> Size(S4);
24
gap> G := SylowSubgroup(S4,2);;
gap> IdGroup(G);
[ 8, 3 ]
gap> A5 := AlternatingGroup(IsIntegralRcwaGroup,5);
<integral rcwa group with 2 generators>
gap> Size(A5);
60
gap> IsPerfect(A5);
true
gap> IsSimple(A5);
true
gap> G := GL(IsIntegralRcwaGroup,2,3);
<integral rcwa group with 2 generators>
gap> Size(G);
48
gap> G := SL(IsIntegralRcwaGroup,2,3);
<integral rcwa group with 2 generators>
gap> Size(G);
24
gap> G := PSL(IsIntegralRcwaGroup,2,3);
<integral rcwa group with 2 generators>
gap> Size(G);
12
gap> STOP_TEST( "rcwa.tst", 3100000000 );

#############################################################################
##
#E  integral.tst . . . . . . . . . . . . . . . . . . . . . . . . .  ends here