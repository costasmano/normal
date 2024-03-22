If (False:C215)
	// Modified by: costasmanousakis-(Designer)-(8/7/09 17:18:46)
	Mods_2009_08  //Copied to Server on : 08/26/09, 15:37:02
End if 


Case of 
	: (Form event code:C388=On Load:K2:1)
		
	: (Form event code:C388=On Data Change:K2:15)
		C_LONGINT:C283($row_L; $loop_L; $findRow_L)
		$row_L:=DCM_CUUsed_aB
		C_BOOLEAN:C305($Find_b)
		$findRow_L:=-1
		For ($loop_L; 1; Size of array:C274(DCM_CUUsedElNos_aL))
			If ((DCM_CUUsedElNos_aL{$loop_L}=DCM_CUElNos_aL{$row_L}) & (DCM_CUUsedEnv_ai{$loop_L}=DCM_CUEnv_ai{$row_L}))
				$findRow_L:=$loop_L
			End if 
		End for 
		If (DCM_CUUsed_aB{$row_L})
			//ALERT("changed what? "+String($row_L)+" on")
			If ($findRow_L<=0)
				DCM_ControlCUs("ADDTOUSED"; $row_L)
			End if 
			
		Else 
			//ALERT("changed what? "+String($row_L)+" off")
			If ($findRow_L>0)
				DCM_ControlCUs("DELETEROW"; $findRow_L)
				
			End if 
			
		End if 
		
	: (Form event code:C388=On Clicked:K2:4)
		
End case 