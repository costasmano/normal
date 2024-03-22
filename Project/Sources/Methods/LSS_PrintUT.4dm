//%attributes = {"invisible":true}
//----------------------------------------------------
//User name (OS): administrator
//Date and time: 02/25/15, 12:11:02
//----------------------------------------------------
//Method: LSS_PrintUT
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2014_Lighting  // 
	//Modified by: administrator (2/25/15 12:11:04)
	// Modified by: Costas Manousakis-(Designer)-(1/7/16 13:59:17)
	Mods_2016_01_bug
	//  `added ability to print multiple pages for ut results
	// Modified by: Costas Manousakis-(Designer)-(5/13/16 15:56:03)
	Mods_2016_05_bug
	//  `Sort order for ut results should be location then Rod num.
	// Modified by: Costas Manousakis-(Designer)-(12/15/16 17:18:25)
	Mods_2016_12
	//  `use LSS_SortUTResults
End if 
C_BOOLEAN:C305($1)

QUERY:C277([LSS_UT:175]; [LSS_UT:175]LSS_InspectionId_s:2=[LSS_Inspection:164]LSS_InspectionId_s:1)
C_LONGINT:C283($Loop_L)
For ($Loop_L; 1; Records in selection:C76([LSS_UT:175]))
	GOTO SELECTED RECORD:C245([LSS_UT:175]; $Loop_L)
	QUERY:C277([LSS_UtResult:176]; [LSS_UtResult:176]LSS_UTId_s:2=[LSS_UT:175]LSS_UTId_s:1)
	LSS_SortUTResults
	//ORDER BY([LSS_UtResult];[LSS_UtResult]LSS_Location_txt;>;[LSS_UtResult]LSS_RodNo_L;>)
	ARRAY LONGINT:C221($rods_aL; 0)
	SELECTION TO ARRAY:C260([LSS_UtResult:176]; $rods_aL)  //get the records in order
	//1st page can have 11 rods, other pages 18 rods
	REDUCE SELECTION:C351([LSS_UtResult:176]; 11)  //we can only print 11
	Print form:C5([LSS_UT:175]; "UTPrint")
	
	If (Size of array:C274($rods_aL)>11)
		PAGE BREAK:C6(>)
		C_LONGINT:C283($RodGroupstart_L; $rodcount_L; $RodGroupEnd_L)
		$RodGroupstart_L:=12
		
		Repeat 
			If (Size of array:C274($rods_aL)>($RodGroupstart_L+17))
				$RodGroupEnd_L:=$RodGroupstart_L+17
			Else 
				$RodGroupEnd_L:=Size of array:C274($rods_aL)
			End if 
			
			ARRAY LONGINT:C221($rodstoprint_aL; 0)
			
			For ($rodcount_L; $RodGroupstart_L; $RodGroupEnd_L)
				APPEND TO ARRAY:C911($rodstoprint_aL; $rods_aL{$rodcount_L})
			End for 
			CREATE SELECTION FROM ARRAY:C640([LSS_UtResult:176]; $rodstoprint_aL)
			Print form:C5([LSS_UT:175]; "UTPrintPg2")
			
			
			$RodGroupstart_L:=$RodGroupEnd_L+1
			If ($rodcount_L<Size of array:C274($rods_aL))
				PAGE BREAK:C6(>)
			End if 
		Until ($rodcount_L>Size of array:C274($rods_aL))
	Else 
		If ($1)
			PAGE BREAK:C6(>)
		End if 
	End if 
	
End for 
//End LSS_PrintUT