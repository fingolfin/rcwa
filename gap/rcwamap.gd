#############################################################################
##
#W  rcwamap.gd                GAP4 Package `RCWA'                 Stefan Kohl
##
#H  @(#)$Id$
##
##  This file contains declarations of functions, operations etc. for
##  computing with residue class-wise affine mappings.
##
Revision.rcwamap_gd :=
  "@(#)$Id$";

#############################################################################
##
#V  InfoRCWA . . . . . . . . . . . . . . . . . .  info class for RCWA package
##
##  This is the Info class of the RCWA package (see~"ref:Info Functions" 
##  in the {\GAP} Reference Manual for a description of the Info mechanism).
##
DeclareInfoClass( "InfoRCWA" );

#############################################################################
##
#F  RCWAInfo . . . . . . . . . . . . . . . . . . set info level of `RcwaInfo'
##
##  For convenience: `RCWAInfo( <n> )' is a shorthand for
##  `SetInfoLevel( RcwaInfo, <n> )'.
##
DeclareGlobalFunction( "RCWAInfo" );

#############################################################################
##
#C  IsRcwaMapping . . . . . . . . . . . . . . . . . . . . . all rcwa mappings
##
##  The category of all rcwa mappings.
##
DeclareCategory( "IsRcwaMapping", IsRingElement );

#############################################################################
##
#C  IsIntegralRcwaMapping . . . . . . . . . . . . . .  integral rcwa mappings
##
##  The category of all integral rcwa mappings.
##
DeclareCategory( "IsIntegralRcwaMapping", IsRingElement );

#############################################################################
##
#C  IsSemilocalIntegralRcwaMapping . . . . . semilocal integral rcwa mappings
##
##  The category of all semilocal integral rcwa mappings.
##
DeclareCategory( "IsSemilocalIntegralRcwaMapping", IsRingElement );

#############################################################################
##
#C  IsRationalBasedRcwaMapping . . . . . semilocal- or integral rcwa mappings
##
##  The category of all integral or semilocal integral rcwa mappings.
##  This is the union of the categories `IsIntegralRcwaMapping' and
##  `IsSemilocalIntegralRcwaMapping'.
##
DeclareCategory( "IsRationalBasedRcwaMapping", IsRingElement );

#############################################################################
##
#C  IsModularRcwaMapping . . . . . . . . . . . . . . .  modular rcwa mappings
##
##  The category of all modular rcwa mappings.
##
DeclareCategory( "IsModularRcwaMapping", IsRingElement );

#############################################################################
##
#F  RcwaMappingsFamily( <R> ) . . . family of rcwa mappings over the ring <R>
##
DeclareGlobalFunction( "RcwaMappingsFamily" );

#############################################################################
##
#V  IntegralRcwaMappingsFamily . . . the family of all integral rcwa mappings
##
DeclareGlobalVariable( "IntegralRcwaMappingsFamily" );

#############################################################################
##
#F  SemilocalIntegralRcwaMappingsFamily( <primes> )
##
##  Family of semilocal integral rcwa mappings with underlying ring
##  $\Z_{(\pi)}$, where the set $\pi$ is given by the list <primes>.
##
DeclareGlobalFunction( "SemilocalIntegralRcwaMappingsFamily" );

#############################################################################
##
#F  ModularRcwaMappingsFamily( <R> ) . . . .  family of modular rcwa mappings
##
##  Family of modular rcwa mappings with underlying polynomial ring <R>.
##
DeclareGlobalFunction( "ModularRcwaMappingsFamily" );

