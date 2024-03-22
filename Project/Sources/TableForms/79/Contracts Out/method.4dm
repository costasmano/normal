If (False:C215)
	//"[Contracts]Contracts Out"
	// Modified by: costasmanousakis-(Designer)-(12/5/2005 11:41:38)
	Mods_2005_CM19
	// Modified by: costasmanousakis-(Designer)-(10/7/08 12:31:57)
	Mods_2008_CM_5404  // ("ACCESS")
	// Modified by: Costas Manousakis-(Designer)-(2/26/20 14:59:03)
	Mods_2020_02_bug
	//  `made all fields/vars in the detail section not-transparent so that the selected rows can be highlited
	//  ` also moved them vertically and adjusted widths  - CallReference #702
	// Modified by: manousakisc (6/5/2020)
	Mods_2020_06
	//  `adjusted height of detail fields and vars to fit in detail section of form
End if 

Case of 
	: (Form event code:C388=On Load:K2:1)
		C_BOOLEAN:C305(InspRtgContrAccess_b)
		InspRtgContrAccess_b:=User in group:C338(Current user:C182; "ReadOnly")
		C_LONGINT:C283(PWINDOWWIDTH_L; $L; $T; $R; $B)
		GET WINDOW RECT:C443($L; $T; $R; $B)
		PWINDOWWIDTH_L:=$R-$L
		If (InspRtgContrAccess_b)
			OBJECT SET VISIBLE:C603(bzAdd; False:C215)
		End if 
		
	: (Form event code:C388=On Outside Call:K2:11)
		If (<>fQuit)
			CANCEL:C270
		End if 
		
	: (Form event code:C388=On Display Detail:K2:22)
		C_TEXT:C284(S3FedAid)  // **Replaced old C_STRING length 1
		S3FedAid:=f_Boolean2String([Contracts:79]FederalFund:8; "YN")
	: (Form event code:C388=On Close Detail:K2:24)
		C_LONGINT:C283(PWINDOWWIDTH_L; $L; $T; $R; $B)
		GET WINDOW RECT:C443($L; $T; $R; $B)
		If ($R<($L+PWINDOWWIDTH_L))
			SET WINDOW RECT:C444($L; $T; ($L+PWINDOWWIDTH_L); $B)
		End if 
		
	: (Form event code:C388=On Activate:K2:9)
		UpdatFilesPalet
	: (Form event code:C388=On Deactivate:K2:10)
		UpdatFilesPalet
		//REDRAW(◊asWindows)
End case 