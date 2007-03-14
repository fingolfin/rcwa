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
#M  ViewObj( <M> ) . . . . . . . . . . . . . . . . . . . . . for rcwa monoids
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
#M  Display( <M> ) . . . . . . . . . . . . . . . . . . . . . for rcwa monoids
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
#M  IsTrivial( <M> ) . . . . . . . . . . . . . . . . . . . . for rcwa monoids
##
InstallMethod( IsTrivial,
               "for rcwa monoids (RCWA)", true,
               [ IsRcwaMonoid and HasGeneratorsOfMonoid ], 0,
               M -> ForAll( GeneratorsOfMonoid( M ), IsOne ) );

#############################################################################
##
#S  The construction of the monoids Rcwa(R) of all rcwa mappings of R. //////
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

    local  M, id, type, rep;

    if   IsIntegers( R ) then
      type := IsRcwaMonoidOverZ;
      rep  := 2 * IdentityRcwaMappingOfZ;
    elif IsZ_pi( R ) then
      type := IsRcwaMonoidOverZ_pi;
      rep  := NoninvertiblePrimes( R )[ 1 ] * One( RCWA( R ) );
    elif IsUnivariatePolynomialRing( R ) and
         IsFiniteFieldPolynomialRing( R )
    then
      type := IsRcwaMonoidOverGFqx;
      rep  := IndeterminatesOfPolynomialRing( R )[ 1 ] * One( RCWA( R ) );
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
    SetRepresentative( M, rep );
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
#S  Constructing rcwa monoids: //////////////////////////////////////////////
#S  Restriction monomorphisms and induction epimorphisms. ///////////////////
##
#############################################################################

#############################################################################
##
#M  Restriction( <M>, <f> ) . . . . . . . . . . . . . . . .  for rcwa monoids
##
InstallMethod( Restriction,
               "for rcwa monoids (RCWA)", ReturnTrue,
               [ IsRcwaMonoid, IsRcwaMapping ], 0,

  function ( M, f )

    local Mf;

    if   Source(One(M)) <> Source(f) or not IsInjective(f)
    then return fail; fi;

    Mf := MonoidByGenerators(List(GeneratorsOfMonoid(M),
                                  g->Restriction(g,f)));

    if HasIsTame(M) then SetIsTame(Mf,IsTame(M)); fi;
    if HasSize(M)   then SetSize(Mf,Size(M)); fi;

    return Mf;
  end );

#############################################################################
##
#M  Induction( <M>, <f> ) . . . . . . . . . . . . . . . . .  for rcwa monoids
##
InstallMethod( Induction,
               "for rcwa monoids (RCWA)", ReturnTrue,
               [ IsRcwaMonoid, IsRcwaMapping ], 0,

  function ( M, f )

    local Mf;

    if Source(One(M)) <> Source(f) or not IsInjective(f)
      or not IsSubset(Image(f),MovedPoints(M))
    then return fail; fi;

    Mf := MonoidByGenerators(List(GeneratorsOfMonoid(M),g->Induction(g,f)));

    if HasIsTame(M) then SetIsTame(Mf,IsTame(M)); fi;
    if HasSize(M)   then SetSize(Mf,Size(M)); fi;

    return Mf;
  end );

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
#S  Finding finite orbits of rcwa monoids. //////////////////////////////////
##
#############################################################################

#############################################################################
## 
#M  ShortOrbits( <M>, <S>, <maxlng> ) . . . . . . . . . . .  for rcwa monoids
## 
InstallMethod( ShortOrbits,
               "for rcwa monoids (RCWA)", true,
               [ IsRcwaMonoid, IsList, IsPosInt ], 0,

  function ( M, S, maxlng )

    local  gens, f, orbs, orb, oldorb, remaining, n;

    if IsRcwaGroup(M) then gens := GeneratorsOfGroup(M);
                      else gens := GeneratorsOfMonoid(M); fi;
    orbs := []; remaining := ShallowCopy(Set(S));
    while remaining <> [] do
      orb := [remaining[1]];
      repeat
        oldorb := ShallowCopy(orb);
        for f in gens do orb := Union(orb,orb^f); od;
      until Length(orb) > maxlng or Length(orb) = Length(oldorb);
      if Length(orb) <= maxlng then Add(orbs,Set(orb)); fi;
      remaining := Difference(remaining,orb);
    od;
    return orbs;
  end );

#############################################################################
##
#S  Orbits of rcwa monoids on the set of residue classes (mod m). ///////////
##
#############################################################################

#############################################################################
##
#M  OrbitsModulo( <M>, <m> ) . . . . . . . . . . . . . . . . for rcwa monoids
##
InstallMethod( OrbitsModulo,
               "for rcwa monoids (RCWA)", true,
               [ IsRcwaMonoid, IsRingElement ], 0,

  function ( M, m )

    local  result, R, gens, orbit, oldorbit, orbitset, img, remaining;

    R := Source(One(M));
    if not m in R then TryNextMethod(); fi;
    if IsRcwaGroup(M) then gens := GeneratorsAndInverses(M);
                      else gens := GeneratorsOfMonoid(M); fi;
    remaining := AllResidueClassesModulo(R,m); result := [];
    repeat
      orbit := [remaining[1]];
      repeat
        oldorbit := ShallowCopy(orbit);
        orbitset := Union(orbit);
        img      := Union(List(gens,gen->orbitset^gen));
        orbit    := Union(orbit,
                          Filtered(remaining,cl->Intersection(cl,img)<>[]));
      until orbit = oldorbit;
      Add(result,List(orbit,Residue));
      remaining := Difference(remaining,orbit);
    until remaining = [];
    return result;
  end );

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
      ball := Union(ball,Union(List(gens,gen->ball*gen)));
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
#M  ModulusOfRcwaMonoid( <M> ) . . . . . . . . . . . .  dispatch to `Modulus'
##
InstallMethod( ModulusOfRcwaMonoid,
               "dispatch to `Modulus' (RCWA)", true, [ IsRcwaMonoid ], 0,
               Modulus );

#############################################################################
##
#M  IsTame( <M> ) . . . . . . . . . . . . . . . . . . . . .  for rcwa monoids
##
InstallMethod( IsTame,
               "for rcwa monoids (RCWA)", true, [ IsRcwaMonoid ], 0,

  function ( M )
    if   Modulus( M ) <> Zero( Source( One( M ) ) ) then return true;
    else SetSize( M, infinity ); return false; fi;
  end );

#############################################################################
##
#S  Computing the order of an rcwa monoid. //////////////////////////////////
##
#############################################################################

#############################################################################
##
#M  Size( <M> ) . . . . . . . . . . . . . . . . . . . . . .  for rcwa monoids
##
##  This method may run into an infinite loop if <M> is infinite.
##
InstallMethod( Size,
               "for rcwa monoids (RCWA)", true, [ IsRcwaMonoid ], 0,

  function ( M )

    local  R, gens;

    if IsTrivial(M)   then return 1; fi;
    if IsRcwaGroup(M) then TryNextMethod(); fi;
    R    := Source(One(M));
    gens := GeneratorsOfMonoid(M);
    if   ForAny(gens,f->IsSurjective(f) and not IsInjective(f))
    then return infinity; fi; # surjective & not injective -> wild
    if   ForAny(gens,f->IsBijective(f) and Order(f)=infinity)
    then return infinity; fi;
    if not ForAll(gens,IsTame) then return infinity; fi;
    if   ForAny(Ball(M,One(M),2),f->(IsBijective(f) and Order(f)=infinity)
                                    or not IsTame(f))
    then return infinity; fi;
    return Length(AsList(M));
  end );

#############################################################################
##
#S  The membership- / submonoid test. ///////////////////////////////////////
##
#############################################################################

