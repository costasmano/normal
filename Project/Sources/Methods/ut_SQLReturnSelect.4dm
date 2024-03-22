//%attributes = {"invisible":true}

// ----------------------------------------------------
// User name (OS): Charles Miller
// Date and time: 03/18/10, 15:10:35
// ----------------------------------------------------
// Method: ut_SQLReturnSelect
// Description
// 
//
// Parameters
//$1 is the where part of the select, so we can use it to do further work (insert, update, or delete)
//$2 is optional is points back to table name 
//$0 is select statement
// ----------------------------------------------------
If (False:C215)
	Mods_OPNToSQLUpgrade  //4D Open to SQL conversion
	//Modified by: Charles Miller (8/11/10 11:56:46)
	
End if 
C_TEXT:C284($0; $SQL_Select_txt)
C_POINTER:C301($1)

$SQL_Select_txt:=""
C_LONGINT:C283(Parent_l; RefID_l)
C_TEXT:C284(ParentID_s)  // Command Replaced was o_C_STRING length was 20
C_TEXT:C284(REFID_s; $RefID_s)  // Command Replaced was o_C_STRING length was 20
ParentID_s:=""
REFID_s:=""
$RefID_s:=""
Parent_l:=0
RefID_l:=0
C_TEXT:C284($TableName_txt; $FieldName_txt; $ParentField_txt; $SQLSelectQuery_txt; $SQLWhereQuery_txt; $SQLUpdate_txt)
SQL_utReturnStrings([Activity Log:59]FileID Local:24; [Activity Log:59]FieldID Local:25; ->$FieldName_txt; ->$TableName_txt)
SQL_utReturnStrings([Activity Log:59]FileID Local:24; [Activity Log:59]FieldID Parent:23; ->$ParentField_txt)
$SQLSelectQuery_txt:=$SQLSelectQuery_txt+"SELECT "+$FieldName_txt+" from "+$TableName_txt+" "
$SQLWhereQuery_txt:=" where "+$FieldName_txt+" = "
Case of 
	: ([Activity Log:59]RefIDType:26=0)  //Global local id.
		
		If ([Activity Log:59]Local Type:18=0)
			$SQLWhereQuery_txt:=$SQLWhereQuery_txt+":RefID_s"
			RefID_s:=[Activity Log:59]Dest ID local:19
		Else 
			$SQLWhereQuery_txt:=$SQLWhereQuery_txt+":RefID_l"
			RefID_l:=Num:C11([Activity Log:59]Dest ID local:19)
			RefID_s:=String:C10(RefID_l)
		End if 
		
	: ([Activity Log:59]RefIDType:26=1)  //Remote Local id
		If ([Activity Log:59]Dest ID local:19#"")
			RefID_s:=[Activity Log:59]Dest ID local:19
		Else 
			RefID_s:=aLookUpDest([Activity Log:59]FileID Local:24; [Activity Log:59]Local ID:15; <>Destination)
			//Danger!             
			If (RefID_s="")  //Assume remote and local ids match!
				RefID_s:=[Activity Log:59]Local ID:15
			End if 
			[Activity Log:59]Dest ID local:19:=RefID_s
		End if 
		
		
		If ([Activity Log:59]Local Type:18=0)
			$SQLWhereQuery_txt:=$SQLWhereQuery_txt+":RefID_s"
		Else 
			RefID_l:=Num:C11(RefID_s)
			$SQLWhereQuery_txt:=$SQLWhereQuery_txt+":RefID_l"
		End if 
		
		If ([Activity Log:59]FieldID Parent:23#[Activity Log:59]FieldID Local:25)
			//Match parent IDs if not the same field      
			If ([Activity Log:59]Dest ID parent:16="")  //Create a valid entry for [Activity Log]Dest ID parent
				$RefID_s:=aLookUpDest([Activity Log:59]FileID Parent:22; [Activity Log:59]Parent ID:14; <>Destination)
				//Danger!             
				If ($RefID_s="")  //Assume remote and local ids match!
					$RefID_s:=[Activity Log:59]Parent ID:14
				End if 
				[Activity Log:59]Dest ID parent:16:=$RefID_s
			Else 
				$RefID_s:=[Activity Log:59]Dest ID parent:16
			End if 
			
			$SQLWhereQuery_txt:=$SQLWhereQuery_txt+" and "+$ParentField_txt+" = "
			
			If ([Activity Log:59]Type Parent:17=0)
				ParentID_s:=$RefID_s
				$SQLWhereQuery_txt:=$SQLWhereQuery_txt+":ParentID_s"
			Else 
				ParentID_l:=Num:C11($RefID_s)
				$SQLWhereQuery_txt:=$SQLWhereQuery_txt+":ParentID_l"
				ParentID_s:=String:C10(ParentID_l)
			End if 
		End if 
		
	: ([Activity Log:59]RefIDType:26=2)
		If ([Activity Log:59]Dest ID local:19#"")
			RefID_s:=[Activity Log:59]Dest ID local:19
		Else 
			RefID_s:=aLookUpDest([Activity Log:59]FileID Local:24; [Activity Log:59]Local ID:15; <>Destination)
			//Danger!             
			If (RefID_s="")  //Assume remote and local ids match!
				RefID_s:=[Activity Log:59]Local ID:15
			End if 
			[Activity Log:59]Dest ID local:19:=RefID_s
		End if 
		If ([Activity Log:59]Local Type:18=0)
			$SQLWhereQuery_txt:=$SQLWhereQuery_txt+":RefID_s"
		Else 
			RefID_l:=Num:C11(RefID_s)
			$SQLWhereQuery_txt:=$SQLWhereQuery_txt+":RefID_l"
		End if 
		
		//Make sure parent IDs match also    
		If ([Activity Log:59]Dest ID parent:16="")  //Create a valid entry for [Activity Log]Dest ID parent
			$RefID_s:=aLookUpDest([Activity Log:59]FileID Parent:22; [Activity Log:59]Parent ID:14; <>Destination)
			//Danger!             
			If ($RefID_s="")  //Assume remote and local ids match!
				$RefID_s:=[Activity Log:59]Parent ID:14
			End if 
			[Activity Log:59]Dest ID parent:16:=$RefID_s
		Else 
			$RefID_s:=[Activity Log:59]Dest ID parent:16
		End if 
		$SQLWhereQuery_txt:=$SQLWhereQuery_txt+" and "+$ParentField_txt+" = "
		If ([Activity Log:59]Type Parent:17=0)
			ParentID_s:=$RefID_s
			$SQLWhereQuery_txt:=$SQLWhereQuery_txt+":ParentID_s"
		Else 
			ParentID_l:=Num:C11($RefID_s)
			$SQLWhereQuery_txt:=$SQLWhereQuery_txt+":ParentID_l"
			ParentID_s:=String:C10(ParentID_l)
		End if 
		
		
	: ([Activity Log:59]RefIDType:26=3)  //For now this is the same as 2
		If ([Activity Log:59]Dest ID local:19#"")
			RefID_s:=[Activity Log:59]Dest ID local:19
		Else 
			RefID_s:=aLookUpDest([Activity Log:59]File Number:7; [Activity Log:59]Local ID:15; <>Destination)
			//Danger!             
			If (RefID_s="")  //Assume remote and local ids match!
				RefID_s:=[Activity Log:59]Local ID:15
			End if 
			[Activity Log:59]Dest ID local:19:=RefID_s
		End if 
		If ([Activity Log:59]Local Type:18=0)
			$SQLWhereQuery_txt:=$SQLWhereQuery_txt+":RefID_s"
		Else 
			RefID_l:=Num:C11(RefID_s)
			$SQLWhereQuery_txt:=$SQLWhereQuery_txt+":RefID_l"
		End if 
		
		//Make sure parent IDs match also    
		If ([Activity Log:59]Dest ID parent:16="")  //Create a valid entry for [Activity Log]Dest ID parent
			$RefID_s:=aLookUpDest([Activity Log:59]FileID Parent:22; [Activity Log:59]Parent ID:14; <>Destination)
			//Danger!             
			If ($RefID_s="")  //Assume remote and local ids match!
				$RefID_s:=[Activity Log:59]Parent ID:14
			End if 
			[Activity Log:59]Dest ID parent:16:=$RefID_s
		Else 
			$RefID_s:=[Activity Log:59]Dest ID parent:16
		End if 
		$SQLWhereQuery_txt:=$SQLWhereQuery_txt+" and "+$ParentField_txt+" = "
		If ([Activity Log:59]Type Parent:17=0)
			ParentID_s:=$RefID_s
			$SQLWhereQuery_txt:=$SQLWhereQuery_txt+":ParentID_s"
		Else 
			ParentID_l:=Num:C11($RefID_s)
			$SQLWhereQuery_txt:=$SQLWhereQuery_txt+":ParentID_l"
			ParentID_s:=String:C10(ParentID_l)
		End if 
End case 

$1->:=$SQLWhereQuery_txt
If (Count parameters:C259=2)
	C_POINTER:C301($2)
	$2->:=$TableName_txt
End if 
$0:=$SQLSelectQuery_txt+$SQLWhereQuery_txt+" "+Char:C90(Carriage return:K15:38)+"FOR UPDATE; "

