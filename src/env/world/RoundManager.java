package world;

import cartago.*;
import jason.asSyntax.Atom;

public class RoundManager extends Artifact {
	
	// Singleton
	
	private static RoundManager _instance;
	public static RoundManager getInstance() { return _instance; }
	
	// Static Variables
	
	static Atom Idle = new Atom("IDLE");
	static Atom Finished = new Atom("FINISHED");
	
	// Variables
	
	int turn = 1;
	int numPlayers = 2;
	String phase = "None";
	
	// Getters
	
	public int getNumPlayers() {
		return numPlayers;
	}
	
	// Methods
	
	public void allObjectivesGiven() {
		
		System.out.println("Done giving objectives!");
		// getObsProperty("round").updateValue(new Atom("player1"));
		
	}
	
	// Operations
	
	@OPERATION
	public void getPhase(OpFeedbackParam<String> phase) {
		phase.set(this.phase);
	}
	@OPERATION
	public void endTurn() {
		if (turn > 0) {
			turn = (turn % numPlayers) + 1;
			getObsProperty("round").updateValue(new Atom("player" + turn));
		}
	}
	
	// Constructor
	
	void init() {
		_instance = this;
		defineObsProperty("round", Idle);
	}
}

