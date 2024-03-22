If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 01/20/11, 12:09:46
	// ----------------------------------------------------
	// Method: Form Method: [Inspections];"RailRoutinePrPg1"
	// Description
	// Copied from [Inspections];"Routine Pr Pg 1"
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2011_01
	// Modified by: manousakisc (11/30/2011)
	Mods_2011_11
	//  `Changed object names so that they are not platform specific. Removed the set visible commands;
	//  `in the form changes the Reference from tracks under to Item 45
	// Modified by: Costas Manousakis-(Designer)-(4/5/12 16:00:38)
	Mods_2012_04
	//  `Make sure the [RailBridgeInfo] record is loaded
	// Modified by: Costas Manousakis-(Designer)-(12/27/12 10:13:05)
	Mods_2012_12
	//  `Use new method INSP_RailRtnPg1_FM 
	// Modified by: Costas Manousakis-(Designer)-(7/29/13 11:33:18)
	Mods_2013_07
	//  `Modified print forms for MBTA to display the title MBTA Area engineer only.
	// Modified by: Costas Manousakis-(Designer)-(1/16/15 10:47:07)
	Mods_2015_01
	//  `fix  : vRN59_8 was incorrectly coded as vRN59_7
	// Modified by: Costas Manousakis-(Designer)-(4/14/16 17:44:05)
	Mods_2016_04_bug
	//  `Modified to show Dive ratings
	// Modified by: Costas Manousakis-(Designer)-(9/6/16 09:48:23)
	Mods_2016_09
	//  `fixed variable for Dive column vRdN60_10
	
End if 

INSP_RailRtnPg1_FM