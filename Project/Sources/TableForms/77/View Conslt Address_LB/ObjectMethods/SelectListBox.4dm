//Method: [Conslt Address].View Conslt Address_LB.SelectListBox
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 07/09/19, 15:00:19
	// ----------------------------------------------------
	//Created : 
	Mods_2019_07
	// Modified by: Costas Manousakis-(Designer)-(2021-10-06)
	Mods_2021_10
	//  `made LB focusable -not tabable-hide focus rect.- enable after sort event [ all columns static
	//  `clean up sort code
	//  `Return $0 to handle sorting
	//  `unload record after sort and on header click
End if 
C_LONGINT:C283($0)
$0:=0
//
Case of 
	: (Form event code:C388=On Header Click:K2:40)
		
		C_TEXT:C284($nameofObj_txt)
		C_LONGINT:C283($dumTbl_L; $dumFld_L)
		RESOLVE POINTER:C394(Self:C308; $nameofObj_txt; $dumTbl_L; $dumFld_L)
		
		Case of 
				
			: ($nameofObj_txt="LB_Header2_l")
				ARRAY TEXT:C222($SortArray_atxt; 0)
				If (Self:C308->>1)
					
					ORDER BY:C49([Conslt Address:77]; [Conslt Address:77]ContactLName:4; >)
					
					LB_Header2_l:=1
				Else 
					ORDER BY:C49([Conslt Address:77]; [Conslt Address:77]ContactLName:4; <)
					
					LB_Header2_l:=2
				End if 
				$0:=-1
				
			: ($nameofObj_txt="LB_Header3_l")
				ConsAddress_sortFunction
				$0:=-1
				
			: ($nameofObj_txt="LB_Header4_l")
				ALERT:C41("sorting is not availabe for the address column")
				$0:=-1
			: ($nameofObj_txt="LB_Header5_l")
				ALERT:C41("sorting is not availabe for the city/state/zip column")
				$0:=-1
				
		End case 
		UNLOAD RECORD:C212(Current form table:C627->)
		
	: (Form event code:C388=On After Sort:K2:28)
		UNLOAD RECORD:C212(Current form table:C627->)
		
End case 
//End [Conslt Address].View Conslt Address_LB.SelectListBox