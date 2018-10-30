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

+round(P) : .my_name(N) & (P == N) <-
	.print(X);
	.print(P);
	
	-round(P);
	endTurn;
	.
	
+round(P) : .my_name(N) & not(P == N) <-
	.print(P);
	-round(P);
	.

{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }