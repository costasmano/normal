//%attributes = {"invisible":true}
//begin method: CA_SetLoginToDisable

//This method will  set [ClientAccess]CA_DisableLogins_b to true when

//[ClientAccess]CA_LimitAccess_s time stamp is Less than or equal to current time 

//stamp


//There should never be more than one record in this table [ClientAccess]



C_TEXT:C284($CurrentTS_s)  // Command Replaced was o_C_STRING length was 12
$CurrentTS_s:=ut_CreateTimeStamp
QUERY:C277([ClientAccess:88]; [ClientAccess:88]CA_Completed_b:5=False:C215; *)
QUERY:C277([ClientAccess:88];  & ; [ClientAccess:88]CA_LimitAccess_s:3<=$CurrentTS_s)

If (Records in selection:C76([ClientAccess:88])=0)
Else 
	If (ut_LoadRecord(->[ClientAccess:88]))
		[ClientAccess:88]CA_DisableLogins_b:4:=True:C214
		SAVE RECORD:C53([ClientAccess:88])
	End if 
	UNLOAD RECORD:C212([ClientAccess:88])
	READ ONLY:C145([ClientAccess:88])
End if 
