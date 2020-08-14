restart
loadPackage("GraphicalModelsMultiTrek",Reload=>true)
--G = mixedGraph(digraph {{b,d},{c,d},{b,c}},bigraph {{a,d}})
G = mixedGraph(digraph {{b,d},{c,d},{b,c},{a,c},{e,c}})
R = gaussianRing G
--T = trekSeparation G
MT=multiTrekSeparation(G,2)
MT=multiTrekSeparation(G,3)
T = apply(T,s -> {sort s#0, sort s#1, sort s#2, sort s#3})
L = {{{a}, {b, c}, {}, {}}, {{b, c}, {a, b}, {}, {b}}, {{a, b}, {b, c}, {}, {b}}, {{b, c}, {a, c}, {}, {c}}, {{b, c}, {a, d}, {}, {d}}}
sort T=== sort L

G = mixedGraph(digraph {{b,d},{c,d},{b,c},{a,c},{e,c}})
Ghash = graph collateVertices G
DG = graph Ghash#Digraph 
v = sort vertices G
v#1
DG#(b)
Dghash := new MutableHashTable from apply(v,i->{i,DG#i});
keys Dghash 
DG
Dghash#b
v = {a,b}
(set subsets v)^**2
(set subsets v)^**2/deepSplice
#set subsets v
L1 = toList (set subsets v)^**2
L2 = toList ((set subsets v)^**2)/deepSplice
L1_1
L2_1


multiTrekSeparation(g,4)
((set subsets vertices G)^**3)/splice
toList(((set subsets vertices G)^**3)/splice)

toList(((set subsets vertices G)^**3)/splice)

G=graph collateVertices g;
(graph G#Digraph)#b

restart
loadPackage("GraphicalModelsMultiTrek",Reload=>true)
g=digraph {{b,d},{c,d},{b,c}}
tops(g,2,{{b},{c,d}},{{c},{c}})
tops(g,1,{{b}},{{c}})
multiTrek
{1,2,3,4,5,6}_(toList 0..(4))


--
k=2
Slist = {{b},{c,d}}
Alist = {{c},{b,c}}
topList := {};
    Glist:=apply(Alist,A->deleteVertices(g,A));
    vert := sort vertices g;
    for v in vert do(
	isTop := true;
	i:=0;
	descd := {};
	while (isTop and i<k) do(
	    pathExists := false;
	    descd = toList(descendants(Glist#i,v));
	    print descd;
	    ddd := 0;
	    print "a";
	    while ((not pathExists) and ddd<length(descd)) do(
		if member(descd#ddd,Slist#i) then(pathExists=true;);
		ddd=ddd+1;
		);
	    print "b";
	    if not pathExists then (isTop=false;);
	    i=i+1; 
	    print "c";
	    );
	print "d";
	if isTop then(topList=append(topList,v););
	print "hi";	
	
	
	
--------------

restart
loadPackage("GraphicalModelsMultiTrek",Reload=>true)
--G = mixedGraph(digraph {{b,d},{c,d},{b,c}},bigraph {{a,d}})
G = mixedGraph(digraph {{a,b},{b,d},{a,c},{c,e}})
D = digraph G

Slist = {{b,d},{c,e}}
Alist = {{b},{c}}
tops(D,2,Slist,Alist)

L = multiTrekSeparation(G,2);

length L
for l in L do
(
    if sum(l#1,i->length i) < min(length l#0#0, length l#0#1) then(
    print l
    )
    )

Lineq = {}
for l in L do
(
    if sum(l#1,i->length i) < min(length l#0#0, length l#0#1) then(
    Lineq=append(Lineq,{l})
    )
    )

for l in LineqLists do
(
    print l
    )

for l in L1sort do
(
    print l
    )

--Compare Lineq and L1
LineqLists=apply(Lineq,l->{sort(l#0#0#0),sort(l#0#0#1),sort(l#0#1#0),sort(l#0#1#1)})
L1sort=apply(L1,l->{sort(l#0),sort(l#1),sort(l#2),sort(l#3)})

for l in L1sort do(
    print(member(l,LineqLists))
    )

for l in L1sort do(
    if not (member(l,LineqLists)) then (print l;)
    )

--we seemingly missed {{a, c, e}, {a, b, d}, {a}, {d}}, but maybe it is implied by one we didn't miss (i.e. not minimal)
missedStatement= {({a, c, e}, {a, b, d}),({a}, {d})}
for l in L do(
    if impliesSeparationStatement(2,l,missedStatement) then (print l);
    )



--------------------------

--------------------------
for l in L do
(
   if l_1 == ({b}, {c}) then print l
    
)

L1 = trekSeparation G;



for l in L1 do
(
 
 if isSubset({{b}},l) then print l 
 
)
 
length L1
    
-----

impliesSeparationStatement = method()
--Return true if statement1 implies statement2
--For every S1 in statement1 and corresponding S2 in statement2: S2 subset of S1
--For every A1 in statement1 and corresponding A2 in statement2: A1 subset of A2
impliesSeparationStatement (ZZ,List,List) := Boolean => (k,statement1,statement2) ->
(for i from 0 to k-1 do(
	if not isSubset(statement2#0#i,statement1#0#i) then(return false;);
	if not isSubset(statement1#1#i,statement2#1#i) then(return false;);
	);
    	return true;
   )

s1 = {({d, b}, {a, b, c, e}), ({b}, {})}
s2 = {({d, b}, {a, b, c, e}), ({b}, {c})}
impliesSeparationStatement(2,s2,s1)
