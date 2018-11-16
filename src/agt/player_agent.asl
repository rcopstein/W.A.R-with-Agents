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
		
		?bestAttackOverall(F2, T2, R2);
		.print("Best attack overall is from ", F2, " to ", T2, " with rate ", R2);
		
		?checkObjective(R3);
		if (R3) { !win; }
		
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
+!win <-
	.my_name(N);
	.send("roundManager", tell, win(N));
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

+?bestAttackFrom(X, T, R) <-
	.send("mapManager", askOne, bestAttackFrom(X, T, R), bestAttackFrom(X, T, R));
	.
+?bestAttackOverall(F, T, R) <-
	.my_name(N);
	.send("mapManager", askOne, bestAttackOverall(N, ResultFrom, ResultTo, ResultRate), bestAttackOverall(N, ResultFrom, ResultTo, ResultRate));
	F = ResultFrom;
	R = ResultRate;
	T = ResultTo;
	.

+?haveMany(C, R) <-
	.my_name(N);
	.send("mapManager", askOne, haveMany(N, C, R), haveMany(N, C, R));
	.
+?haveAll(L, R) <-
	.my_name(N);
	.send("mapManager", askOne, haveAll(N, L, R), haveAll(N, L, R));
	.
+?checkObjective(R) <-
	.findall(Y, obj_conquer(Y), X);
	.nth(0, X, K);
	
	if (.number(K)) { ?haveMany(K, R); }
	else { ?haveAll(X, R); }
	.

{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }