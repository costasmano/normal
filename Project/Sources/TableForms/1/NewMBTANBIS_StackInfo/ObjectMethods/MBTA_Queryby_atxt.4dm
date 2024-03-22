
//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 02/14/13, 13:25:24
//----------------------------------------------------
//Method: Object Method: [Bridge MHD NBIS].NBIS Stack Info MBTA.MBTA_Queryby_atxt
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2013_02  //r001 ` 
	//Modified by: Charles Miller (2/21/13 13:31:16)
	// Modified by: Costas Manousakis-(Designer)-(3/29/13 10:21:41)
	Mods_2013_03
	//  `Changed 1st label to "Filter" from "Query" - Added All records at the end of the list
End if 
Case of 
	: (Form event code:C388=On Clicked:K2:4)
		If (MBTA_Queryby_atxt>1)
			C_TEXT:C284($WindowTitle_txt)
			$WindowTitle_txt:=MainTitle
			USE NAMED SELECTION:C332("UserRegionA")
			Case of 
				: (MBTA_Queryby_atxt=4)
					QUERY SELECTION:C341([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]Item8 BridgeCat:207="RRO")
					$WindowTitle_txt:=$WindowTitle_txt+" - Commuter Rail "
					
					
				: (MBTA_Queryby_atxt=3)
					QUERY SELECTION:C341([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]Item8 BridgeCat:207="TRO")
					$WindowTitle_txt:=$WindowTitle_txt+" - Transit "
					
					
				: (MBTA_Queryby_atxt=2)
					mbta_ReturnHwySelection
					$WindowTitle_txt:=$WindowTitle_txt+" - Highway "
					
				: (MBTA_Queryby_atxt=5)
					QUERY SELECTION:C341([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]Item8 BridgeCat:207="PED")
					$WindowTitle_txt:=$WindowTitle_txt+" - Pedestrian "
					
					
			End case 
			If (MBTA_Queryby_atxt#2)
				mbta_SortRecords
			End if 
			SET WINDOW TITLE:C213($WindowTitle_txt+" ["+String:C10(Records in selection:C76([Bridge MHD NBIS:1]))+"]")
			//MBTA_Queryby_atxt:=1
		End if 
	: (Form event code:C388=On Load:K2:1)
		ARRAY TEXT:C222(MBTA_Queryby_atxt; 0)
		ARRAY TEXT:C222(MBTA_Queryby_atxt; 6)
		MBTA_Queryby_atxt{1}:="Filter By Bridge Category"
		MBTA_Queryby_atxt{2}:="Highway"
		MBTA_Queryby_atxt{3}:="Transit"
		MBTA_Queryby_atxt{4}:="Commuter Rail"
		MBTA_Queryby_atxt{5}:="Pedestrian"
		MBTA_Queryby_atxt{6}:="All Records"
		MBTA_Queryby_atxt:=1
		
End case 
//End Object Method: [Bridge MHD NBIS].NBIS Stack Info MBTA.MBTA_Queryby_atxt

