#############################################################################
##
#W  general.g                 GAP4 Package `RCWA'                 Stefan Kohl
##
#H  @(#)$Id$
##
##  This file contains some more general pieces of code which are not direct-
##  ly related to RCWA. Some of them might perhaps later be moved into the
##  GAP Library or elsewhere.
##
Revision.general_g :=
  "@(#)$Id$";

#############################################################################
##
#M  \*( <n>, infinity ) . . . . . . . . . . for positive integer and infinity
#M  \*( infinity, <n> ) . . . . . . . . . . for infinity and positive integer
#M  \*( infinity, infinity )  . . . . . . . . . . . for infinity and infinity
##
##  In GAP 4.4.7, the GAP Library function `DirectProduct' and the general
##  method for `DirectProductOp' run into error if one of the factors is
##  known to be infinite. The methods below are installed as a workaround.
##  As maybe there are further similar places where finiteness is assumed
##  implicitly, it may be good if these methods remain available after 4.4.8.
##
InstallMethod( \*, "for positive integer and infinity (RCWA)",
               ReturnTrue, [ IsPosInt, IsInfinity ], 0,
               function ( n, infty ) return infinity; end );
InstallMethod( \*, "for infinity and positive integer (RCWA)",
               ReturnTrue, [ IsInfinity, IsPosInt ], 0,
               function ( infty, n ) return infinity; end );
InstallMethod( \*, "for infinity and infinity (RCWA)",
               ReturnTrue, [ IsInfinity, IsInfinity ], 0,
               function ( infty1, infty2 ) return infinity; end );

#############################################################################
##
#F  SearchCycle( <l> ) . . . a utility function for detecting cycles in lists
##
DeclareGlobalFunction( "SearchCycle" );
InstallGlobalFunction( SearchCycle,

  function ( l )

    local  pos, incr, refine;

    if Length(l) < 2 then return fail; fi;
    pos := 1; incr := 1;
    while Length(Set(List([1..Int((Length(l)-pos+1)/incr)],
                          i->l{[pos+(i-1)*incr..pos+i*incr-1]}))) > 1 do
      pos := pos + 1; incr := incr + 1;
      if pos + 2*incr-1 > Length(l) then return fail; fi;
    od;
    refine := SearchCycle(l{[pos..pos+incr-1]});
    if refine <> fail then return refine;
                      else return l{[pos..pos+incr-1]}; fi;
  end );

#############################################################################
##
#O  AllProducts( <D>, <k> ) . . all products of <k>-tuples of elements of <D>
#M  AllProducts( <l>, <k> ) . . . . . . . . . . . . . . . . . . . . for lists
##
DeclareOperation( "AllProducts", [ IsListOrCollection, IsPosInt ] );
InstallMethod( AllProducts,
               "for lists (RCWA)", ReturnTrue, [ IsList, IsPosInt ], 0,
               function ( l, k ) return List(Tuples(l,k),Product); end );

#############################################################################
##
#O  GeneratorsAndInverses( <D> ) list of generators of <D> and their inverses
#M  GeneratorsAndInverses( <G> ) . . . . . . . . . . . . . . . . . for groups
##
DeclareOperation( "GeneratorsAndInverses", [ IsMagmaWithInverses ] );
InstallMethod( GeneratorsAndInverses,
               "for groups (RCWA)", true, [ IsGroup ], 0,
               G -> Concatenation(GeneratorsOfGroup(G),
                                  List(GeneratorsOfGroup(G),g->g^-1)) );

#############################################################################
##
#F  EpimorphismByGenerators( <D1>, <D2> ) .  epi.: gen's of <F>->gen's of <G>
#O  EpimorphismByGeneratorsNC( <D1>, <D2> ) .  NC version as underlying oper.
#M  EpimorphismByGeneratorsNC( <G>, <H> ) . . . . . . . . . . . .  for groups
##
DeclareOperation( "EpimorphismByGeneratorsNC", [ IsDomain, IsDomain ] );
InstallMethod( EpimorphismByGeneratorsNC,
               "for groups (RCWA)", ReturnTrue, [ IsGroup, IsGroup ], 0,
  function ( G, H )
    return GroupHomomorphismByImagesNC(G,H,GeneratorsOfGroup(G),
                                           GeneratorsOfGroup(H));
  end );
