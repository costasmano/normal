//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 10/20/09, 20:16:26
	// ----------------------------------------------------
	// Method: ut_Distr6Towns
	// Description
	//  `A query for the records in [Town Data] that will be part of the new D6
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2009_10("MASSDOT")
	// Modified by: costasmanousakis-(Designer)-(7/1/11 14:12:56)
	Mods_2011_06
	//  `Removed Somerville from the D6 towns
	
End if 

QUERY:C277([Town Data:2]; [Town Data:2]Town Name:1="Boston"; *)
QUERY:C277([Town Data:2];  | ; [Town Data:2]Town Name:1="Braintree"; *)
QUERY:C277([Town Data:2];  | ; [Town Data:2]Town Name:1="Brookline"; *)
QUERY:C277([Town Data:2];  | ; [Town Data:2]Town Name:1="Cambridge"; *)
QUERY:C277([Town Data:2];  | ; [Town Data:2]Town Name:1="Canton"; *)
QUERY:C277([Town Data:2];  | ; [Town Data:2]Town Name:1="Chelsea"; *)
QUERY:C277([Town Data:2];  | ; [Town Data:2]Town Name:1="Dedham"; *)
QUERY:C277([Town Data:2];  | ; [Town Data:2]Town Name:1="Dover"; *)
QUERY:C277([Town Data:2];  | ; [Town Data:2]Town Name:1="Milton"; *)
QUERY:C277([Town Data:2];  | ; [Town Data:2]Town Name:1="Needham"; *)
QUERY:C277([Town Data:2];  | ; [Town Data:2]Town Name:1="Newton"; *)
QUERY:C277([Town Data:2];  | ; [Town Data:2]Town Name:1="Quincy"; *)
QUERY:C277([Town Data:2];  | ; [Town Data:2]Town Name:1="Randolph"; *)
//QUERY([Town Data]; | ;[Town Data]Town Name="Somerville";*)
QUERY:C277([Town Data:2];  | ; [Town Data:2]Town Name:1="Watertown"; *)
QUERY:C277([Town Data:2];  | ; [Town Data:2]Town Name:1="Wellesley"; *)
QUERY:C277([Town Data:2];  | ; [Town Data:2]Town Name:1="Weston"; *)
QUERY:C277([Town Data:2];  | ; [Town Data:2]Town Name:1="Westwood"; *)
QUERY:C277([Town Data:2];  | ; [Town Data:2]Town Name:1="Weymouth"; *)
QUERY:C277([Town Data:2];  | ; [Town Data:2]Town Name:1="Winthrop"; *)
QUERY:C277([Town Data:2])