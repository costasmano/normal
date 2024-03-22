//%attributes = {"invisible":true,"shared":true}
//Method: PON_FixParentLinks
//Description
// Fix/adjust the Parent and Grandparent Links of an element. 
// use the current values of str unit, env, parent key, grand parent key
// tool is to be executed in user mode by selecting a record from PON_ELEM_INSP table
// method prop : Shared by components and host database
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 01/07/19, 12:03:06
	// ----------------------------------------------------
	//Created : 
	Mods_2019_01
	// Modified by: Costas Manousakis-(Designer)-(1/29/19 10:18:00)
	Mods_2019_01_bug
	//  `don't make changes if found IDs match stored values
End if 
//

// get the current record

C_LONGINT:C283($ElemID_L; $InspID_L; $ParID_L; $GParID_L; $StrU_L; $Env_L; $ParKey_L; $GPKey_L; $elemKey_L)
If (ut_LoadRecordInteractive(->[PON_ELEM_INSP:179]))
	$InspID_L:=[PON_ELEM_INSP:179]INSPID:21
	$ElemID_L:=[PON_ELEM_INSP:179]ELEMID:22
	$ParID_L:=[PON_ELEM_INSP:179]ELEM_PARENTID:27
	$ParKey_L:=[PON_ELEM_INSP:179]ELEM_PARENT_KEY:4
	$StrU_L:=[PON_ELEM_INSP:179]STRUNITKEY:6
	$Env_L:=[PON_ELEM_INSP:179]ENVKEY:5
	$GParID_L:=[PON_ELEM_INSP:179]ELEM_GRANDPARENTID:28
	$GPKey_L:=[PON_ELEM_INSP:179]ELEM_GRANDPARENT_KEY:19
	$elemKey_L:=[PON_ELEM_INSP:179]ELEM_KEY:3
	
	//load the definitions
	ARRAY LONGINT:C221($DefKey_aL; 0)
	ARRAY TEXT:C222($DefDefect_atxt; 0)
	ARRAY TEXT:C222($DefProtsys_atxt; 0)
	Begin SQL
		select 
		[PON_ELEM_DEFS].[ELEM_KEY] ,
		[PON_ELEM_DEFS].[ELEM_PROTECT_SYS] ,
		[PON_ELEM_DEFS].[ELEM_SMART_FLAG]
		from [PON_ELEM_DEFS]
		into 
		:$DefKey_aL ,
		:$DefProtsys_atxt ,
		:$DefDefect_atxt ;
	End SQL
	
	//load the inspection elements
	ARRAY LONGINT:C221($ElemIDs_aL; 0)
	ARRAY LONGINT:C221($ElemKeys_aL; 0)
	ARRAY LONGINT:C221($ElemParKeys_aL; 0)
	ARRAY LONGINT:C221($ElemGParKeys_aL; 0)
	ARRAY LONGINT:C221($ElemStrU_aL; 0)
	ARRAY LONGINT:C221($ElemEnv_aL; 0)
	
	Begin SQL
		select 
		[PON_ELEM_INSP].[ELEMID] ,
		[PON_ELEM_INSP].[ELEM_KEY] ,
		[PON_ELEM_INSP].[ELEM_PARENT_KEY] ,
		[PON_ELEM_INSP].[STRUNITKEY] ,
		[PON_ELEM_INSP].[ENVKEY] ,
		[PON_ELEM_INSP].[ELEM_GRANDPARENT_KEY]
		from [PON_ELEM_INSP]
		where 
		[PON_ELEM_INSP].[INSPID] = :$InspID_L and
		[PON_ELEM_INSP].[ELEMID] <> :$ElemID_L
		into 
		:$ElemIDs_aL ,
		:$ElemKeys_aL ,
		:$ElemParKeys_aL ,
		:$ElemStrU_aL ,
		:$ElemEnv_aL ,
		:$ElemGParKeys_aL ;
	End SQL
	
	//build lookup array
	ARRAY TEXT:C222($Lookup_atxt; Size of array:C274($ElemIDs_aL))
	
	C_TEXT:C284($StuFmt_txt; $EnvFmt_txt; $keyFmt_txt)
	$StuFmt_txt:="000"
	$EnvFmt_txt:="000"
	$keyFmt_txt:="000000"
	
	C_LONGINT:C283($loop_L)
	For ($loop_L; 1; Size of array:C274($ElemKeys_aL))
		
		Case of 
			: ($ElemParKeys_aL{$loop_L}=0)
				$Lookup_atxt{$loop_L}:=String:C10($ElemStrU_aL{$loop_L}; $StuFmt_txt)+String:C10($ElemEnv_aL{$loop_L}; $EnvFmt_txt)+\
					String:C10($ElemKeys_aL{$loop_L}; $keyFmt_txt)+\
					String:C10(0; $keyFmt_txt)+\
					String:C10(0; $keyFmt_txt)
			: ($ElemParKeys_aL{$loop_L}>0) & ($ElemGParKeys_aL{$loop_L}=0)
				$Lookup_atxt{$loop_L}:=String:C10($ElemStrU_aL{$loop_L}; $StuFmt_txt)+String:C10($ElemEnv_aL{$loop_L}; $EnvFmt_txt)+\
					String:C10($ElemParKeys_aL{$loop_L}; $keyFmt_txt)+\
					String:C10($ElemKeys_aL{$loop_L}; $keyFmt_txt)+\
					String:C10(0; $keyFmt_txt)
			: ($ElemParKeys_aL{$loop_L}>0) & ($ElemGParKeys_aL{$loop_L}>0)
				$Lookup_atxt{$loop_L}:=String:C10($ElemStrU_aL{$loop_L}; $StuFmt_txt)+String:C10($ElemEnv_aL{$loop_L}; $EnvFmt_txt)+\
					String:C10($ElemGParKeys_aL{$loop_L}; $keyFmt_txt)+\
					String:C10($ElemParKeys_aL{$loop_L}; $keyFmt_txt)+\
					String:C10($ElemKeys_aL{$loop_L}; $keyFmt_txt)
		End case 
		
	End for 
	
	C_TEXT:C284($msg_txt)
	$msg_txt:="ID "+String:C10($ElemID_L)+" StrU/Env ="+String:C10($StrU_L)+"/"+String:C10($Env_L)+" Key="+String:C10($elemKey_L)+\
		" ParKey="+String:C10($ParKey_L)+" GParKey="+String:C10($GPKey_L)
	C_TEXT:C284($ParentLookup_txt; $myRef_txt; $Gplookup_txt)
	C_LONGINT:C283($ParIndx_L; $duplIndx_L)
	
	If ($GPKey_L=0)
		//no GrandP
		$Gplookup_txt:=""
		
		If ($ParKey_L>0)
			$ParentLookup_txt:=String:C10($StrU_L; $StuFmt_txt)+String:C10($Env_L; $EnvFmt_txt)+\
				String:C10($ParKey_L; $keyFmt_txt)+String:C10(0; $keyFmt_txt)+String:C10(0; $keyFmt_txt)
			$myRef_txt:=String:C10($StrU_L; $StuFmt_txt)+String:C10($Env_L; $EnvFmt_txt)+\
				String:C10($ParKey_L; $keyFmt_txt)+\
				String:C10($elemKey_L; $keyFmt_txt)+\
				String:C10(0; $keyFmt_txt)
			
		Else 
			$ParentLookup_txt:=""
			$myRef_txt:=String:C10($StrU_L; $StuFmt_txt)+String:C10($Env_L; $EnvFmt_txt)+\
				String:C10($elemKey_L; $keyFmt_txt)+\
				String:C10(0; $keyFmt_txt)+\
				String:C10(0; $keyFmt_txt)
		End if 
		
	Else 
		$ParentLookup_txt:=String:C10($StrU_L; $StuFmt_txt)+String:C10($Env_L; $EnvFmt_txt)+\
			String:C10($GPKey_L; $keyFmt_txt)+String:C10($ParKey_L; $keyFmt_txt)+String:C10(0; $keyFmt_txt)
		$Gplookup_txt:=String:C10($StrU_L; $StuFmt_txt)+String:C10($Env_L; $EnvFmt_txt)+\
			String:C10($GPKey_L; $keyFmt_txt)+String:C10(0; $keyFmt_txt)+String:C10(0; $keyFmt_txt)
		$myRef_txt:=String:C10($StrU_L; $StuFmt_txt)+String:C10($Env_L; $EnvFmt_txt)+\
			String:C10($GPKey_L; $keyFmt_txt)+String:C10($ParKey_L; $keyFmt_txt)+String:C10($elemKey_L; $keyFmt_txt)
	End if 
	
	$duplIndx_L:=Find in array:C230($Lookup_atxt; $myRef_txt)
	// check if i'm not duplicated!
	If ($duplIndx_L>0)
		//problem - there is a duplicate
		ALERT:C41("For "+$msg_txt+" Found another inspection element with id = "+String:C10($ElemIDs_aL{$duplIndx_L})+\
			" StrU "+String:C10($ElemStrU_aL{$duplIndx_L})+\
			" Env "+String:C10($ElemEnv_aL{$duplIndx_L})+\
			" Key "+String:C10($ElemKeys_aL{$duplIndx_L})+\
			" ParKey "+String:C10($ElemParKeys_aL{$duplIndx_L})+\
			" GParKey "+String:C10($ElemGParKeys_aL{$duplIndx_L})\
			)
		
	Else 
		//fix parent link
		
		If ($ParentLookup_txt#"")
			$ParIndx_L:=Find in array:C230($Lookup_atxt; $ParentLookup_txt)
			If ($ParIndx_L>0)
				// found a match 
				
				If ([PON_ELEM_INSP:179]ELEM_PARENTID:27#$ElemIDs_aL{$ParIndx_L})  // fix if they are not the same
					$msg_txt:="For Element "+$msg_txt+\
						" assign parentID to \nID "+String:C10($ElemIDs_aL{$ParIndx_L})+\
						" StrU/Env="+String:C10($ElemStrU_aL{$ParIndx_L})+"/"+String:C10($ElemEnv_aL{$ParIndx_L})+\
						" Key="+String:C10($ElemKeys_aL{$ParIndx_L})+\
						" ParKey="+String:C10($ElemParKeys_aL{$ParIndx_L})+" ?"
					CONFIRM:C162($msg_txt; "Assign"; "Cancel")
					
					If (Ok=1)
						[PON_ELEM_INSP:179]ELEM_PARENTID:27:=$ElemIDs_aL{$ParIndx_L}
						LogLink(->[PON_ELEM_INSP:179]ELEM_PARENTID:27; ->[Inspections:27]InspID:2; ->[PON_ELEM_INSP:179]INSPID:21; ->[PON_ELEM_INSP:179]ELEMID:22; 2; ->[PON_ELEM_INSP:179])
						SAVE RECORD:C53([PON_ELEM_INSP:179])
						
					End if 
					
				Else 
					ALERT:C41("Found Parent ID matches stored value!")
				End if 
				
				
			Else 
				// cannot find correct parent
				ALERT:C41("Could not find matching parent for "+$msg_txt)
			End if 
			
		Else 
			ALERT:C41($msg_txt+" does not have a parent!!!")
		End if 
		
		//fix gpparent link
		
		If ($Gplookup_txt#"")
			
			$ParIndx_L:=Find in array:C230($Lookup_atxt; $Gplookup_txt)
			
			If ($ParIndx_L>0)
				
				
				If ([PON_ELEM_INSP:179]ELEM_GRANDPARENTID:28#$ElemIDs_aL{$ParIndx_L})  //fix it if it different
					$msg_txt:="For element "+$msg_txt+\
						" assign Grand parID to \nID "+String:C10($ElemIDs_aL{$ParIndx_L})+\
						" StrU/Env ="+String:C10($ElemStrU_aL{$ParIndx_L})+"/"+String:C10($ElemEnv_aL{$ParIndx_L})+\
						" Key="+String:C10($ElemKeys_aL{$ParIndx_L})+\
						" ParKey="+String:C10($ElemParKeys_aL{$ParIndx_L})+" ?"
					CONFIRM:C162($msg_txt; "Assign"; "Cancel")
					If (OK=1)
						[PON_ELEM_INSP:179]ELEM_GRANDPARENTID:28:=$ElemIDs_aL{$ParIndx_L}
						LogLink(->[PON_ELEM_INSP:179]ELEM_GRANDPARENTID:28; ->[Inspections:27]InspID:2; ->[PON_ELEM_INSP:179]INSPID:21; ->[PON_ELEM_INSP:179]ELEMID:22; 2; ->[PON_ELEM_INSP:179])
						SAVE RECORD:C53([PON_ELEM_INSP:179])
					End if 
					
				Else 
					ALERT:C41("Found GrandParent ID matches stored value!")
				End if 
				
			Else 
				ALERT:C41("could not find the grand parent  for "+$msg_txt)
			End if 
			
			
		Else 
			ALERT:C41($msg_txt+" has no grand parent!!!!")
		End if 
		
	End if 
	
	UNLOAD RECORD:C212([PON_ELEM_INSP:179])
	
End if 
//End PON_FixParentLinks