#############################################################################
##
#R  IsRationalBasedRcwaDenseRep . ."dense" rep. of "rat.-based" rcwa mappings
##
##  Representation of integral rcwa mappings and semilocal integral rcwa
##  mappings by modulus <modulus> and coefficient list <coeffs>.
##
##  The coefficient list is a list of <modulus> lists of 3 integers,
##  defining the mapping on the residue classes
##  0 .. <modulus> - 1 (mod <modulus>), in this order.
##  If <n> mod <modulus> = <r>, then <n> is mapped to
##  (<coeffs>[<r>+1][1] * <n> + <coeffs>[<r>+1][2])/<coeffs>[<r>+1][3].
##
DeclareRepresentation( "IsRationalBasedRcwaDenseRep",
                       IsComponentObjectRep and IsAttributeStoringRep,
                       [ "modulus", "coeffs" ] );

#############################################################################
##
#R  IsModularRcwaDenseRep . .`dense' representation of integral rcwa mappings
##
##  Representation of modular rcwa mappings by finite field size <q>,
##  modulus <modulus> and coefficient list <coeffs>.
##
##  The coefficient list is a list of <q>^<d> lists of 3 polynomials,
##  where <d> denotes the degree of <modulus>, defining the mapping on the
##  residue classes (mod <modulus>), in `natural' order. 
##  If <P> mod <modulus> = <r>, then <P> is mapped to
##  (<coeffs>[<pos(r)>][1]*<P>+<coeffs>[<pos(r)>][2])/<coeffs>[<pos(r)>][3],
##  where <pos(r)> denotes the position of <r> in the sorted list of
##  polynomials of degree less than <d> over GF(<q>).
##
DeclareRepresentation( "IsModularRcwaDenseRep", 
                       IsComponentObjectRep and IsAttributeStoringRep, 
                       [ "modulus", "coeffs" ] );

#############################################################################
##
#F  RcwaMapping( <R>, <modulus>, <coeffs> )
#F  RcwaMapping( <R>, <coeffs> )
#F  RcwaMapping( <coeffs> )
#F  RcwaMapping( <perm>, <range> )
#F  RcwaMapping( <modulus>, <values> )
#F  RcwaMapping( <pi>, <coeffs> )
#F  RcwaMapping( <q>, <modulus>, <coeffs> )
#F  RcwaMapping( <cycles> )
#F  RcwaMappingNC( <R>, <modulus>, <coeffs> )
#F  RcwaMappingNC( <R>, <coeffs> )
#F  RcwaMappingNC( <coeffs> )
#F  RcwaMappingNC( <perm>, <range> )
#F  RcwaMappingNC( <modulus>, <values> )
#F  RcwaMappingNC( <pi>, <coeffs> )
#F  RcwaMappingNC( <q>, <modulus>, <coeffs> )
#F  RcwaMappingNC( <cycles> )
##
##  Construction of the rcwa mapping 
##
##  \beginlist
##  \item{(a)}
##    with modulus <modulus> and coefficients <coeffs> over the ring <R>
##    resp.
##  \item{(b)}
##    with coefficients <coeffs> over the ring <R>, if this information is
##    sufficient resp.
##  \item{(c)}
##    with coefficients <coeffs>, if already this information is sufficient
##    resp.
##  \item{(d)}
##    acting on the translates of <range> by integral multiples
##    of the length of <range> as the translates of the finite permutation
##    <perm> to the respective intervals resp.
##  \item{(e)}
##    with modulus <modulus> with values prescribed by the list <values>,
##    which consists of 2 * <modulus> pairs giving preimage and image for
##    2 points per residue class (mod <modulus>) resp.
##  \item{(f)}
##    with coefficients <coeffs> over $\Z_{<pi>}$ resp.
##  \item{(g)}
##    with modulus <modulus> and coefficients <coeffs> over GF(<q>)[<x>]
##    resp.
##  \item{(h)}
##    an arbitrary rcwa mapping with residue class cycles as given by
##    <cycles>.
##  \endlist
##
##  The difference between `RcwaMapping' and `RcwaMappingNC'
##  is that the former performs some argument checks which are omitted in the
##  latter, where just anything may happen if wrong or inconsistent arguments
##  are given.
##
DeclareOperation( "RcwaMapping", [ IsObject ] );
DeclareOperation( "RcwaMappingNC", [ IsObject ] );

#############################################################################
##
#V  ZeroIntegralRcwaMapping . . . . . . . . . . .  zero integral rcwa mapping
##
DeclareGlobalVariable( "ZeroIntegralRcwaMapping" );

#############################################################################
##
#V  IdentityIntegralRcwaMapping . . . . . . .  identity integral rcwa mapping
##
DeclareGlobalVariable( "IdentityIntegralRcwaMapping" );

#############################################################################
##
#A  Multiplier( <f> ) . . . . . . . .  the multiplier of the rcwa mapping <f>
##
##  We define the *multiplier* of an rcwa mapping <f> as the standard
##  associate of the least common multiple of the coefficients $a_r$
##  (cp. chapter `introduction' in the manual).
##
DeclareAttribute( "Multiplier", IsRcwaMapping );

#############################################################################
##
#A  Divisor( <f> ) . . . . . . . . . . .  the divisor of the rcwa mapping <f>
##
##  We define the *divisor* of an rcwa mapping <f> as the standard
##  associate of the least common multiple of the coefficients $c_r$
##  (cp. chapter `introduction' in the manual).
##
DeclareAttribute( "Divisor", IsRcwaMapping );

#############################################################################
##
#A  PrimeSet( <f> ) . . . . . . . . . . . . prime set of the rcwa mapping <f>
##
##  Prime set of rcwa mapping <f>.
##
##  We define the prime set of an rcwa mapping <f> as the set of all primes
##  dividing the modulus of <f> or some coefficient occuring as factor in the
##  numerator or as denominator.
##
DeclareAttribute( "PrimeSet", IsRcwaMapping );

#############################################################################
##
#O  Multpk( <f>, <p>, <k> )  the elements multiplied by a multiple of <p>^<k>
##
##  The set of elements $n$ of the base ring $R$, which are mapped to
##  $(a_r n + b_r)/c_r$, where $p^k||a_r$ if $k \gt 0$, resp. $p^{-k}||c_r$
##  if $k \lt 0$ resp. $p \nmid a_r, c_r$ if $k = 0$.
##
DeclareOperation( "Multpk", [ IsRcwaMapping, IsInt, IsInt ] );

#############################################################################
##
#P  IsFlat( <f> ) . . . . indicates whether or not <f> is a flat rcwa mapping
##
##  We say that an rcwa mapping is *flat* if and only if its multiplier
##  and its divisor are equal to 1.
##
DeclareProperty( "IsFlat", IsRcwaMapping );

#############################################################################
##
#P  IsBalanced( <f> ) . .  indicates whether or not <f> is a balanced mapping
##
##  We say that an rcwa mapping is *balanced* if and only if its multiplier
##  and its divisor have the same prime divisors.
##
DeclareProperty( "IsBalanced", IsRcwaMapping );

#############################################################################
##
#P  IsClassWiseOrderPreserving( <f> ) .  is <f> class-wise order-preserving ?
##
##  Indicates whether or not the rational-based rcwa mapping <f> is
##  class-wise order-preserving.
##
DeclareProperty( "IsClassWiseOrderPreserving", IsRationalBasedRcwaMapping ); 

#############################################################################
##
#F  TransitionMatrix( <f>, <deg> ) . . <deg>x<deg>-`Transition matrix' of <f>
##
##  We define the *transition matrix* <M> of degree <deg> of the rcwa mapping
##  <f> by <M>[<i>+1][<j>+1] = 1 if there is an <n> congruent to <i> (mod
##  <deg>) such that <n>^<f> is congruent to <j> mod <deg>, and 0 if not.
##  Their rank (and in case it is invertible the absolute value of its 
##  determinant) does not depend on the particular assignment of the residue
##  classes (mod <deg>) to rows / columns.
##
DeclareGlobalFunction( "TransitionMatrix" );

#############################################################################
##
#O  TransitionGraph( <f>, <m> ) . .  transition graph of the rcwa mapping <f>
##
##  Transition graph for modulus <m> of the rcwa mapping <f>.
##
##  We define the *transition graph* $\Gamma_{f,m}$ for modulus <m> of the
##  rcwa mapping $f$ as follows:
##  \beginlist
##
##     \item{-} The vertices are the residue classes (mod $m$).
##
##     \item{-} There is an edge from $r_1(m)$ to $r_2(m)$ if and only if
##              there is some $n_1 \in r_1(m)$ such that
##	        $n_1^f \in r_2(m)$.
##
##  \endlist
##
DeclareOperation( "TransitionGraph", [ IsRcwaMapping, IsRingElement ] );

#############################################################################
##
#O  OrbitsModulo( <f>, <m> ) . . orbit partition of $R/mR$ under `Group(<f>)'
##
##  Returns the set of the sets of vertices of the weakly-connected
##  components of the transition graph $\Gamma_{f,m}$.
##
DeclareOperation( "OrbitsModulo", [ IsRcwaMapping, IsRingElement ] );

#############################################################################
##
#O  FactorizationOnConnectedComponents( <f>, <m> )
##
##  Returns the set of restrictions of the rcwa mapping <f> onto the
##  weakly-connected components of its transition graph $\Gamma_{f,m}$.
##  These mappings have pairwisely disjoint supports, hence any two of them
##  commute, and their product equals <f>.
##
DeclareOperation( "FactorizationOnConnectedComponents",
                  [ IsRcwaMapping, IsRingElement ] );

#############################################################################
##
#F  Trajectory( <f>, <n>, <val>, <cond> )
##
##  This function computes the trajectory of <n> under the rcwa mapping <f>.
##  The parameter <val> can either specify the length of the sequence to
##  be computed or be a `stopping value' such that the function stops when
##  it reaches some iterate <n>^(<f>^<k>) = <val>, depending on whether
##  <cond> = `"length"' or <cond> = `"stop"'.
##
DeclareGlobalFunction( "Trajectory" );

#############################################################################
##
#F  TrajectoryModulo( <f>, <n>, <m>, <lng> ) . .  trajectory (mod <m>) of <f>
#F  TrajectoryModulo( <f>, <n>, <lng> )
##
##  Returns the sequence $(n_i), i = 0, \dots, lng-1$ with $n_i := n^(f^i)$
##  mod <m> as a list. If <m> is not given, it defaults to the modulus
##  of <f>.
##
DeclareGlobalFunction( "TrajectoryModulo" );

#############################################################################
##
#F  CoefficientsOnTrajectory( <f>, <n>, <val>, <cond>, <all> )
##
##  This function computes accumulated coefficients on the trajectory of <n>
##  under the rcwa mapping <f>. More precisely: it computes a list <c> of
##  coefficient triples such that for any <k>, we have
##  <n>^(<f>^(<k>-1)) = (<c>[<k>][1]*<n> + <c>[<k>][2])/<c>[<k>][3].
##  The meaning of the arguments <val> and <cond> is the same as in
##  `Trajectory'; if <all> = `true', the whole sequence of coefficient
##  triples is returned, otherwise the result is only the last triple.
##
DeclareGlobalFunction( "CoefficientsOnTrajectory" );

#############################################################################
##
#P  IsTame( <f> ) . . . . indicates whether or not <f> is a tame rcwa mapping
##
##  We say that an rcwa mapping <f> is *tame* if and only if the moduli
##  of its powers are bounded, and *wild* otherwise.
##
DeclareProperty( "IsTame", IsRcwaMapping );

#############################################################################
##
#O  ShortCycles( <f>, <maxlng> ) . . . . short cycles of the rcwa mapping <f>
##
##  Computes all ``single'' finite cycles of the rcwa mapping <f>
##  of length <= <maxlng>.
##
DeclareOperation( "ShortCycles", [ IsRcwaMapping, IsPosInt ] );