DeclareGlobalFunction( "EpimorphismByGenerators" );
InstallGlobalFunction( EpimorphismByGenerators,
  function ( D1, D2 )
    return EpimorphismByGeneratorsNC(D1,D2);
  end );

#############################################################################
##
#M  IsCyclic( <G> ) . . . . . . . . . . . . . . . . default method for groups
##
InstallMethod( IsCyclic, "default method for groups (RCWA)", true,
               [ IsGroup ], 50,

  function ( G )
    if   HasIsFinitelyGeneratedGroup(G) and not IsFinitelyGeneratedGroup(G)
    then return false; fi;
    if   HasGeneratorsOfGroup(G) and Length(GeneratorsOfGroup(G)) = 1
    then return true;
    else TryNextMethod(); fi;
  end );

#############################################################################
##
#M  AbelianInvariants( <G> ) . .  for groups knowing an iso. to a pcp group
#M  AbelianInvariants( <G> ) . .  for groups knowing an iso. to a perm.-group
##
InstallMethod( AbelianInvariants,
               "for groups knowing an isomorphism to a pcp group", true,
               [ IsGroup and HasIsomorphismPcpGroup ], 0,
               G -> AbelianInvariants(Image(IsomorphismPcpGroup(G))) );
InstallMethod( AbelianInvariants,
               "for groups knowing an isomorphism to a permutation group",
               true, [ IsGroup and HasIsomorphismPermGroup ], 0,
               G -> AbelianInvariants(Image(IsomorphismPermGroup(G))) );

#############################################################################
##
#F  SaveAsBitmapPicture( <picture>, <filename>, <colored> )
##
##  Writes the pixel matrix <picture> to a bitmap- (bmp-) picture file
##  named <filename>. The argument <colored> is a boolean which specifies
##  whether a 24-bit True Color picture file or a monochrome picture file
##  should be created. In the former case, <picture> must be an integer
##  matrix, with entries n = 65536*red+256*green+blue in the range 0..2^24-1
##  specifying the RGB values of the colors of the pixels. In the latter
##  case, <picture> must be a GF(2) matrix, where zeros stand for black
##  pixels and ones stand for white pixels.
##
if not IsBound( SaveAsBitmapPicture ) then
DeclareGlobalFunction( "SaveAsBitmapPicture" );
InstallGlobalFunction( SaveAsBitmapPicture,

  function ( picture, filename )

    local  AppendHex, Append16Bit, Append32Bit, str, colored,
           height, width, fullwidth, length, offset, vec8, pix,
           chunk, fill, x, y, n, i;

    Append16Bit := function ( n )
      Add(str,CHAR_INT(n mod 256)); Add(str,CHAR_INT(Int(n/256)));
    end;

    Append32Bit := function ( n )
      Add(str,CHAR_INT(n mod 256)); n := Int(n/256);
      Add(str,CHAR_INT(n mod 256)); n := Int(n/256);
      Add(str,CHAR_INT(n mod 256)); n := Int(n/256);
      Add(str,CHAR_INT(n));
    end;

    if not IsMatrix(picture) or not IsString(filename)
      or (not IsInt(picture[1][1]) and not picture[1][1] in GF(2))
    then Error("usage: SaveAsBitmapPicture( <picture>, <filename> )\n"); fi;

    colored := IsInt(picture[1][1]);
    height  := Length(picture);
    width   := Length(picture[1]);
    if colored then fullwidth := width + (width mod 4)/3;
    elif width mod 32 <> 0 then
      fullwidth := width + 32 - width mod 32;
      fill := List([1..fullwidth-width],i->Zero(GF(2)));
      ConvertToGF2VectorRep(fill);
      picture := List(picture,line->Concatenation(line,fill));
    else fullwidth := width; fi;
    str := "BM";
    if colored then offset := 54; length := 3 * fullwidth * height + offset;
               else offset := 62; length := (fullwidth * height)/8 + offset;
    fi;
    for n in [length,0,offset,40,width,height] do Append32Bit(n); od;
    Append16Bit(1);
    if colored then
      Append16Bit(24);
      for i in [1..6] do Append32Bit(0); od;
      for y in [1..height] do
        for x in [1..width] do
          pix := picture[y][x];
          Add(str,CHAR_INT(pix mod 256)); pix := Int(pix/256);
          Add(str,CHAR_INT(pix mod 256)); pix := Int(pix/256);
          Add(str,CHAR_INT(pix));
        od;
        for i in [1..width mod 4] do Add(str,CHAR_INT(0)); od;
      od;
    else # monochrome picture
      Append16Bit(1);
      for i in [1..6] do Append32Bit(0); od;
      Append32Bit(0); Append32Bit(2^24-1);
      vec8 := List([0..255],i->CoefficientsQadic(i+256,2){[8,7..1]})*Z(2)^0;
      for i in [1..256] do ConvertToGF2VectorRep(vec8[i]); od;
      for y in [1..height] do
        for x in [1,9..fullwidth-7] do
          Add(str,CHAR_INT(PositionSorted(vec8,picture[y]{[x..x+7]})-1));
        od;
      od;
    fi;
    FileString(filename,str);
  end );
