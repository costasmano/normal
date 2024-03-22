// ----------------------------------------------------
// Method: Object Method: LockButton
// Description
// 
// 
// Parameters
// ----------------------------------------------------

If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 01/03/12, 09:41:36
	// First Release
	Mods_2012_01
End if 

C_TEXT:C284(SCPOA_OldGenMsg_txt; vGenericHlpMsgVar1_S)

Case of 
	: (Form event code:C388=On Load:K2:1)
		
		If (Read only state:C362(Current form table:C627->))
			Self:C308->:=0
		Else 
			Self:C308->:=1
		End if 
		
	: (Form event code:C388=On Clicked:K2:4)
		
		If (Self:C308->=1)
			READ WRITE:C146(Current form table:C627->)
			vGenericHlpMsgVar1_S:="Click to Lock the "+Table name:C256(Current form table:C627)+" table"
			
		Else 
			READ ONLY:C145(Current form table:C627->)
			vGenericHlpMsgVar1_S:="Click to Unlock the "+Table name:C256(Current form table:C627)+" table"
			
		End if 
	: (Form event code:C388=On Mouse Enter:K2:33)
		SCPOA_OldGenMsg_txt:=vGenericHlpMsgVar1_S
		If (Self:C308->=0)
			vGenericHlpMsgVar1_S:="Click to Unlock the "+Table name:C256(Current form table:C627)+" table"
		Else 
			vGenericHlpMsgVar1_S:="Click to Lock the "+Table name:C256(Current form table:C627)+" table"
		End if 
		
	: (Form event code:C388=On Mouse Leave:K2:34)
		If (SCPOA_OldGenMsg_txt#"")
			vGenericHlpMsgVar1_S:=SCPOA_OldGenMsg_txt
		End if 
		
End case 