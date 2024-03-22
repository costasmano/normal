//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 03/10/06, 15:56:14
	// ----------------------------------------------------
	// Method: SC_CalcTravelCost
	// Description
	// Calculate the Travel cost Part of the total Failure Cost
	// 
	// Parameters
	// ----------------------------------------------------
	Mods_2006_CM03
End if 
C_REAL:C285($0; $TimeCost_r)
C_REAL:C285($1; $ReplaceDur_r; $2; $AdjustDetLen_r)
$ReplaceDur_r:=$1
$AdjustDetLen_r:=$2

$TimeCost_r:=(SC_TravelCostPassenger_r*SC_Occupancy_r*(1-([Bridge MHD NBIS:1]Item109:90/100)))
$TimeCost_r:=$TimeCost_r+(SC_TravelCostTruck_r*([Bridge MHD NBIS:1]Item109:90/100))
$TimeCost_r:=($TimeCost_r*(365*$ReplaceDur_r)*$AdjustDetLen_r*[Bridge MHD NBIS:1]Item29:88)/SC_DesignSpeed_r

$0:=$TimeCost_r