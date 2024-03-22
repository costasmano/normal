//Method: Object Method: [PON_ELEM_INSP].SearchNBE.NBESearch_ProtSys_L
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 07/07/15, 17:46:20
	// ----------------------------------------------------
	//Created : 
	Mods_2015_07
End if 
//
//Set the element selection array of LB1 to the protective systems
Case of 
		
	: (Form event code:C388=On Clicked:K2:4)
		If (NBESearch_ProtSys_L=1)
			COPY ARRAY:C226(PON_PROTSYSELEM_Desc_atxt; SRC_PON_ELEMSELECTLB1_atxt)
			COPY ARRAY:C226(PON_PROTSYSELEM_KEY_aL; SRC_PON_ELEMSELECTLB1_aL)
			INSERT IN ARRAY:C227(SRC_PON_ELEMSELECTLB1_aL; 1; 1)
			INSERT IN ARRAY:C227(SRC_PON_ELEMSELECTLB1_atxt; 1; 1)
			SRC_PON_ELEMSELECTLB1_atxt{1}:=" Clear..."
			
			NBESearch_Defect_1:=0
			OBJECT SET VISIBLE:C603(*; "NBESearch_Defect_2"; True:C214)
			OBJECT SET VISIBLE:C603(*; "NBESearch_LB2"; True:C214)
		Else 
			
		End if 
		
End case 

//End Object Method: [PON_ELEM_INSP].SearchNBE.NBESearch_ProtSys_L