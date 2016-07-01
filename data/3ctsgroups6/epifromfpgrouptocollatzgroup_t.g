#############################################################################
##
#W  epifromfpgrouptocollatzgroup_t.g     GAP4 Package `RCWA'      Stefan Kohl
##
##  Data library of groups generated by 3 class transpositions which inter-
##  change residue classes with moduli <= 6: part containing an epimorphism
##  from a finitely presented group to the "Collatz group"
##  G_T = <(0(2),1(2)),(1(2),2(4)),(1(4),2(6))>. The group G_T acts transi-
##  tively on N_0 if an only if the Collatz conjecture holds.
##
#############################################################################

local  phi, G_T, H, rels, F, a, b, c, T, r, r_inv, f, u0, v0, v, w;

F := FreeGroup("a","b","c");
a := F.1;; b := F.2;; c := F.3;;

rels :=
[ a^2, b^2, c^2, ((a*b)^2*a*c)^4, (a*b*a*c)^6, ((a*b)^3*a*c)^4, 
  (a*b*c*b*a*c)^6, ((a*b)^4*a*c)^4, ((a*b*a*c)^2*a*c)^4, 
  a*b*((a*b)^3*a*c*a*b*c)^2*a*b*a*(b*a*c)^2*(a*b)^2*a*(b*a*c)^2, 
  a*b*(a*b*a*c*a*b*c)^2*(a*b*a*c)^2*a*c*a*(b*a*c*a*b*a*c)^2*b*a*c, 
  (a*b)^2*(c*a*b*a)^2*c*(b*a)^2*((c*a*b*a)^2*c*b)^2*(c*a*b*a)^2*c, 
  ((a*b)^5*a*c)^4, 
  a*b*((a*b)^2*a*c*a*b*c)^2*a*b*a*c*(a*(b*a*c)^2*a*b)^2*(a*b)^2*a*c*a*b*c*b*a*c,
  ((a*b)^6*a*c)^4, (a*b*a*(b*a*c*a*b*c)^3*a*(b*a*c)^2*a*b*c)^2, 
  ((a*b)^7*a*c)^4, (a*b*((a*b)^2*a*c*a*b*c)^2*b*a*c*a*b*a*(b*a*c)^2)^2, 
  ((a*b)^2*a*(c*b*a*c*a*b)^2*(c*a*b*a)^2*c*b*a*c*a*b*c*b*a*c)^2, 
  (a*b*(a*b*a*c)^2*b*a*c*a*b*c*b*a*c)^4, 
  (a*b)^2*a*(b*a*(c*a*b)^2*a*c)^2*b*a*c*a*b*a*(b*a*c)^2*a*b*(a*(b*a*c)^2*a*b*c*a*b*a*c)^2*b*a*c*a*b*c*b*a*c, 
  (a*b)^2*a*(b*a*c*a*b*c)^2*a*b*a*(c*a*(b*a*c)^2*a*b)^2*(c*(a*b)^2*a*c*a*b)^2*c*b*a*c*a*b*(c*a*b*a)^2*c*b*a*c, 
  (a*b)^3*a*c*a*b*c*(b*a*c*a*b*a)^2*c*a*b*a*(c*b*a*c*a*b)^2*(a*b*a*c)^2*b*a*(c*a*b)^2*a*b*a*c*a*b*c*(b*a*c*a*b*a)^2*c*a*(b*a*c)^2, 
  a*b*((a*b)^2*a*(c*a*b)^2*a*c)^2*b*a*c*a*b*c*(b*a*c*a*b*a)^2*c*b*a*c*a*b*(c*(a*b)^2*a*(c*a*b)^2*a)^2*c*b*a*c, 
  ((a*b*a*c)^2*a*(b*(c*a*b*a)^2*c)^2*(a*c*a*b)^2*a*c*b*c)^2 ];

H := F/rels;

a := SparseRep(ClassTransposition(0,2,1,2));
b := SparseRep(ClassTransposition(1,2,2,4));
c := SparseRep(ClassTransposition(1,4,2,6));
G_T := Group(a,b,c);

phi := GroupHomomorphismByImagesNC(H,G_T);

# Mappings needed in the proof of the equivalence of the transitivity
# of G_T on N_0 with the Collatz conjecture.

T := SparseRep(RcwaMapping([[1,0,2],[3,1,2]]));

r := SparseRep(RcwaMapping([[2,-2,1],[2,-1,1],[2,-2,1]]));
r_inv := SparseRep(RcwaMapping([[1,0,1],[1,1,2],[1,2,2],
                                [1,0,1],[1,2,2],[1,0,1]]));
f := SparseRep(RcwaMapping([[3,4,2],[3,1,2],[1,0,2],[1,-3,2]]));

u0 := r*f^2;
v0 := T^2*r;

v := SparseRep(RcwaMapping([[1,1,1],[1,0,1],[1,0,1],
                            [1,-1,1],[1,0,1],[1,-1,1]]));
w := RcwaMapping([[1,4,3,1,2],[2,6,2,-1,3],[0,6,1,0,1],
                  [4,6,1,0,1],[3,4,1,0,1]]);

return phi;

#############################################################################
##
#E  epifromfpgrouptocollatzgroup_c.g . . . . . . . . . . . . . . .  ends here
