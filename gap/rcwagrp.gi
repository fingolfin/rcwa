#############################################################################
##
#W  rcwagrp.gi                GAP4 Package `RCWA'                 Stefan Kohl
##
#H  @(#)$Id$
##
##  This file contains implementations of methods and functions for
##  computing with groups generated by integral residue class-wise affine
##  mappings.
##
Revision.rcwagrp_gi :=
  "@(#)$Id$";

InstallTrueMethod( IsGroup,     IsRcwaGroup );
InstallTrueMethod( IsRcwaGroup, IsRationalBasedRcwaGroup );
InstallTrueMethod( IsRationalBasedRcwaGroup, IsIntegralRcwaGroup );
InstallTrueMethod( IsRationalBasedRcwaGroup,
                   IsSemilocalIntegralRcwaGroup );
InstallTrueMethod( IsRcwaGroup, IsModularRcwaGroup );

#############################################################################
##
#M  IsGeneratorsOfMagmaWithInverses( <l> ) .  for list of integral rcwa map's
##
##  Tests whether all rcwa mappings in the list <l> belong to the same
##  family and are bijective, hence generate a group.
##
InstallMethod( IsGeneratorsOfMagmaWithInverses,
               "for lists of rcwa mappings", 
               true, [ IsListOrCollection ], 0,

  function ( l )

    if   ForAll(l,IsRcwaMapping)
    then return     Length(Set(List(l,FamilyObj))) = 1
                and ForAll(l,IsBijective); 
    else TryNextMethod(); fi;
  end );

#############################################################################
## 
#M  IsCyclic( <G> ) . . . . . . . . . . . . . . . . generic method for groups
## 
InstallMethod( IsCyclic, "generic method for groups", true, [ IsGroup ], 50,

  function ( G )

    if   Length(GeneratorsOfGroup(G)) = 1
    then return true;
    else TryNextMethod(); fi;
  end );

#############################################################################
##
#V  TrivialIntegralRcwaGroup( <G> ) . . . . . . . trivial integral rcwa group
#V  TrivialRcwaGroup( <G> )
##
InstallValue( TrivialIntegralRcwaGroup,
              Group( IdentityIntegralRcwaMapping ) );

#############################################################################
##
#M  TrivialSubmagmaWithOne( <G> ). . . . . . . . . . . . . . . for rcwa group
##
InstallMethod( TrivialSubmagmaWithOne,
               "for rcwa groups", true, [ IsRcwaGroup ], 0,

  function ( G )

    local  Triv;

    Triv := Group(One(G));
    SetParentAttr(Triv,G);
    return Triv;
  end );

#############################################################################
##
#V  IntegralRcwaGroupsFamily . . . . . the family of all integral rcwa groups
##
BindGlobal( "IntegralRcwaGroupsFamily",
            FamilyObj( TrivialIntegralRcwaGroup ) );

#############################################################################
##
#M  RCWACons( IsRcwaGroup, Integers ) . . . . . . . . . . . . . . . RCWA( Z )
##
##  Group formed by all bijective integral rcwa mappings.
##
InstallMethod( RCWACons, "natural RCWA(Z)", true,
               [ IsRcwaGroup, IsIntegers ], 0,

  function ( filter, R )

    local  G;

    G := Objectify( NewType( IntegralRcwaGroupsFamily,
                             IsIntegralRcwaGroup and IsAttributeStoringRep ),
                    rec( ) );
    SetIsTrivial( G, false );
    SetIsNaturalRCWA_Z( G, true );
    SetOne( G, IdentityIntegralRcwaMapping );
    SetIsFinite( G, false ); SetSize( G, infinity );
    SetIsFinitelyGeneratedGroup( G, false );
    SetRepresentative( G, IntegralRcwaMapping( [ [ -1, 0, 1 ] ] ) );
    SetName( G, "RCWA(Z)" );
    return G;
  end );

