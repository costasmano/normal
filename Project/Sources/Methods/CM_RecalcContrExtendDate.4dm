//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 04/11/06, 08:59:49
	// ----------------------------------------------------
	// Method: CM_RecalcContrExtendDate
	// Description
	// Re-calculate the Contract Extend date for records in [Contract_Maintenance]
	// 
	// Parameters
	// ----------------------------------------------------
	
End if 
//reset the Extended Date to the latest extended date -only for extensions that have board action.
CUT NAMED SELECTION:C334([ExtendTime_Maintenance:98]; "ExtendTimeMnt_temp")
QUERY:C277([ExtendTime_Maintenance:98]; [ExtendTime_Maintenance:98]ContractNo:1=[Contract_Maintenance:97]ContractNo:1)
QUERY SELECTION:C341([ExtendTime_Maintenance:98]; [ExtendTime_Maintenance:98]DateBoardAction:5#!00-00-00!)
If (Records in selection:C76([ExtendTime_Maintenance:98])>0)
	ORDER BY:C49([ExtendTime_Maintenance:98]; [ExtendTime_Maintenance:98]ExtendedDate:7; <)
	FIRST RECORD:C50([ExtendTime_Maintenance:98])
	If ([Contract_Maintenance:97]ExtendedCompleteDate:6#[ExtendTime_Maintenance:98]ExtendedDate:7)
		[Contract_Maintenance:97]ExtendedCompleteDate:6:=[ExtendTime_Maintenance:98]ExtendedDate:7
		SAVE RECORD:C53([Contract_Maintenance:97])
	End if 
Else 
	//no approved extended date found
	If ([Contract_Maintenance:97]ExtendedCompleteDate:6#!00-00-00!)
		//if there is a date already - ask if it should be deleted
		C_TEXT:C284($msg)
		$msg:="Contract "+[Contract_Maintenance:97]ContractNo:1+" has a stored Extended Complete Date as "+String:C10([Contract_Maintenance:97]ExtendedCompleteDate:6)
		$msg:=$msg+" but there are no Board approved Extension Times!"
		CONFIRM:C162($msg; "Leave date as is?"; "Clear Date")
		If (OK#1)
			[Contract_Maintenance:97]ExtendedCompleteDate:6:=!00-00-00!
			SAVE RECORD:C53([Contract_Maintenance:97])
		End if 
		
	End if 
	
End if 
USE NAMED SELECTION:C332("ExtendTimeMnt_temp")
