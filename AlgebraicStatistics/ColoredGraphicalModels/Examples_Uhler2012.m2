-------------
--FUNCTIONS--
-------------

-----------------
-- DUAL VARIETY
-----------------
-- Source: Algorithm 5.1 from Blekherman, Parrilo, and Thomas, eds. 
-- Semidefinite optimization and convex algebraic geometry. 
-- SIAM, 2012.

-- Input:
-- IX - ideal of variety X in C^{n}
-- n - number of coordinates of the ambient space of X 
--     (i.e., all indices start from 1)
-- x - variables for X
-- u - variables for the dual of X
restart
dualVariety=(IX,n,x,u)->(
    c:=codim IX;
    JacX:=submatrix(transpose jacobian IX,toList(0..n-1));
    AugJacX:=matrix{toList(u_1..u_n)}||JacX;
    SingX:=minors(c,JacX);
    conormalX:=saturate(IX+minors(c+1,AugJacX),SingX);
    dualX:=eliminate(toList(x_1..x_n),conormalX);
    dualX
    )

-----------------------------
-- ALGEBRAIC BOUNDARY
-----------------------------
--algebraic boundary H_G
-- See p. 7 from Sturmfels and Uhler paragraph after Proposition 2.4
-- Algorithm for K a s x s matrix
-- 1. For all 1 <=p<=s compute I:= the ideal of the p-minors of K
-- 2. Compute the dual variety of each minimal prime of I
-- 3. Keep only those varieties, whose ideal is principal
-- 4. H_L is the product of these principal generators

boundaryComponents=(K,p)->(
    I:=minors(p,K);
    minPrimes:=minimalPrimes I;
    m:= length minPrimes;
    allComponents:=for i to  m-1 list (dualComponent:=dualVariety(minPrimes_i,n,l,t),numgens trim dualComponent);
    boundaryComponents:= for i in allComponents list (if i_1==1 then i_0)
    )


algBoundary=(K)->(
    s=numgens target K;       
    delete (null, flatten (for p from 1 to s list boundaryComponents(K,p))) 
    )


--Example 6.2 in Uhler (Example 5.1 in Sturmfels and Uhler)
--restart
n=5
R=QQ[l_1..l_n,t_1..t_n,s_11..s_14,s_22..s_24,s_33..s_34,s_44]
K=matrix{{l_1,l_3,0,l_4},{l_3,l_1,l_4,0},{0,l_4,l_2,l_5},{l_4,0,l_5,l_2}}
S=matrix{{s_11,s_12,s_13,s_14},{s_12,s_22,s_23,s_24},{s_13,s_23,s_33,s_34},{s_14,s_24,s_34,s_44}}--estimate

--sufficient statistics
stat1=t_1-s_11-s_22
stat2=t_2-s_33-s_44
stat3=t_3-2*s_12
stat4=t_4-2*(s_23+s_14)
stat5=t_5-2*s_34

-- compute P_G (ideal of variety of L^{-1})
P_G=eliminate({l_1,l_2,l_3,l_4,l_5},ideal(K*S-id_(R^4)))

-- algebraic boundary 
H_G= algBoundary K


-------------------------------------
-- EXISTENCE OF MLE 
------------------------------------
-- Computation of I_(G,n) (Theorem 3.3, Uhler)
-- with coloring
-- (for some reason, I need to restart and redeclare all rings...)
restart
n=5
R=QQ[t_1..t_n,s_11..s_14,s_22..s_24,s_33..s_34,s_44]
S=matrix{{s_11,s_12,s_13,s_14},{s_12,s_22,s_23,s_24},{s_13,s_23,s_33,s_34},{s_14,s_24,s_34,s_44}}--estimate

--sufficient statistics
stat1=t_1-s_11-s_22
stat2=t_2-s_33-s_44
stat3=t_3-2*s_12
stat4=t_4-2*(s_23+s_14)
stat5=t_5-2*s_34

varList=flatten {toList(s_11..s_14), toList(s_22..s_24),s_33,s_34,s_44}
Istat=ideal(stat1,stat2,stat3,stat4,stat5)

I_G2=eliminate(varList,minors(3,S)+Istat)
I_G1=eliminate(varList,minors(2,S)+Istat)

----------------------------------------------------------------------
----------------------------------------------------------------------
-- Uhler 2012, Table 2
----------------------------------------------------------------------
----------------------------------------------------------------------

-- GRAPH 1
n=3
R=QQ[l_1..l_n,t_1..t_n,s_11..s_14,s_22..s_24,s_33..s_34,s_44]
K=matrix{{l_1,l_2,0,l_2},{l_2,l_1,l_3,0},{0,l_3,l_1,l_2},{l_2,0,l_2,l_1}}
S=matrix{{s_11,s_12,s_13,s_14},{s_12,s_22,s_23,s_24},{s_13,s_23,s_33,s_34},{s_14,s_24,s_34,s_44}}--estimate

-- compute P_G (ideal of variety of L^{-1})
P_G=eliminate(toList(l_1..l_n),ideal(K*S-id_(R^4)))

-- algebraic boundary 
H_G= algBoundary K

-------------------------------------
-- EXISTENCE OF MLE 
------------------------------------
-- Computation of I_(G,n) (Theorem 3.3, Uhler)
-- with coloring
restart
n=3
R=QQ[t_1..t_n,s_11..s_14,s_22..s_24,s_33..s_34,s_44]
S=matrix{{s_11,s_12,s_13,s_14},{s_12,s_22,s_23,s_24},{s_13,s_23,s_33,s_34},{s_14,s_24,s_34,s_44}}--estimate

--sufficient statistics
stat1=t_1-s_11-s_22-s_33-s_44
stat2=t_2-2*(s_12+s_14+s_34)
stat3=t_3-2*s_23

varList=flatten {toList(s_11..s_14), toList(s_22..s_24),s_33,s_34,s_44}
Istat=ideal(stat1,stat2,stat3)

I_G3=eliminate(varList,minors(4,S)+Istat)
I_G2=eliminate(varList,minors(3,S)+Istat)
I_G1=eliminate(varList,minors(2,S)+Istat)