#############################################################################
##
#M  RCWACons( IsRcwaGroup, Z_pi( <pi> ) ) . . . . . . . . . . .  RCWA( Z_pi )
##
##  Group formed by all bijective rcwa mappings over Z_pi.
##
InstallMethod( RCWACons, "natural RCWA(Z_pi)", true, 
               [ IsRcwaGroup, IsZ_pi ], 0,

  function ( filter, R )

    local  G, pi, id;

    pi := NoninvertiblePrimes( R );
    id := SemilocalIntegralRcwaMapping( pi, [ [1,0,1] ] );
    G  := Objectify( NewType( FamilyObj( Group( id ) ),
                                  IsSemilocalIntegralRcwaGroup
                              and IsAttributeStoringRep ),
                     rec( ) );
    SetIsTrivial( G, false );
    SetIsNaturalRCWA_Z_pi( G, true );
    SetOne( G, id );
    SetIsFinite( G, false ); SetSize( G, infinity );
  # SetIsFinitelyGeneratedGroup( G, false ); ???
    SetRepresentative( G, -id );
    SetName( G, Concatenation( "RCWA(", Name(R), ")" ) );
    return G;
  end );

#############################################################################
##
#M  RCWACons( IsRcwaGroup, PolynomialRing( GF( <q> ), 1 ) )  RCWA( GF(q)[x] )
##
##  Group formed by all bijective rcwa mappings over GF(q)[x].
##
InstallMethod( RCWACons, "natural RCWA(Z_pi)", true, 
               [ IsRcwaGroup, IsUnivariatePolynomialRing ], 0,

  function ( filter, R )

    local  G, q, id;

    q := Size( CoefficientsRing( R ) );
    id := ModularRcwaMapping( q, One(R), [ [1,0,1] * One(R) ] );
    G  := Objectify( NewType( FamilyObj( Group( id ) ),
                                  IsModularRcwaGroup
                              and IsAttributeStoringRep ),
                     rec( ) );
    SetIsTrivial( G, false );
    SetIsNaturalRCWA_GF_q_x( G, true );
    SetOne( G, id );
    SetIsFinite( G, false ); SetSize( G, infinity );
    SetIsFinitelyGeneratedGroup( G, false );
    SetRepresentative( G, -id );
    SetName( G, Concatenation( "RCWA(GF(", String(q), ")[x])" ) );
    return G;
  end );

#############################################################################
##
#F  RCWA( <R> ) . . . . . . . . . . . . . . . . . . . RCWA( <R> ) for PID <R>
##
InstallGlobalFunction( RCWA, R -> RCWACons( IsRcwaGroup, R ) );

#############################################################################
##
#M  IsNaturalRCWA_Z( <G> ) . . . . . . . . . . . . . . . . . . . . .  RCWA(Z)
##
##  The group RCWA(Z) can only be obtained by the above constructor.
##
InstallMethod( IsNaturalRCWA_Z,
               "for rcwa groups", true, [ IsRcwaGroup ], 0, ReturnFalse );

#############################################################################
##
#M  IsNaturalRCWA_Z_pi( <G> ) . . . . . . . . . . . . . . . . . .  RCWA(Z_pi)
##
##  The groups RCWA(Z_pi) can only be obtained by the above constructor.
##
InstallMethod( IsNaturalRCWA_Z_pi,
               "for rcwa groups", true, [ IsRcwaGroup ], 0, ReturnFalse );

#############################################################################
##
#M  IsNaturalRCWA_GF_q_x( <G> ) . . . . . . . . . . . . . . .  RCWA(GF(q)[x])
##
##  The groups RCWA(GF(q)[x]) can only be obtained by the above constructor.
##
InstallMethod( IsNaturalRCWA_GF_q_x,
               "for rcwa groups", true, [ IsRcwaGroup ], 0, ReturnFalse );

#############################################################################
##
#M  \in( <g>, RCWA( Integers ) ) . . .  for integral rcwa mapping and RCWA(Z)
##
InstallMethod( \in,
               "for integral rcwa mapping and RCWA(Z)", ReturnTrue,
               [ IsIntegralRcwaMapping, IsNaturalRCWA_Z ], 100,

  function ( g, G )
    return IsBijective(g);
  end );

#############################################################################
##
#M  \in( <g>, RCWA( Z_pi( <pi> ) ) ) . . . .  for rcwa mapping and RCWA(Z_pi)
##
InstallMethod( \in,
               "for semilocal integral rcwa mapping and RCWA(Z_pi)",
               ReturnTrue,
               [ IsSemilocalIntegralRcwaMapping, IsNaturalRCWA_Z_pi ], 100,

  function ( g, G )
    return FamilyObj(g) = FamilyObj(One(G)) and IsBijective(g);
  end );

