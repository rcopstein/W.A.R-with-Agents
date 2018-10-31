/* Initial beliefs and rules */

/* Initial goals */

/* Plans */

+?objectives(X) <-
	if (math.random(2) == 0) {
		?conquerWhich(X);
	}
	else {
		?conquerCount(X);
	}
	.

+?conquerWhich(X) <-
	.print("Here");
	.send("mapManager", askOne, numTerritories(N), numTerritories(N));
	
	+aux([]);
	while (aux(L) & .length(L) < N/2) {
		.send("mapManager", askOne, randomTerritory(T), randomTerritory(T));
		.union([T], L, LL);
		-+aux(LL);
	}
	
	?aux(LLL);
	X = LLL;
	-aux(_);
	.
+?conquerCount(X) <-
	.send("mapManager", askOne, numTerritories(N), numTerritories(N));
	.send("roundManager", askOne, numPlayers(NP), numPlayers(NP));
	.print(N);
	.print(NP);
	X = math.ceil(N / NP);
	.

{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }