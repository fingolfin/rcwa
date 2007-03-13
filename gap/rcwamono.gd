#############################################################################
##
#W  rcwamono.gd                GAP4 Package `RCWA'                Stefan Kohl
##
#H  @(#)$Id$
##
##  This file contains declarations of functions, operations etc. for
##  computing with rcwa monoids.
##
##  See the definitions given in the file rcwamap.gd.
##
Revision.rcwamono_gd :=
  "@(#)$Id$";

#############################################################################
##
#C  IsRcwaMonoidOverZ . . . . . . . . . . . . . . . . . . rcwa monoids over Z
#C  IsRcwaMonoidOverZ_pi  . . . . . . . . . . . . .  rcwa monoids over Z_(pi)
#C  IsRcwaMonoidOverGFqx  . . . . . . . . . . . .  rcwa monoids over GF(q)[x]
#C  IsRcwaMonoidOverZOrZ_pi . . . . . . . . . . rcwa monoids over Z or Z_(pi)
##
##  The category of all rcwa monoids over Z, over semilocalizations of Z, or
##  over polynomial rings in one variable over a finite field, respectively.
##  The category `IsRcwaMonoidOverZOrZ_pi' is the union of
##  `IsRcwaMonoidOverZ' and `IsRcwaMonoidOverZ_pi'.
##
DeclareSynonym( "IsRcwaMonoidOverZ",
                 CategoryCollections(IsRcwaMappingOfZ) and IsMonoid );
DeclareSynonym( "IsRcwaMonoidOverZ_pi",
                 CategoryCollections(IsRcwaMappingOfZ_pi) and IsMonoid );
DeclareSynonym( "IsRcwaMonoidOverGFqx",
                 CategoryCollections(IsRcwaMappingOfGFqx) and IsMonoid );
DeclareSynonym( "IsRcwaMonoidOverZOrZ_pi",
                 CategoryCollections(IsRcwaMappingOfZOrZ_pi) and IsMonoid );

#############################################################################
##
#V  TrivialRcwaMonoidOverZ . . . . . . . . . . . . trivial rcwa monoid over Z
##
DeclareGlobalVariable( "TrivialRcwaMonoidOverZ" );

#############################################################################
##
#O  RcwaCons( <R> ) . . . . . . . . . . . . . . . . . .  Rcwa( R ) for ring R
#F  Rcwa( <R> )
##
##  The monoid formed by all rcwa mappings of <R>.
##
DeclareConstructor( "RcwaCons", [ IsRcwaMonoid, IsRing ] );
DeclareGlobalFunction( "Rcwa" );

#############################################################################
##
#P  IsNaturalRcwa( <G> ) . . . . . . . . . . . . . . . . . . . . .  Rcwa( R )
##
DeclareProperty( "IsNaturalRcwa", IsRcwaMonoid );

#############################################################################
##
#A  ModulusOfRcwaMonoid( <G> ) . . . . . . . . modulus of the rcwa monoid <M>
##
##  We define the *modulus* of an rcwa monoid by the lcm of the moduli of its
##  elements in case such an lcm exists, and by 0 otherwise. 
##
DeclareAttribute( "ModulusOfRcwaMonoid", IsRcwaMonoid );

#############################################################################
##
#E  rcwamono.gd . . . . . . . . . . . . . . . . . . . . . . . . . . ends here