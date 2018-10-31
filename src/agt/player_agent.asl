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
	.print("Phase ", P);
	
	if (P == "pick") { !pickOne }
	elif (P == "play") { }
	
	.my_name(N);
	.print("Playing: ", N);
	if (P == "pick") { !endTurn }
	.

+!pickOne <-
	.my_name(P);
	.send("mapManager", askOne, randomTerritoryNotTaken(T), randomTerritoryNotTaken(T));
	.send("mapManager", tell, pick(P, T));
	.

+!endTurn <-
	.my_name(N);
	.send("roundManager", tell, endTurn(N));
	.

+?phase(X) <-
	.send("roundManager", askOne, phase(X), phase(X));
	.print("Phase ", X);
	.

{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }