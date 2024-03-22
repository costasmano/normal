
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
C_LONGINT:C283($TableNumber_l; $SkipCount_l; $CreateCount_l; $ReplaceCount_l; $RecordCount_l)
4DError_b:=False:C215
SQLError_b:=False:C215
$TableNumber_l:=Table:C252(->[Activity Log:59])

Compiler_FieldVariables($TableNumber_l)
clone_ClearFieldVariables($TableNumber_l)

SQLCount_txt:="SELECT Count(*) FROM [Activity Log] "+SQL_SelectByRef_txt+" INTO :Count_l"
C_TEXT:C284($SelectFields_txt; $UpdateFields_txt)


$SkipCount_l:=0
$CreateCount_l:=0
$ReplaceCount_l:=0

clone_CloneSetUpSelectInto($TableNumber_l; ->$SelectFields_txt; ->$UpdateFields_txt; False:C215)
SQL_txt:="SELECT "+$SelectFields_txt+" FROM [Activity Log] "+SQL_SelectByRef_txt+" LIMIT 1 OFFSET :Offset_l INTO "+$UpdateFields_txt

$TableNumber_l:=Table:C252(->[Activity Log:59])

$BegTime:=Current time:C178
ON ERR CALL:C155("SQL_Error")
Begin SQL
	EXECUTE IMMEDIATE :SQLCount_txt;
End SQL
If (Count_l>0)
	$BegTime:=Current time:C178
	C_REAL:C285($Interval)
	$Interval:=MaxNum(MinNum(Int:C8(Count_l/10); 5); 2)
	
	<>ProgressPID:=StartProgress("Clone"; "Button"; "[Activity Log]")
	UpdateProgress(1; Count_l)
	Offset_l:=0
	Repeat 
		If (Offset_l%$Interval)=0
			//    GOTO XY(1;2)  ` 2-10-2000 : CM 
			//    MESSAGE(String($i;"00000"))
			UpdateProgress(Offset_l; Count_l)
		End if 
		
		
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
POST OUTSIDE CALL:C329(<>ProgressPID)

UNLOAD RECORD:C212([Activity Log:59])
C_TEXT:C284($Message_txt)
$Message_txt:="Create Count "+String:C10($CreateCount_l)+" Skip Count  "+String:C10($SkipCount_l)+" Replace Count "+String:C10($ReplaceCount_l)+Char:C90(Carriage return:K15:38)
$Message_txt:=$Message_txt+"Elapsed time is "+String:C10(Current time:C178-$BegTime)+Char:C90(Carriage return:K15:38)+"Retrieve additional [Activity Log] records?"
CONFIRM:C162($Message_txt; "Yes"; "No")

If (OK=1)
Else 
	CANCEL:C270
End if 
//End Object Method: CloneActivityLogListBox.Button

