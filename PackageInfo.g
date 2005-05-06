####################################################################################################
##
##  PackageInfo.g                         GAP4 Package `RCWA'                            Stefan Kohl
##  
#H  @(#)$Id$
##

SetPackageInfo( rec(

PackageName      := "RCWA",
Subtitle         := "Residue Class-Wise Affine Groups",
Version          := "1.0.0",
Date             := "26/04/2005",
ArchiveURL       := "http://www.cip.mathematik.uni-stuttgart.de/~kohlsn/rcwa/rcwa-1.0.0",
ArchiveFormats   := ".tar.gz",
Persons          := [
                      rec( LastName      := "Kohl",
                           FirstNames    := "Stefan",
                           IsAuthor      := true,
                           IsMaintainer  := true,
                           Email         := "kohl@mathematik.uni-stuttgart.de",
                           WWWHome       := "http://www.cip.mathematik.uni-stuttgart.de/~kohlsn/",
                           PostalAddress := Concatenation("Stefan Kohl\n",
                                                          "Institut f�r Geometrie und Topologie\n",
                                                          "Pfaffenwaldring 57\n",
                                                          "Universit�t Stuttgart\n",
                                                          "70550 Stuttgart\n",
                                                          "Germany"),
                           Place         := "Stuttgart / Germany",
                           Institution   := "University of Stuttgart"
                         )
                    ],
Status           := "accepted",
CommunicatedBy   := "Bettina Eick (Braunschweig)",
AcceptDate       := "04/2005",
README_URL       := "http://www.cip.mathematik.uni-stuttgart.de/~kohlsn/rcwa/README.rcwa",
PackageInfoURL   := "http://www.cip.mathematik.uni-stuttgart.de/~kohlsn/rcwa/PackageInfo.g",
AbstractHTML     := Concatenation("<p>This package provides methods for computations with the ",
                                  "so-called <strong>R</strong>esidue ",
                                  "<strong>C</strong>lass-<strong>W</strong>ise ",
                                  "<strong>A</strong>ffine mappings (<em>rcwa</em> mappings for ",
                                  "short) and the groups generated by bijective mappings of this ",
                                  "type.</p>\n",
                                  "<p>The rcwa mappings are a type of mappings of certain ",
                                  "euclidian rings <em>R</em> into themselves, e.g. the integers ",
                                  "form an example for a possible ring&nbsp;<em>R</em>.",
                                  "Similar classes of mappings are known as <em>Generalized ",
                                  "Collatz Mappings</em>, <em>Periodically Linear Functions</em> ",
                                  "or <em>Number Theoretic Functions with Periodic Rational ",
                                  "Coefficients</em>. In fact, the development of this package ",
                                  "has partially been motivated by the 3<em>n</em>+1 - conjecture.",
                                  " A regularly updated comprehensive annotated bibliography for ",
                                  "this conjecture is <a href = ",
                                  "\"http://arxiv.org/abs/math.NT/0309224\" target = \"_parent\">",
                                  "[Lag04]</a>.</p>\n",
                                  "<p> The bijective rcwa mappings of <em>R</em> form a proper ",
                                  "subgroup of Sym(<em>R</em>), called RCWA(<em>R</em>). ",
                                  "In general, the computation with arbitrary mappings from&nbsp;R",
                                  " into&nbsp;R is an algorithmically difficult task. ",
                                  "The rcwa mappings provide a class of mappings which are ",
                                  "accessible to computations. The investigation of rcwa mappings ",
                                  "and groups generated by them is the central aim of this ",
                                  "package. </p>\n",
                                  "<p>An object of particular interest is the group RCWA(Z) of ",
                                  "all residue class-wise affine bijections of the integers.</p>"),
PackageWWWHome   := "http://www.cip.mathematik.uni-stuttgart.de/~kohlsn/rcwa.html",
PackageDoc       := rec(
                         BookName  := "RCWA",
                         ArchiveURLSubset := ["doc"],
                         HTMLStart := "doc/chap0.html",
                         PDFFile   := "doc/manual.pdf",
                         SixFile   := "doc/manual.six",
                         LongTitle := "[R]esidue [C]lass-[W]ise [A]ffine groups",
                         Autoload  := false
                       ),
Dependencies     := rec(
                         GAP                    := ">=4.4",
                         NeededOtherPackages    := [ ["ResClasses", ">=2.0.4"], ["GRAPE",">=4.0"],
                                                     ["GAPDoc",">=0.999"] ],
                         SuggestedOtherPackages := [ ],
                         ExternalConditions     := [ ]
                       ),
AvailabilityTest := ReturnTrue,
BannerString     := Concatenation( "\nLoading RCWA ", ~.Version,
                                   " ([R]esidue [C]lass-[W]ise [A]ffine groups)",
                                   "\nby Stefan Kohl, kohl@mathematik.uni-stuttgart.de\n\n" ),
Autoload         := false,
TestFile         := "tst/testall.g",
Keywords         := [ "infinite permutation groups", "permutation groups over rings",
                      "residue class-wise affine groups", "residue class-wise affine mappings",
                      "Collatz conjecture", "3n+1 conjecture" ]

) );

####################################################################################################
##
#E  PackageInfo.g  . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . ends here