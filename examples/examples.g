#############################################################################
##
#W  examples.g                GAP4 Package `RCWA'                 Stefan Kohl
##
#H  @(#)$Id$
##
##  This file contains the rcwa mappings used in the examples in the manual,
##  as well as a number of other interesting or illustrative examples.
##

# First of all a few useful abbreviations.

rc := function(r,m) return ResidueClass(DefaultRing(m),m,r); end;
md := f -> [Multiplier(f),Divisor(f)];

#############################################################################
##
##  `A wild rcwa mapping all of those cycles seem to be finite'
##
sigma1 := RcwaMapping([[1,0,1],[1,1,1],[1,1,1],[1,-2,1]]);
sigma2 := RcwaMapping([[1, 0,1],[3,3,2],[1,0,1],[2,0,1],[1,0,1],[1,0,1],
                       [1,-3,3],[3,3,2],[1,0,1],[1,0,1],[1,0,1],[1,0,1],
                       [2, 0,1],[3,3,2],[1,0,1],[1,0,1],[1,0,1],[1,0,1]]);
sigma  := sigma1 * sigma2;
sigma0 := FactorizationOnConnectedComponents(sigma,36)[3];
sigma_r := RcwaMapping([[1, 0,1], [1, 0,1], [2, 2,1], [3,-3,2],
                        [1, 0,1], [1, 1,3], [3, 6,2], [1, 0,1],
                        [1, 0,1], [1, 0,1], [1, 0,1], [1, 0,1],
                        [2, 0,1], [1, 0,1], [1, 1,1], [3,-3,2],
                        [1, 0,1], [1, 1,1], [3, 6,2], [1, 0,1],
                        [1, 0,1], [2, 0,1], [1, 0,1], [1, 0,1],
                        [1,-9,3], [1, 0,1], [1, 1,1], [3,-3,2],
                        [1, 0,1], [2, 2,1], [3, 6,2], [1, 0,1],
                        [1, 0,1], [1, 0,1], [1, 0,1], [1, 0,1]]);
sigmas2 := RcwaMapping([[1,0,1],[1, 0,1],[3,0,2],[2,1,1],[1,0,1],[1,0,1],
                        [3,0,2],[1,-1,3],[1,0,1],[2,1,1],[3,0,2],[1,0,1]]);
sigmas := sigma1 * sigmas2;
comm := Comm(sigmas,sigma1); SetName(comm,"comm");

SetName(sigma1,"sigma1"); SetName(sigma2,"sigma2");
SetName(sigma,"sigma");
SetName(sigma0,"sigma0"); SetName(sigma_r,"sigma_r");
SetName(sigmas,"sigmas"); SetName(sigmas2,"sigmas2");

#############################################################################
##
##  `An rcwa mapping which seems to be contracting, but very slow'
##
##  The trajectory of 3224 under f6 has length 19949562.
##
f6 := RcwaMapping([[1,0,6],[5,1,6],[7,-2,6],[11,3,6],[11,-2,6],[11,-1,6]]);
SetName(f6,"f6");

# A mapping still having long, but less extreme trajectories:

T7 := RcwaMapping([[1,0,6],[7,1,2],[1,0,2],[1,0,3],[1,0,2],[7,1,2]]);
SetName(T7,"T7");

# Some other probably contracting mappings with divergence very close to 1.

f5 := RcwaMapping([[7,0,5],[7,-2,5],[3,-1,5],[3,1,5],[7,2,5]]);
f7 := RcwaMapping([[5,0,7],[9,-2,7],[9,3,7],
                           [5,-1,7],[5,1,7],
                           [9,-3,7],[9,2,7]]);
f9 := RcwaMapping([[ 5, 0,9],[16, 2,9],[10,-2,9],
                   [11, 3,9],[ 5,-2,9],[ 5, 2,9],
                   [11,-3,9],[10, 2,9],[16,-2,9]]);
SetName(f5,"f5"); SetName(f7,"f7"); SetName(f9,"f9");

#############################################################################
##
##  `An abelian rcwa group over a polynomial ring'
##
##  As the mappings <g> and <h> are modified within the example, we denote
##  the unmodified versions by <gu> and <hu> and the modified ones by
##  <gm> and <hm>, respectively. The temporary variables have been renamed
##  to avoid name clashes.
##
x := Indeterminate(GF(4),1); SetName(x,"x");
R := PolynomialRing(GF(4),1); e := One(GF(4));
pp := x^2 + x + e;;    qq := x^2 + e;;
rr := x^2 + x + Z(4);; ss := x^2 + x + Z(4)^2;;
cg := List( AllResidues(R,x^2), pol -> [ pp, pp * pol mod qq, qq ] );;
ch := List( AllResidues(R,x^2), pol -> [ rr, rr * pol mod ss, ss ] );;
gu := RcwaMapping( R, qq, cg );
hu := RcwaMapping( R, ss, ch );
cg[1][2] := cg[1][2] + (x^2 + e) * pp * qq;;
ch[7][2] := ch[7][2] + x * rr * ss;;
gm := RcwaMapping( R, qq, cg );
hm := RcwaMapping( R, ss, ch );

