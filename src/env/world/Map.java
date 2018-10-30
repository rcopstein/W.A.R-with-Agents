package world;

import java.util.List;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Queue;
import java.util.concurrent.ArrayBlockingQueue;

import cartago.*;

public class Map extends Artifact {
	
	// Singleton
	
	private static Map _instance = null;
	public static Map getInstance() { return _instance; }
	
	// Variables
	
	ArrayList<Territory> territories;
	HashMap<Territory, Territory[]> borders;
	
	// Getters
	
	public List<Territory> getTerritories() {
		return territories;
	}
	
	// Functions
	
	private Territory _getTerritory(String name) {
		for (Territory territory : territories) {
			if (territory.getName().equals(name)) {
				return territory;
			}
		}
		
		return null;
	}
	private int _distanceToTerritory(Territory a, Territory b) {
		
		Queue<Territory> stack = new ArrayBlockingQueue<Territory>(territories.size());
		Queue<Integer> dists = new ArrayBlockingQueue<Integer>(territories.size());
		HashSet<Territory> marks = new HashSet<Territory>();
		
		stack.add(a);
		dists.add(0);
		marks.add(a);
		
		while (!stack.isEmpty()) {
			
			Territory t = stack.poll();
			Integer d = dists.poll();
			
			if (t == b) return d;
			
			for (Territory tt : borders.get(t)) {
				if (!marks.contains(tt)) {
					stack.add(tt);
					dists.add(d+1);
				}
			}
			
			marks.add(t);
			
		}
		
		return -1;
		
	}
	
	// Operations
	
	@OPERATION
	void attack(String name, OpFeedbackParam<Boolean> result) {
		
		Territory t = _getTerritory(name);
		result.set(t != null);
		
	}
	@OPERATION
	void borders(String from, OpFeedbackParam<String[]> result) {
		
		Territory t = _getTerritory(from);
		Territory[] b = borders.get(t);
		
		String[] s = new String[b.length];
		for (int i = 0; i < b.length; ++i) s[i] = b[i].getName(); 
		
		result.set(s);
		
	}
	@OPERATION
	void distance(String from, String to, OpFeedbackParam<Integer> result) {
		
		Territory a = _getTerritory(from);
		Territory b = _getTerritory(to);
		
		result.set(_distanceToTerritory(a, b));
		
	}
	
	// Constructor
	
	void init() {
		
		territories = new ArrayList<Territory>();
		borders = new HashMap<Territory, Territory[]>();
		
		initTerritories();
		_instance = this;
		
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