#############################################################################
##
#M  \in( <f>, <M> ) . . . . . . . . . . . . . . . . . . . .  for rcwa monoids
##
##  This method may run into an infinite loop if <f> is not an element of
##  the monoid <M>.
##
InstallMethod( \in,
               "for rcwa monoids (RCWA)",
               ReturnTrue, [ IsRcwaMappingOfZ, IsRcwaMonoid ], 0,

  function ( f, M )

    local  R, gens, orbs, max, r;

    if IsRcwaGroup(M) then TryNextMethod(); fi;
    Info(InfoRCWA,2,"\\in for an rcwa mapping <f> and an rcwa monoid <M>");
    R    := Source(One(M));
    gens := GeneratorsOfMonoid(M);
    if f = One(M) or f in gens then
      Info(InfoRCWA,2,"<f> = 1 or <f> lies in list of generators of <M>.");
      return true;
    fi;
    if    IsZero(Multiplier(f))
      and not ForAny(gens,g->IsZero(Multiplier(g)))
    then
     Info(InfoRCWA,2,"Mult(<f>) = 0, but Mult(<M>) <> 0.");
     return false;
    fi;
    if not ForAny(Concatenation(gens,[f]),g->IsZero(Multiplier(g))) then
      if not IsSubset(PrimeSet(M),PrimeSet(f)) then
        Info(InfoRCWA,2,"<f> and <M> have incompatible prime sets.");
        return false;
      fi;
      if not IsSubset(Factors(Product(List(gens,Multiplier))),
                      Filtered(Factors(Multiplier(f)),p->p<>1))
      then
        Info(InfoRCWA,2,"The multiplier of <f> has factors which");
        Info(InfoRCWA,2,"no multiplier of a generator of <M> has.");
        return false;
      fi;
    fi;
    if not IsSubset(Factors(Product(List(gens,Divisor))),
                    Filtered(Factors(Divisor(f)),p->p<>1))
    then
      Info(InfoRCWA,2,"The divisor of <f> has factors which");
      Info(InfoRCWA,2,"no divisor of a generator of <M> has.");
      return false;
    fi;
    if (IsIntegers(R) or IsZ_pi(R)) and IsClassWiseOrderPreserving(M)
      and not IsClassWiseOrderPreserving(f) then
      Info(InfoRCWA,2,"<M> is class-wise order-preserving, but <f> is not.");
      return false;
    fi;
    if   not IsInjective(f) and ForAll(gens,IsInjective) then
      Info(InfoRCWA,2,"<f> is not injective, ",
                      "but all generators of <M> are.");
      return false;
    fi;
    if   not IsSurjective(f) and ForAll(gens,IsSurjective) then
      Info(InfoRCWA,2,"<f> is not surjective, ",
                      "but all generators of <M> are.");
      return false;
    fi;
    if not IsSubset(Support(M),Support(f)) then
      Info(InfoRCWA,2,"Support(<f>) is not a subset of Support(<M>).");
      return false;
    fi;
    if IsIntegers(R) and IsClassWiseOrderPreserving(M) then
      max := Maximum(Concatenation(List(Concatenation(gens,[f]),
                                        g->Maximum(List(Coefficients(g),
                                                        c->AbsInt(c[2])))),
                                   List(Concatenation(gens,[f]),Modulus)));
      if Minimum([0..max]^f) < 0 or Maximum([-max..-1]^f) >= 0 then
        if    ForAll(gens,g->Minimum([0..max]^g)>=0)
          and ForAll(gens,g->Maximum([-max..-1]^g)<0)
        then
          Info(InfoRCWA,2,"<M> fixes the nonnegative integers setwise,");
          Info(InfoRCWA,2,"but <f> does not.");
          return false;
        fi;
      fi;
    fi;
    if IsTame(M) then
      if Modulus(M) mod Modulus(f) <> 0 then
        Info(InfoRCWA,2,"Mod(<f>) does not divide Mod(<M>).");
        return false;
      fi;
      if not IsTame(f) then
        Info(InfoRCWA,2,"<M> is tame, but <f> is wild.");
        return false;
      fi;
      if IsFinite(M) and IsBijective(f) and Order(f) = infinity then
        Info(InfoRCWA,2,"<M> is finite, but <f> has infinite order.");
        return false;
      fi;
    fi;
    orbs := ShortOrbits(M,Intersection(Support(M),[-100..100]),50);
    if orbs <> [] and not ForAll(orbs,orb->IsSubset(orb,orb^f)) then
      Info(InfoRCWA,2,"<f> does not leave some finite orbit of <M> ",
                      "invariant.");
      return false;
    fi;
    Info(InfoRCWA,2,"Trying to find <f> in balls around 1 ...");
    r := 1;
    repeat
      r := r + 1;
      if f in Ball(M,One(M),r) then
        Info(InfoRCWA,2,"<f> lies in the ball with radius ",r,".");
        return true;
      fi;
    until false;
  end );

#############################################################################
##
#M  IsSubset( <M>, <N> ) . . . . . . . . . . . . . . . . for two rcwa monoids
##
##  Checking for a submonoid relation.
##
InstallMethod( IsSubset,
               "for two rcwa monoids (RCWA)", true,
               [ IsRcwaMonoid, IsRcwaMonoid ], 0,

  function ( M, N )

    local  gensM, gensN, Mmultzero, Nmultzero;

    gensM := GeneratorsOfMonoid(M); gensN := GeneratorsOfMonoid(N);
    if IsSubset(gensM,gensN) then return true; fi;
    Mmultzero := ForAny(gensM,f->IsZero(Multiplier(f)));
    Nmultzero := ForAny(gensN,f->IsZero(Multiplier(f)));
    if Nmultzero and not Mmultzero then return false; fi;
    if not Mmultzero and not Nmultzero then
      if not IsSubset(Union(Factors(Product(List(gensM,Multiplier))),[1]),
                            Factors(Product(List(gensN,Multiplier))))
      then return false; fi;
    fi;
    if not IsSubset(Union(Factors(Product(List(gensM,Divisor))),[1]),
                          Factors(Product(List(gensN,Divisor))))
    then return false; fi;
    if not IsSubset(Support(M),Support(N)) then return false; fi;
    if IsTame(M) and not IsTame(N) then return false; fi;
    return ForAll(GeneratorsOfMonoid(N),f->f in M);
  end );

#############################################################################
##
#E  rcwamono.gi . . . . . . . . . . . . . . . . . . . . . . . . . . ends here