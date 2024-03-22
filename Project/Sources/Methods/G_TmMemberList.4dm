//%attributes = {"invisible":true}
If (False:C215)
	//G_TmMemberList
	//method to compose the vTeamMbr var in Insp forms
	
	Mods_2005_CM01
	// Modified by: costasmanousakis-(Designer)-(4/18/2006 16:28:45)
	Mods_2006_CMy2
	// Modified by: costasmanousakis-(Designer)-(11/30/07 09:32:06)
	Mods_2007_CM_5401
End if 

C_TEXT:C284(vTeamMbr)
C_LONGINT:C283($i; $size; $j; $k; $n)  //Command Replaced was o_C_INTEGER
C_TEXT:C284($s)  // Command Replaced was o_C_STRING length was 255

If (Form event code:C388=On Printing Detail:K2:18)
	If (Type:C295(aInspTeam)#String array:K8:15)
		//in case called from outside the  Input Form    
		G_Insp_RelateInsp(->[Field Trip:43]InspID:1)
		
		INSP_BuildTmMbrArea
	End if 
	
	$size:=Size of array:C274(aInspTeam)
	If ($size>0)
		$s:=aInspTeam{1}
		$n:=Position:C15(" "; $s)
		$s:=Delete string:C232($s; 2; $n-2)
		$s:=Insert string:C231($s; "."; 2)
		vTeamMbr:=$s
		For ($i; 2; $size)
			$s:=aInspTeam{$i}
			$n:=Position:C15(" "; $s)
			$s:=Delete string:C232($s; 2; $n-2)
			$s:=Insert string:C231($s; "."; 2)
			vTeamMbr:=vTeamMbr+", "+$s
		End for 
	Else 
		vTeamMbr:=""
	End if 
	If ([Inspections:27]TeamMembrAddl:199)
		If (Length:C16(vTeamMbr)>0)
			vTeamMbr:=vTeamMbr+" (See also General Remarks)"
		Else 
			vTeamMbr:="See General Remarks"
		End if 
	End if 
	vTeamMbr:=Uppercase:C13(vTeamMbr)
	G_FitPrintObject(->vTeamMbr; 11; 6; 0)
	
End if 