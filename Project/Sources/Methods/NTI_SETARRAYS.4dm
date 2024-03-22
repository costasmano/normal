//%attributes = {"invisible":true}
//Method: NTI_SETARRAYS
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 04/21/16, 17:01:52
	// ----------------------------------------------------
	//Created : 
	Mods_2016_NTE
End if 
//

// Master Elements
If (Type:C295(NTI_MASTERELEM_KEY_aL)#LongInt array:K8:19)
	ARRAY LONGINT:C221(NTI_MASTERELEM_KEY_aL; 0)
	ARRAY TEXT:C222(NTI_MASTERELEM_Desc_atxt; 0)
End if 
C_LONGINT:C283($loop_L; $sortindx_L)
ARRAY TEXT:C222($Category_atxt; 0)
If (Size of array:C274(NTI_MASTERELEM_KEY_aL)=0)
	Begin SQL
		select [NTI_ELEM_DEFS].ELEM_KEY, [NTI_ELEM_DEFS].ELEM_SHORTNAME, [NTI_ELEM_DEFS].[ELEM_CATEGORY] from
		[NTI_ELEM_DEFS]
		where
		[NTI_ELEM_DEFS].ELEM_PROTECT_SYS = 'N'
		and
		[NTI_ELEM_DEFS].[DEFECTFLAG] =  'N'
		and
		[NTI_ELEM_DEFS].[ELEM_BINONLY] = 'Y'
		order by
		[NTI_ELEM_DEFS].[ELEM_CATEGORY] ASC, 
		[NTI_ELEM_DEFS].[ELEM_KEY] ASC
		into :NTI_MASTERELEM_KEY_aL, :NTI_MASTERELEM_Desc_atxt, :$Category_atxt ;
		
	End SQL
	
	For ($loop_L; 1; Size of array:C274(NTI_MASTERELEM_Desc_atxt))
		NTI_MASTERELEM_Desc_atxt{$loop_L}:=$Category_atxt{$loop_L}+" - "+String:C10(NTI_MASTERELEM_KEY_aL{$loop_L})+" : "+NTI_MASTERELEM_Desc_atxt{$loop_L}
	End for 
	C_TEXT:C284($defectRef_txt)
	ARRAY TEXT:C222($ElementRefs_atxt; 0)
	ARRAY LONGINT:C221($SortTool_aL; Size of array:C274(NTI_MASTERELEM_KEY_aL))
	
	$defectRef_txt:=DOM Find XML element:C864(NTI_DEFECT_ELEM_TREE; "NTI_ELEMDEFECTS/Element"; $ElementRefs_atxt)
	ARRAY LONGINT:C221($SortedElemRefs_aL; Size of array:C274($ElementRefs_atxt))
	For ($loop_L; 1; Size of array:C274($ElementRefs_atxt))
		DOM GET XML ELEMENT VALUE:C731($ElementRefs_atxt{$loop_L}; $SortedElemRefs_aL{$loop_L})
		//$SortedElemRefs_aL{$loop_L}:=Find in array($ElementRefs_atxt;String(NTI_MASTERELEM_KEY_aL{$loop_L}))
	End for 
	
	For ($loop_L; 1; Size of array:C274($SortTool_aL))
		$SortTool_aL{$loop_L}:=Find in array:C230($SortedElemRefs_aL; NTI_MASTERELEM_KEY_aL{$loop_L})
	End for 
	SORT ARRAY:C229($SortTool_aL; NTI_MASTERELEM_KEY_aL; NTI_MASTERELEM_Desc_atxt)
	
End if 

//Tin only elements
If (Type:C295(NTI_MASTER_TIN_KEY_aL)#LongInt array:K8:19)
	ARRAY LONGINT:C221(NTI_MASTER_TIN_KEY_aL; 0)
	ARRAY TEXT:C222(NTI_MASTER_TIN_Desc_atxt; 0)
End if 

ARRAY TEXT:C222($Category_atxt; 0)

If (Size of array:C274(NTI_MASTER_TIN_KEY_aL)=0)
	Begin SQL
		select [NTI_ELEM_DEFS].ELEM_KEY, [NTI_ELEM_DEFS].ELEM_SHORTNAME, [NTI_ELEM_DEFS].[ELEM_CATEGORY] from
		[NTI_ELEM_DEFS]
		where
		[NTI_ELEM_DEFS].ELEM_PROTECT_SYS = 'N'
		and
		[NTI_ELEM_DEFS].[DEFECTFLAG] =  'N'
		and
		[NTI_ELEM_DEFS].[ELEM_TIN_ONLY] = 'Y'
		order by
		[NTI_ELEM_DEFS].[ELEM_CATEGORY] ASC, 
		[NTI_ELEM_DEFS].ELEM_KEY ASC
		into :NTI_MASTER_TIN_KEY_aL, :NTI_MASTER_TIN_Desc_atxt, :$Category_atxt ;
		
	End SQL
	For ($loop_L; 1; Size of array:C274(NTI_MASTER_TIN_Desc_atxt))
		NTI_MASTER_TIN_Desc_atxt{$loop_L}:=$Category_atxt{$loop_L}+" - "+String:C10(NTI_MASTER_TIN_KEY_aL{$loop_L})+" : "+NTI_MASTER_TIN_Desc_atxt{$loop_L}
	End for 
	
	C_TEXT:C284($defectRef_txt)
	ARRAY TEXT:C222($ElementRefs_atxt; 0)
	ARRAY LONGINT:C221($SortTool_aL; Size of array:C274(NTI_MASTER_TIN_KEY_aL))
	
	$defectRef_txt:=DOM Find XML element:C864(NTI_DEFECT_ELEM_TREE; "NTI_ELEMDEFECTS/Element"; $ElementRefs_atxt)
	ARRAY LONGINT:C221($SortedElemRefs_aL; Size of array:C274($ElementRefs_atxt))
	For ($loop_L; 1; Size of array:C274($ElementRefs_atxt))
		DOM GET XML ELEMENT VALUE:C731($ElementRefs_atxt{$loop_L}; $SortedElemRefs_aL{$loop_L})
		//$SortedElemRefs_aL{$loop_L}:=Find in array($ElementRefs_atxt;String(NTI_MASTERELEM_KEY_aL{$loop_L}))
	End for 
	For ($loop_L; 1; Size of array:C274($SortTool_aL))
		$SortTool_aL{$loop_L}:=Find in array:C230($SortedElemRefs_aL; NTI_MASTER_TIN_KEY_aL{$loop_L})
	End for 
	SORT ARRAY:C229($SortTool_aL; NTI_MASTER_TIN_KEY_aL; NTI_MASTER_TIN_Desc_atxt)
	
End if 

// Protective systems
If (Type:C295(NTI_PROTSYSELEM_KEY_aL)#LongInt array:K8:19)
	ARRAY LONGINT:C221(NTI_PROTSYSELEM_KEY_aL; 0)
	ARRAY TEXT:C222(NTI_PROTSYSELEM_Desc_atxt; 0)
End if 
If (Size of array:C274(NTI_PROTSYSELEM_KEY_aL)=0)
	Begin SQL
		select [NTI_ELEM_DEFS].ELEM_KEY, [NTI_ELEM_DEFS].ELEM_SHORTNAME from
		[NTI_ELEM_DEFS]
		where
		[NTI_ELEM_DEFS].ELEM_PROTECT_SYS = 'Y'
		and
		[NTI_ELEM_DEFS].DEFECTFLAG =  'N'
		order by [NTI_ELEM_DEFS].ELEM_KEY 
		into :NTI_PROTSYSELEM_KEY_aL, :NTI_PROTSYSELEM_Desc_atxt;
		
	End SQL
	For ($loop_L; 1; Size of array:C274(NTI_PROTSYSELEM_Desc_atxt))
		NTI_PROTSYSELEM_Desc_atxt{$loop_L}:=String:C10(NTI_PROTSYSELEM_KEY_aL{$loop_L})+" : "+NTI_PROTSYSELEM_Desc_atxt{$loop_L}
	End for 
End if 
// damage/smart flags
If (Type:C295(NTI_SFLAGSELEM_KEY_aL)#LongInt array:K8:19)
	ARRAY LONGINT:C221(NTI_SFLAGSELEM_KEY_aL; 0)
	ARRAY TEXT:C222(NTI_SFLAGSELEM_Desc_atxt; 0)
End if 
If (Size of array:C274(NTI_SFLAGSELEM_KEY_aL)=0)
	Begin SQL
		select [NTI_ELEM_DEFS].ELEM_KEY, [NTI_ELEM_DEFS].ELEM_SHORTNAME from
		[NTI_ELEM_DEFS]
		where
		[NTI_ELEM_DEFS].[DEFECTFLAG] =  'Y'
		order by [NTI_ELEM_DEFS].ELEM_KEY 
		into :NTI_SFLAGSELEM_KEY_aL, :NTI_SFLAGSELEM_Desc_atxt;
		
	End SQL
	
	For ($loop_L; 1; Size of array:C274(NTI_SFLAGSELEM_Desc_atxt))
		NTI_SFLAGSELEM_Desc_atxt{$loop_L}:=String:C10(NTI_SFLAGSELEM_KEY_aL{$loop_L})+" : "+NTI_SFLAGSELEM_Desc_atxt{$loop_L}
	End for 
End if 

//End NTI_SETARRAYS