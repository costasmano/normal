//%attributes = {"invisible":true}
// ----------------------------------------------------
// SD_ImportOldHistoryRecords
// User name (OS): cjmiller
// Date and time: 10/05/04, 13:16:21
// ----------------------------------------------------
// Description
// This method will all for opening a tab delimited history record file
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2005_CJM01
	Mods_2005_CJM01  //10/12/04, 12:11:10
	Mods_2005_CM04
	
End if 
C_TEXT:C284($Month_txt; $Year_txt; $MaxYr_txt)
C_BOOLEAN:C305($GoodRequest_b; $EntryAccepted_b)
$GoodRequest_b:=False:C215
$EntryAccepted_b:=False:C215
C_LONGINT:C283($TestValue_l)
$Month_txt:="1-12"
$MaxYr_txt:=String:C10(Year of:C25(Current date:C33(*)))
$Year_txt:="1996-"+$MaxYr_txt
Repeat 
	
	Repeat 
		$Month_txt:=Request:C163("Please enter the month for import"; $Month_txt)
		$TestValue_l:=Num:C11($Month_txt)
		If ($TestValue_l>0) & ($TestValue_l<13)
			$GoodRequest_b:=True:C214
			$Month_txt:=String:C10($TestValue_l; "00")
		Else 
			ALERT:C41("You have enter an invalid month "+Char:C90(13)+"You entered-> "+$Month_txt+Char:C90(13)+"Only values from 1 to 12 are allowed")
		End if 
		
	Until ($GoodRequest_b)
	$GoodRequest_b:=False:C215
	$Year_txt:="1996-"+$MaxYr_txt
	Repeat 
		$Year_txt:=Request:C163("Please enter the year for import"; $Year_txt)
		$TestValue_l:=Num:C11($Year_txt)
		If ($TestValue_l>1995) & ($TestValue_l<=Year of:C25(Current date:C33(*)))
			$GoodRequest_b:=True:C214
			$Year_txt:=String:C10($TestValue_l)
		Else 
			ALERT:C41("You have enter an invalid year "+Char:C90(13)+"You entered-> "+$Year_txt+Char:C90(13)+"Only values from 1996 to "+$MaxYr_txt+" are allowed")
		End if 
		
	Until ($GoodRequest_b)
	CONFIRM:C162("You entered "+$Month_txt+"/"+$Year_txt+Char:C90(13)+"Press OK to proceed or Cancel to enter again")
	If (OK=1)
		$EntryAccepted_b:=True:C214
	End if 
	
Until ($EntryAccepted_b)
START TRANSACTION:C239
READ WRITE:C146([SD_History:89])
IMPORT DATA:C665("")
QUERY:C277([SD_History:89]; [SD_History:89]SD_Year:2=""; *)
QUERY:C277([SD_History:89];  & ; [SD_History:89]SD_Month:3="")
CONFIRM:C162("You are about to add month "+$Month_txt+" and year "+$Year_txt+" to "+String:C10(Records in selection:C76([SD_History:89]))+" history record(s)"+Char:C90(13)+"Press OK if correct or cancel to cancel")

If (OK=1)
	Repeat 
		APPLY TO SELECTION:C70([SD_History:89]; [SD_History:89]SD_Year:2:=$Year_txt)
		APPLY TO SELECTION:C70([SD_History:89]; [SD_History:89]SD_Month:3:=$Month_txt)
		APPLY TO SELECTION:C70([SD_History:89]; SD_FixData)
		
		USE SET:C118("LockedSet")
	Until (Records in set:C195("LockedSet")=0)
	VALIDATE TRANSACTION:C240
	SD_SetAddRemoveStatus($Year_txt; $Month_txt)
	
	UNLOAD RECORD:C212([SD_History:89])
Else 
	CANCEL TRANSACTION:C241
End if 


READ ONLY:C145([SD_History:89])

//End SD_ImportOldHistoryRecords