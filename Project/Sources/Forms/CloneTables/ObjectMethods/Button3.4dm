
//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 03/28/11, 16:09:58
//----------------------------------------------------
//Method: Object Method: CloneTables.Button1
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	//Ugrade to v11
	//Modified by: Charles Miller (3/28/11 16:09:59)
End if 
C_LONGINT:C283(StartRefID_l; EndRefID_l)
C_TIME:C306($BegTime; $EndTime)
$BegTime:=Current time:C178
ARRAY POINTER:C280(KeysToReset_aptr; 0)
ARRAY LONGINT:C221(KeyIndextType_aL; 0)

C_TEXT:C284($TableName_txt; $SelectFields_txt; $UpdateFields_txt; SQL_txt; SQLCount_txt)
C_LONGINT:C283($Loop_l; $TableNumber_l; Offset_l; Count_l; $InnerLoop_l; $Width_l; $Height_l)
StartRefID_l:=0
EndRefID_l:=0
4DError_b:=False:C215
SQLError_b:=False:C215
FORM GET PROPERTIES:C674("CloneActivityLogListBox"; $Width_l; $Height_l)
ut_OpenNewWindow($Width_l; $Height_l; 0; 4; "Clone Activity Log"; "ut_CloseCancel")
DIALOG:C40("CloneActivityLogListBox")

For ($Loop_l; 1; Size of array:C274(KeysToReset_aptr))
	SET INDEX:C344(KeysToReset_aptr{$Loop_l}->; KeyIndextType_aL{$Loop_l}; *)
End for 
$EndTime:=Current time:C178
CONFIRM:C162("Elapsed time is "+String:C10($EndTime-$BegTime)+Char:C90(Carriage return:K15:38)+"Process another table"; "Yes"; "No")

If (OK=1)
	
Else 
	CANCEL:C270
End if 


//End Object Method: CloneTables.Button1

