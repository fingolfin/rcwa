#############################################################################
##
#W  rcwamono.gi                GAP4 Package `RCWA'                Stefan Kohl
##
#H  @(#)$Id$
##
##  This file contains implementations of methods and functions for computing
##  with rcwa monoids over
##
##    - the ring Z of the integers, over
##    - the semilocalizations Z_(pi) of the ring of integers, and over
##    - the polynomial rings GF(q)[x] in one variable over a finite field.
##
##  See the definitions given in the file rcwamap.gd.
##
Revision.rcwamono_gi :=
  "@(#)$Id$";

#############################################################################
##
#S  Implications between the categories of rcwa monoids. ////////////////////
##
#############################################################################

InstallTrueMethod( IsMonoid,     IsRcwaMonoid );
InstallTrueMethod( IsRcwaMonoid, IsRcwaMonoidOverZOrZ_pi );
InstallTrueMethod( IsRcwaMonoidOverZOrZ_pi, IsRcwaMonoidOverZ );
InstallTrueMethod( IsRcwaMonoidOverZOrZ_pi, IsRcwaMonoidOverZ_pi );
InstallTrueMethod( IsRcwaMonoid, IsRcwaMonoidOverGFqx );

#############################################################################
##
#S  Methods for `View' and `Display'. ///////////////////////////////////////
##
#############################################################################

#############################################################################
##
#M  ViewObj( <G> ) . . . . . . . . . . . . . . . . . . . . . for rcwa monoids
##
InstallMethod( ViewObj,
               "for rcwa monoids (RCWA)", true, [ IsRcwaMonoid ], 0,

  function ( M )

    local  NrGens, RingString;

    RingString := RingToString(Source(One(M)));
    if   IsTrivial(M)
    then Display(M:NoLineFeed);
    else Print("<");
         if   HasIsTame(M) and not (HasSize(M) and IsInt(Size(M)))
         then if IsTame(M) then Print("tame "); else Print("wild "); fi; fi;
         NrGens := Length(GeneratorsOfMonoid(M));
         Print("rcwa monoid over ",RingString," with ",NrGens," generator");
         if NrGens > 1 then Print("s"); fi;
         if HasSize(M) then Print(", of size ",Size(M)); fi;
         Print(">");
    fi;
  end );

#############################################################################
##
#M  Display( <G> ) . . . . . . . . . . . . . . . . . . . . . for rcwa monoids
##
InstallMethod( Display,
               "for rcwa monoids (RCWA)", true, [ IsRcwaMonoid], 0,

  function ( M )

    local  RingString, g, prefix;

    RingString := RingToString(Source(One(M)));
    if   IsTrivial(M) 
    then Print("Trivial rcwa monoid over ",RingString);
         if ValueOption("NoLineFeed") <> true then Print("\n"); fi;
    else prefix := false;
         if HasIsTame(M) and not (HasSize(M) and IsInt(Size(M))) then
           if IsTame(M) then Print("\nTame "); else Print("\nWild "); fi;
           prefix := true;
         fi;
         if prefix then Print("rcwa "); else Print("\nRcwa "); fi;
         Print("monoid over ",RingString);
         if HasSize(M) then Print(" of size ",Size(M)); fi;
         Print(", generated by\n\n[\n");
         for g in GeneratorsOfMonoid(M) do Display(g); od;
         Print("]\n\n");
    fi;
  end );

#############################################################################
##
#S  The trivial rcwa monoids. ///////////////////////////////////////////////
##
#############################################################################

#############################################################################
##
#V  TrivialRcwaMonoidOverZ . . . . . . . . . . . . trivial rcwa monoid over Z
##
InstallValue( TrivialRcwaMonoidOverZ, Monoid( IdentityRcwaMappingOfZ ) );

#############################################################################
##
#M  TrivialSubmagmaWithOne( <M> ). . . . . . . . . . . . . . for rcwa monoids
##
InstallMethod( TrivialSubmagmaWithOne,
               "for rcwa monoids (RCWA)", true, [ IsRcwaMonoid ], 0,

  function ( M )

    local  triv;

    triv := Monoid(One(M));
    SetParentAttr(triv,M);
    return triv;
  end );

#############################################################################
##
#S  The construction of the monoids RCWA(R) of all rcwa mappings of R. //////
##
#############################################################################

#############################################################################
##
#M  RcwaCons( IsRcwaMonoid, <R> ) . . . . . . . . . . . . . . . . . Rcwa( R )
##
##  The monoid which is formed by all rcwa mappings of R.
##
InstallMethod( RcwaCons,
               "natural Rcwa(R) (RCWA)", ReturnTrue, 
               [ IsRcwaMonoid, IsRing ], 0,

  function ( filter, R )

    local  M, type, id;

    if   IsIntegers( R )                  then type := IsRcwaMonoidOverZ;
    elif IsZ_pi( R )                      then type := IsRcwaMonoidOverZ_pi;
    elif IsUnivariatePolynomialRing( R )
     and IsFiniteFieldPolynomialRing( R ) then type := IsRcwaMonoidOverGFqx;
    else TryNextMethod( ); fi;

    id := One( RCWA( R ) );

    M  := Objectify( NewType( FamilyObj( Monoid( id ) ),
                              type and IsAttributeStoringRep ), rec( ) );

    SetIsTrivial( M, false );
    SetOne( M, id );
    SetIsNaturalRcwa( M, true );
    SetIsWholeFamily( M, true );
    SetIsFinite( M, false );
    SetSize( M, infinity );
    SetIsTame( M, false );
    SetMultiplier( M, infinity );
    SetDivisor( M, infinity );
    SetIsCommutative( M, false );
    SetRepresentative( M, Representative( RCWA( R ) ) );
    SetName( M, Concatenation( "Rcwa(", RingToString(R), ")" ) );
    SetStructureDescription( M, Name( M ) );

    return M;
  end );

#############################################################################
##
#F  Rcwa( <R> ) . . . . . . . . . . . . . . . . . . . . . . . . . . Rcwa( R )
##
InstallGlobalFunction( Rcwa, R -> RcwaCons( IsRcwaMonoid, R ) );

#############################################################################
##
#M  IsNaturalRcwa( <M> ) . . . . . . . . . . . . . . . . . . . . . .  Rcwa(R)
##
##  The monoids Rcwa( <R> ) can only be obtained by the above constructor.
##
InstallMethod( IsNaturalRcwa,
               "for rcwa monoids (RCWA)", true, [ IsRcwaMonoid ], 0,
               ReturnFalse );

#############################################################################
##
#M  IsWholeFamily . . . . . . . . . . . . . . . . . . . .  for an rcwa monoid
##
InstallMethod( IsWholeFamily,
               "for an rcwa monoid (RCWA)", true,
               [ IsRcwaMonoid ], 0, IsNaturalRcwa );

#############################################################################
##
#S  Methods for the attributes and properties derived from the coefficients.
##
#############################################################################

#############################################################################
##
#M  PrimeSet( <M> ) . . . . . . . . . . . . . . . . . . . .  for rcwa monoids
##
InstallMethod( PrimeSet,
               "for rcwa monoids (RCWA)", true, [ IsRcwaMonoid ], 0,
               M -> Union( List( GeneratorsOfMonoid( M ), PrimeSet ) ) );

#############################################################################
##
#M  IsIntegral( <M> ) . . . . . . . . . . . . . . . . . . .  for rcwa monoids
##
InstallMethod( IsIntegral,
               "for rcwa monoids (RCWA)", true, [ IsRcwaMonoid ], 0, 
               M -> ForAll( GeneratorsOfMonoid( M ), IsIntegral ) );

#############################################################################
##
#M  IsClassWiseOrderPreserving( <M> ) . . . for rcwa monoids over Z or Z_(pi)
##
InstallMethod( IsClassWiseOrderPreserving,
               "for rcwa monoids over Z or Z_(pi) (RCWA)",
               true, [ IsRcwaMonoidOverZOrZ_pi ], 0,
               M -> ForAll( GeneratorsOfMonoid( M ),
                            IsClassWiseOrderPreserving ) );

#############################################################################
##
#S  The support of an rcwa monoid. //////////////////////////////////////////
##
#############################################################################

#############################################################################
##
#M  MovedPoints( <M> ) . . . . . . . . . . . . . . . . . . . for rcwa monoids
##
##  The set of moved points (support) of the rcwa monoid <M>.
##
InstallMethod( MovedPoints,
               "for rcwa monoids (RCWA)", true, [ IsRcwaMonoid ], 0,

  function ( M )
    if IsNaturalRcwa(M) then return Source(One(M)); fi;
    return Union(List(GeneratorsOfMonoid(M),MovedPoints));
  end );

#############################################################################
##
#M  Support( <M> ) . . . . . . . . . . . . . . . . . . . . . for rcwa monoids
##
InstallMethod( Support,
               "for rcwa monoids (RCWA)", true, [ IsRcwaMonoid ], 0,
               MovedPoints );

#############################################################################
##
#S  Computing balls of given radius in rcwa monoids and on the //////////////
#S  underlying rings. ///////////////////////////////////////////////////////
##
#############################################################################

#############################################################################
##
#M  Ball( <M>, <f>, <r> ) . . . . . . . . for a monoid and an element thereof
##
##  As element tests can be expensive, this method does not check whether <f>
##  is indeed an element of <M>.
##
InstallMethod( Ball,
               "for a monoid and an element thereof (RCWA)", ReturnTrue,
               [ IsMonoid, IsMultiplicativeElement, IsInt ], 0,

  function ( M, f, r )

    local  ball, gens, k;

    if   not IsCollsElms(FamilyObj(M),FamilyObj(f)) or r < 0
    then TryNextMethod(); fi;
    ball := [f];
    gens := Set(GeneratorsOfMonoid(M));
    for k in [1..r] do
      ball := Union(ball,Union(List(gens,gen->Union(ball*gen,gen*ball))));
    od;
    return ball;
  end );

#############################################################################
##
#M  Ball( <M>, <p>, <r>, <act> ) . .  for a transformation monoid and a point
##
InstallMethod( Ball,
               "for a transformation monoid and a point (RCWA)", ReturnTrue,
               [ IsMonoid, IsObject, IsInt, IsFunction ], 0,

  function ( M, p, r, act )

    local  ball, gens, k;

    if r < 0 then TryNextMethod(); fi;
    ball := [p];
    gens := Set(GeneratorsOfMonoid(M));
    for k in [1..r] do
      ball := Union(ball,Union(List(gens,gen->List(ball,pt->act(pt,gen)))));
    od;
    return ball;
  end );

#############################################################################
##
#S  The modulus of an rcwa monoid, and tame rcwa monoids. ///////////////////
##
#############################################################################

#############################################################################
##
#M  Modulus( <M> ) . . . . . . . . . . . . . . . . . . . . . for rcwa monoids
##
InstallMethod( Modulus,
               "for rcwa monoids (RCWA)", true, [ IsRcwaMonoid ], 0,

  function ( M )

    local  R, gens, r, ball, size;

    if IsGroup(M) then TryNextMethod(); fi;
    R := Source(One(M));
    gens := GeneratorsOfMonoid(M);
    if IsIntegral(M) then return Lcm(R,List(gens,Modulus)); fi;
    r := 1; size := 1;
    repeat
      ball := Ball(M,One(M),r);
      if Length(ball) = size then return Lcm(R,List(ball,Modulus)); fi;
      if not ForAll(ball,IsTame) then return Zero(R); fi;
      size := Length(ball);
    until false;
  end );

#############################################################################
##
#M  ModulusOfRcwaMonoid( <G> ) . . . . . . . . . . . .  dispatch to `Modulus'
##
InstallMethod( ModulusOfRcwaMonoid,
               "dispatch to `Modulus' (RCWA)", true, [ IsRcwaMonoid ], 0,
               Modulus );

#############################################################################
##
#M  IsTame( <G> ) . . . . . . . . . . . . . . . . . . . . .  for rcwa monoids
##
InstallMethod( IsTame,
               "for rcwa monoids (RCWA)", true, [ IsRcwaMonoid ], 0,

  function ( M )
    if   Modulus( M ) <> Zero( Source( One( M ) ) ) then return true;
    else SetSize( M, infinity ); return false; fi;
  end );

#############################################################################
##
#E  rcwamono.gi . . . . . . . . . . . . . . . . . . . . . . . . . . ends here