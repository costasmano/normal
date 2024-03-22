// ----------------------------------------------------
// Object Method: aIt8OwnerDesIncluded
// User name (OS): cjmiller
// Date and time: 04/19/05, 13:55:14
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2005_CJM03
	Mods_2007_CJM_v5310  //06/20/07 Fix so that if nothing selected, no errors
	Mods_2007_CJM_v5310  //06/28/07 Fix so that if reselect nothing buttons disappear
	Mods_2008_v55  //r005 `04/28/08, 11:30:16     
	Mods_2008_v55  //r006 `05/06/08, 11:13:13     `Make sure if no new bins drop down not visible and data handled correctly
End if 

Case of 
		
	: (Form event code:C388=On Double Clicked:K2:5)
		
		Case of 
			: (PRJ_ExistSelectedBins_atxt<1)
				//: (Substring(PRJ_ExistSelectedBins_atxt{PRJ_ExistSelectedBins_atxt};5;3)=Substring(PRJ_PrimaryBin_txt;1;3))
				//ALERT("You may not move primary bin")
			Else 
				PRJ_MoveSelectedArray(->PRJ_ExistSelectedBins_atxt; ->PRJ_ExstSelectedBinRecordNos_al; ->PRJ_ExstSelectedBinGroup_al; ->PRJ_UnassignedBins_atxt; ->PRJ_UnassignedBinRecordNos_al; ->PRJ_UnassignedBinGroup_al)
				
				OBJECT SET VISIBLE:C603(*; "Move@"; False:C215)
				OBJECT SET VISIBLE:C603(*; "Assign@"; False:C215)
				
		End case 
		PRJ_ExistSelected_txt:=""
		
	: (Form event code:C388=On Clicked:K2:4)
		OBJECT SET VISIBLE:C603(*; "Move@"; False:C215)
		OBJECT SET VISIBLE:C603(*; "Assign@"; False:C215)
		PRJ_ExistSelected_txt:=PRJ_ExistSelectedBins_atxt{PRJ_ExistSelectedBins_atxt}
		
		Case of 
			: (PRJ_ExistSelectedBins_atxt<1)
				OBJECT SET VISIBLE:C603(*; "Move@"; False:C215)
				//: (Substring(PRJ_ExistSelectedBins_atxt{PRJ_ExistSelectedBins_atxt};5;3)=Substring(PRJ_PrimaryBin_txt;1;3))
				//ALERT("You may not move primary bin")
				//PRJ_ExistSelectedBins_atxt:=0
			Else 
				OBJECT SET VISIBLE:C603(*; "MovetoUnassigned1@"; True:C214)
		End case 
		
End case 

//End Object Method: aIt8OwnerDesIncluded