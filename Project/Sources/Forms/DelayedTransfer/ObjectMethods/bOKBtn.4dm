If (Form event code:C388=On Clicked:K2:4)
	C_BOOLEAN:C305($vbPwdChk; $DateTimeOK_b; $DateTime24Hrs_b; $EntryOK_b; $DateTimeLater_b)
	$vbPwdChk:=Validate password:C638(f_GetUserID(Current user:C182); vsPassword)
	C_TEXT:C284($targetdatetime_txt; $CurrentDatetime_txt)
	$CurrentDatetime_txt:=ISODateTime(Current date:C33; Current time:C178)
	$targetdatetime_txt:=ISODateTime(vDate; v_1_195_tm)
	$DateTimeLater_b:=($targetdatetime_txt>$CurrentDatetime_txt)  //should be at least a minute
	$EntryOK_b:=False:C215
	
	Case of 
		: (Not:C34($vbPwdChk))
			ALERT:C41("Invalid Password for user "+Current user:C182)
		: (Not:C34($DateTimeLater_b))
			ALERT:C41("You picked a date/time in the past!")
		Else 
			$EntryOK_b:=True:C214
	End case 
	
	If ($EntryOK_b)
		C_TEXT:C284($Extranote_txt)
		//bring attention if time is more than 12  hrs ahead
		C_LONGINT:C283($timediff_L)
		$timediff_L:=vDate-Current date:C33
		$timediff_L:=($timediff_L*24*3600)+(v_1_195_tm-Current time:C178)  //this is in seconds
		$Extranote_txt:=""
		If (($timediff_L/3600)>12)
			$Extranote_txt:=Char:C90(13)+"This is more than 12 hours ahead!"+Char:C90(13)
		End if 
		CONFIRM:C162("Will wait until "+String:C10(vDate)+" "+String:C10(v_1_195_tm)+" to execute a data transfer."+$Extranote_txt+" Do not quit the app or put the computer to sleep."; "Continue?"; "No")
		If (OK=1)
			ACCEPT:C269
		End if 
		
	End if 
End if 