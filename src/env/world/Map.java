package world;

import java.util.ArrayList;
import java.util.HashMap;

import cartago.*;

public class Map extends Artifact {
	
	// Variables
	
	ArrayList<Territory> territories;
	HashMap<Territory, Territory[]> borders;
	
	// Functions
	
	private Territory getTerritory(String name) {
		for (Territory territory : territories) {
			if (territory.getName().equals(name)) {
				return territory;
			}
		}
		
		return null;
	}
	
	// Operations
	
	@OPERATION
	void attack(String name, OpFeedbackParam<Boolean> result) {
		
		Territory t = getTerritory(name);
		result.set(t != null);
		
	}
	
	// Constructor
	
	void init() {
		
		territories = new ArrayList<Territory>();
		borders = new HashMap<Territory, Territory[]>();
		
		initTerritories();
		
	}
	void initTerritories() {
		
		Territory A = new Territory("A");
		Territory B = new Territory("B");
		Territory C = new Territory("C");
		Territory D = new Territory("D");
		
		territories.add(A);
		territories.add(B);
		territories.add(C);
		territories.add(D);
		
		borders.put(A, new Territory[] { B, C });
		borders.put(B, new Territory[] { A, D });
		borders.put(C, new Territory[] { A });
		borders.put(D, new Territory[] { B });
		
	}

}