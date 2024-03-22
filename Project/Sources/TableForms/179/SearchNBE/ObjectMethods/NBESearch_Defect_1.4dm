//Method: Object Method: [PON_ELEM_INSP].SearchNBE.NBESearch_Defect_1
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 07/07/15, 17:46:53
	// ----------------------------------------------------
	//Created : 
	Mods_2015_07
End if 
//

If (NBESearch_Defect_1=1)
	NBESearch_ProtSys_L:=0
	
	If (NBESearch_Defect_1=1)
		PON_FindAllowedDefects(SRC_NBEKEY_L; ->SRC_PON_ELEMSELECTLB1_aL)
		If (Size of array:C274(SRC_PON_ELEMSELECTLB1_aL)>0)
			READ ONLY:C145([PON_ELEM_DEFS:178])
			QUERY WITH ARRAY:C644([PON_ELEM_DEFS:178]ELEM_KEY:1; SRC_PON_ELEMSELECTLB1_aL)
			SELECTION TO ARRAY:C260([PON_ELEM_DEFS:178]ELEM_LONGNAME:11; SRC_PON_ELEMSELECTLB1_atxt; [PON_ELEM_DEFS:178]ELEM_KEY:1; SRC_PON_ELEMSELECTLB1_aL)
			SORT ARRAY:C229(SRC_PON_ELEMSELECTLB1_aL; SRC_PON_ELEMSELECTLB1_atxt)
			INSERT IN ARRAY:C227(SRC_PON_ELEMSELECTLB1_aL; 1; 1)
			INSERT IN ARRAY:C227(SRC_PON_ELEMSELECTLB1_atxt; 1; 1)
			SRC_PON_ELEMSELECTLB1_atxt{1}:=" Clear..."
		Else 
			ALERT:C41("Current element "+String:C10(SRC_NBEKEY_L)+" does not have any associated defects!")
		End if 
		
	End if 
Else 
	
	
End if 


//End Object Method: [PON_ELEM_INSP].SearchNBE.NBESearch_Defect_1