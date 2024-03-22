If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 09/14/05, 12:54:54
	// ----------------------------------------------------
	// Method: Form Method: CondUnitsPrt3
	// Description
	// 
	//
	// Parameters
	// ----------------------------------------------------
	Mods_2005_CM17
	// Modified by: Costas Manousakis-(Designer)-(9/14/16 )
	Mods_2016_09
	//  //added search on BMS Elements
End if 


Case of 
		
	: (Form event code:C388=On Printing Detail:K2:18)
		READ ONLY:C145([BMS Elements:47])
		QUERY:C277([BMS Elements:47]; [BMS Elements:47]Element ID:1=[Cond Units:45]Element ID:3)
		DISPLAY_1CU
		
End case 