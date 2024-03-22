//[Inspections];"Routine Form"
//Description for vTeamMbr
If (False:C215)
	// Modified by: Costas Manousakis-(Designer)-(6/23/17 16:36:03)
	Mods_2017_06_bug
	//  `in v15 array is a text array
End if 

C_TEXT:C284(vTeamMbr)
C_LONGINT:C283($i; $size)  //Command Replaced was o_C_INTEGER

If ((Form event code:C388=On Load:K2:1) | (Form event code:C388=On Printing Detail:K2:18) | (Form event code:C388=On Display Detail:K2:22))
	If ((Type:C295(aInspTeam)=String array:K8:15) | (Type:C295(aInspTeam)=Text array:K8:16))
		$size:=Size of array:C274(aInspTeam)
	Else 
		$size:=0
	End if 
	If ($size>0)
		vTeamMbr:=aInspTeam{1}
		For ($i; 2; $size)
			vTeamMbr:=vTeamMbr+","+aInspTeam{$i}
		End for 
	Else 
		vTeamMbr:=""
	End if 
End if 