fi;

#############################################################################
##
#F  ReadFromBitmapPicture( <filename> )
##
##  Reads the bitmap picture file <filename> created by `SaveAsBitmapPicture'
##  back into GAP. The function returns the pixel matrix <picture>, as it has
##  been passed as an argument to `SaveAsBitmapPicture'. The file passed to
##  this function must be an uncompressed monochrome or 24-bit True Color
##  bitmap file.
##
if not IsBound( ReadFromBitmapPicture ) then
DeclareGlobalFunction( "ReadFromBitmapPicture" );
InstallGlobalFunction( ReadFromBitmapPicture,

  function ( filename )

    local  str, picture, height, width, fullwidth, vec8, chunk, x, y, i;

    if   not IsString(filename)
    then Error("usage: ReadFromBitmapPicture( <filename> )\n"); fi;

    str    := StringFile(filename);
    width  := List(str{[19..22]},INT_CHAR) * List([0..3],i->256^i);
    height := List(str{[23..26]},INT_CHAR) * List([0..3],i->256^i);
    if INT_CHAR(str[29]) = 24 then # 24-bit RGB picture
      fullwidth := width + (width mod 4)/3;
      picture := List([1..height],
                      y->List([1..Int(fullwidth)],
                              x->List(str{[55+3*(fullwidth*(y-1)+x-1)..
                                           55+3*(fullwidth*(y-1)+x-1)+2]},
                                      INT_CHAR)
                                *[1,256,65536]));
    else # monochrome picture
      if width mod 32 = 0 then fullwidth := width;
                          else fullwidth := width + 32 - width mod 32; fi;
      vec8 := List([0..255],i->CoefficientsQadic(i+256,2){[8,7..1]})*Z(2)^0;
      for i in [1..256] do ConvertToGF2VectorRep(vec8[i]); od;
      picture := List([1..height],y->Concatenation(List([1,9..fullwidth-7],
                     x->vec8[INT_CHAR(str[63+(fullwidth*(y-1)+x-1)/8])+1])));
    fi;
    if width = fullwidth then return picture;
                         else return picture{[1..height]}{[1..width]}; fi;
  end );
fi;

#############################################################################
##
#E  general.g . . . . . . . . . . . . . . . . . . . . . . . . . . . ends here