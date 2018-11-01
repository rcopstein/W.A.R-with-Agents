/* Initial beliefs and rules */

given(0).

/* Initial goals */

/* Plans */

+?objectives(X) <-
	J = math.random(2)
	JJ = math.floor(J)
	if (JJ == 0) { ?conquerWhich(X); }
	else { ?conquerCount(X); }
	
	?given(Y);
	-+given(Y+1);
	
	.send("roundManager", askOne, numPlayers(Z), numPlayers(Z));
	if (Y+1 == Z) { .send("roundManager", achieve, allObjectivesPicked); }
	.

+?conquerWhich(X) <-
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
	X = math.ceil(N / NP);
	.

{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }