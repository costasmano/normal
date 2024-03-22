//%attributes = {"invisible":true}
//Method: BridgeRank
//Description
// Run the Bridge ranking calculations
// options :`
// Source of bridge data
//  ` use the bridge table
//  ` copy data from bridg table to archive bridge table - purpose will be "BRIDGERANK"
//  `  ` under current date
//  `use data from the archive table on a specific date.
// source of Pontis metrics
//  ` specify date of pontis metrics
// output
//  ` save results to db
//  ` export results to file
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 03/20/14, 16:43:17
	// ----------------------------------------------------
	//Created : 
	Mods_2014_03
End if 
//
C_BOOLEAN:C305(BridgeRankUseArchive_b)
C_DATE:C307(BridgeRankArchiveDate_d)
C_DATE:C307(BridgeRankPontisMetricDate_d)

BrgRank_DoRankCalc

//End BridgeRank