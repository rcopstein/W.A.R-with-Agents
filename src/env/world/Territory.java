package world;

public class Territory {

	// Variables

	int power;
	String name;
	String owner;
	
	// Getters

	public int getPower() {
		return power;
	}
	
	public String getName() {
		return name;
	}
	
	public String getOwner() {
		return owner;
	}
	
	// Constructor
	
	public Territory(String name) {
		this.power = 0;
		this.name = name;
		this.owner = null;
	}
	
}