#############################################################################
##
#M  \in( <g>, RCWA( GF(q)[x] ) ) . . . .  for rcwa mapping and RCWA(GF(q)[x])
##
InstallMethod( \in,
               "for modular rcwa mapping and RCWA(GF(q)[x])",
               ReturnTrue,
               [ IsModularRcwaMapping, IsNaturalRCWA_GF_q_x ], 100,

  function ( g, G )
    return FamilyObj(g) = FamilyObj(One(G)) and IsBijective(g);
  end );

############################################################################# 
## 
#M  IsSubset( RCWA( Integers ), G ) . . . for RCWA(Z) and integral rcwa group
## 
InstallMethod( IsSubset,
               "for RCWA(Z) and integral rcwa group", ReturnTrue,
               [ IsNaturalRCWA_Z, IsIntegralRcwaGroup ], 0, ReturnTrue );

#############################################################################
##
#M  IsSubset( RCWA( Z_pi( <pi> ) ), G ) . . . . for RCWA(Z_pi) and rcwa group
##
InstallMethod( IsSubset,
               "for RCWA(Z_pi) and semilocal integral rcwa group",
               ReturnTrue,
               [ IsNaturalRCWA_Z_pi, IsSemilocalIntegralRcwaGroup ], 0,

  function ( RCWA_Z_pi, G )
    return FamilyObj(One(RCWA_Z_pi)) = FamilyObj(One(G));
  end );

#############################################################################
##
#M  IsSubset( RCWA( GF(q)[x] ), G ) . . . . for RCWA(GF(q)[x]) and rcwa group
##
InstallMethod( IsSubset,
               "for RCWA(GF(q)[x]) and modular rcwa group",
               ReturnTrue,
               [ IsNaturalRCWA_GF_q_x, IsModularRcwaGroup ], 0,

  function ( RCWA_GF_q_x, G )
    return FamilyObj(One(RCWA_GF_q_x)) = FamilyObj(One(G));
  end );

#############################################################################
##
#M  Display( RCWA( <R> ) ) . . . . . . . . . . . . . . . .  for whole RCWA(R)
##
InstallMethod( Display,
               "for whole RCWA(R)", true, [ IsRcwaGroup and HasName ], 0,

  function ( G )
    if   IsNaturalRCWA_Z( G ) or IsNaturalRCWA_Z_pi( G )
      or IsNaturalRCWA_GF_q_x( G )
    then Print( Name( G ), "\n" ); else TryNextMethod(); fi;
  end );

#############################################################################
##
#M  ViewObj( <G> ) . . . . . . . . . . . . . . . . . . . . . . for rcwa group
##
InstallMethod( ViewObj,
               "for rcwa groups", true, [ IsRcwaGroup ], 0,

  function ( G )

    local  NrGens, pi, q, piStr, LocStr, RingStr;

    if IsSemilocalIntegralRcwaGroup(G) then
      pi    := NoninvertiblePrimes(Source(One(G)));
      piStr := String(pi){[3..Length(String(pi)) - 2]};
      if Length(pi) = 1 then LocStr := ""; else LocStr := "semi"; fi;
    fi;
    if   IsModularRcwaGroup(G)
    then q := Size(UnderlyingField(One(G)));
         RingStr := Concatenation("GF(",String(q),")[x]");
    fi;
    Print("<");
    if   IsTrivial(G) 
    then if   IsIntegralRcwaGroup(G)
         then Print("trivial integral rcwa group");
         elif IsSemilocalIntegralRcwaGroup(G)
         then Print("trivial ",piStr,"-",LocStr,"local integral rcwa group");
         else Print("trivial rcwa group over ",RingStr);
         fi;
    else NrGens := Length(GeneratorsOfGroup(G));
         if IsRationalBasedRcwaGroup(G) then
           if IsSemilocalIntegralRcwaGroup(G) then
             Print(piStr,"-",LocStr,"local ");
           fi;
           Print("integral rcwa group with ",NrGens," generator");
         else Print("rcwa group over ",RingStr," with ",NrGens," generator");
         fi;
         if NrGens > 1 then Print("s"); fi;
         if   HasIdGroup(G) then Print(", of isomorphism type ",IdGroup(G));
         elif HasSize(G)    then Print(", of size ",Size(G)); fi;
    fi;
    Print(">");
  end );

#############################################################################
##
#M  Display( <G> ) . . . . . . . . . . . . . . . . . . . . . . for rcwa group
##
InstallMethod( Display,
               "for rcwa groups", true, [ IsRcwaGroup ], 0,

  function ( G )

    local  pi, q, piStr, LocStr, RingStr, g;

    if IsSemilocalIntegralRcwaGroup(G) then
      pi    := NoninvertiblePrimes(Source(One(G)));
      piStr := String(pi){[3..Length(String(pi)) - 2]};
      if Length(pi) = 1 then LocStr := ""; else LocStr := "semi"; fi;
    fi;
    if   IsModularRcwaGroup(G)
    then q := Size(UnderlyingField(One(G)));
         RingStr := Concatenation("GF(",String(q),")[x]");
    fi;
    if   IsTrivial(G) 
    then if   IsIntegralRcwaGroup(G)
         then Print("Trivial integral rcwa group");
         elif IsSemilocalIntegralRcwaGroup(G)
         then Print("Trivial ",piStr,"-",LocStr,"local integral rcwa group");
         else Print("Trivial rcwa group over ",RingStr);
         fi;
         Print("\n");
    else Print("\n");
         if IsRationalBasedRcwaGroup(G) then
           if IsSemilocalIntegralRcwaGroup(G) then
             Print(piStr,"-",LocStr,"local i");
           else Print("I"); fi;
           Print("ntegral rcwa group");
         else Print("Rcwa group over ",RingStr);
         fi;
         if   HasIdGroup(G)
         then if IsModularRcwaGroup(G) then Print(","); fi;
              Print(" of isomorphism type ",IdGroup(G));
         elif HasSize(G)
         then if IsModularRcwaGroup(G) then Print(","); fi;
              Print(" of size ",Size(G));
         fi;
         Print(", generated by\n\n[\n");
         for g in GeneratorsOfGroup(G) do Display(g); od;
         Print("]\n\n");
    fi;
  end );

#############################################################################
##
#M  IsomorphismIntegralRcwaGroup( <G> ) . . . . .  rcwa representation of <G>
#M  IsomorphismRcwaGroup( <G> )
##
##  This is a rather simple-minded method.
##
InstallMethod( IsomorphismIntegralRcwaGroup,
               "generic method for finite groups", true,
               [ IsGroup and IsFinite ], 0,

  function ( G )

    local  G2, H, phi1, phi2, n;

    if IsIntegralRcwaGroup(G) then return IdentityMapping(G); fi;
    if   not IsPermGroup(G) 
    then phi1 := IsomorphismPermGroup(G); G2 := Image(phi1);
    else phi1 := IdentityMapping(G);      G2 := G;
    fi;
    n := LargestMovedPoint(G2);
    H := GroupWithGenerators(List(GeneratorsOfGroup(G2),
                                  g -> IntegralRcwaMapping(g,[1..n])));
    phi2 := GroupHomomorphismByImagesNC(G2,H,GeneratorsOfGroup(G2),
                                             GeneratorsOfGroup(H));
    return Immutable(CompositionMapping(phi2,phi1));
  end );

#############################################################################
##
#F  IntegralRcwaGroupByPermGroup( <G> ) . . . .  rcwa group isomorphic to <G>
#F  RcwaGroupByPermGroup( <G> )
##
InstallGlobalFunction( IntegralRcwaGroupByPermGroup,

  function ( G )

    local  H, phi, phi_1;

    if   not IsPermGroup(G) 
    then Error("<G> must be a permutation group"); fi;
    phi := IsomorphismIntegralRcwaGroup(G);
    H   := Image(phi);
    phi_1 := InverseGeneralMapping(phi);
    SetIsomorphismPermGroup(H,phi_1);
    SetNiceMonomorphism(H,phi_1);
    SetNiceObject(H,G);
    # SetIsHandledByNiceMonomorphism(H,true);

    return H;
  end );

#############################################################################
##
#M  \in( <g>, <G> ) . . . . for integral rcwa mapping and integral rcwa group
##
##  This may run into an infinite loop if <G> is infinite and <g> is not an
##  element of <G>.
##
InstallMethod( \in,
               "for integral rcwa mapping and integral rcwa group",
               ReturnTrue, [ IsIntegralRcwaMapping, IsIntegralRcwaGroup ], 0,

  function ( g, G )

    local  H, gens, actson, gimage, k;

    gens := GeneratorsOfGroup(G);
    if g = One(G) or g in gens or g^-1 in gens then return true; fi;
    if not IsSubset(PrimeSet(G),PrimeSet(g)) then return false; fi;
    if   g in List(Combinations(gens,2), t -> Product(t)) 
    then return true; fi;
    if IsFinite(G) then
      if   Modulus(G) mod Modulus(g) <> 0 or Order(g) = infinity
      then return false; fi;
      if   HasParent(G)
      then H := Image(IsomorphismPermGroup(G));
      else H := NiceObject(G); fi;
      actson := Union(List(RcwaBase(G), rep -> Orbit(G,rep)));
      if   ForAll(actson, n -> n^g in actson)
      then gimage := Permutation(g,actson); 
           return gimage in H;
      else return false; fi;
    else
      gens := Union(gens,List(gens, g -> g^-1));
      k := 2;
      repeat
        if   g in List(Tuples(gens,k), t -> Product(t)) 
        then return true; fi;
        k := k + 1;
      until false;
    fi;
  end );

#############################################################################
##
#M  \in( <g>, <G> ) . . . . . . . . . . . . . for rcwa mapping and rcwa group
##
##  This may run into an infinite loop if <G> is infinite and <g> is not an
##  element of <G>.
##
InstallMethod( \in,
               "for rcwa mapping and rcwa group",
               ReturnTrue, [ IsRcwaMapping, IsRcwaGroup ], 0,

  function ( g, G )

    local  gens, k;

    if FamilyObj(g) <> FamilyObj(One(G)) then return false; fi;
    gens := GeneratorsOfGroup(G);
    if g = One(G) or g in gens or g^-1 in gens then return true; fi;
    if not IsSubset(PrimeSet(G),PrimeSet(g)) then return false; fi;
    if   g in List(Combinations(gens,2), t -> Product(t))
    then return true; fi;
    gens := Union(gens,List(gens, g -> g^-1));
    k := 2;
    repeat
      if   g in List(Tuples(gens,k), t -> Product(t))
      then return true; fi;
      k := k + 1;
    until false;
  end );

#############################################################################
##
#M  Modulus( <G> ) . . . . . . . . . . . . . . . . . . . . . . for rcwa group
##
##  Modulus of rcwa group <G>.
##
##  We define the modulus of an rcwa group <G> as the least common multiple
##  of the moduli of its elements.
##
##  Caution: this is a highly probabilistic and experimental method !
##
InstallOtherMethod( Modulus,
                    "for rcwa groups", true, [ IsRcwaGroup ], 0,

  function ( G )

    local  m, oldm, maxfinmod, g, gens, step, maxstep;

    if HasModulusOfRcwaGroup(G) then return ModulusOfRcwaGroup(G); fi;
    if   IsCyclic(G)
    then gens := GeneratorsOfGroup(G);
    else gens := Union(List(GeneratorsOfGroup(G), g -> [g, g^-1])); fi;
    m := 1;
    for step in [1..2] do
      m := Maximum(m, Maximum(List(Tuples(gens,step),
                                   t -> Modulus(Product(t)))));
    od;
    oldm := m; maxfinmod := 10 * m;
    step := 1; maxstep   := 10 * Length(gens);
    g := gens[1];
    repeat
      g := g * Random(gens); step := step + 1;
      if Modulus(g) > oldm then oldm := m; m := Modulus(g); step := 1; fi;
      if m > maxfinmod then return 0; fi;
    until step > maxstep;

    SetModulusOfRcwaGroup(G,m);
    return m;
  end );

