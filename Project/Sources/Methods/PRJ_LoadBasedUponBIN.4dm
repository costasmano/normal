//%attributes = {"invisible":true}
// ----------------------------------------------------
// PRJ_LoadBasedUponBIN
// User name (OS): cjmiller
// Date and time: 03/31/06, 13:40:15
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2006_CJMv2
	// Modified by: costasmanousakis-(Designer)-(5/24/10 15:30:52)
	Mods_2010_05
	//  `PRJ_RatingApprovedDate_s = [Conslt Rating]NBISLetter
End if 
If ([PRJ_ProjectDetails:115]PRJ_PrimaryBin_s:34#"")
	//lets filll deck area and load
	QUERY:C277([Bridge Design:75]; [Bridge Design:75]BIN:1=[PRJ_ProjectDetails:115]PRJ_PrimaryBin_s:34)
	If (Records in selection:C76([Bridge Design:75])=0)
		PRJ_DeckArea_s:=""
		PRJ_Material_s:=""
		
	Else 
		If ([Bridge Design:75]MetricUnit:38)
			PRJ_DeckAreaUnits_s:="SQ Meters"
		Else 
			PRJ_DeckAreaUnits_s:="SQ Feet"
		End if 
		PRJ_Material_s:=[Bridge Design:75]SuperStruct:11
		PRJ_DeckArea_s:=String:C10(Round:C94(([Bridge Design:75]StructLength:43*[Bridge Design:75]WideOutToOut:26); 0))
	End if 
	QUERY:C277([Conslt Rating:63]; [Conslt Rating:63]BIN:1=[PRJ_ProjectDetails:115]PRJ_PrimaryBin_s:34)
	If (Records in selection:C76([Conslt Rating:63])=0)
		PRJ_RatingReceivedDate_s:=""
		PRJ_RatingApprovedDate_s:=""
	Else 
		PRJ_RatingReceivedDate_s:=String:C10([Conslt Rating:63]RepSubmit1:23; 7)
		PRJ_RatingApprovedDate_s:=String:C10([Conslt Rating:63]NBISLetter:26; 7)
	End if 
End if 

//End PRJ_LoadBasedUponBIN