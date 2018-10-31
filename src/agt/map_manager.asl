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

+!start : true.

+pick(P, T) <-
	-pick(P, T)[source(P)];
	+conquered(P, T, 1);
	
	.print(P, " conquered ", T);
	
	?numTerritories(NT)
	?numConqueredTerritories(NCT);
	
	if (NT == NCT) { .send("roundManager", tell, allTerritoriesPicked); }
	.

/* Auxiliary Plans */

+?allTerritories(X) <-
	.findall(A, territory(A), X)
	.
+?allConqueredTerritories(X) <-
	.findall(A, conquered(_, A, _), X);
	.

+?numTerritories(X) <-
	?allTerritories(A);
	X = .length(A)
	.
+?numConqueredTerritories(X) <-
	?allConqueredTerritories(A);
	X = .length(A)
	.

+?territoryByIndex(I, X) <-
	?allTerritories(A);
	.nth(I, A, X);
	.

+?randomTerritory(X) <-
	?numTerritories(Num);
	R = math.floor(math.random(Num));
	?territoryByIndex(R, X);
	.
+?randomTerritoryNotTaken(X) <-
	+aux(true);
	+ter("None");
	
	while (aux(CC) & CC) {
		?randomTerritory(T);
		if (not conquered(_, T, _)) { -+aux(false); }
		-+ter(T);
	}
	
	?ter(X);
	-aux(_);
	-ter(_);
	.

+?allBorders(T, X) <-
	.findall(A, border(T, A), X);
	.

+?taken(T, X) : taken(P, T, N) <-
	X = true;
	.
+?taken(T, X) : not taken(P, T, N) <-
	X = false;
	.

{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }