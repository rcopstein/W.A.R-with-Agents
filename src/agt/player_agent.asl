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
	elif (P == "play") { }
	.

+!pickOne <-
	.my_name(P);
	.send("mapManager", askOne, randomTerritoryNotTaken(T), randomTerritoryNotTaken(T));
	.send("mapManager", achieve, pick(P, T));
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

{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }