If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 12/02/05, 14:59:57
	// ----------------------------------------------------
	// Method: Form Method: Print4
	// Description
	// 
	//
	// Parameters
	// ----------------------------------------------------
	// Modified by: costasmanousakis-(Designer)-(12/2/2005 15:00:10)
	Mods_2005_CM19
	// Modified by: costasmanousakis-(Designer)-(12/2/2005 19:52:05)
	Mods_2005_CM19
	// Modified by: costasmanousakis-(Designer)-(12/28/2005 22:18:07)
	Mods_2005_CM21
	// Modified by: costasmanousakis-(Designer)-(3/19/09 09:11:52)
	Mods_2009_CM_5404  //Copied to Server on : 03/19/09, 09:12:02`"WKHRMODS")
	//Copy of Print4 form for estimates with version=0
End if 

Case of 
	: (Form event code:C388=On Printing Detail:K2:18)
		If ([Work_Estimate:103]AddendumNo:29=0)
			OBJECT SET VISIBLE:C603(*; "Addend@"; False:C215)
		Else 
			OBJECT SET VISIBLE:C603(*; "Addend@"; True:C214)
		End if 
		READ ONLY:C145([Contract_Project_Maintenance:100])
		QUERY:C277([Contract_Project_Maintenance:100]; [Contract_Project_Maintenance:100]AssignID:13=[Work_Estimate:103]AssignID:2)
		ARRAY TEXT:C222($arr_PrjBrgNo_s; 0)  //Command Replaced was o_ARRAY string length was 20
		SELECTION TO ARRAY:C260([Contract_Project_Maintenance:100]BridgeNo:4; $arr_PrjBrgNo_s)
		READ WRITE:C146([Contract_Project_Maintenance:100])
		C_LONGINT:C283($i; $numprojs)
		$numprojs:=Size of array:C274($arr_PrjBrgNo_s)
		C_TEXT:C284(vBrgAssgnList)
		vBrgAssgnList:=""
		If ($numprojs>0)
			vBrgAssgnList:=$arr_PrjBrgNo_s{1}
			For ($i; 2; $numprojs)
				vBrgAssgnList:=vBrgAssgnList+" , "+$arr_PrjBrgNo_s{$i}
			End for 
		End if 
		
End case 