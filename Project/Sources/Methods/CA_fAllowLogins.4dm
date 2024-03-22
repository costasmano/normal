//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// CA_fAllowLogins
	// User name (OS): cjmiller
	// Date and time: 07/29/04, 11:57:06
	// ----------------------------------------------------
	// Description
	// This method will return true or false depending upon if logins have been disabl
	
	// Parameters
	//$0 booolean
	// ----------------------------------------------------
	Mods_2005_CM03
	Mods_2005_CM18
	Mods_2011_06  // CJ Miller`06/14/11, 10:45:14      ` Type all local variables for v11
End if 

C_BOOLEAN:C305($EnableLogIns_b; $0)

$EnableLogIns_b:=True:C214

C_TEXT:C284($CurrentTS_s)  // Command Replaced was o_C_STRING length was 12
READ ONLY:C145([ClientAccess:88])
$CurrentTS_s:=ut_CreateTimeStamp
QUERY:C277([ClientAccess:88]; [ClientAccess:88]CA_Completed_b:5=False:C215; *)
QUERY:C277([ClientAccess:88];  & ; [ClientAccess:88]CA_MessageStart_s:2<=Substring:C12($CurrentTS_s; 1; 8))

If (Records in selection:C76([ClientAccess:88])>0)
	
	Case of 
		: (Current user:C182="Designer") | (Current user:C182="Administrator")
			If ([ClientAccess:88]CA_DisableLogins_b:4)
				
				ut_BigAlert([ClientAccess:88]CA_Message_txt:1)
				CONFIRM:C162("Do you wish to reset client log ins to allow users in?")
				If (OK=1)
					If (ut_LoadRecord(->[ClientAccess:88]))
					End if 
					[ClientAccess:88]CA_DisableLogins_b:4:=False:C215
					[ClientAccess:88]CA_Completed_b:5:=True:C214
					SAVE RECORD:C53([ClientAccess:88])
					UNLOAD RECORD:C212([ClientAccess:88])
					READ ONLY:C145([ClientAccess:88])
				End if 
				
			End if 
		: (User in group:C338(Current user:C182; "BatchOperators"))
			//Allow batch operators in
		Else 
			LOAD RECORD:C52([ClientAccess:88])  // I know we do not really need do this but I beleiiev in consistency
			If ([ClientAccess:88]CA_DisableLogins_b:4)
				$EnableLogIns_b:=False:C215
			End if 
			
			ut_BigAlert([ClientAccess:88]CA_Message_txt:1)
			
	End case 
End if 
$0:=$EnableLogIns_b

//End CA_fAllowLogins