#############################################################################
##
#M  ModulusOfRcwaGroup( <G> ) . . . . . . . . . . . . . . . .  for rcwa group
##
InstallMethod( ModulusOfRcwaGroup,
               "for rcwa groups", true, [ IsRcwaGroup ], 0,
               G -> Modulus( G ) );

#############################################################################
##
#M  PrimeSet( <G> ) . . . . . . . . . . . . . . . . . . . . .  for rcwa group
##
InstallMethod( PrimeSet,
               "for rcwa groups", true, [ IsRcwaGroup ], 0,
               G -> Union( List( GeneratorsOfGroup( G ), PrimeSet ) ) );

#############################################################################
##
#M  IsFlat( <G> ) . . . . . . . . . . . . . . . . . . . . . .  for rcwa group
##
InstallMethod( IsFlat,
               "for rcwa groups", true, [ IsRcwaGroup ], 0, 
               G -> ForAll( GeneratorsOfGroup( G ), IsFlat ) );

#############################################################################
##
#M  IsClassWiseOrderPreserving( <G> ) . . . . . for rational-based rcwa group
##
##  We say that a rational-based rcwa group is *class-wise order-preserving*
##  if all of its elements are.
##
InstallOtherMethod( IsClassWiseOrderPreserving,
                    "for rational-based rcwa groups",
                    true, [ IsRationalBasedRcwaGroup ], 0,
                    G -> ForAll( GeneratorsOfGroup( G ),
                                 IsClassWiseOrderPreserving ) );

#############################################################################
##
#M  IsTame( <G> ) . . . . . . . . . . . . . . . . . . . . . .  for rcwa group
##
InstallMethod( IsTame,
               "for rcwa groups", true, [ IsRcwaGroup ], 0,
               G -> Modulus( G ) <> Zero( Source( One( G ) ) ) );

#############################################################################
##
#M  RcwaBase( <G> ) . . . . . . . . . . . . . . . . . for integral rcwa group
##
##  This is a probabilistic method. The result is not guaranteed to be
##  correct. The probability of getting an action homomorphism with non-
##  trivial kernel can be reduced by specifying a larger value for the option
##  <Steps>. By default, it is 10. If <G> is infinite, this method will run
##  into an infinite loop.
##
InstallMethod( RcwaBase,
               "for integral residue class-wise affine groups",
               true, [ IsIntegralRcwaGroup ], 0,

  function ( G )

    local  H, oldsize, step, steps, orb, orbs, rep, reps, repsbuf,
           bases, baselng;

    steps := ValueOption("Steps"); if steps = fail then steps := 10; fi;
    oldsize := 1; step := 0; orbs := []; reps := []; repsbuf := [];
    repeat
      step := step + 1;
      rep := Random([1..2^28-1]); AddSet(reps,rep);
      orb := Orbit(G,rep); orbs := Union(orbs,orb);
      H := Action(G,orbs);
      if Size(H) > oldsize then
        oldsize := Size(H);
        repsbuf := ShallowCopy(reps);
        step    := 0;
      fi;
    until step = steps;
    baselng := 1;
    repeat
      bases := Filtered(Combinations(repsbuf,baselng),
                        c -> Size(Action(G,Union(List(c,rep->Orbit(G,rep)))))
                           = oldsize);
      baselng := baselng + 1;
    until bases <> [];

    return bases[1];
  end );

#############################################################################
##
#M  IsomorphismPermGroup( <G> ) . . . . . . . . . . . for integral rcwa group
##
InstallMethod( IsomorphismPermGroup,
               "for integral residue class-wise affine groups",
               true, [ IsIntegralRcwaGroup ], 0,

  function ( G )

    local  H, phi, base;

    if   IsTrivial(G) 
    then return GroupHomomorphismByImagesNC(G,Group(()),[One(G)],[()]); fi;
    base := RcwaBase(G);
    H := Action(G,Union(List(base, rep -> Orbit(G,rep))));
    phi := Immutable(GroupHomomorphismByImagesNC(G,H,GeneratorsOfGroup(G),
                                                     GeneratorsOfGroup(H)));
    if not HasParent(G) and not HasNiceMonomorphism(G) then
      SetNiceMonomorphism(G,phi);
      SetNiceObject(G,H);
    fi;
    # SetIsHandledByNiceMonomorphism(G,true);

    return phi;
  end );

