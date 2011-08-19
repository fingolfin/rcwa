#############################################################################
##
#W  rcwaaux.g                 GAP4 Package `RCWA'                 Stefan Kohl
##
##  This file contains auxiliary functions for the RCWA package.
##
#############################################################################

#############################################################################
##
#F  RCWABuildManual( ) . . . . . . . . . . . . . . . . . . . build the manual
##
##  This function builds the manual of the RCWA package in the file formats
##  LaTeX, PDF, HTML and ASCII-text.
##
##  This is done using the GAPDoc package by Frank L�beck and Max Neunh�ffer.
##
BindGlobal( "RCWABuildManual", 

  function ( )

    local  RCWADir;

    RCWADir := GAPInfo.PackagesInfo.("rcwa")[1].InstallationPath;
    MakeGAPDocDoc( Concatenation( RCWADir, "/doc/" ), "rcwa.xml",
                   [ "../gap/rcwaaux.g",
                     "../gap/rcwamap.gd", "../gap/rcwamap.gi",
                     "../gap/rcwagrp.gd", "../gap/rcwagrp.gi" ],
                     "RCWA", "../../../" );
  end );

#############################################################################
##
#F  RCWATestInstall( ) . . . . .  RCWA test suite
##
##  Performs a nontrivial computation to check whether an installation of
##  RCWA appears to work.
##
BindGlobal( "RCWATestInstall",

  function ( )

    local  RCWADir, dir;

    RCWADir := GAPInfo.PackagesInfo.("rcwa")[1].InstallationPath;
    dir := Concatenation( RCWADir, "/tst/" );
    ReadTest( Concatenation( dir, "testinstall.tst" ) );
  end );

#############################################################################
##
#F  RCWATestAll( ) . . . . . . . . . . . . . . . . . . . . .  RCWA test suite
##
##  Runs the full test suite of the RCWA package.
##
##  The function makes use of an adaptation of the test file tst/testall.g
##  of the GAP Library to this package. 
##
BindGlobal( "RCWATestAll",

  function ( )

    local  RCWADir, dir;

    RCWADir := GAPInfo.PackagesInfo.("rcwa")[1].InstallationPath;
    dir := Concatenation( RCWADir, "/tst/" );
    Read( Concatenation( dir, "testall.g" ) );
  end );

#############################################################################
##
#F  RCWADoThingsToBeDoneBeforeTest(  )
#F  RCWADoThingsToBeDoneAfterTest(  )
##
BindGlobal( "RCWADoThingsToBeDoneBeforeTest",

  function (  )
    RESCLASSES_WARNINGLEVEL_BUFFER := InfoLevel(InfoWarning);;
    SetInfoLevel(InfoWarning,0);
    RESCLASSES_VIEWINGFORMAT_BUFFER := RESCLASSES_VIEWINGFORMAT;;
    ResidueClassUnionViewingFormat("short");
    CallFuncList(HideGlobalVariables,ONE_LETTER_GLOBALS);
  end );

BindGlobal( "RCWADoThingsToBeDoneAfterTest",

  function (  )
    CallFuncList(UnhideGlobalVariables,ONE_LETTER_GLOBALS);
    ResidueClassUnionViewingFormat(RESCLASSES_VIEWINGFORMAT_BUFFER);
    SetInfoLevel(InfoWarning,RESCLASSES_WARNINGLEVEL_BUFFER);
  end );

#############################################################################
##
#F  RCWALoadExamples( ) . . . . . . . . . . . . . . . . .  read examples file
##
BindGlobal( "RCWALoadExamples", function ( )
                                  ReadPackage("rcwa","examples/examples.g");
                                end );

#############################################################################
##
#F  RCWALoadDatabaseOfProductsOf2ClassTranspositions( )
##
##  This function loads the data library of products of 2 class transposi-
##  tions which interchange residue classes with moduli <= 6.
##
BindGlobal( "RCWALoadDatabaseOfProductsOf2ClassTranspositions",
            function ( )
              ReadPackage("rcwa","data/ctprodclass.g");
              ReadPackage("rcwa","data/ctprods.g");
            end );

#############################################################################
##
#F  RCWALoadDatabaseOfGroupsGeneratedBy3ClassTranspositions( )
##
##  This function loads the data library of groups generated by 3 class
##  transpositions which interchange residue classes with moduli <= 6.
##  It returns a record containing all data in the library.
##
BindGlobal( "RCWALoadDatabaseOfGroupsGeneratedBy3ClassTranspositions",

  function ( )
    return ReadAsFunction(
             Concatenation(PackageInfo("rcwa")[1].InstallationPath,
                           "/data/3ctsgrpdata.g"))();
  end );

#############################################################################
##
#F  RCWACheckDatabaseOfGroupsGeneratedBy3ClassTranspositions( startmod )
##
##  This function checks the data library of groups generated by 3 class
##  transpositions which interchange residue classes with moduli <= 6.
##  It raises an error if there is a difference between a database entry and
##  the result of an attempt to recompute that entry. The function runs rela-
##  tively long, and it is recommended to set the `InfoLevel' of `InfoRCWA'
##  to 2 in order to get information on the progress of the checks.
##
BindGlobal( "RCWACheckDatabaseOfGroupsGeneratedBy3ClassTranspositions",

  function ( startmod )

    local  data, cts, grps, sizes, mods, modset, errors,
           pos, i, m, n, m0, n0;

    Info(InfoRCWA,2,"Checking database of groups generated by 3 class ",
                    "transpositions ...");

    data := RCWALoadDatabaseOfGroupsGeneratedBy3ClassTranspositions();

    cts  := List(ClassPairs(6),ClassTransposition);;
    grps := List(Combinations(cts,3),Group);;

    if   cts <> data.cts or grps <> data.grps
    then Error("*** List of groups is corrupted !!! ***"); fi;

    mods  := data.mods;
    sizes := data.sizes;

    modset := Filtered(Set(mods),m->m>=startmod);
    errors := [];

    for m in modset do
      Info(InfoRCWA,2,"Checking groups with modulus m = ",m);
      pos := Positions(mods,m);
      Info(InfoRCWA,2,"There are ",Length(pos)," such groups.");
      Info(InfoRCWA,2,"They have ",Length(Set(sizes{pos})),
                      " different orders.");
      for i in pos do
        n  := sizes[i];
        m0 := Mod(grps[i]:AssumeIsTame);
        n0 := Size(grps[i]);
        Info(InfoRCWA,2,"|grps[",i,"]| = ",n0);
        if m0 <> m or n0 <> n then
          if m0 <> m then Error("** Modulus discrepancy !!! ***"); fi;
          if n0 <> n then Error("** Order discrepancy !!! ***"); fi;
          Add(errors,rec(i:=i,m_wrong:=m ,n_wrong:=n,
                              m_right:=m0,n_right:=n0));
          Print("Errors =\n",errors,"\n");
        fi;
      od;
    od;

    return errors;
  end );

ResidueClassUnionViewingFormat( "short" );

#############################################################################
##
#E  rcwaaux.g . . . . . . . . . . . . . . . . . . . . . . . . . . . ends here