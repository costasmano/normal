//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): administrator
//Date and time: 10/22/15, 13:00:01
//----------------------------------------------------
//Method: NTI_CheckForValidate
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2015_11  //Add new method of assigning Tunnel number
	//Modified by: administrator (11/10/15 16:45:30)
	
	
End if 


C_LONGINT:C283($Count_L)
OBJECT SET ENABLED:C1123(*; "bValidate"; False:C215)  // **replaced _ o _DISABLE BUTTON(*;"bValidate")
If ([NTI_TunnelInfo:181]NTI_i1_s:6#"") & (Length:C16([NTI_TunnelInfo:181]NTI_i1_s:6)=15)
	SET QUERY DESTINATION:C396(Into variable:K19:4; $Count_L)
	
	QUERY:C277([NTI_TunnelInfo:181]; [NTI_TunnelInfo:181]NTI_i1_s:6=[NTI_TunnelInfo:181]NTI_i1_s:6)
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
End if 
Case of 
	: (Length:C16([NTI_TunnelInfo:181]NTI_i1_s:6)#15)
	: (Old:C35([NTI_TunnelInfo:181]NTI_i1_s:6)=[NTI_TunnelInfo:181]NTI_i1_s:6) & ($Count_L=1)
		OBJECT SET ENABLED:C1123(bValidate; True:C214)  // **replaced _ o _ENABLE BUTTON(bValidate)
	: ($Count_L=1)
		ALERT:C41("You already have a tunnel TIN with this number")
		
	: ($Count_L>1)
		ALERT:C41("You already have more than one tunnel TIN with this number, notify admin!")
		
	: ([NTI_TunnelInfo:181]NTI_i2_s:7="")
	: ([NTI_TunnelInfo:181]NTI_TownName_s:71="")
	: ([NTI_TunnelInfo:181]NTI_i4_L:9=0)
	: ([NTI_TunnelInfo:181]NTI_i5_L:10=0)
	: ([NTI_TunnelInfo:181]NTI_i6_s:11="")
	: ([NTI_TunnelInfo:181]NTI_i8_s:13="")
	: ([NTI_TunnelInfo:181]NTI_i9_L:14=0)
	: ([NTI_TunnelInfo:181]NTI_i10_s:15="")
	Else 
		OBJECT SET ENABLED:C1123(*; "bValidate"; True:C214)  // **replaced _ o _ENABLE BUTTON(*;"bValidate")
		
		
End case 
//End NTI_CheckForValidate

