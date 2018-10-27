
/* Initial beliefs and rules */



/* Initial goals */

!start.

/* Plans */

+!start : true <-
	attack("A", T);
	if (T) {
		.print("Conquered!");
		+conquer("A")
	}
	else {
		.print("Didn't conquer!");
		+conquer("A")
	}
	.

{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }