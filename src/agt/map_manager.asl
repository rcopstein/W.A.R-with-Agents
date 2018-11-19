/* Initial beliefs and rules */

/*
 * territory("Alaska").
territory("Aral").
territory("Argentina").
territory("Australia").
territory("Borneo").
territory("Brasil").
territory("California").
territory("China").
territory("Congo").
territory("Dudinka").
territory("Egypt").
territory("England").
territory("Germany").
territory("Greenland").
territory("Iceland").
territory("India").
territory("Japan").
territory("Labrador").
territory("Mackenzie").
territory("Madagascar").
territory("Mexico").
territory("Middle_East").
territory("Mongolia").
territory("Moscow").
territory("New_Guinea").
territory("New_York").
territory("Nigeria").
territory("Omsk").
territory("Ottawa").
territory("Peru").
territory("Poland").
territory("Portugal").
territory("Siberia").
territory("South_Africa").
territory("Sudan").
territory("Sumatra").
territory("Sweden").
territory("Tchita").
territory("Vancouver").
territory("Venezuela").
territory("Vietnam").
territory("Vladivostok").
border("Alaska", "Mackenzie").
border("Mackenzie", "Alaska").
border("Alaska", "Vancouver").
border("Vancouver", "Alaska").
border("Alaska", "Vladivostok").
border("Vladivostok", "Alaska").
border("Aral", "China").
border("China", "Aral").
border("Aral", "India").
border("India", "Aral").
border("Aral", "Middle_East").
border("Middle_East", "Aral").
border("Aral", "Moscow").
border("Moscow", "Aral").
border("Aral", "Omsk").
border("Omsk", "Aral").
border("Argentina", "Brasil").
border("Brasil", "Argentina").
border("Argentina", "Peru").
border("Peru", "Argentina").
border("Australia", "Borneo").
border("Borneo", "Australia").
border("Australia", "New_Guinea").
border("New_Guinea", "Australia").
border("Australia", "Sumatra").
border("Sumatra", "Australia").
border("Borneo", "Australia").
border("Australia", "Borneo").
border("Borneo", "New_Guinea").
border("New_Guinea", "Borneo").
border("Borneo", "Vietnam").
border("Vietnam", "Borneo").
border("Brasil", "Argentina").
border("Argentina", "Brasil").
border("Brasil", "Nigeria").
border("Nigeria", "Brasil").
border("Brasil", "Peru").
border("Peru", "Brasil").
border("Brasil", "Venezuela").
border("Venezuela", "Brasil").
border("California", "Mexico").
border("Mexico", "California").
border("California", "New_York").
border("New_York", "California").
border("California", "Ottawa").
border("Ottawa", "California").
border("California", "Vancouver").
border("Vancouver", "California").
border("China", "India").
border("India", "China").
border("China", "Japan").
border("Japan", "China").
border("China", "Mongolia").
border("Mongolia", "China").
border("China", "Tchita").
border("Tchita", "China").
border("China", "Vietnam").
border("Vietnam", "China").
border("China", "Vladivostok").
border("Vladivostok", "China").
border("Congo", "Nigeria").
border("Nigeria", "Congo").
border("Congo", "South_Africa").
border("South_Africa", "Congo").
border("Congo", "Sudan").
border("Sudan", "Congo").
border("Dudinka", "Mongolia").
border("Mongolia", "Dudinka").
border("Dudinka", "Omsk").
border("Omsk", "Dudinka").
border("Dudinka", "Siberia").
border("Siberia", "Dudinka").
border("Dudinka", "Tchita").
border("Tchita", "Dudinka").
border("Egypt", "Middle_East").
border("Middle_East", "Egypt").
border("Egypt", "Nigeria").
border("Nigeria", "Egypt").
border("Egypt", "Poland").
border("Poland", "Egypt").
border("Egypt", "Portugal").
border("Portugal", "Egypt").
border("Egypt", "Sudan").
border("Sudan", "Egypt").
border("England", "Germany").
border("Germany", "England").
border("England", "Iceland").
border("Iceland", "England").
border("England", "Portugal").
border("Portugal", "England").
border("England", "Sweden").
border("Sweden", "England").
border("Germany", "Poland").
border("Poland", "Germany").
border("Germany", "Portugal").
border("Portugal", "Germany").
border("Greenland", "Iceland").
border("Iceland", "Greenland").
border("Greenland", "Labrador").
border("Labrador", "Greenland").
border("Greenland", "Mackenzie").
border("Mackenzie", "Greenland").
border("India", "Middle_East").
border("Middle_East", "India").
border("India", "Sumatra").
border("Sumatra", "India").
border("India", "Vietnam").
border("Vietnam", "India").
border("Japan", "Vladivostok").
border("Vladivostok", "Japan").
border("Labrador", "New_York").
border("New_York", "Labrador").
border("Labrador", "Ottawa").
border("Ottawa", "Labrador").
border("Mackenzie", "Ottawa").
border("Ottawa", "Mackenzie").
border("Mackenzie", "Vancouver").
border("Vancouver", "Mackenzie").
border("Madagascar", "South_Africa").
border("South_Africa", "Madagascar").
border("Madagascar", "Sudan").
border("Sudan", "Madagascar").
border("Mexico", "New_York").
border("New_York", "Mexico").
border("Mexico", "Venezuela").
border("Venezuela", "Mexico").
border("Middle_East", "Moscow").
border("Moscow", "Middle_East").
border("Middle_East", "Poland").
border("Poland", "Middle_East").
border("Mongolia", "Omsk").
border("Omsk", "Mongolia").
border("Mongolia", "Tchita").
border("Tchita", "Mongolia").
border("Moscow", "Omsk").
border("Omsk", "Moscow").
border("Moscow", "Poland").
border("Poland", "Moscow").
border("Moscow", "Sweden").
border("Sweden", "Moscow").
border("New_York", "Ottawa").
border("Ottawa", "New_York").
border("Nigeria", "Portugal").
border("Portugal", "Nigeria").
border("Nigeria", "Sudan").
border("Sudan", "Nigeria").
border("Omsk", "China").
border("China", "Omsk").
border("Ottawa", "Vancouver").
border("Vancouver", "Ottawa").
border("Peru", "Venezuela").
border("Venezuela", "Peru").
border("Siberia", "Tchita").
border("Tchita", "Siberia").
border("Siberia", "Vladivostok").
border("Vladivostok", "Siberia").
border("South_Africa", "Sudan").
border("Sudan", "South_Africa").
border("Tchita", "Vladivostok").
border("Vladivostok", "Tchita").
 */

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

