If (False:C215)
	Mods_2011_06  // CJ Miller`06/14/11, 17:01:50      ` Type all local variables for v11
End if 
Case of 
	: (Form event code:C388=On Load:K2:1)
		//C_POINTER($vpSrcObj)
		//C_LONGINT($vlSrcElem; $vlPID)
		//_O_DRAG AND DROP PROPERTIES($vpSrcObj; $vlSrcElem; $vlPID)
		//If ($vpSrcObj=Get pointer("GroupMemberList_hL"))
		////Accept objects only from GroupMemberList_hL      
		//$0:=0
		//Else 
		//$0:=-1
		//End if 
	: (Form event code:C388=On Drop:K2:12)
		GRP_RemoveFromGroup
	: (Form event code:C388=On Double Clicked:K2:5)
		GRP_AddToGroup
End case 
