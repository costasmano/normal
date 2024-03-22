//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 01/06/11, 16:33:21
	// ----------------------------------------------------
	// Method: INSP_VerifyElmtSftyFormVar
	// Description
	// `find what element variables are on forms for inspections. 
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2011_01
	//`Inspection form variables mods : 
	// `find what element variables are on forms for inspections. 
End if 

//search for VRxxxx variable
C_LONGINT:C283($ol; $ot; $or; $ob; $loop_L)
C_POINTER:C301($Var_ptr)
C_BOOLEAN:C305(INSPFORMVARSDO_B)
C_LONGINT:C283(INSPFORMVARMAXNO_L)
If (INSPFORMVARSDO_B)
	For ($loop_L; 1; INSPFORMVARMAXNO_L)
		$Var_ptr:=Get pointer:C304("VR"+String:C10($loop_L))
		OBJECT GET COORDINATES:C663($Var_ptr->; $ol; $ot; $or; $ob)
		If (($ol+$ot+$or+$ob)>0)
			If (Find in array:C230(INSPFORMVARS_AL; $loop_L)>0)
			Else 
				APPEND TO ARRAY:C911(INSPFORMVARS_AL; $loop_L)
			End if 
		End if 
	End for 
	
End if 