#############################################################################
##
#M  NiceMonomorphism( <G> ) . . . . . . . . . . . . . for integral rcwa group
##
InstallMethod( NiceMonomorphism,
               "for integral residue class-wise affine groups",
               true, [ IsIntegralRcwaGroup ], 0,

  function ( G )

    if IsFinite(G) then return IsomorphismPermGroup(G);
                   else return IdentityMapping(G); fi;
  end );

#############################################################################
##
#M  NiceObject( <G> ) . . . . . . . . . . . . . . . . . . . .  for rcwa group
##
InstallMethod( NiceObject,
               "for rcwa groups", true, [ IsRcwaGroup ], 0,
               G -> Image( NiceMonomorphism( G ) ) );

#############################################################################
##
#M  Size( <G> ) . . . . . . . . . . . . . . . . . . . for integral rcwa group
##
##  This method firstly looks for elements of infinite order.
##  In case this search is not successful, it assumes the group to be
##  probably finite and tries to construct an isomorphism to a finite
##  permutation group. If this assumption is false, the method may run
##  into an infinite loop.
##
InstallMethod( Size,
               "for integral rcwa groups",
               true, [ IsIntegralRcwaGroup ], 0,

  function ( G )

    local  gen, k;

    gen := GeneratorsOfGroup(G);
    if ForAny(gen, g -> Order(g) = infinity) then return infinity; fi;
    if   ForAny(Combinations(gen,2), t -> Order(Comm(t[1],t[2])) = infinity)
    then return infinity; fi;
    for k in [2..3] do
      if   ForAny(Tuples(gen,k), t -> Order(Product(t)) = infinity)
      then return infinity; fi;
    od;
    return Size(Image(IsomorphismPermGroup(G)));
  end );

#############################################################################
##
#M  Size( <G> ) . . . . . . . . . . . . . . . . . . . . . . .  for rcwa group
##
##  This method looks for elements of infinite order.
##  In case this search is not successful, it gives up.
##
InstallMethod( Size,
               "for rcwa groups", true, [ IsRcwaGroup ], 0,

  function ( G )

    local  gen, k;

    gen := GeneratorsOfGroup(G);
    if ForAny(gen, g -> Order(g) = infinity) then return infinity; fi;
    if   ForAny(Combinations(gen,2), t -> Order(Comm(t[1],t[2])) = infinity)
    then return infinity; fi;
    for k in [2..3] do
      if   ForAny(Tuples(gen,k), t -> Order(Product(t)) = infinity)
      then return infinity; fi;
    od;
    TryNextMethod();
  end );

############################################################################# 
## 
#M  ShortOrbits( <G>, <S>, <maxlng> ) . . . . . . . . . . . .  for rcwa group
## 
InstallMethod( ShortOrbits,
               "for rcwa groups", true, [ IsRcwaGroup, IsList, IsPosInt ], 0,

  function ( G, S, maxlng )

    local  gens, g, orbs, orb, oldorb, remaining, n;

    gens := GeneratorsOfGroup(G);
    orbs := []; remaining := ShallowCopy(Set(S));
    while remaining <> [] do
      orb := [remaining[1]];
      repeat
        oldorb := ShallowCopy(orb);
        for g in gens do for n in oldorb do AddSet(orb,n^g); od; od;
      until Length(orb) > maxlng or Length(orb) = Length(oldorb);
      if Length(orb) <= maxlng then Add(orbs,Set(orb)); fi;
      remaining := Difference(remaining,orb);
    od;
    return orbs;
  end );

#############################################################################
##
#F  NrConjugacyClassesOfRCWAZOfOrder( <ord> ) . #Ccl of RCWA(Z) / order <ord>
##
InstallGlobalFunction( NrConjugacyClassesOfRCWAZOfOrder,

  function ( ord )

    if   not IsPosInt(ord) then return 0;
    elif ord = 1 then return 1;
    elif ord mod 2 = 0 then return infinity;
    else return Length(Filtered(Combinations(DivisorsInt(ord)),
                                l -> l <> [] and Lcm(l) = ord));
    fi;
  end );

#############################################################################
##
#E  rcwagrp.gi . . . . . . . . . . . . . . . . . . . . . . . . . .  ends here