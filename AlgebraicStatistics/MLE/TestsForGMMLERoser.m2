restart;

installPackage("GraphicalModelsMLE")
check GraphicalModelsMLE
help GraphicalModelsMLE

----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------

--EXAMPLE 2.1.13 OWL
restart
needsPackage("GraphicalModelsMLE")
debug needsPackage("GraphicalModelsMLE")
G=graph{{1,2},{2,3},{3,4},{1,4}}
R=gaussianRing(G)
U=random(ZZ^4,ZZ^4)
U = {matrix{{1,2,1,-1}}, matrix{{2,1,3,0}}, matrix{{-1, 0, 1, 1}}, matrix{{-5, 3, 4, -6}}}
U = {{1,2,1,-1},{2,1,3,0},{-1, 0, 1, 1},{-5, 3, 4, -6}}
--Generate score equations for an undirected graph on 4 nodes  with random observations
J=time scoreEquations(R,U)
J=time scoreEquations(R,U,doSaturate=>false)
J=time scoreEquations(R,U,saturateOptions=>{Strategy=>Eliminate})
J=time scoreEquations(R,U,saturateOptions=>{Strategy=>Bayer})
solverMLE(G,U)
solverMLE(G,U,concentrationMatrix=>false)


--piecewise
restart
debug needsPackage("GraphicalModelsMLE")
G=graph{{1,2},{2,3},{3,4},{1,4}}
R=gaussianRing(mixedGraph(G))
U = {{1,2,1,-1},{2,1,3,0},{-1, 0, 1, 1},{-5, 3, 4, -6}}
(J,Sinv)=scoreEquationsInternal(R,U)
sols=zeroDimSolve(J)
M=genListMatrix(sols,Sinv)
L=checkPD M
V=sampleCovarianceMatrix(U)
optSols=maxMLE(L,V)
optSols_1
optSols_0
inverse optSols_1

solverMLE(G,U,concentrationMatrix=>false)

-- test for undirected as  mixedGraph
restart
needsPackage("GraphicalModelsMLE")
G=graph{{1,2},{2,3},{3,4},{1,4}}
g=mixedGraph G
R2=gaussianRing(g)
U = {matrix{{1,2,1,-1}}, matrix{{2,1,3,0}}, matrix{{-1, 0, 1, 1}}, matrix{{-5, 3, 4, -6}}}
U = {{1,2,1,-1},{2,1,3,0},{-1, 0, 1, 1},{-5, 3, 4, -6}}
J2=time scoreEquations(R2,U)
--with usual saturation
-- used 11.1563 seconds
--iterating saturation (denoms)
-- used 0.421875 seconds
-- redirected to Undir
-- used 0.078125 seconds
J2=time scoreEquationsFromCovarianceMatrix(R2,U,doSaturate =>false)
-- used 0.3125 seconds
-- does not enter in saturate if
--iterating saturation (denoms)
-- used 0.25 seconds
-- redirected to Undir
-- used 0.03125 seconds
J2=time scoreEquationsFromCovarianceMatrix(R2,U,saturateOptions=>{Strategy =>Eliminate})
dim J2, degree J2
test=ideal{58*k_(4,4)+47*k_(1,4)-21*k_(3,4)-8, 27*k_(3,3)+14*k_(2,3)-42*k_(3,4)-16,
     10*k_(2,2)-13*k_(1,2)+7*k_(2,3)-8, 115*k_(1,1)-26*k_(1,2)+94*k_(1,4)-16,
     49587264*k_(3,4)^2+159578097*k_(1,2)-401770875*k_(1,4)+86063425*k_(2,3)-241038399*k_(3,4)-
     9279488, 289984*k_(2,3)*k_(3,4)-2996077*k_(1,2)+3236687*k_(1,4)-1267133*k_(2,3)+2001475*k_(3
     ,4), 289984*k_(1,4)*k_(3,4)+572663*k_(1,2)-1267133*k_(1,4)+247207*k_(2,3)-713625*k_(3,4),
     289984*k_(1,2)*k_(3,4)-1267133*k_(1,2)+1588223*k_(1,4)-634637*k_(2,3)+786099*k_(3,4),
     12469312*k_(2,3)^2+159578097*k_(1,2)-401770875*k_(1,4)+94182977*k_(2,3)-216679743*k_(3,4)-
     9279488, 289984*k_(1,4)*k_(2,3)-1428105*k_(1,2)+2001475*k_(1,4)-713625*k_(2,3)+983079*k_(3,4
     ), 289984*k_(1,2)*k_(2,3)+2001475*k_(1,2)-3960705*k_(1,4)+786099*k_(2,3)-2523789*k_(3,4),
     163260992*k_(1,4)^2+159578097*k_(1,2)-347253883*k_(1,4)+86063425*k_(2,3)-216679743*k_(3,4)-
     9279488, 289984*k_(1,2)*k_(1,4)-713625*k_(1,2)+786099*k_(1,4)-302505*k_(2,3)+482391*k_(3,4),
     58866752*k_(1,2)^2+144498929*k_(1,2)-401770875*k_(1,4)+86063425*k_(2,3)-216679743*k_(3,4)-
     9279488};