# An rcwa mapping of GF(2)[x] of infinite order which has only finite cycles.
# This is the example of an rcwa mapping of a polynomial ring we gave in the
# introduction in the manual.

R := PolynomialRing(GF(2),1);
x := IndeterminatesOfPolynomialRing(R)[1]; SetName(x,"x");
e := One(GF(2)); zero := Zero(R);

r_2mod := RcwaMapping( 2, x^2 + e,
                       [ [ x^2 + x + e, zero   , x^2 + e ],
                         [ x^2 + x + e, x      , x^2 + e ],
                         [ x^2 + x + e, x^2    , x^2 + e ],
                         [ x^2 + x + e, x^2 + x, x^2 + e ] ] );
SetName(r_2mod,"r");

#############################################################################
##
##  `Exploring the structure of a wild rcwa group'
##
u := RcwaMapping([[3,0,5],[9,1,5],[3,-1,5],[9,-2,5],[9,4,5]]);
SetName(u,"u");
nu := RcwaMapping([[ 1, 1, 1]]);
SetName(nu,"nu");

# The following mapping is wild, but all cycles of integers |n| < 29 are
# finite. It has been constructed in a similar way as `u'.

f5_12 := RcwaMapping([[5, 0,6],[5,3,4],[5,-4,6],[5,-3,4],
                      [5, 4,6],[5,3,4],[5, 0,6],[5,-3,4],
                      [5,-4,6],[5,3,4],[5, 4,6],[5,-3,4]]);
SetName(f5_12,"f5_12");

#############################################################################
##
##  `Three involutions whose product has coprime multiplier and divisor'
##
f1 := RcwaMapping([[rc(1,6),rc(0, 8)],[rc(5,6),rc(4, 8)]]); SetName(f1,"f1");
f2 := RcwaMapping([[rc(1,6),rc(0, 4)],[rc(5,6),rc(2, 4)]]); SetName(f2,"f2");
f3 := RcwaMapping([[rc(2,6),rc(1,12)],[rc(4,6),rc(7,12)]]); SetName(f3,"f3");

f12 := f1*f2; SetName(f12,"f12");
f23 := f2*f3; SetName(f23,"f23"); # Only finite cycles (?)
f13 := f1*f3; SetName(f13,"f13"); #  "     "      "    (?)

f := f1*f2*f3; SetName(f,"f");

# Two tame mappings (of orders 3 and 2, respectively), whose product is not
# balanced.

g1 := RcwaMapping([[6,2,1],[1,-1,1],[1,4,6],[6,2,1],[1,-1,1],[1,0,1],
                   [6,2,1],[1,-1,1],[1,0,1],[6,2,1],[1,-1,1],[1,0,1],
                   [6,2,1],[1,-1,1],[1,0,1],[6,2,1],[1,-1,1],[1,0,1]]);

g2 := RcwaMapping([[1,0,1],[3,-1,1],[1,1,3],[1,0,1],[1,0,1],[1,0,1],
                   [1,0,1],[3,-1,1],[1,0,1],[1,0,1],[1,0,1],[1,0,1],
                   [1,0,1],[3,-1,1],[1,0,1],[1,0,1],[1,0,1],[1,0,1]]);

SetName(g1,"g1"); SetName(g2,"g2");

# Two mappings with non-balanced commutator.

c1 := Restriction(RcwaMapping([[2,0,3],[4,-1,3],[4,1,3]]),
                  RcwaMapping([[2,0,1]]));
c2 := RcwaMapping([[1,0,2,],[2,1,1],[1,-1,1],[2,1,1]]);
SetName(c1,"c1"); SetName(c2,"c2");

#############################################################################
##
##  `An rcwa representation of a small group'
##
r := RcwaMapping([[1,0,1],[1,1,1],[3, -3,1],
                  [1,0,3],[1,1,1],[3, -3,1],
                  [1,0,1],[1,1,1],[3, -3,1]]); SetName(r,"r");
s := RcwaMapping([[1,0,1],[1,1,1],[3,  6,1],
                  [1,0,3],[1,1,1],[3,  6,1],
                  [1,0,1],[1,1,1],[3,-21,1]]); SetName(s,"s");

#############################################################################
##
##  `An rcwa representation of the symmetric group on 10 point'
##
a := RcwaMapping([[3,0,2],[3, 1,4],[3,0,2],[3,-1,4]]); SetName(a,"a");
b := RcwaMapping([[3,0,2],[3,13,4],[3,0,2],[3,-1,4]]); SetName(b,"b");
c := RcwaMapping([[3,0,2],[3, 1,4],[3,0,2],[3,11,4]]); SetName(c,"c");

ab := Comm(a,b); SetName(ab,"[a,b]");
ac := Comm(a,c); SetName(ac,"[a,c]");
bc := Comm(b,c); SetName(bc,"[b,c]");

