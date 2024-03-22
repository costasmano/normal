
//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 03/15/12, 14:55:26
//----------------------------------------------------
//Method: Object Method: CloneActivityLogListBox.Button
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2012_03  //r001
	//Modified by: Charles Miller (3/15/12 14:55:29)
	
End if 
C_TIME:C306($BegTime)

SQLError_b:=False:C215
4DError_b:=False:C215
C_LONGINT:C283($TableNumber_l; $RecordCount_l; $SkipCount_l; $CreateCount_l; $ReplaceCount_l; $Loop_l)
C_POINTER:C301($Table_ptr)
$SkipCount_l:=0
$CreateCount_l:=0
$ReplaceCount_l:=0

$TableNumber_l:=TableNumber_al{TableNames_atxt}
$Table_ptr:=Table:C252($TableNumber_l)

$TableNumber_l:=Table:C252(->[Activity Log:59])
Compiler_FieldVariables($TableNumber_l)
clone_ClearFieldVariables($TableNumber_l)

SQLCount_txt:="SELECT Count(*) FROM [Activity Log] "+SQL_SelectByTable_txt+" INTO :Count_l "
C_TEXT:C284($SelectFields_txt; $UpdateFields_txt)

clone_CloneSetUpSelectInto($TableNumber_l; ->$SelectFields_txt; ->$UpdateFields_txt; False:C215)

SQL_txt:="SELECT "+$SelectFields_txt+" FROM [Activity Log] "+SQL_SelectByTable_txt+" LIMIT 1 OFFSET :Offset_l INTO "+$UpdateFields_txt
$TableNumber_l:=Table:C252(->[Activity Log:59])


FIRST RECORD:C50($Table_ptr->)
C_REAL:C285($Interval)
$Interval:=MaxNum(MinNum((Records in selection:C76($Table_ptr->)/10); 5); 2)

<>ProgressPID:=StartProgress("Clone"; "[Activity Log]"; "Clone [Activity Log]")
UpdateProgress(1; Records in selection:C76($Table_ptr->))

For ($Loop_l; 1; Records in selection:C76($Table_ptr->))
	$BegTime:=Current time:C178
	
	Offset_l:=0
	
	If ($Loop_l%$Interval)=0
		UpdateProgress(Offset_l; Count_l)
	End if 
	
	Case of 
		: (Type:C295(ACTLOGLocalID_Ptr->)=Is integer:K8:5)
			SQLLocalID_txt:=String:C10(ACTLOGLocalID_Ptr->)
		: (Type:C295(ACTLOGLocalID_Ptr->)=Is longint:K8:6)
			SQLLocalID_txt:=String:C10(ACTLOGLocalID_Ptr->)
		: (Type:C295(ACTLOGLocalID_Ptr->)=Is real:K8:4)
			SQLLocalID_txt:=String:C10(ACTLOGLocalID_Ptr->)
		: (Type:C295(ACTLOGLocalID_Ptr->)=Is date:K8:7)
			SQLLocalID_txt:=String:C10(ACTLOGLocalID_Ptr->)
		: (Type:C295(ACTLOGLocalID_Ptr->)=Is alpha field:K8:1)
			SQLLocalID_txt:=ACTLOGLocalID_Ptr->
		: (Type:C295(ACTLOGLocalID_Ptr->)=Is text:K8:3)
			SQLLocalID_txt:=ACTLOGLocalID_Ptr->
	End case 
	
	Begin SQL
		EXECUTE IMMEDIATE :SQLCount_txt;
	End SQL
	
	
	If (Count_l>0)
		Offset_l:=0
		
		Repeat 
			clone_ClearFieldVariables($TableNumber_l)
			ON ERR CALL:C155("SQL_Error")
			Begin SQL
				EXECUTE IMMEDIATE :SQL_txt;
			End SQL
			If (ut_fTestForSQLor4DError)
				ON ERR CALL:C155("4D_Errors")
				SET QUERY DESTINATION:C396(Into variable:K19:4; $RecordCount_l)
				QUERY:C277([Activity Log:59]; [Activity Log:59]RefID:28=v_59_028_l)
				SET QUERY DESTINATION:C396(Into current selection:K19:1)
				If ($RecordCount_l=0)
					CREATE RECORD:C68([Activity Log:59])
					clone_NewSQLUpdateLocalTable($TableNumber_l)
					
					SAVE RECORD:C53([Activity Log:59])
					$CreateCount_l:=$CreateCount_l+1
				Else 
					Case of 
						: (RBAbort_l=1)
							ALERT:C41("There is already record with ref id "+String:C10(v_59_028_l))
							4DError_b:=True:C214
						: (RBSkip_l=1)
							$SkipCount_l:=$SkipCount_l+1
							
						: (RBReplace_l=1)
							QUERY:C277([Activity Log:59]; [Activity Log:59]RefID:28=v_59_028_l)
							clone_NewSQLUpdateLocalTable($TableNumber_l)
							
							SAVE RECORD:C53([Activity Log:59])
							$ReplaceCount_l:=$ReplaceCount_l+1
					End case 
					
				End if 
				Offset_l:=Offset_l+1
			End if 
			
		Until (Offset_l=Count_l) | (4DError_b) | (SQLError_b)
	End if 
	NEXT RECORD:C51($Table_ptr->)
End for 
POST OUTSIDE CALL:C329(<>ProgressPID)
C_TEXT:C284($Message_txt)
C_TEXT:C284($Message_txt)
$Message_txt:="Create Count "+String:C10($CreateCount_l)+" Skip Count  "+String:C10($SkipCount_l)+" Replace Count "+String:C10($ReplaceCount_l)+Char:C90(Carriage return:K15:38)
$Message_txt:=$Message_txt+"Elapsed time is "+String:C10(Current time:C178-$BegTime)+Char:C90(Carriage return:K15:38)+"Retrieve additional [Activity Log] records?"
CONFIRM:C162($Message_txt; "Yes"; "No")

UNLOAD RECORD:C212($Table_ptr->)
UNLOAD RECORD:C212([Activity Log:59])
//End Object Method: CloneActivityLogListBox.Button

