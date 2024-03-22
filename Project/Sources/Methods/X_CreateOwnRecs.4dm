//%attributes = {"invisible":true}
// Method: X_CreateOwnRecs
// Description
//  ` common method to created owner records when creating
//  ` entries in the Activity log from the Logxxx/Flushxxx methods
//  ` Checks if there is an array of owners defined and adds them to the list
// 
// Parameters
// $1 : $RefID_L (Optional)
// $2 : $task_txt (Optional) ("ALL" | "CURRUSER" | "ARRAY" )
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 08/23/10, 16:22:19
	// ----------------------------------------------------
	
	Mods_2010_09
	// Modified by: costasmanousakis-(Designer)-(1/31/11 09:35:43)
	Mods_2011_01
	//  `Added optional 2nd text param to choose which type of  [owner] records are created;
	//  ` and some error checks on the parameters.
	Mods_2012_02  //r002   `Fix bug where resolve pointer not retuning corect data
	//Modified by: Charles Miller (2/9/12 14:43:44)
End if 
C_LONGINT:C283($RefID_L)
If (Count parameters:C259>0)
	C_LONGINT:C283($1)
	$RefID_L:=$1
	If ($RefID_L<0)
		$RefID_L:=[Activity Log:59]RefID:28
	End if 
Else 
	$RefID_L:=[Activity Log:59]RefID:28
End if 
If ($RefID_L>0)
	C_TEXT:C284($task_txt)
	If (Count parameters:C259>1)
		C_TEXT:C284($2)
		$task_txt:=$2
	Else 
		$task_txt:="ALL"
	End if 
	C_BOOLEAN:C305($DoCurrUser_b; $DoArrayUsers_b)
	$DoCurrUser_b:=False:C215
	$DoArrayUsers_b:=False:C215
	Case of 
		: ($task_txt="ALL")
			$DoCurrUser_b:=True:C214
			$DoArrayUsers_b:=True:C214
		: ($task_txt="CURRUSER")
			$DoCurrUser_b:=True:C214
		: ($task_txt="ARRAY")
			$DoArrayUsers_b:=True:C214
		Else 
			ALERT:C41("Invalid 2nd parameter passed to method "+Current method name:C684+"!!! ["+$2+"}")
	End case 
	If ($DoCurrUser_b)
		//Generate an owner record
		C_LONGINT:C283($Exist_L)
		SET QUERY DESTINATION:C396(Into variable:K19:4; $Exist_L)
		QUERY:C277([Owners of Data:62]; [Owners of Data:62]RefID:1=$RefID_L; *)
		QUERY:C277([Owners of Data:62];  & ; [Owners of Data:62]Owner Name:2=<>CurrentUser_Name)
		SET QUERY DESTINATION:C396(Into current selection:K19:1)
		If ($Exist_L=0)
			CREATE RECORD:C68([Owners of Data:62])
			[Owners of Data:62]RefID:1:=$RefID_L
			[Owners of Data:62]Owner Name:2:=<>CurrentUser_Name
			SAVE RECORD:C53([Owners of Data:62])
		End if 
		
	End if 
	If ($DoArrayUsers_b)
		C_TEXT:C284($TestVarNAme_txt; $SourceArrName_txt)
		C_POINTER:C301($SpecOwnerArr_ptr)
		$SourceArrName_txt:="SpecOwnerList_atxt"
		$SpecOwnerArr_ptr:=Get pointer:C304($SourceArrName_txt)
		C_LONGINT:C283($TestTbl_L; $testFld_L)
		//RESOLVE POINTER($SpecOwnerArr_ptr;$TestVarNAme_txt;$TestTbl_L;$testFld_L)
		C_BOOLEAN:C305($btOK)
		$btOK:=(Type:C295($SpecOwnerArr_ptr->)#5)
		If ($btOK)  //($TestVarNAme_txt=$SourceArrName_txt)
			If (Type:C295($SpecOwnerArr_ptr->)=Text array:K8:16)
				If (Size of array:C274($SpecOwnerArr_ptr->)>0)
					C_LONGINT:C283($Exist_L)
					C_LONGINT:C283($loop_L)
					For ($loop_L; 1; Size of array:C274($SpecOwnerArr_ptr->))
						If ($SpecOwnerArr_ptr->{$loop_L}#"")
							SET QUERY DESTINATION:C396(Into variable:K19:4; $Exist_L)
							QUERY:C277([Owners of Data:62]; [Owners of Data:62]RefID:1=$RefID_L; *)
							QUERY:C277([Owners of Data:62];  & ; [Owners of Data:62]Owner Name:2=$SpecOwnerArr_ptr->{$loop_L})
							SET QUERY DESTINATION:C396(Into current selection:K19:1)
							If ($Exist_L=0)
								CREATE RECORD:C68([Owners of Data:62])
								[Owners of Data:62]RefID:1:=$RefID_L
								[Owners of Data:62]Owner Name:2:=$SpecOwnerArr_ptr->{$loop_L}
								SAVE RECORD:C53([Owners of Data:62])
							End if 
						End if 
					End for 
				End if 
			End if 
		End if 
		
	End if 
	UNLOAD RECORD:C212([Owners of Data:62])
Else 
	ALERT:C41("Activity Log ID in method "+Current method name:C684+" is not greater than zero !! ["+String:C10($RefID_L)+"}")
End if 