+?pick(P, T) <-

	+conquered(P, T, 3);
	.print(P, " conquered ", T);
	
	?numTerritories(NT)
	?numConqueredTerritories(NCT);
	if (NT == NCT) { .send("roundManager", achieve, allTerritoriesPicked); }
	.

+!attack(Attacker, From, To) <-

	?conquered(Attacker, From, FromArmies);
	?conquered(Target, To, ToArmies);
	
	Luck = math.floor(math.random(2));
	
	if ( Luck == 1 ) {
		
		// Attack succeeded
		
		.print(Attacker, " successfully attacked ", To, " from ", From);
		-conquered(Target, To, TargetArmies); 
		+conquered(Target, To, TargetArmies - 1);
		
		if ( TargetArmies - 1 == 0 ) {
			
			.print(Attacker, " conquered ", To);
			
			-conquered(Attacker, From, FromArmies);
			+conquered(Attacker, From, FromArmies - 1);
			
			-conquered(Target, To, 0);
			+conquered(Attacker, To, 1);
		}
		
	}
	else {
		
		// Attack failed
		
		.print(Attacker, " failed an attack to ", To, " from ", From);
		-conquered(Attacker, From, FromArmies);
		+conquered(Attacker, From, FromArmies - 1);
		
	}

	.

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

+?taken(T, X) : conquered(P, T, N) <-
	X = true;
	.
+?taken(T, X) : not conquered(P, T, N) <-
	X = false;
	.

+?haveMany(P, C, R) <-
	.findall(T, conquered(P, T, _), X);
	.length(X, D);
	R = (D >= C);
	.
+?haveAll(P, L, R) <-
	.findall(T, conquered(P, T, _), X);
	.intersection(X, L, Y);
	R = (Y == L);
	.

+?closest(P, T, X, D) <-
	
	+closest_checked(T);
	
	if (conquered(P, T, _)) {
		
		X = T;
		D = 1;
		
	}
	else {
		
		+closest_distance(T, 100);
		
		?allBorders(T, Y);
		for ( .member(B, Y) ) {
			
			if (not closest_checked(B)) {
				?closest(P, B, XX, DD);
				?closest_distance(T, OD);
				
				if (DD + 1 < OD) {
					-+closest_distance(T, DD + 1);
					-+closest_territory(T, XX);
				}
			}
		}
		
		?closest_distance(T, D);
		?closest_territory(T, X);
		
		-closest_distance(T, _);
		-closest_territory(T, _);
	}
	
	-closest_checked(T);
	.
+?closestLessTroops(P, T, X, D, A) <-

	+closest_l_troops_checked(T);
	
	if (conquered(P, T, AA)) {
		
		X = T;
		D = 1;
		A = AA;
		
	}
	else {
		
		+closest_l_troops_distance(T, 100);
		+closest_l_troops_armies(T, 10000);
		
		?allBorders(T, Y);
		for ( .member(B, Y) ) {
			
			if (not closest_l_troops_checked(B)) {
				?closestLessTroops(P, B, XX, DD, AA);
				?closest_l_troops_distance(T, OD);
				?closest_l_troops_armies(T, OA);
				
				if ((DD + 1 < OD) | (DD + 1 == OD & AA < OA)) {
					-+closest_l_troops_distance(T, DD + 1);
					-+closest_l_troops_territory(T, XX);
					-+closest_l_troops_armies(T, AA);
				}
			}
		}
		
		?closest_l_troops_armies(T, A);
		?closest_l_troops_distance(T, D);
		?closest_l_troops_territory(T, X);
		
		-closest_l_troops_armies(T, _);
		-closest_l_troops_distance(T, _);
		-closest_l_troops_territory(T, _);
	}
	
	-closest_l_troops_checked(T);
	.
+?closestMostTroops(P, T, X, D, A) <-

	+closest_m_troops_checked(T);
	
	if (conquered(P, T, AA)) {
		
		X = T;
		D = 1;
		A = AA;
		
	}
	else {
		
		+closest_m_troops_distance(T, 100);
		+closest_m_troops_armies(T, 10000);
		
		?allBorders(T, Y);
		for ( .member(B, Y) ) {
			
			if (not closest_m_troops_checked(B)) {
				?closestMostTroops(P, B, XX, DD, AA);
				?closest_m_troops_distance(T, OD);
				?closest_m_troops_armies(T, OA);
				
				if ((DD + 1 < OD) | (DD + 1 == OD & AA < OA)) {
					-+closest_m_troops_distance(T, DD + 1);
					-+closest_m_troops_territory(T, XX);
					-+closest_m_troops_armies(T, AA);
				}
			}
		}
		
		?closest_m_troops_armies(T, A);
		?closest_m_troops_distance(T, D);
		?closest_m_troops_territory(T, X);
		
		-closest_m_troops_armies(T, _);
		-closest_m_troops_distance(T, _);
		-closest_m_troops_territory(T, _);
	}
	
	-closest_m_troops_checked(T);
	.

+?rateOfSuccess(X, Y, R) <-
	?conquered(_, X, A1);
	?conquered(_, Y, A2);
	
	if ( A1 == 1 ) { R = 0; }
	else { R = A1 / (A1 + A2); }
	.
+?bestAttackFrom(X, T, R) <-

	?conquered(P, X, A);
	?allBorders(X, B);
	
	+best_attack_from_res(X, 0);
	
	for ( .member(M, B) ) {
		if (not conquered(P, M, _)) {
			
			?rateOfSuccess(X, M, NewRate);
			?best_attack_from_res(OldTer, OldRate);
			if (NewRate > OldRate) { -+best_attack_from_res(M, NewRate); }
			
		}
	}
	
	?best_attack_from_res(T, R);
	-best_attack_from_res(_, _);
	
	.
+?bestAttackOverall(P, ResultFrom, ResultTo, ResultRate) <-

	.findall(T, conquered(P, T, _), MyTerritories);
	
	for ( .member(Territory, MyTerritories) ) {
		
		?bestAttackFrom(Territory, Target, Rate);
		
		if (not bestAttackOverall(_, _, _)) {
			
			+bestAttackOverall(Territory, Target, Rate);
			
		}
		else {
			
			?bestAttackOverall(BestFrom, BestTo, BestRate);
			
			if (Rate > BestRate & Rate > 0) {
				
				-bestAttackOverall(_, _, _);
				+bestAttackOverall(Territory, Target, Rate);
				
			}
		}
	}
	
	if ( bestAttackOverall(_, _, _) ) {
		
		?bestAttackOverall(ResultFrom, ResultTo, ResultRate);
		-bestAttackOverall(_, _, _);
		
	}
	
	.

// TODO: Calculate rate of threat as the inverse of rate of success
// TODO: Check the worst rate of threat and return that territory

{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }