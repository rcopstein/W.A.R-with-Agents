
/* Initial beliefs and rules */



/* Initial goals */

!start.

/* Plans */

+!start : true <-
	distance("A", "D", D)
	borders("A", B)
	.print(B)
	.print(D)
	.

{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }