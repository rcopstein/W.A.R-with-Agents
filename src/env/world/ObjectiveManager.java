package world;

import java.util.List;
import java.util.Random;
import java.util.HashSet;

import cartago.*;

public class ObjectiveManager extends Artifact {
	
	// Variables
	
	int given = 0;
	
	// Operations
	
	@OPERATION
	public void getObjective(OpFeedbackParam<String> objective, OpFeedbackParam<String[]> who, OpFeedbackParam<Integer> howMany) {
		
		Random r = new Random();
		if (r.nextInt() % 2 == 0) {
			
			// Specific Countries
			
			HashSet<Territory> territories = new HashSet<Territory>();
			List<Territory> allTerritories = Map.getInstance().getTerritories();
			
			while (territories.size() < allTerritories.size() / 2) {
				territories.add(allTerritories.get(r.nextInt(allTerritories.size())));
			}
			
			int aux = 0;
			String[] toConquer = new String[territories.size()];
			for (Territory t : territories) toConquer[aux++] = t.getName();
			
			objective.set("conquer");
			who.set(toConquer);
			
		}
		else {
			
			// Number of Countries
			
			objective.set("count");
			howMany.set(2);
			
		}
		
		++given;
		if (given == RoundManager.getInstance().getNumPlayers()) RoundManager.getInstance().allObjectivesGiven();
	}
	
	// Constructor
	
	void init() {}
	
}

