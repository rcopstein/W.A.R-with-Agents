/* Initial beliefs and rules */

playersReady(0).
numPlayers(2).
phase("none").
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

	-playersReady(_);
	.abolish(ready(_));

	?whosNext(H);
	-+phase("pick");
	.send(H, tell, turn);
	
	.

+win(P) <-
	.print(P, " won!");
	-+phase("end");
	.

+endTurn(P) <-
	-endTurn(P)[source(P)];
	.send(P, untell, turn);
	
	?whosNext(H);
	.send(H, tell, turn);
	.

+!allTerritoriesPicked <-
	-+phase("objective");
	.
+!allObjectivesPicked <-
	-+phase("play");
	.

+?sendBack([H|T], X) <-
	.concat(T, [H], X);
	.
+?whosNext(X) <-
	?order([H|T]);
	-order([H|T]);
	?sendBack([H|T], L);
	+order(L);
	X = H;
	.

{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }