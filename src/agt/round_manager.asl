/* Initial beliefs and rules */

playersReady(0).
numPlayers(2).
phase("None").
order([]).

/* Initial goals */

/* Plans */
	
+ready(P) <-

	?playersReady(X);
	-playersReady(X);
	+playersReady(X+1);
	
	?order(L);
	-order(L);
	+order([P|L]);
	.
	
+playersReady(N) : numPlayers(M) & M == N <-
	.print("Done!");
	.

{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }