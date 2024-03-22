//%attributes = {"invisible":true}
// ----------------------------------------------------
// ut_PRJRetrieveDesignContractAmt
// User name (OS): charlesmiller
// Date and time: 01/14/11, 11:40:18
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2011_01  //r001 CJ Miller`01/14/11, 11:40:20      `ALP changes from advanced proerties
End if 

C_LONGINT:C283($Lpid)

$Lpid:=LSpawnProcess("ut_PRJCntrlRetrieveOfAmounts"; <>LStackSize; "Retrieve DC Amounts"; False:C215; False:C215; "DC")

//End ut_PRJRetrieveDesignContractAmt