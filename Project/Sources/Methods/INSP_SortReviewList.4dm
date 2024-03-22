//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 06/02/10, 08:34:52
	// ----------------------------------------------------
	// Method: INSP_SortReviewList
	// Description
	//  ` Sort the Pending Inspections List form. New method to be called instead of getting called on the 
	//  `On Header event of the review form
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2010_06
	// Modified by: costasmanousakis-(Designer)-(11/10/11 08:14:07)
	Mods_2011_11
	//  `Removed ut_Send2Clipboard calls
	
End if 
C_LONGINT:C283($lLevelNb; $i)
$lLevelNb:=Size of array:C274(aPtrSortField)
If ($lLevelNb>0)  //There is at least one order level
	//ut_Send2Clipboard ("     "+"MultiSort"+"-"+String(Milliseconds)+Char(13);"Prepend")
	For ($i; 1; $lLevelNb)
		If ((aPtrSortOrder{$i})->=1)
			ORDER BY:C49(MultiLevelTBL->; (aPtrSortField{$i})->; >; *)  //Building sort definition
		Else 
			ORDER BY:C49(MultiLevelTBL->; (aPtrSortField{$i})->; <; *)  //Building sort definition
		End if 
		
	End for 
	ORDER BY:C49(MultiLevelTBL->)  //No * ends the sort definition and starts the actual sort operation
End if 
Case of 
	: (SorttmLdr=1)
		INSP_SortByTmLeader(SorttmLdr)
		//ut_Send2Clipboard ("     "+"INSP_SortByTmLeader"+"-"+String(Milliseconds)+Char(13);"Prepend")
	: (SorttmLdr=2)
		INSP_SortByTmLeader(SorttmLdr)
		//ut_Send2Clipboard ("     "+"INSP_SortByTmLeader"+"-"+String(Milliseconds)+Char(13);"Prepend")
	: (SortBdept=1)
		INSP_SortbyBDEPT(SortBdept)
		//ut_Send2Clipboard ("     "+"INSP_SortbyBDEPT"+"-"+String(Milliseconds)+Char(13);"Prepend")
	: (SortBdept=2)
		INSP_SortbyBDEPT(SortBdept)
		//ut_Send2Clipboard ("     "+"INSP_SortbyBDEPT"+"-"+String(Milliseconds)+Char(13);"Prepend")
End case 
UNLOAD RECORD:C212([Inspections:27])
//vbSortedHeader:=True  `set this to indicate we're done with the header.
//REDRAW WINDOW