/* Initial beliefs and rules */

territory("Canada").
territory("Mexico").
territory("United States").

border("Canada", "United States").
border("United States", "Canada").
border("Mexico", "United States").
border("United States", "Mexico").

/* Initial goals */

!start.

/* Plans */

+!start : true <- 
	?allTerritories(X);
	.print(X);
	?allBorders("United States", A);
	.print(A);
	.

/* Auxiliary Plans */

+?allTerritories(X) : not territory(T) <-
	X = [];
	.
+?allTerritories(X) : territory(T) <-
	-territory(T);
	?allTerritories(A);
	.concat([T], A, X);
	+territory(T);
	.

+?allBorders(T, X) : not border(T, O) <-
	X = [];
	.
+?allBorders(T, X) : border(T, O) <-
	-border(T, O);
	?allBorders(T, A);
	.concat([O], A, X);
	+border(T, O);
	.

{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }