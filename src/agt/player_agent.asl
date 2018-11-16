/* Initial beliefs and rules */

/* Initial goals */

!start.

/* Plans */

+!start : .my_name(N) <-
	.send("roundManager", tell, ready(N));
	.
	
+!addObjectives([]).
+!addObjectives([H|T]) <-
	+conquer(H);
	!addObjectives(T);
	.

+turn <-
	?phase(P);
	.my_name(N);
	.print("Playing: ", N, ", Phase: ", P);
	
	if (P == "pick") { !pickOne; !endTurn }
	elif (P == "objective") { !getObjective; !endTurn }
	elif (P == "play") { 
		
		?closest("Canada", T, D);
		.print(T, " ", D);
		
		?closestLessTroops("Canada", T, D, A);
		.print(T, " ", D, " ", A);
		
		?closestMostTroops("Canada", T, D, A);
		.print(T, " ", D, " ", A);
		
		?haveMany(2, R1);
		.print(R1);
		
		?haveAll(["Canada"], R2);
		.print(R2);
		
	}
	.

+!pickOne <-
	.my_name(P);
	.send("mapManager", askOne, randomTerritoryNotTaken(T), randomTerritoryNotTaken(T));
	.send("mapManager", askOne, pick(P, T), pick(P, T));
	.
+!getObjective <-
	.send("objManager", askOne, objectives(X), objectives(X));
	if (.list(X)) {
		for (.member(Y, X)) {
			+obj_conquer(Y);
		}
	}
	elif (.number(X)) {
		+obj_conquer(X);
	}
	.

+!endTurn <-
	.my_name(N);
	.send("roundManager", tell, endTurn(N));
	.

+?phase(X) <-
	.send("roundManager", askOne, phase(X), phase(X));
	.

+?closest(X, Y, D) <-
	.my_name(N);
	.send("mapManager", askOne, closest(N, X, Y, D), closest(N, X, Y, D));
	.
+?closestLessTroops(X, Y, D, A) <-
	.my_name(N);
	.send("mapManager", askOne, closestLessTroops(N, X, Y, D, A), closestLessTroops(N, X, Y, D, A));
	.
+?closestMostTroops(X, Y, D, A) <-
	.my_name(N);
	.send("mapManager", askOne, closestMostTroops(N, X, Y, D, A), closestMostTroops(N, X, Y, D, A));
	.

+?haveMany(C, R) <-
	.my_name(N);
	.send("mapManager", askOne, haveMany(N, C, R), haveMany(N, C, R));
	.
+?haveAll(L, R) <-
	.my_name(N);
	.send("mapManager", askOne, haveAll(N, L, R), haveAll(N, L, R));
	.

{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }