//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 08/27/10, 11:33:24
//----------------------------------------------------
//Method: SQL_INSPDownloadRecords
//Description
//
// Parameters
// ----------------------------------------------------
//SQL_INSPDownloadRecords (->[ElementsSafety]ElmSafetyID;->[ElementsSafety]InspID;->[Inspections]InspID;"ElementsSafety")

If (False:C215)
	Mods_OPNToSQLUpgrade  //4D Open to SQL conversion
	//Modified by: Charles Miller (8/27/10 11:33:26)
	//Fix delete bug and alert how $0 is returned
	//Modified by: Charles Miller (11/4/11 10:32:34)
	
	// Modified by: Costas Manousakis-()-(12/2/11 17:57:30)
	Mods_2010_12
	//Add  call to INSP_InitDwnlFldPtrArr
End if 
C_BOOLEAN:C305($0)
C_LONGINT:C283($TableNumber_l)

C_POINTER:C301($1; $2; $3)
C_POINTER:C301($TableUniqueKey_ptr; $TableParentKey_ptr; $ParentKey_ptr)
$TableUniqueKey_ptr:=$1
$TableParentKey_ptr:=$2
$ParentKey_ptr:=$3
C_TEXT:C284($4; $SequenceName_txt)
C_LONGINT:C283($5; $6; RemoteID_l; $Loop_l; $LocalParentID_l)
RemoteID_l:=$5
$LocalParentID_l:=$6
$SequenceName_txt:=$4
ARRAY LONGINT:C221(UniqueIDs_al; 0)
C_TEXT:C284($KeyField_txt; $WhereKey_txt; $TableName_txt; $SQL_Select_txt; $BindToVariable_txt)
$KeyField_txt:="["+Field name:C257($TableUniqueKey_ptr)+"]"
$WhereKey_txt:="["+Field name:C257($TableParentKey_ptr)+"]"
$TableName_txt:="["+Table name:C256($TableUniqueKey_ptr)+"]"
$TableNumber_l:=Table:C252($TableUniqueKey_ptr)
C_POINTER:C301($Table_ptr)
$Table_ptr:=Table:C252($TableNumber_l)
SQL_Select:="SELECT "+$KeyField_txt+" FROM "+$TableName_txt+" WHERE "+$WhereKey_txt+" = :RemoteID_l;"
ARRAY LONGINT:C221(UniqueIDs_al; 0)

SQL EXECUTE:C820(SQL_Select; UniqueIDs_al)
While (Not:C34(SQL End selection:C821))
	SQL LOAD RECORD:C822(SQL all records:K49:10)
End while 
SQL CANCEL LOAD:C824
C_LONGINT:C283(NumRecs_L; INSP_LocalInspID_L; INSP_RemoteChildID_L)
If ((Size of array:C274(UniqueIDs_al)>0) & (Not:C34(SQLError_b)))
	INSP_InitDwnlFldPtrArr($TableNumber_l; $TableParentKey_ptr; $TableUniqueKey_ptr)
	NumRecs_L:=Size of array:C274(UniqueIDs_al)
	
	clone_ClearFieldVariables($TableNumber_l)
	
	$SQL_Select_txt:=ut_SetSelectForAllFields($TableNumber_l; ->$BindToVariable_txt)
	$SQL_Select_txt:=$SQL_Select_txt+" FROM "+$TableName_txt+" WHERE "+$KeyField_txt+" = :vKey_l INTO "+$BindToVariable_txt+";"
	
	ut_Message("DownLoading "+String:C10(NumRecs_L)+$TableName_txt+".."+<>sCR)
	For ($Loop_l; 1; NumRecs_L)
		vKey_l:=UniqueIDs_al{$Loop_l}
		ut_Message(String:C10($Loop_l)+"...")
		ut_SQLReturnRecord($SQL_Select_txt; $TableName_txt; String:C10(vKey_l))
		If (Not:C34(SQLError_b))
			CREATE RECORD:C68($Table_ptr->)
			clone_NewSQLUpdateLocalTable($TableNumber_l)
			INSP_RemoteChildID_L:=$TableUniqueKey_ptr->
			Inc_Sequence($SequenceName_txt; $TableUniqueKey_ptr)
			$TableParentKey_ptr->:=$LocalParentID_l
			SAVE RECORD:C53($Table_ptr->)
			X_CleanIDResTable($TableNumber_l; String:C10(INSP_RemoteChildID_L); "REMOTE")
			G_StoreRecResolution($TableNumber_l; String:C10($TableUniqueKey_ptr->); String:C10(INSP_RemoteChildID_L); <>Destination)
			LogNewRecord($ParentKey_ptr; $TableParentKey_ptr; $TableUniqueKey_ptr; 2; $SequenceName_txt)
			INSP_LogTableChanges(1; $ParentKey_ptr; $TableParentKey_ptr; $TableUniqueKey_ptr; 2)  //log new insp grp chgs
		Else 
			$Loop_l:=NumRecs_L+1
		End if 
		
	End for 
	ut_Message(<>sCR)
	
End if 

$0:=ut_fTestForSQLor4DError
//End SQL_INSPDownloadRecords