J2==test
--Find the optimal covariance matrix
MLEsolver(J2,R2)

----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------
    
--EXAMPLE 3.2.1 OWL
restart
needsPackage("GraphicalModelsMLE")
 G=graph{{1,2},{2,4},{3,4},{2,3}}
 R=gaussianRing(G)
-- U=random(ZZ^4,ZZ^4)
U = {matrix{{1,2,1,-1}}, matrix{{2,1,3,0}}, matrix{{-1, 0, 1, 1}}, matrix{{-5, 3, 4, -6}}}
--Generate score equations for an undirected graph on 4 nodes  with random observations
J=time scoreEquationsFromCovarianceMatrixUndir(R,U)
dim J, degree J
aux=toExternalString J
test=ideal{8*k_(3,4)-7, 8*k_(2,3)-7, 32*k_(2,4)-75, 203*k_(1,2)-52, 32*k_(4,4)-43, 2*k_(3,3)-3, 32480*k_(2,2)-184381, 203*k_(1,1)-40}

-- test for undirected as  mixedGraph
restart
needsPackage("GraphicalModelsMLE")
G=graph{{1,2},{2,4},{3,4},{2,3}}
g=mixedGraph G
R2=gaussianRing(g)
U = {matrix{{1,2,1,-1}}, matrix{{2,1,3,0}}, matrix{{-1, 0, 1, 1}}, matrix{{-5, 3, 4, -6}}}
J2=time scoreEquationsFromCovarianceMatrix(R2,U)
-- used 0.328125 seconds
-- used 0.234375 seconds
J2=time scoreEquationsFromCovarianceMatrix(R2,U,doSaturate =>false)
--does not enter in if saturate
-- used 0.1875 seconds
-- used 0.140625 seconds

dim J2, degree J2
test=ideal{8*k_(3,4)-7, 8*k_(2,3)-7, 32*k_(2,4)-75, 203*k_(1,2)-52, 32*k_(4,4)-43, 2*k_(3,3)-3, 32480*k_(2,2)-184381, 203*k_(1,1)-40}
J2==test
--Find the optimal covariance matrix
MLEsolver(J2,R2)


----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------


--EXAMPLE 3.2.8 OWL: chain graph from figure 3.2.5(a) turned into an undirected graph
restart
needsPackage("GraphicalModelsMLE")
G=graph{{2,3},{3,4},{1,3}}
R=gaussianRing(G)
undirectedEdgesMatrix(R)
U = {matrix{{1,2,1,-1}}, matrix{{2,1,3,0}}, matrix{{-1, 0, 1, 1}}, matrix{{-5, 3, 4, -6}}}
--U=random(ZZ^4,ZZ^4)
J=time scoreEquationsFromCovarianceMatrixUndir(R,U)
 -- used 0.03125 seconds
dim J, degree J
aux=toExternalString J
test=ideal{57*k_(3,4)-28, 43*k_(2,3)+28, 283*k_(1,3)-58, 19*k_(4,4)-6, 6242697*k_(3,3)-11951602, 43*k_(2,2)-54, 283*k_(1,1)-54}
J==test

MLEsolver(J,R)

-- test for undirected as  mixedGraph
restart
needsPackage("GraphicalModelsMLE")
G=graph{{2,3},{3,4},{1,3}}
g=mixedGraph(G)
R2=gaussianRing(g)
U = {matrix{{1,2,1,-1}}, matrix{{2,1,3,0}}, matrix{{-1, 0, 1, 1}}, matrix{{-5, 3, 4, -6}}}
--U=random(ZZ^4,ZZ^4)
J2=time scoreEquationsFromCovarianceMatrix(R2,U)
-- used 0.078125 seconds (iterated saturation) 
J2=time scoreEquationsFromCovarianceMatrix(R2,U,doSaturate =>false)
--does not enter in if saturate
-- used 0.078125 seconds
dim J2, degree J2
test=ideal{57*k_(3,4)-28, 43*k_(2,3)+28, 283*k_(1,3)-58, 19*k_(4,4)-6, 6242697*k_(3,3)-11951602, 43*k_(2,2)-54, 283*k_(1,1)-54}
J2==test


--EXAMPLE 3.2.11 OWL: chain graph from figure 3.2.5(b) turned into an undirected graph
restart
needsPackage("GraphicalModelsMLE")
G=graph{{1,2},{2,5},{5,6},{2,4},{4,5},{3,4}}
R=gaussianRing(G)
--undirectedEdgesMatrix(R)
--U=random(ZZ^6,ZZ^6)
--auxU=toExternalString U
U=matrix{{1, 2, 9, 6, 0, 0}, {2, 7, 7, 3, 2, 2}, {6, 3, 4, 1, 5, 5}, {5, 5, 8, 8, 7, 6}, {3, 2, 3, 8, 7, 5}, {8, 0, 5, 3, 8, 5}}
J=time scoreEquationsFromCovarianceMatrixUndir(R,U)
-- used 0.09375 seconds
dim J, degree J
aux=toExternalString J
test=ideal{452*k_(5,6)+627, 28733*k_(4,5)+639, 1703*k_(3,4)+72, 28733*k_(2,4)+309,
       28733*k_(2,5)-1781, 524*k_(1,2)-51, 452*k_(6,6)-915, 3961131380*k_(5,5)-4311459839, 12575600843*k_(4,4)-1906007136, 3406*k_(3,3)-771, 557075404*k_(2,2)-148839607, 524*k_(1,1)-111}
J==test

MLEsolver(J,R)

-- test for undirected as  mixedGraph
restart
needsPackage("GraphicalModelsMLE")
G=graph{{1,2},{2,5},{5,6},{2,4},{4,5},{3,4}}
g=mixedGraph G
R2=gaussianRing(g)
--U=matrix{{1, 2, 9, 6, 0, 0}, {2, 7, 7, 3, 2, 2}, {6, 3, 4, 1, 5, 5}, {5, 5, 8, 8, 7, 6}, {3, 2, 3, 8, 7, 5}, {8, 0, 5, 3, 8, 5}}
U={matrix{{1, 2, 9, 6, 0, 0}},matrix{{2, 7, 7, 3, 2, 2}},matrix{{6, 3, 4, 1, 5, 5}},matrix{{5, 5, 8, 8, 7, 6}},matrix{{3, 2, 3, 8, 7, 5}},matrix{{8, 0, 5, 3, 8, 5}}}
J2=time scoreEquationsFromCovarianceMatrix(R2,U,doSaturate =>false);
-- used 3.23437 seconds
J2=time scoreEquationsFromCovarianceMatrix(R2,U);
--Enters in saturate if
-- used 2.9375 seconds
J2=time scoreEquationsFromCovarianceMatrix(R2,U,doSaturate=>true,saturateOptions=>{Strategy => Bayer});
J2=time scoreEquationsFromCovarianceMatrix(R2,U,saturateOptions=>{Strategy => Eliminate});


dim J2, degree J2
test=ideal{452*k_(5,6)+627, 28733*k_(4,5)+639, 1703*k_(3,4)+72, 28733*k_(2,4)+309,
       28733*k_(2,5)-1781, 524*k_(1,2)-51, 452*k_(6,6)-915, 3961131380*k_(5,5)-4311459839, 12575600843*k_(4,4)-1906007136, 3406*k_(3,3)-771, 557075404*k_(2,2)-148839607, 524*k_(1,1)-111}
J2==test

----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------

--EXAMPLE 3.3.7 OWL
restart
needsPackage("GraphicalModelsMLE")
G=graph{{1,2},{1,3},{1,4}}
R=gaussianRing(G)
undirectedEdgesMatrix(R)
--U=random(ZZ^4,ZZ^4)
U = {matrix{{1,2,1,-1}}, matrix{{2,1,3,0}}, matrix{{-1, 0, 1, 1}}, matrix{{-5, 3, 4, -6}}}
J=scoreEquationsFromCovarianceMatrixUndir(R,U)
dim J, degree J
aux=toExternalString J
test=ideal{563*k_(1,4)+188, 283*k_(1,3)-58, 203*k_(1,2)-52, 563*k_(4,4)-230, 283*k_(3,3)-230,
     203*k_(2,2)-230, 3719535505*k_(1,1)-1940386226}
J==test
MLEsolver(J,R)

-- test for undirected as  mixedGraph
restart
needsPackage("GraphicalModelsMLE")
G=graph{{1,2},{1,3},{1,4}}
g=mixedGraph G
R2=gaussianRing(g)
U = {matrix{{1,2,1,-1}}, matrix{{2,1,3,0}}, matrix{{-1, 0, 1, 1}}, matrix{{-5, 3, 4, -6}}}
J2=time scoreEquationsFromCovarianceMatrix(R2,U)
 -- used 0.046875 seconds
J2=time scoreEquationsFromCovarianceMatrix(R2,U,doSaturate=>false)
-- does not enter in saturate if
-- used 0.03125 seconds
dim J2, degree J2
test=ideal{563*k_(1,4)+188, 283*k_(1,3)-58, 203*k_(1,2)-52, 563*k_(4,4)-230, 283*k_(3,3)-230,
     203*k_(2,2)-230, 3719535505*k_(1,1)-1940386226}
J2==test

----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------


--7.4 OWL conjecture on maximum likelihood of degree of Gaussian cycles
restart
needsPackage("GraphicalModelsMLE")
m=5;
L={{1,m}};
for l from 1 to m-1 do(L=L|{{l,l+1}});
G=graph(L)
R=gaussianRing(G)
undirectedEdgesMatrix(R)
--U=random(ZZ^m,ZZ^m)
U=matrix{{1, 2, 9, 6, 0}, {2, 7, 7, 3, 2}, {6, 3, 4, 1, 5}, {5, 5, 8, 8, 7}, {3, 2, 3, 8, 7}, {8, 0, 5, 3, 8}}
J=time scoreEquationsFromCovarianceMatrixUndir(R,U)
-- used 1.48437 seconds
dim J, degree J
toExternalString J
test=ideal{305*k_(5,5)+199*k_(1,5)+41*k_(4,5)-36, 257*k_(4,4)+48*k_(3,4)+41*k_(4,5)-36,
     28*k_(3,3)+11*k_(2,3)+8*k_(3,4)-6, 185*k_(2,2)-85*k_(1,2)+66*k_(2,3)-36,
     209*k_(1,1)+199*k_(1,5)-85*k_(1,2)-36,
     3406*k_(3,4)^2-6392*k_(4,5)^2+144*k_(3,4)-123*k_(4,5),
     2227*k_(2,3)^2-6392*k_(4,5)^2+198*k_(2,3)-123*k_(4,5),
     2620*k_(1,2)^2-6392*k_(4,5)^2-255*k_(1,2)-123*k_(4,5),
     2012*k_(1,5)^2-6392*k_(4,5)^2+597*k_(1,5)-123*k_(4,5),
     1232865467558324938965035419343798721272*k_(4,5)^3+49314206990304115444167486486990940160*k
     _(1,5)*k_(1,2)-66034939236722969017488147375301853056*k_(1,5)*k_(2,3)+
     101480174190711264899182282038290960000*k_(1,2)*k_(2,3)+
     196906658022102480415854097305593942720*k_(1,5)*k_(3,4)-
     187726497717751381089219293824842694720*k_(1,2)*k_(3,4)+
     143157403472268769068291373037108357720*k_(2,3)*k_(3,4)-
     84543304865167105920848914629360767264*k_(1,5)*k_(4,5)+
     183228656933459435380234955496478064480*k_(1,2)*k_(4,5)-
     213271753754471921978059643953636418086*k_(2,3)*k_(4,5)+
     215303976662673822393874051870472769740*k_(3,4)*k_(4,5)-
     68472826116771625864196199075967753669*k_(4,5)^2-22604764396938048726119378507789481756*k_(4
     ,5)+778882534268141781206547660138747744,
     1232865467558324938965035419343798721272*k_(3,4)*k_(4,5)^2-
     94626667390818598857677355004516323200*k_(1,5)*k_(1,2)+
     59139502140500375780990993615832838480*k_(1,5)*k_(2,3)-
     33532156886052038330578766164427956720*k_(1,2)*k_(2,3)-
     84543304865167105920848914629360767264*k_(1,5)*k_(3,4)+
     183228656933459435380234955496478064480*k_(1,2)*k_(3,4)-
     213271753754471921978059643953636418086*k_(2,3)*k_(3,4)+
     369532401079647403058760830880022455040*k_(1,5)*k_(4,5)-
     352304102587159961222046308317203319040*k_(1,2)*k_(4,5)+
     268661809452361119167503950808337235040*k_(2,3)*k_(4,5)-
     22374519088605308591304970894422609413*k_(3,4)*k_(4,5)+
     808116863668708791979825566386413355360*k_(4,5)^2-20830643068882836891148908837473445228*k_(
     3,4)+15550434016153188581589259177961333340*k_(4,5)-6827019811969692548014796712275707320,
     1232865467558324938965035419343798721272*k_(2,3)*k_(4,5)^2+
     297789670695405477981043444338374725120*k_(1,5)*k_(1,2)-
     84543304865167105920848914629360767264*k_(1,5)*k_(2,3)+
     183228656933459435380234955496478064480*k_(1,2)*k_(2,3)+
     90448650332529986488574460824214929440*k_(1,5)*k_(3,4)-
     51284475237491352740885171780889816160*k_(1,2)*k_(3,4)+
     215303976662673822393874051870472769740*k_(2,3)*k_(3,4)-
     189535398114563636263935445901629746176*k_(1,5)*k_(4,5)+
     291271339661888821390019374399980160000*k_(1,2)*k_(4,5)-
     22374519088605308591304970894422609413*k_(2,3)*k_(4,5)+
     410894532103611123432653101236280477120*k_(3,4)*k_(4,5)-
     1224277548269945689522907269107897606112*k_(4,5)^2-20830643068882836891148908837473445228*k
     _(2,3)-23558532296183247780243678676513048428*k_(4,5)+10342770276373133171814297955542313944
     , 1232865467558324938965035419343798721272*k_(1,2)*k_(4,5)^2-
     84543304865167105920848914629360767264*k_(1,5)*k_(1,2)+
     253121220091094656283886927687618516352*k_(1,5)*k_(2,3)-
     213271753754471921978059643953636418086*k_(1,2)*k_(2,3)-
     123014667608064178514980561505871220160*k_(1,5)*k_(3,4)+
     215303976662673822393874051870472769740*k_(1,2)*k_(3,4)-
     43591803951867649829752396013756343736*k_(2,3)*k_(3,4)+
     120311607283215231266839150238490873856*k_(1,5)*k_(4,5)-
     22374519088605308591304970894422609413*k_(1,2)*k_(4,5)+
     247580638712605498181516468239983136000*k_(2,3)*k_(4,5)-
     457995333363307949588660200812364314752*k_(3,4)*k_(4,5)+
     894043950472269245000352546208769303936*k_(4,5)^2-20830643068882836891148908837473445228*k_(
     1,2)+17203912063217946986083129409211299184*k_(4,5)-7552937003363976725597471447946424032,
     1232865467558324938965035419343798721272*k_(1,5)*k_(4,5)^2+
     183228656933459435380234955496478064480*k_(1,5)*k_(1,2)-
     213271753754471921978059643953636418086*k_(1,5)*k_(2,3)+
     329611131530153081244425323330795483520*k_(1,2)*k_(2,3)+
     215303976662673822393874051870472769740*k_(1,5)*k_(3,4)-
     160188086050262498861455800768082801600*k_(1,2)*k_(3,4)+
     100113888812397753434421135315868115240*k_(2,3)*k_(3,4)-
     22374519088605308591304970894422609413*k_(1,5)*k_(4,5)+
     156668196362834943299760722477557698560*k_(1,2)*k_(4,5)-
     209788932207322672942238686890123978496*k_(2,3)*k_(4,5)+
     625560317135824579929492738557334235520*k_(3,4)*k_(4,5)-
     537177738268536919528892904881584517248*k_(4,5)^2-20830643068882836891148908837473445228*k_(
     1,5)-10336805664428980147380135685299576912*k_(4,5)+4538109803895649820801035178912009376,
     192876324711878119362489896643272641*k_(2,3)*k_(3,4)*k_(4,5)-
     11320529475611182814943123657575680*k_(1,5)*k_(1,2)+57811702296565613745112770788489120*k_(1
     ,5)*k_(2,3)-55116411543673335610457807934481120*k_(1,2)*k_(2,3)-
     29651970919049379891103793163584128*k_(1,5)*k_(3,4)+45568106955864959541617549186480000*k_(1
     ,2)*k_(3,4)-7211875317297609085245811667951368*k_(2,3)*k_(3,4)+
     26555681248540806367755273289552240*k_(1,5)*k_(4,5)-15057097838370919771252252431265360*k_(1
     ,2)*k_(4,5)+63213146407126782851988858446997290*k_(2,3)*k_(4,5)-
     95766391447899381220502758847614018*k_(3,4)*k_(4,5)+241276883208227318515944275535103040*k_(
     4,5)^2+4642843653725275371943233086798760*k_(4,5)-2038321604074511138901907208838480,
     192876324711878119362489896643272641*k_(1,2)*k_(3,4)*k_(4,5)+
     57811702296565613745112770788489120*k_(1,5)*k_(1,2)-9622450054269505392701655108939328*k_(1,
     5)*k_(2,3)+42030946409943854688282845871141620*k_(1,2)*k_(2,3)+
     18822216408513021161895987208775168*k_(1,5)*k_(3,4)-7211875317297609085245811667951368*k_(1,
     2)*k_(3,4)+38732890912485215610374916808508000*k_(2,3)*k_(3,4)-
     36117048622449846892243265268899360*k_(1,5)*k_(4,5)+63213146407126782851988858446997290*k_(1
     ,2)*k_(4,5)-12798533162615281805564414566575556*k_(2,3)*k_(4,5)+
     69934601882999784496272883777281704*k_(3,4)*k_(4,5)-268934429455847298642783441463513984*k_(
     4,5)^2-5175052381581542198539168225909296*k_(4,5)+2271974216304091696919634830887008,
     192876324711878119362489896643272641*k_(1,5)*k_(3,4)*k_(4,5)-
     55116411543673335610457807934481120*k_(1,5)*k_(1,2)+42030946409943854688282845871141620*k_(1
     ,5)*k_(2,3)-12530228201881761495466369972873280*k_(1,2)*k_(2,3)-
     7211875317297609085245811667951368*k_(1,5)*k_(3,4)+24510043235737631930500738810631680*k_(1,
     2)*k_(3,4)-32820546340319567106107429112973088*k_(2,3)*k_(3,4)+
     63213146407126782851988858446997290*k_(1,5)*k_(4,5)-47031146814522166430257134694093600*k_(1
     ,2)*k_(4,5)+29393390725894818976635682711646540*k_(2,3)*k_(4,5)-
     42019535221256016859268844249185272*k_(3,4)*k_(4,5)+367328430496667398666760269264435840*k_(
     4,5)^2+7068428809619851382354742352866960*k_(4,5)-3103212648125788411765496642722080,
     192876324711878119362489896643272641*k_(1,2)*k_(2,3)*k_(4,5)-
     29651970919049379891103793163584128*k_(1,5)*k_(1,2)+18822216408513021161895987208775168*k_(1
     ,5)*k_(2,3)-7211875317297609085245811667951368*k_(1,2)*k_(2,3)-
     14716688318294537659426060754848384*k_(1,5)*k_(3,4)+64282623921090601287961999567628360*k_(1
     ,2)*k_(3,4)-71651335006775336293595150314825456*k_(2,3)*k_(3,4)+
     113660179654734915259940245930677376*k_(1,5)*k_(4,5)-95766391447899381220502758847614018*k_(
     1,2)*k_(4,5)+69934601882999784496272883777281704*k_(2,3)*k_(4,5)-
     19574227189882195702627928160644968*k_(3,4)*k_(4,5)+222344534093044901824442270534336000*k_(
     4,5)^2+4278532179825488567648059961784000*k_(4,5)-1878379981386799858967440958832000,
     192876324711878119362489896643272641*k_(1,5)*k_(2,3)*k_(4,5)+
     45568106955864959541617549186480000*k_(1,5)*k_(1,2)-7211875317297609085245811667951368*k_(1,
     5)*k_(2,3)+24510043235737631930500738810631680*k_(1,2)*k_(2,3)+
     64282623921090601287961999567628360*k_(1,5)*k_(3,4)-19163878426407399934242683487923840*k_(1
     ,2)*k_(3,4)+97866132217744771578456310788068560*k_(2,3)*k_(3,4)-
     95766391447899381220502758847614018*k_(1,5)*k_(4,5)+148006794580221410527357576708933760*k_(
     1,2)*k_(4,5)-42019535221256016859268844249185272*k_(2,3)*k_(4,5)+
     44954597580780311376031044147224120*k_(3,4)*k_(4,5)-188404968304735224914448753381341696*k_(
     4,5)^2-3625439784337051418097183458370624*k_(4,5)+1591656490684559159164617128065152,
     192876324711878119362489896643272641*k_(1,5)*k_(1,2)*k_(4,5)-
     7211875317297609085245811667951368*k_(1,5)*k_(1,2)+38732890912485215610374916808508000*k_(1,
     5)*k_(2,3)-32820546340319567106107429112973088*k_(1,2)*k_(2,3)-
     71651335006775336293595150314825456*k_(1,5)*k_(3,4)+97866132217744771578456310788068560*k_(1
     ,2)*k_(3,4)-16289296662446289944106280964735264*k_(2,3)*k_(3,4)+
     69934601882999784496272883777281704*k_(1,5)*k_(4,5)-42019535221256016859268844249185272*k_(1
     ,2)*k_(4,5)+125805775393188198948253940202593696*k_(2,3)*k_(4,5)-
     61140490858878816359334275102321680*k_(3,4)*k_(4,5)+119594043025064842213557803417982976*k_(
     4,5)^2+2301324670225747120192054102066944*k_(4,5)-1010337660099108491791633508224512,
     192876324711878119362489896643272641*k_(1,2)*k_(2,3)*k_(3,4)+
     26555681248540806367755273289552240*k_(1,5)*k_(1,2)-36117048622449846892243265268899360*k_(1
     ,5)*k_(2,3)+63213146407126782851988858446997290*k_(1,2)*k_(2,3)+
     113660179654734915259940245930677376*k_(1,5)*k_(3,4)-95766391447899381220502758847614018*k_(
     1,2)*k_(3,4)+69934601882999784496272883777281704*k_(2,3)*k_(3,4)-
     27618635270269725401952842144741888*k_(1,5)*k_(4,5)+120638441604113659257972137767551520*k_(
     1,2)*k_(4,5)-134467214727923649321391720731756992*k_(2,3)*k_(4,5)+
     111172267046522450912221135267168000*k_(3,4)*k_(4,5)-73469442276997648227362135527212352*k_(
     4,5)^2-1413758041312689413636661869500488*k_(4,5)+620674262039717303547802771975824,
     192876324711878119362489896643272641*k_(1,5)*k_(2,3)*k_(3,4)-
     15057097838370919771252252431265360*k_(1,5)*k_(1,2)+63213146407126782851988858446997290*k_(1
     ,5)*k_(2,3)-47031146814522166430257134694093600*k_(1,2)*k_(2,3)-
     95766391447899381220502758847614018*k_(1,5)*k_(3,4)+148006794580221410527357576708933760*k_(
     1,2)*k_(3,4)-42019535221256016859268844249185272*k_(2,3)*k_(3,4)+
     120638441604113659257972137767551520*k_(1,5)*k_(4,5)-35964624457309483376300420685498880*k_(
     1,2)*k_(4,5)+183664215248333699333380134632217920*k_(2,3)*k_(4,5)-
     94202484152367612457224376690670848*k_(3,4)*k_(4,5)+168731525388342777636870483963039680*k_(
     4,5)^2+3246867588042265589695724269000920*k_(4,5)-1425454063042945868646903337610160,
     192876324711878119362489896643272641*k_(1,5)*k_(1,2)*k_(3,4)+
     63213146407126782851988858446997290*k_(1,5)*k_(1,2)-12798533162615281805564414566575556*k_(1
     ,5)*k_(2,3)+29393390725894818976635682711646540*k_(1,2)*k_(2,3)+
     69934601882999784496272883777281704*k_(1,5)*k_(3,4)-42019535221256016859268844249185272*k_(1
     ,2)*k_(3,4)+125805775393188198948253940202593696*k_(2,3)*k_(3,4)-
     134467214727923649321391720731756992*k_(1,5)*k_(4,5)+183664215248333699333380134632217920*k
     _(1,2)*k_(4,5)-30569930788713060869855357582674048*k_(2,3)*k_(4,5)+
     59797021512532421106778901708991488*k_(3,4)*k_(4,5)-229483275143836402917712675545531520*k_(
     4,5)^2-4415901571134524023604295852956880*k_(4,5)+1938688494644425181094568911054240,
     192876324711878119362489896643272641*k_(1,5)*k_(1,2)*k_(2,3)-
     95766391447899381220502758847614018*k_(1,5)*k_(1,2)+69934601882999784496272883777281704*k_(1
     ,5)*k_(2,3)-42019535221256016859268844249185272*k_(1,2)*k_(2,3)-
     19574227189882195702627928160644968*k_(1,5)*k_(3,4)+44954597580780311376031044147224120*k_(1
     ,2)*k_(3,4)-61140490858878816359334275102321680*k_(2,3)*k_(3,4)+
     111172267046522450912221135267168000*k_(1,5)*k_(4,5)-94202484152367612457224376690670848*k_(
     1,2)*k_(4,5)+59797021512532421106778901708991488*k_(2,3)*k_(4,5)-
     46754011794502328389190546891148544*k_(3,4)*k_(4,5)+722182771722729203122801244521759232*k_(
     4,5)^2+13896821170509338545698459492518208*k_(4,5)-6101043440711416922501762704032384};
