If (False:C215)
	//Object Method: btnSave 
	// Modified by: costasmanousakis-(Designer)-(11/21/07 12:17:33)
	Mods_2007_CM_5401
End if 

If (Form event code:C388=On Clicked:K2:4)
	If (False:C215)
		If (Is new record:C668([Contract_Project_Maintenance:100]))
			LogNewRecord(->[Contract_Maintenance:97]ContractNo:1; ->[Contract_Project_Maintenance:100]ContractNo:2; ->[Contract_Project_Maintenance:100]ProjectID:1; 1; "ProjMaint")
		End if 
	End if 
	If (vDistrict="")
		CONFIRM:C162("Cannot save an undefined Bridge number!"; "Cancel"; "Try again")
		If (OK=1)
			CANCEL:C270
		End if 
	Else 
		[Contract_Project_Maintenance:100]BridgeNo:4:=vBridgeNo
		[Contract_Project_Maintenance:100]District:8:=vDistrict
		[Contract_Project_Maintenance:100]Town:7:=vTown
		[Contract_Project_Maintenance:100]Location:6:=vLocation
		[Contract_Project_Maintenance:100]Project Type:3:=[Contract_Project_Maintenance:100]Project Type:3
		
		SAVE RECORD:C53([Contract_Project_Maintenance:100])
		ACCEPT:C269
	End if 
End if 