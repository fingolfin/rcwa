#############################################################################
##
#W  rcwagrp.gd                GAP4 Package `RCWA'                 Stefan Kohl
##
#H  @(#)$Id$
##
#Y  Copyright (C) 2002 by Stefan Kohl, Fachbereich Mathematik,
#Y  Universit\"at Stuttgart, Germany
##
##  This file contains declarations of functions, operations etc. for
##  computing with groups generated by integral residue class-wise affine
##  mappings.
##
Revision.rcwagrp_gd :=
  "@(#)$Id$";

#############################################################################
##
#C  CategoryCollections( IsIntegralRcwaMapping ) . . .  integral rcwa domains
##
##  The category of all domains formed out of integral rcwa mappings.
##
DeclareCategoryCollections( "IsIntegralRcwaMapping" );

#############################################################################
##
#C  IsRcwaGroup . . . . . . . . . . . . . . . . . . . . . . . all rcwa groups
##
##  The category of all rcwa groups.
##
DeclareSynonym( "IsRcwaGroup",
                 CategoryCollections(IsRcwaMapping) and IsGroup );

#############################################################################
##
#C  IsIntegralRcwaGroup . . . . . . . . . . . . . . . .  integral rcwa groups
##
##  The category of all integral rcwa groups.
##
DeclareSynonym( "IsIntegralRcwaGroup",
                 CategoryCollections(IsIntegralRcwaMapping) and IsGroup );

#############################################################################
##
#C  IsSemilocalIntegralRcwaGroup . . . . . . . semilocal integral rcwa groups
##
##  The category of all semilocal integral rcwa groups.
##
DeclareSynonym( "IsSemilocalIntegralRcwaGroup",
                 CategoryCollections(IsSemilocalIntegralRcwaMapping)
                 and IsGroup );

#############################################################################
##
#C  IsRationalBasedRcwaGroup . . . . . . . . . . . rational-based rcwa groups
##
##  The category of all integral or semilocal integral rcwa groups.
##  This is the union of the categories `IsIntegralRcwaGroup' and
##  `IsSemilocalIntegralRcwaGroup'.
##
DeclareSynonym( "IsRationalBasedRcwaGroup",
                 CategoryCollections(IsRationalBasedRcwaMapping)
                 and IsGroup );

#############################################################################
##
#C  IsModularRcwaGroup . . . . . . . . . . . . . . . . .  modular rcwa groups
##
##  The category of all modular rcwa groups.
##
DeclareSynonym( "IsModularRcwaGroup",
                 CategoryCollections(IsModularRcwaMapping) and IsGroup );

#############################################################################
##
#V  TrivialIntegralRcwaGroup( <G> ) . . . . . . . trivial integral rcwa group
#V  TrivialRcwaGroup( <G> )
##
DeclareGlobalVariable( "TrivialIntegralRcwaGroup" );
DeclareSynonym( "TrivialRcwaGroup", TrivialIntegralRcwaGroup );

#############################################################################
##
#O  RCWACons( <R> ) . . . . . . . . . . . . . . . . . RCWA( <R> ) for PID <R>
##
##  Currently only implemented for <R> = `Integers'.
##
DeclareConstructor( "RCWACons", [ IsRcwaGroup, IsRing ] );

#############################################################################
##
#F  RCWA( <R> ) . . . . . . . . . . . . . . . . . . . RCWA( <R> ) for PID <R>
##
##  Currently only implemented for <R> = `Integers'.
##
DeclareGlobalFunction( "RCWA" );

#############################################################################
##
#P  IsNaturalRCWA_Z( <G> ) . . . . . . . . . . . . . . . . . . . .  RCWA( Z )
##
DeclareProperty( "IsNaturalRCWA_Z", IsRcwaGroup );

#############################################################################
##
#P  IsNaturalRCWA_Z_pi( <G> ) . . . . . . . . . . . . . . . . .  RCWA( Z_pi )
##
DeclareProperty( "IsNaturalRCWA_Z_pi", IsRcwaGroup );

#############################################################################
##
#P  IsNaturalRCWA_GF_q_x( <G> ) . . . . . . . . . . . . . .  RCWA( GF(q)[x] )
##
DeclareProperty( "IsNaturalRCWA_GF_q_x", IsRcwaGroup );

#############################################################################
##
#A  IsomorphismMatrixGroup( <G> ) . . . . . . .  matrix representation of <G>
##
DeclareAttribute( "IsomorphismMatrixGroup", IsGroup );

#############################################################################
##
#A  ActionOnClassPartition( <G> ) . action of <G> on permuted class partition
##
##  Action of the tame group <G> on its permuted class partition.
##
DeclareAttribute( "ActionOnClassPartition", IsRcwaGroup );

#############################################################################
##
#A  RankOfKernelOfActionOnClassPartition( <G> )
##
##  Rank of the largest free abelian group fitting into the kernel of the
##  action of <G> on its permuted class partition.
##  The group <G> has to be tame.
##
DeclareAttribute( "RankOfKernelOfActionOnClassPartition", IsRcwaGroup );

