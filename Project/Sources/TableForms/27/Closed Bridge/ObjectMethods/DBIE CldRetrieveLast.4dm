If (False:C215)
	//[Inspections];"Closed Bridge"
	//bRetrieveCldData
	Mods_2004_VN02
End if 

C_DATE:C307($vdCurrDate)
C_BOOLEAN:C305($vbFound)
$vbFound:=False:C215
$vdCurrDate:=[Inspections:27]Insp Date:78
PUSH RECORD:C176([Inspections:27])
QUERY:C277([Inspections:27]; [Inspections:27]BIN:1=[Bridge MHD NBIS:1]BIN:3)
QUERY SELECTION:C341([Inspections:27]; [Inspections:27]Insp Type:6="CLD"; *)
QUERY SELECTION:C341([Inspections:27];  & ; [Inspections:27]Insp Date:78<$vdCurrDate)
ORDER BY:C49([Inspections:27]; [Inspections:27]Insp Date:78; <)

If (Records in selection:C76([Inspections:27])>0)
	C_BOOLEAN:C305($vbUnderC; $vbLoopNeverStop)
	C_DATE:C307($vdCompDate)
	C_REAL:C285($vrAmt)
	C_TEXT:C284($vsContractor; $vsContrNum; $vsRes)  // Command Replaced was o_C_STRING length was 20
	C_TEXT:C284($vsSched)  // Command Replaced was o_C_STRING length was 2
	C_TEXT:C284($vtRem; $vtScope; $vtMessage)
	C_LONGINT:C283($viCounter)  //Command Replaced was o_C_INTEGER
	
	$vbLoopNeverStop:=True:C214  // flag to stop the loop
	$viCounter:=1  // number of records has been exmained
	FIRST RECORD:C50([Inspections:27])
	
	While ($vbLoopNeverStop & ($viCounter<=Records in selection:C76([Inspections:27])))
		//Copy the information from the current record
		$vbUnderC:=[Inspections:27]Cld_UnderConstruction:195
		$vsContrNum:=[Inspections:27]Cld_Contract_Number:190
		$vrAmt:=[Inspections:27]Cld_Amount:187
		$vdCompDate:=[Inspections:27]Cld_Completion_Date:188
		$vsContractor:=[Inspections:27]Cld_Contractor:189
		$vsRes:=[Inspections:27]Cld_Resident_Engineer:192
		$vtScope:=[Inspections:27]Cld_Scope_of_Work:193
		$vtRem:=[Inspections:27]Cld_Remarks:191
		
		//Print out the confirm message for unapproved inspection 
		$vtMessage:="This is the information of unapproved inspection on "+String:C10([Inspections:27]Insp Date:78)+Char:C90(13)
		$vtMessage:=$vtMessage+"Under Construction = "+f_Boolean2String($vbUnderC; "YN")+Char:C90(13)
		$vtMessage:=$vtMessage+"Construction Number = "+$vsContrNum+Char:C90(13)
		$vtMessage:=$vtMessage+"Amount = "+String:C10($vrAmt)+Char:C90(13)
		$vtMessage:=$vtMessage+"Completion Day = "+String:C10($vdCompDate)+Char:C90(13)
		$vtMessage:=$vtMessage+"Contractor = "+$vsContractor+Char:C90(13)
		$vtMessage:=$vtMessage+"Resident Engineer  = "+$vsRes+Char:C90(13)
		$vtMessage:=$vtMessage+"Scope of work  = "+$vtScope+Char:C90(13)
		$vtMessage:=$vtMessage+"Remark  = "+$vtRem
		
		If ([Inspections:27]InspApproved:167=BMS Approved)
			$vbLoopNeverStop:=False:C215
			$vbFound:=True:C214
		Else 
			G_MyConfirm($vtMessage)
			If (OK=1)
				$vbLoopNeverStop:=False:C215
				$vbFound:=True:C214
			Else 
				NEXT RECORD:C51([Inspections:27])
				$viCounter:=$viCounter+1
			End if 
		End if 
	End while 
End if   //if any prev closed inspections found.  
POP RECORD:C177([Inspections:27])
If ($vbFound)
	If ($vbUnderC#[Inspections:27]Cld_UnderConstruction:195)
		[Inspections:27]Cld_UnderConstruction:195:=$vbUnderC
		PushChange(1; ->[Inspections:27]Cld_UnderConstruction:195)
	End if 
	If ([Inspections:27]Cld_Contract_Number:190#$vsContrNum)
		[Inspections:27]Cld_Contract_Number:190:=$vsContrNum
		PushChange(1; ->[Inspections:27]Cld_Contract_Number:190)
	End if 
	If ([Inspections:27]Cld_Amount:187#$vrAmt)
		[Inspections:27]Cld_Amount:187:=$vrAmt
		PushChange(1; ->[Inspections:27]Cld_Amount:187)
	End if 
	If ([Inspections:27]Cld_Completion_Date:188#$vdCompDate)
		[Inspections:27]Cld_Completion_Date:188:=$vdCompDate
		PushChange(1; ->[Inspections:27]Cld_Completion_Date:188)
	End if 
	If ([Inspections:27]Cld_Contractor:189#$vsContractor)
		[Inspections:27]Cld_Contractor:189:=$vsContractor
		PushChange(1; ->[Inspections:27]Cld_Contractor:189)
	End if 
	If ([Inspections:27]Cld_Resident_Engineer:192#$vsRes)
		[Inspections:27]Cld_Resident_Engineer:192:=$vsRes
		PushChange(1; ->[Inspections:27]Cld_Resident_Engineer:192)
	End if 
	If ([Inspections:27]Cld_Scope_of_Work:193#$vtScope)
		[Inspections:27]Cld_Scope_of_Work:193:=$vtScope
		PushChange(1; ->[Inspections:27]Cld_Scope_of_Work:193)
	End if 
	If ([Inspections:27]Cld_Remarks:191#$vtRem)
		[Inspections:27]Cld_Remarks:191:=$vtRem
		PushChange(1; ->[Inspections:27]Cld_Remarks:191)
	End if 
	If ([Inspections:27]Cld_UnderConstruction:195)
		CBCldUnderConstruction:=1
	Else 
		CBCldUnderConstruction:=0
	End if 
	If (([Inspections:27]Cld_UnderConstruction:195) & Not:C34(vbInspectionLocked))
		//unlock fields
		OBJECT SET ENTERABLE:C238(*; "DBIE Cld @"; True:C214 & blnDBIE)
		If (blnDBIE)
			OBJECT SET RGB COLORS:C628(*; "DBIE Cld @"; Col_paletteToRGB(Abs:C99(<>Color_Editable)%256); Col_paletteToRGB(Abs:C99(<>Color_Editable)\256))  // **Replaced o OBJECT SET COLOR(*; "DBIE Cld @"; <>Color_Editable)
		Else 
			OBJECT SET RGB COLORS:C628(*; "DBIE Cld @"; Col_paletteToRGB(Abs:C99(<>Color_Not_Editable)%256); Col_paletteToRGB(Abs:C99(<>Color_Not_Editable)\256))  // **Replaced o OBJECT SET COLOR(*; "DBIE Cld @"; <>Color_Not_Editable)
		End if 
		
	Else 
		//lock fields
		OBJECT SET ENTERABLE:C238(*; "DBIE Cld @"; False:C215)
		OBJECT SET RGB COLORS:C628(*; "DBIE Cld @"; Col_paletteToRGB(Abs:C99(<>Color_Not_Editable)%256); Col_paletteToRGB(Abs:C99(<>Color_Not_Editable)\256))  // **Replaced o OBJECT SET COLOR(*; "DBIE Cld @"; <>Color_Not_Editable)
	End if 
Else 
	ALERT:C41("No Previous Approved Closed Inspections found!!!")
End if   //if found prev closed