MLEsolver(J,R)

conj=(m-3)*2^(m-2)+1
degree J===conj

--Could be computed up to m=7. For m=8 even in the MPI server the computation is killed.

restart
needsPackage("GraphicalModelsMLE")
m=5;
L={{1,m}};
for l from 1 to m-1 do(L=L|{{l,l+1}});
G=graph(L)
g=mixedGraph(G)
R2=gaussianRing(g)
U={matrix{{1, 2, 9, 6, 0}},matrix{{2, 7, 7, 3, 2}},matrix{{6, 3, 4, 1, 5}},matrix{{5, 5, 8, 8, 7}},matrix{{3, 2, 3, 8, 7}},matrix{{8, 0, 5, 3, 8}}}
J2=time scoreEquationsFromCovarianceMatrix(R2,U);
--Enters in saturate if
-- used 5.98437 seconds
J2=time scoreEquationsFromCovarianceMatrix(R2,U,doSaturate=>false);
--does not enter in saturate if
 -- used 9.6875 seconds
J2==test


restart
debug loadPackage("GraphicalModelsMLE")

R=R2
--   R := gaussianRing(G);  
    ----------------------------------------------------
    -- Extract information about the graph
    ---------------------------------------------------- 
    -- Lambda
    L = directedEdgesMatrix R
    -- K 
    K = undirectedEdgesMatrix R
    -- Psi
    P = bidirectedEdgesMatrix R
    
    ----------------------------------------------------
    -- Create an auxiliary ring and its fraction field
    -- which do not have the s variables
    ----------------------------------------------------
    -- d is equal to the number of vertices in G
    d = numRows L
    -- create a new ring, lpR, which does not have the s variables
    (F,lpR)=changeRing(d,R)
    -- create its fraction field
    FR = frac(lpR)
    
    -----------------------------------------------------
    -- Construct Omega
    -----------------------------------------------------
    -- Kinv
    K=substitute(K, FR)
    Kinv=inverse K
    P=substitute(P,FR)
       
     --Omega
    if K==0 then W:=P else (if P==0 then W=Kinv else W = directSum(Kinv,P));
    --W:= directSum(Kinv,P);
    
    -- move to FR, the fraction field of lpR
    L= substitute (L,FR)
    
    -- Sigma
    if L==0 then S:=W else (
	IdL := inverse (id_(FR^d)-L);
    	S = (transpose IdL) * W * IdL
	);
    if S == Kinv then Sinv:= K else Sinv = inverse S; 
    
    -- Sample covariance matrix
    V = sampleCovarianceMatrix(U);
     
    -- Compute ideal J   
    C1 = trace(Sinv * V)
    C1derivative = JacobianMatrixOfRationalFunction(C1)
    LL=JacobianMatrixOfRationalFunction (det Sinv)*matrix{{1/det(Sinv)}} - (C1derivative)
--  LL=JacobianMatrixOfRationalFunction (det S)*matrix{{-1/det(S)}} - (C1derivative)
    LL=flatten entries(LL)
    denoms = apply(#LL, i -> lift(denominator(LL_i), lpR))
--    prod = product(denoms);
    J=ideal apply(#LL, i -> lift(numerator(LL_i),lpR))
    for i from 0 to (#denoms-1) do (J=time saturate(J,denoms_i)); 
    
    netList J_*


    LL2=JacobianMatrixOfRationalFunction(det Sinv)-det(Sinv)*C1derivative;
    LL2=flatten entries(LL2);
    J=ideal{LL2};
    
    
----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------
    
restart
debug loadPackage("GraphicalModelsMLE")
G = mixedGraph(digraph {{1,2},{1,3},{2,3},{3,4}},bigraph {{3,4}})
R=gaussianRing(G)
U = {matrix{{1,2,1,-1}}, matrix{{2,1,3,0}}, matrix{{-1, 0, 1, 1}}, matrix{{-5, 3, 4, -6}}}
J=scoreEquationsFromCovarianceMatrix(R,U)
I=ideal(20*p_(3,4)+39,50*p_(4,4)-271,440104*p_(3,3)-742363,230*p_(2,2)-203,16*p_(1,1)-115,5*l_(3,4)+2,110026*l_(2,3)-2575,55013*l_(1,3)-600,115*l_(1,2)+26);
assert(J===I)

sols=zeroDimSolve(J)
--evaluate concentration matrix on solutions
M=genListMatrix(sols,Sinv)
L=checkPD M
V=sampleCovarianceMatrix(U)
optSols=maxMLE(L,V)

restart
loadPackage("GraphicalModelsMLE")
G = mixedGraph(digraph {{1,2},{1,3},{2,3},{3,4}},bigraph {{3,4}})
U = {matrix{{1,2,1,-1}}, matrix{{2,1,3,0}}, matrix{{-1, 0, 1, 1}}, matrix{{-5, 3, 4, -6}}}
solverMLE(G,U) 


-- Carlos example
restart
needsPackage "GraphicalModelsMLE"
g=mixedGraph(bigraph{{3,4}},digraph{{1,3},{2,4}})
U = {{1,2,1,-1},{2,1,3,0},{-1, 0, 1, 1},{-5, 3, 4, -6}}
solverMLE(g,U)
--Warning: The sample covariance matrix is singular
--none of the matrices are pd
U2=random(QQ^4,QQ^4)
solverMLE(g,U2)
--depends on matrix
--ML-degree 4

-----------------------------------------------
-- Data checks: singularity, PD, PSD
-----------------------------------------------

restart
needsPackage "GraphicalModelsMLE"
G=graph{{1,2},{2,3},{3,4},{1,4}}
U = matrix{{1,2,1,-1},{2,1,3,0},{-1, 0, 1, 1},{-5, 3, 4, -6}}
det U
--sample data matrix is not singular
isPD U
isPSD U
--sample data matrix is not PD nor PSD
V=sampleCovarianceMatrix U
det V
--covariance matrix is singular
isPD V
isPSD V
eigenvalues V
--not PD but PSD
(m,L,d)=solverMLE(G,U)
--all good
(mcov,Lcov,d)=solverMLE(G,U,sampleData=>false)
--The sample covariance matrix must be symmetric.


restart
needsPackage "GraphicalModelsMLE"
G=graph{{1,2},{2,3},{3,4},{4,1}}
U=random(QQ^4,QQ^4)

V=matrix{{5,1,4/7,0},{1,5,1,3/10},{4/7,1,5,1},{0,3/10,1,5}};
(m,cov,d)=solverMLE(G,V,sampleData=>false,concentrationMatrix=>false)
(m,cov,d)=solverMLE(G,V,sampleData=>false)

V=matrix{{5,1,3,0},{1,5,1,8},{3,1,5,1},{0,8,1,5}};
(m,cov,d)=solverMLE(G,V,sampleData=>false)

restart
needsPackage "GraphicalModelsMLE"
G=graph{{1,2},{2,3},{3,4},{4,1}}
U=random(QQ^4,QQ^4)
(m,cov,d)=solverMLE(G,U)
V=sampleCovarianceMatrix U
MLdegree(gaussianRing G)


restart
needsPackage "GraphicalModelsMLE"
G=graph{{1,2},{2,3},{3,4},{1,4}}
U = {{1,2,1,-1},{2,1,3,0},{-1, 0, 1, 1},{-5, 3, 4, -6}}
solverMLE(G,U)
V=sampleCovarianceMatrix U

----------------------------------------------
---jacobianMatrixOfRationalFunction
---------------------------------------------
restart
needsPackage "GraphicalModelsMLE"
R=QQ[x,y];
FR=frac R;
F=1/(x^2+y^2);
jacobianMatrixOfRationalFunction(F)
use R
G=x^2
jacobianMatrixOfRationalFunction(G)

----------------------------------------------
---documentation ----------------------------
---------------------------------------------

restart
needsPackage "GraphicalModelsMLE"
help sampleCovarianceMatrix
help jacobianMatrixOfRationalFunction
help MLdegree

help scoreEquations 
help doSaturate
help [scoreEquations,doSaturate]
help saturateOptions
help [scoreEquations,saturateOptions]
help sampleData
help [scoreEquations,sampleData]

help solverMLE
help chooseSolver
help [solverMLE, chooseSolver]
help optionsES
help [solverMLE, optionsES]
help optionsNAG4M2
help [solverMLE, optionsNAG4M2]
help concentrationMatrix
help [solverMLE, concentrationMatrix]
----------------------------------------------
---documentation of scoreEquations: examples
---------------------------------------------
restart
needsPackage "GraphicalModelsMLE"

G = mixedGraph(digraph {{1,2},{1,3},{2,3},{3,4}},bigraph{{3,4}})
R = gaussianRing(G)
describe R
U = matrix{{6, 10, 1/3, 1}, {3/5, 3, 1/2, 1}, {4/5, 3/2, 9/8, 3/10}, {10/7, 2/3,
    1, 8/3}}
JU=scoreEquations(R,U)
RU=ring(JU)
V = sampleCovarianceMatrix U
JV=scoreEquations(R,V,sampleData=>false)
JV=sub(JV,RU)
JU==JV
	    
G = mixedGraph(digraph {{1,2},{1,3},{2,3},{3,4}},bigraph{{3,4}})
R = gaussianRing(G)
U = matrix{{6, 10, 1/3, 1}, {3/5, 3, 1/2, 1}, {4/5, 3/2, 9/8, 3/10}, {10/7, 2/3,
            1, 8/3}}
J=scoreEquations(R,U,saturateOptions => {Strategy => Eliminate})
J=sub(J,RU)
assert(J==JU)
JnoSat=scoreEquations(R,U,doSaturate=>false)
J==JnoSat