#############################################################################
##
#A  KernelOfActionOnClassPartition( <G> )
##
##  Kernel of the action of <G> on its permuted class partition.
##  The group <G> has to be tame.
##
DeclareAttribute( "KernelOfActionOnClassPartition", IsRcwaGroup );

#############################################################################
##
#A  KernelOfActionOnClassPartitionHNFMat( <G> )
##
##  Matrix of row vectors spanning the lattice corresponding to
##  KernelOfActionOnClassPartition( <G> ), in Hermite normal form.
##
DeclareAttribute( "KernelOfActionOnClassPartitionHNFMat",
                  IsIntegralRcwaGroup );

#############################################################################
##
#A  IsomorphismIntegralRcwaGroup( <G> ) . . . . .  rcwa representation of <G>
#A  IsomorphismRcwaGroup( <G> )
##
##  A faithful integral rcwa representation of the group <G>.
##
DeclareAttribute( "IsomorphismIntegralRcwaGroup", IsGroup );
DeclareSynonym( "IsomorphismRcwaGroup", IsomorphismIntegralRcwaGroup );

#############################################################################
##
#F  IntegralRcwaGroupByPermGroup( <G> ) . . . .  rcwa group isomorphic to <G>
#F  RcwaGroupByPermGroup( <G> )
##
##  Constructs an integral rcwa group isomorphic to the permutation
##  group <G>, which acts on [ 1 .. LargestMovedPoint( <G> ) ] as <G> does.
##
DeclareGlobalFunction( "IntegralRcwaGroupByPermGroup" );
DeclareSynonym( "RcwaGroupByPermGroup", IntegralRcwaGroupByPermGroup );

#############################################################################
##
#A  ModulusOfRcwaGroup( <G> ) . . . . . . . . . modulus of the rcwa group <G>
##
DeclareAttribute( "ModulusOfRcwaGroup", IsRcwaGroup );

#############################################################################
##
#A  PrimeSet( <G> ) . . . . . . . . . . . . . prime set of the rcwa group <G>
##
##  Prime set of rcwa group <G>.
##
##  We define the prime set of an rcwa group <G> as the union of the prime
##  sets of its elements.
##
DeclareAttribute( "PrimeSet", IsRcwaGroup );

#############################################################################
##
#P  IsTame( <G> ) . . . . . indicates whether or not <G> is a tame rcwa group
##
##  We say that an $R$-rcwa group is *tame* if and only if its modulus is
##  strictly positive, and *wild* otherwise.
##
DeclareProperty( "IsTame", IsRcwaGroup );

############################################################################# 
## 
#P  IsFlat( <G> ) . . . . . indicates whether or not <G> is a flat rcwa group 
## 
##  We say that an $R$-rcwa group is *flat* if and only if all of its
##  elements are flat.
## 
DeclareProperty( "IsFlat", IsRcwaGroup ); 

############################################################################# 
## 
#P  IsClassWiseOrderPreserving( <G> ) .  is <G> class-wise order-preserving ?
##
##  Indicates whether <G> is class-wise order-preserving or not.
##  
##  We say that an integral rcwa group <G> is *class-wise order-preserving*
##  if all of its elements are.
##
DeclareProperty( "IsClassWiseOrderPreserving", IsIntegralRcwaGroup ); 

#############################################################################
##
#A  RcwaBase( <G> ) . . . . . . . . . . . . . . . . . . . .  <internal stuff>
##
##  A set of representatives for a set of orbits on which the rcwa group <G>
##  acts faithfully. Used for element testing, etc.. Only useful for finite
##  rcwa groups.
##
DeclareAttribute( "RcwaBase", IsRcwaGroup );

############################################################################# 
## 
#O  ShortOrbits( <G>, <S>, <maxlng> ) . . . .  short orbits of rcwa group <G>
## 
##  Computes all finite orbits of the rcwa group <G> of maximal length
##  <maxlng>, which intersect non-trivially with the set <S>.
##
DeclareOperation( "ShortOrbits", [ IsGroup, IsListOrCollection, IsPosInt ] );

############################################################################# 
## 
#O  OrbitUnion( <G>, <S> ) . . . . . . .  union of the orbit of <S> under <G>
## 
##  Computes the union of the elements of the orbit of the set <S> under
##  the rcwa group <G>. In particular, <S> can be a union of residue classes.
##
DeclareOperation( "OrbitUnion", [ IsRcwaGroup, IsListOrCollection ] );

#############################################################################
##
#F  NrConjugacyClassesOfRCWAZOfOrder( <ord> ) . #Ccl of RCWA(Z) / order <ord>
##
##  Computes the number of conjugacy classes of the whole group RCWA(Z) of
##  elements of order <ord>.
##
DeclareGlobalFunction( "NrConjugacyClassesOfRCWAZOfOrder" );

#############################################################################
##
#E  rcwagrp.gd . . . . . . . . . . . . . . . . . . . . . . . . . .  ends here