t  := RcwaMapping([[-1, 0, 1]]); SetName(t,"t");

# Two rcwa mappings of orders 7 and 12, respectively, which have isomorphic
# transition graphs for modulus 6 and generate the infinite tame group we
# have looked at in the example we gave in the chapter about rcwa groups
# for the use of `RespectedClassPartition'.

g := RcwaMapping([[2,2,1],[1, 4,1],[1,0,2],[2,2,1],[1,-4,1],[1,-2,1]]);
h := RcwaMapping([[2,2,1],[1,-2,1],[1,0,2],[2,2,1],[1,-1,1],[1, 1,1]]);
SetName(g,"g"); SetName(h,"h");

# A factorization of `a' (see above) into two balanced mappings,
# where one of them is an involution.

a_2 := RcwaMapping([[rc(1,2),rc(36,72)]]); a_1 := a/a_2;
SetName(a_1,"a_1"); SetName(a_2,"a_2");

#############################################################################
##
##  `Some examples over (semi)localizations of the integers'
##
a2  := RcwaMapping(Z_pi(2),    ShallowCopy(Coefficients(a)));

a23 := RcwaMapping(Z_pi([2,3]),ShallowCopy(Coefficients(a)));
b23 := RcwaMapping(Z_pi([2,3]),ShallowCopy(Coefficients(b)));
c23 := RcwaMapping(Z_pi([2,3]),ShallowCopy(Coefficients(c)));

ab23 := Comm(a23,b23); ac23 := Comm(a23,c23);

v := RcwaMapping([[6,0,1],[1,-7,2],[6,0,1],[1,-1,1],
                  [6,0,1],[1, 1,2],[6,0,1],[1,-1,1]]);

v2 := RcwaMapping(Z_pi(2),ShallowCopy(Coefficients(v)));
w2 := RcwaMapping(Z_pi(2),[[1,0,2],[2,-1,1],[1,1,1],[2,-1,1]]);
SetName(v,"v"); SetName(v2,"v2"); SetName(w2,"w2");

v2w2 := Comm(v2,w2); SetName(v2w2,"[v2,w2]");

#############################################################################
##
##  `Twisting 257-cycles into an rcwa mapping with modulus 32'
##
##  In order to avoid a name clash we call the mapping `x_257' instead
##  of `x'.
##
x_257 := RcwaMapping([[ 16,  2,  1], [ 16, 18,  1],
                      [  1, 16,  1], [ 16, 18,  1],
                      [  1, 16,  1], [ 16, 18,  1],
                      [  1, 16,  1], [ 16, 18,  1],
                      [  1, 16,  1], [ 16, 18,  1],
                      [  1, 16,  1], [ 16, 18,  1],
                      [  1, 16,  1], [ 16, 18,  1],
                      [  1, 16,  1], [ 16, 18,  1],
                      [  1,  0, 16], [ 16, 18,  1],
                      [  1,-14,  1], [ 16, 18,  1],
                      [  1,-14,  1], [ 16, 18,  1],
                      [  1,-14,  1], [ 16, 18,  1],
                      [  1,-14,  1], [ 16, 18,  1],
                      [  1,-14,  1], [ 16, 18,  1],
                      [  1,-14,  1], [ 16, 18,  1],
                      [  1,-14,  1], [  1,-31,  1]]);
SetName(x_257,"x");

#############################################################################
##
##  `The behaviour of the moduli of powers'
##
##  We only list mappings here which are used exclusively in this example.
##
v6 := RcwaMapping([[-1,2,1],[1,-1,1],[1,-1,1]]);
w8 := RcwaMapping([[-1,3,1],[1,-1,1],[1,-1,1],[1,-1,1]]);
SetName(v6,"v6"); SetName(w8,"w8");

z := RcwaMapping([[2,  1, 1],[1,  1,1],[2, -1,1],[2, -2,1],
                  [1,  6, 2],[1,  1,1],[1, -6,2],[2,  5,1],
                  [1,  6, 2],[1,  1,1],[1,  1,1],[2, -5,1],
                  [1,  0, 1],[1, -4,1],[1,  0,1],[2,-10,1]]);
SetName(z,"z");

e1 := RcwaMapping([[1,4,1],[2,0,1],[1,0,2],[2,0,1]]); SetName(e1,"e1");
e2 := RcwaMapping([[1,4,1],[2,0,1],[1,0,2],[1,0,1],
                   [1,4,1],[2,0,1],[1,0,1],[1,0,1]]); SetName(e2,"e2");

#############################################################################
##
##  `Images and preimages under the Collatz mapping'
##
T := RcwaMapping([[1,0,2],[3,1,2]]); SetName(T,"T");

#############################################################################
##
##  `Replacing the Collatz mapping by conjugates'
##
##  (All mappings used in this example have already been defined above.)

#############################################################################
##
#E  examples.g . . . . . . . . . . . . . . . . . . . . . . . . . .  ends here
