//%attributes = {"invisible":true}
//Method: PON_SETARRAYS
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 02/20/15, 09:36:21
	// ----------------------------------------------------
	//Created : 
	Mods_2015_02
End if 
//

// Master Elements
If (Type:C295(PON_MASTERELEM_KEY_aL)#LongInt array:K8:19)
	ARRAY LONGINT:C221(PON_MASTERELEM_KEY_aL; 0)
	ARRAY TEXT:C222(PON_MASTERELEM_Desc_atxt; 0)
End if 
If (Size of array:C274(PON_MASTERELEM_KEY_aL)=0)
	Begin SQL
		select [PON_ELEM_DEFS].ELEM_KEY, [PON_ELEM_DEFS].ELEM_SHORTNAME from
		[PON_ELEM_DEFS]
		where
		[PON_ELEM_DEFS].ELEM_PROTECT_SYS = 'N'
		and
		[PON_ELEM_DEFS].ELEM_SMART_FLAG =  'N'
		order by [PON_ELEM_DEFS].ELEM_KEY ASC
		into :PON_MASTERELEM_KEY_aL, :PON_MASTERELEM_Desc_atxt ;
		
	End SQL
	
	C_LONGINT:C283($loop_L)
	For ($loop_L; 1; Size of array:C274(PON_MASTERELEM_Desc_atxt))
		PON_MASTERELEM_Desc_atxt{$loop_L}:=String:C10(PON_MASTERELEM_KEY_aL{$loop_L})+" : "+PON_MASTERELEM_Desc_atxt{$loop_L}
	End for 
	
End if 

// Protective systems
If (Type:C295(PON_PROTSYSELEM_KEY_aL)#LongInt array:K8:19)
	ARRAY LONGINT:C221(PON_PROTSYSELEM_KEY_aL; 0)
	ARRAY TEXT:C222(PON_PROTSYSELEM_Desc_atxt; 0)
End if 
If (Size of array:C274(PON_PROTSYSELEM_KEY_aL)=0)
	Begin SQL
		select [PON_ELEM_DEFS].ELEM_KEY, [PON_ELEM_DEFS].ELEM_SHORTNAME from
		[PON_ELEM_DEFS]
		where
		[PON_ELEM_DEFS].ELEM_PROTECT_SYS = 'Y'
		and
		[PON_ELEM_DEFS].ELEM_SMART_FLAG =  'N'
		order by [PON_ELEM_DEFS].ELEM_KEY 
		into :PON_PROTSYSELEM_KEY_aL, :PON_PROTSYSELEM_Desc_atxt;
		
	End SQL
	For ($loop_L; 1; Size of array:C274(PON_PROTSYSELEM_Desc_atxt))
		PON_PROTSYSELEM_Desc_atxt{$loop_L}:=String:C10(PON_PROTSYSELEM_KEY_aL{$loop_L})+" : "+PON_PROTSYSELEM_Desc_atxt{$loop_L}
	End for 
End if 

// damage/smart flags
If (Type:C295(PON_SFLAGSELEM_KEY_aL)#LongInt array:K8:19)
	ARRAY LONGINT:C221(PON_SFLAGSELEM_KEY_aL; 0)
	ARRAY TEXT:C222(PON_SFLAGSELEM_Desc_atxt; 0)
End if 
If (Size of array:C274(PON_SFLAGSELEM_KEY_aL)=0)
	Begin SQL
		select [PON_ELEM_DEFS].ELEM_KEY, [PON_ELEM_DEFS].ELEM_SHORTNAME from
		[PON_ELEM_DEFS]
		where
		[PON_ELEM_DEFS].ELEM_PROTECT_SYS = 'N'
		and
		[PON_ELEM_DEFS].ELEM_SMART_FLAG =  'Y'
		order by [PON_ELEM_DEFS].ELEM_KEY 
		into :PON_SFLAGSELEM_KEY_aL, :PON_SFLAGSELEM_Desc_atxt;
		
	End SQL
	
	For ($loop_L; 1; Size of array:C274(PON_SFLAGSELEM_Desc_atxt))
		PON_SFLAGSELEM_Desc_atxt{$loop_L}:=String:C10(PON_SFLAGSELEM_KEY_aL{$loop_L})+" : "+PON_SFLAGSELEM_Desc_atxt{$loop_L}
	End for 
End if 

If (Type:C295(PON_ENVKEY_aL)#LongInt array:K8:19)
	ARRAY LONGINT:C221(PON_ENVKEY_aL; 0)
	ARRAY TEXT:C222(PON_ENVDESC_atxt; 0)
End if 
//ALERT(" NEED A CHANGE HERE for PON_ENVKEY_aL and PON_ENVDESC_atxt")
If (Size of array:C274(PON_ENVKEY_aL)=0)
	Begin SQL
		select [Environments].[Envir No] , [Environments].[Envir Name] from
		[Environments]
		order BY [Environments].[Envir No]  
		into :PON_ENVKEY_aL, :PON_ENVDESC_atxt ;
	End SQL
	
	For ($loop_L; 1; Size of array:C274(PON_ENVDESC_atxt))
		PON_ENVDESC_atxt{$loop_L}:=String:C10(PON_ENVKEY_aL{$loop_L})+" : "+PON_ENVDESC_atxt{$loop_L}
	End for 
End if 
//End PON_SETARRAYS