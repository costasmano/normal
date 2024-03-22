//[Inspections];"Routine Form"
//Description for vTeamMbr
If (False:C215)
	// Modified by: Costas Manousakis-(Designer)-(6/23/17 16:34:50)
	Mods_2017_06_bug
	//  `in v15 array is a text array
	// Modified by: Costas Manousakis-(Designer)-(6/2/20 17:00:36)
	Mods_2020_06
	//  `include the designated TL in team members - CallReference #714
End if 

C_TEXT:C284(vTeamMbr)
C_LONGINT:C283($i; $size)  //Command Replaced was o C_INTEGER

If (Form event code:C388=On Printing Detail:K2:18)
	vTeamMbr:=""
	If ([Inspections:27]TeamLeader:4#0)
		If (Find in array:C230(aInspTeamID; [Inspections:27]TeamLeader:4)>0)
			//already in list of team members
		Else 
			vTeamMbr:=Get_Description(->APEOPLE; ->APEOPLE_ID; ->[Inspections:27]TeamLeader:4)
		End if 
	End if 
	If ((Type:C295(aInspTeam)=String array:K8:15) | (Type:C295(aInspTeam)=Text array:K8:16))
		$size:=Size of array:C274(aInspTeam)
	Else 
		$size:=0
	End if 
	If ($size>0)
		If (vTeamMbr="")
			vTeamMbr:=aInspTeam{1}
		Else 
			vTeamMbr:=vTeamMbr+","+aInspTeam{1}
		End if 
		
		For ($i; 2; $size)
			vTeamMbr:=vTeamMbr+","+aInspTeam{$i}
		End for 
	Else 
		//vTeamMbr:=""
	End if 
End if 