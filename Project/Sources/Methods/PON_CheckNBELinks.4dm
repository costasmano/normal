//%attributes = {"invisible":true}
//Method: PON_CheckNBELinks
//Description
// Check on NBE links to their children and create error report.
// Will scan all parents and verify that elements linked to them are from the same report
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 03/02/21, 21:08:18
	// ----------------------------------------------------
	//Created : 
	Mods_2021_03
End if 
//

C_TIME:C306($LogFile_t)
C_TEXT:C284($logFile_txt)
ARRAY TEXT:C222($files_atxt; 0)
$logFile_txt:=Select document:C905(""; ".txt"; "Select output for error log file"; File name entry:K24:17; $files_atxt)

If (OK=1)
	$LogFile_t:=Create document:C266($files_atxt{1})
	
	ARRAY LONGINT:C221($mainElemKeys_aL; 0)
	Begin SQL
		select
		[PON_ELEM_DEFS].[ELEM_KEY]
		from
		[PON_ELEM_DEFS]
		where
		[PON_ELEM_DEFS].[ELEM_PROTECT_SYS]='N'
		and
		[PON_ELEM_DEFS].[ELEM_SMART_FLAG]='N'
		into :$mainElemKeys_aL ;
	End SQL
	
	C_TEXT:C284($parentkeyIN_txt; $SQL_cmd)
	C_LONGINT:C283($loop_L)
	$parentkeyIN_txt:="( "+String:C10($mainElemKeys_aL{1})
	For ($loop_L; 2; Size of array:C274($mainElemKeys_aL))
		$parentkeyIN_txt:=$parentkeyIN_txt+" , "+String:C10($mainElemKeys_aL{$loop_L})
	End for 
	$parentkeyIN_txt:=$parentkeyIN_txt+" )"
	
	ARRAY LONGINT:C221($mainElemIDS_aL; 0)
	ARRAY LONGINT:C221($mainElemKeys_aL; 0)
	ARRAY LONGINT:C221($mainElemEnv_aL; 0)
	ARRAY LONGINT:C221($mainElemInspIDs_aL; 0)
	
	ARRAY LONGINT:C221($InspElemKeys_aL; 0)
	ARRAY LONGINT:C221($ElemIDS_aL; 0)
	ARRAY LONGINT:C221($parentIDs_aL; 0)
	ARRAY LONGINT:C221($grandpaIDs_aL; 0)
	ARRAY LONGINT:C221($Parentkeys_aL; 0)
	ARRAY LONGINT:C221($GrandParentkeys_aL; 0)
	ARRAY LONGINT:C221($ElemInspIDs_aL; 0)
	$SQL_cmd:="select [PON_ELEM_INSP].[ELEM_KEY], "+\
		"[PON_ELEM_INSP].[ELEMID] ,"+\
		"[PON_ELEM_INSP].[ENVKEY] ,"+\
		"[PON_ELEM_INSP].[INSPID] from [PON_ELEM_INSP] "+\
		"where [PON_ELEM_INSP].[ELEM_KEY] in "+\
		$parentkeyIN_txt+" into :$mainElemKeys_aL ,"+\
		":$mainElemIDS_aL , "+\
		":$mainElemEnv_aL, "+\
		":$mainElemInspIDs_aL ; "
	Begin SQL
		execute IMMEDIATE :$SQL_cmd ;
	End SQL
	
	C_LONGINT:C283($mainElemID_L; $totalCount_L)
	//start the bar
	C_OBJECT:C1216($mainprogress_o)
	$mainprogress_o:=ProgressNew("Scanning "+String:C10(Size of array:C274($mainElemIDS_aL))+" Main Elements "; Size of array:C274($mainElemIDS_aL); True:C214; " elements"; 3)
	
	
	For ($loop_L; 1; Size of array:C274($mainElemIDS_aL))
		
		//update progress
		UpdateProgressNew($mainprogress_o; $loop_L)
		
		$mainElemID_L:=$mainElemIDS_aL{$loop_L}
		ARRAY LONGINT:C221($InspElemKeys_aL; 0)
		ARRAY LONGINT:C221($ElemIDS_aL; 0)
		ARRAY LONGINT:C221($Parentkeys_aL; 0)
		ARRAY LONGINT:C221($ElemInspIDs_aL; 0)
		ARRAY LONGINT:C221($ElemEnv_aL; 0)
		
		//check on chidren
		Begin SQL
			select
			[PON_ELEM_INSP].[ELEM_KEY],
			[PON_ELEM_INSP].[ELEMID] ,
			[PON_ELEM_INSP].[ELEM_PARENT_KEY] ,
			[PON_ELEM_INSP].[INSPID] ,
			[PON_ELEM_INSP].[ENVKEY]
			from
			[PON_ELEM_INSP]
			where 
			[PON_ELEM_INSP].[ELEM_PARENTID] = :$mainElemID_L
			into
			:$InspElemKeys_aL ,
			:$ElemIDS_aL ,
			:$Parentkeys_aL,
			:$ElemInspIDs_aL ,
			:$ElemEnv_aL ;
		End SQL
		
		C_LONGINT:C283($childloop_L)
		C_TEXT:C284($ElemError_txt; $MainElemError_txt)
		$MainElemError_txt:=""
		For ($childloop_L; 1; Size of array:C274($ElemIDS_aL))
			$ElemError_txt:=""
			If ($Parentkeys_aL{$childloop_L}#$mainElemKeys_aL{$loop_L})
				$ElemError_txt:=$ElemError_txt+"\t"+"Wrong ParentKey\t"+String:C10($Parentkeys_aL{$childloop_L})
			End if 
			If ($ElemEnv_aL{$childloop_L}#$mainElemEnv_aL{$loop_L})
				$ElemError_txt:=$ElemError_txt+"\t"+"Wrong EnvKey\t"+String:C10($ElemEnv_aL{$childloop_L})
				
			End if 
			
			If ($ElemInspIDs_aL{$childloop_L}#$mainElemInspIDs_aL{$loop_L})
				$ElemError_txt:=$ElemError_txt+"\t"+"Wrong InspectionID\t"+String:C10($ElemInspIDs_aL{$childloop_L})
			End if 
			If ($ElemError_txt#"")
				$MainElemError_txt:=$MainElemError_txt+\
					"Main ElemID\t"+String:C10($mainElemID_L)+"\tKey\t"+String:C10($mainElemKeys_aL{$loop_L})+\
					"\tEnv\t"+String:C10($mainElemEnv_aL{$loop_L})+\
					"\tChild ID\t"+String:C10($ElemIDS_aL{$childloop_L})+\
					"\tKey\t"+String:C10($InspElemKeys_aL{$childloop_L})+$ElemError_txt+"\r"
			End if 
			
		End for 
		
		//check on grandchildren
		ARRAY LONGINT:C221($InspElemKeys_aL; 0)
		ARRAY LONGINT:C221($ElemIDS_aL; 0)
		ARRAY LONGINT:C221($Parentkeys_aL; 0)
		ARRAY LONGINT:C221($ElemInspIDs_aL; 0)
		ARRAY LONGINT:C221($ElemEnv_aL; 0)
		
		Begin SQL
			select
			[PON_ELEM_INSP].[ELEM_KEY],
			[PON_ELEM_INSP].[ELEMID] ,
			[PON_ELEM_INSP].[ELEM_GRANDPARENT_KEY] ,
			[PON_ELEM_INSP].[INSPID] ,
			[PON_ELEM_INSP].[ENVKEY]
			from
			[PON_ELEM_INSP]
			where 
			[PON_ELEM_INSP].[ELEM_GRANDPARENTID] = :$mainElemID_L
			into
			:$InspElemKeys_aL ,
			:$ElemIDS_aL ,
			:$Parentkeys_aL,
			:$ElemInspIDs_aL ,
			:$ElemEnv_aL ;
		End SQL
		
		For ($childloop_L; 1; Size of array:C274($ElemIDS_aL))
			$ElemError_txt:=""
			If ($Parentkeys_aL{$childloop_L}#$mainElemKeys_aL{$loop_L})
				$ElemError_txt:=$ElemError_txt+"\t"+"ParentKey\t"+String:C10($Parentkeys_aL{$childloop_L})
			End if 
			If ($ElemEnv_aL{$childloop_L}#$mainElemEnv_aL{$loop_L})
				$ElemError_txt:=$ElemError_txt+"\t"+"EnvKey\t"+String:C10($ElemEnv_aL{$childloop_L})
			End if 
			If ($ElemInspIDs_aL{$childloop_L}#$mainElemInspIDs_aL{$loop_L})
				$ElemError_txt:=$ElemError_txt+"\t"+"InspectionID\t"+String:C10($ElemInspIDs_aL{$childloop_L})
			End if 
			If ($ElemError_txt#"")
				$MainElemError_txt:=$MainElemError_txt+\
					"Main ElemID\t"+String:C10($mainElemID_L)+"\tKey\t"+String:C10($mainElemKeys_aL{$loop_L})+\
					"\tEnv\t"+String:C10($mainElemEnv_aL{$loop_L})+\
					"\tGrandChild ID\t"+String:C10($ElemIDS_aL{$childloop_L})+\
					"\tKey\t"+String:C10($InspElemKeys_aL{$childloop_L})+$ElemError_txt+"\r"
			End if 
			
		End for 
		If ($MainElemError_txt#"")
			//write to log
			SEND PACKET:C103($LogFile_t; $MainElemError_txt)
		End if 
		
		//check if progress stopped
		If (Progress Stopped(OB Get:C1224($mainprogress_o; "progress"; Is longint:K8:6)))
			//abort loop
			$totalCount_L:=$loop_L+1
			$loop_L:=Size of array:C274($mainElemKeys_aL)+1
		End if 
		
	End for 
	
	//quit progress
	Progress QUIT(OB Get:C1224($mainprogress_o; "progress"; Is longint:K8:6))
	
	CLOSE DOCUMENT:C267($LogFile_t)
	
	ALERT:C41("Scanned "+String:C10($totalCount_L-1)+" main element records")
	
	SHOW ON DISK:C922($files_atxt{1})
	
End if 

//[PON_ELEM_INSP]
//[PON_ELEM_INSP].[ELEM_KEY]
//[PON_ELEM_INSP].[ELEMID]
//[PON_ELEM_INSP].[ELEM_PARENTID]
//[PON_ELEM_INSP].[ELEM_GRANDPARENTID]
//[PON_ELEM_INSP].[ELEM_PARENT_KEY]
//[PON_ELEM_INSP].[ELEM_GRANDPARENT_KEY]
//[PON_ELEM_INSP].[INSPID]
//[PON_ELEM_INSP].[ENVKEY

//End PON_CheckNBELinks