#############################################################################
##
#A  RespectedClassPartition( <sigma> ) . . . . . . . permuted class partition
##
##  A partition of the base ring <R> into a finite number of residue classes,
##  on which the bijective mapping <sigma> acts as a permutation. 
##  The partition is non-trivial as long as Modulus( <sigma> ) <> One( <R> ).
##  Such a partition exists always if <sigma> is tame and <R> has the
##  `class halving property'. 
##
DeclareAttribute( "RespectedClassPartition", IsRcwaMapping );

#############################################################################
##
#A  FlateningConjugator( <f> ) . . . . . .  mapping <x> s.th. <f>^<x> is flat
##
##  A mapping <x> such that <f>^<x> is flat. Exists always if <f> is a tame
##  bijection and <R> has the `class halving property'.
##
DeclareAttribute( "FlateningConjugator", IsRcwaMapping );

#############################################################################
##
#A  FlatConjugate( <f> ) . . . . . . . . . . . . . . .  flat conjugate of <f>
##
##  Some flat conjugate of the rcwa mapping <f>.
##  This is certainly not defined uniquely, and exists only if <f> is tame.
##  
DeclareAttribute( "FlatConjugate", IsRcwaMapping );

#############################################################################
##
#A  StandardizingConjugator( <f> ) . .  mapping <x> s.th. <f>^<x> is standard
##
##  A mapping <x> such that <f>^<x> is the ``standard'' representative of
##  the conjugacy class of the bijective integral rcwa mapping <f> in the
##  whole group RCWA(Z).
##
DeclareAttribute( "StandardizingConjugator", IsRcwaMapping );

#############################################################################
##
#A  StandardConjugate( <f> ) . .  standard rep. of the conjugacy class of <f>
##
##  Some ``nice'' canonical representative of the conjugacy class of the
##  bijective integral rcwa mapping <f> in the whole group RCWA(Z).
##  Two integral rcwa mappings are conjugate if and only if their 
##  ``standard conjugates'' are equal. 
##
DeclareAttribute( "StandardConjugate", IsRcwaMapping );

#############################################################################
##
#A  CycleType( <f> ) . . . . . . . . . . . . . . . . . . .  cycle type of <f>
##
##  The *cycle type* of a tame rcwa mapping <f> is denoted by a list of two
##  lists, where the first list is the set of the cycle lengths which occur
##  infinitely often, and the second list contains the cycle lengths which
##  occur only finitely often, with the respective multiplicities and sorted
##  by increasing length.
##
DeclareAttribute( "CycleType", IsRcwaMapping );

#############################################################################
##
#O  ContractionCentre( <f>, <boundstart>, <maxlng> ) . . . contraction centre
##
##  Tries to compute the `contraction centre' of an rcwa mapping --
##  assuming its existence this is the uniquely-defined finite subset $S_0$
##  of the base ring <R> which is mapped bijectively onto itself under <f>
##  and where for any $x \in R$ there is an integer $k$ such that
##  $x^{f^k} \in S_0$. The mapping <f> is assumed to be contracting.
##  As this problem seems to be computationally undecidable methods will be
##  probabilistic. The argument <boundstart> is a bound on the starting value
##  and <maxlng> is a bound on the sequence length to be searched.
##  If the limit <maxlng> is reached without completing a cycle a warning
##  is issued.
##
DeclareOperation( "ContractionCentre",
                  [ IsRcwaMapping, IsRingElement, IsPosInt ] );
DeclareSynonym( "ContractionCenter", ContractionCentre );

#############################################################################
##
#O  Restriction( <g>, <f> ) . . . . . . . . . . . . restriction of <g> by <f>
##
##  Computes the restriction of the rcwa mapping <g> by (i.e. to the image
##  of) the rcwa mapping <f>.
##
DeclareOperation( "Restriction",
                  [IsRcwaMapping, IsRcwaMapping ] );

#############################################################################
##
#E  rcwamap.gd . . . . . . . . . . . . . . . . . . . . . . . . . .  ends here




