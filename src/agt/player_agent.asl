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
		
		?canPlay(J);
		
		if ( J ) {
		
			?checkObjective(R3);
			if (R3) { !win; }
			else {
			
				+rate(1);
				+place(1);
				
				while ( place(X) & X > 0 ) {
					
					?worstThreatOverall(T, F, R);
					.print("Worst threat from ", F, " to ", T, " with a rate ", R);
					.send("mapManager", achieve, put(N, T), put(N, T));
					-+place(X-1);
					
				}
				-place(_);
				
				while ( rate(X) & X > 0 ) {
					
					?checkObjective(R4);
					
					if (R3) { !win; }
					else {
						
						?bestAttackOverall(F2, T2, R2);
						.print("Best attack overall is from ", F2, " to ", T2, " with rate ", R2);
						
						if ( not (F2 == T2) ) {
							
							-+rate(R2);
							if (R2 > 0) { .send("mapManager", askOne, attack(N, F2, T2), attack(N, F2, T2)); }
							
						}
						else { -+rate(0); }
					}
				}
				-rate(_);
				
			}
			
		}
		else { .print("Can't play!"); }
		
		.print("Turn ended!");	
		!endTurn;
	}
	.

+?canPlay(X) <-
	.my_name(N);
	.send("mapManager", askOne, numConqueredTerritories(N, Y), numConqueredTerritories(N, Y));
	.eval(X, Y > 0);
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

+?worstThreatTo(X, T, R) <-
	.send("mapManager", askOne, worstThreatTo(X, T, R), worstThreatTo(X, T, R));
	.
+?worstThreatOverall(F, T, R) <-
	.my_name(N);
	.send("mapManager", askOne, worstThreatOverall(N, ResultFrom, ResultTo, ResultRate), worstThreatOverall(N, ResultFrom, ResultTo, ResultRate));
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