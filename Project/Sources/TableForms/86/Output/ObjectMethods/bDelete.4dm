If (False:C215)
	//Object Method: bDelete 
	// Modified by: costasmanousakis-(Designer)-(2/23/2007 16:04:53)
	Mods_2007_CM07
	Mods_2011_06  // CJ Miller`06/20/11, 11:31:28      ` Type all local variables for v11
End if 
C_LONGINT:C283($n)
$n:=Records in set:C195("UserSet")
If ($n=0)
	ALERT:C41("There are no selected records.")
Else 
	If ($n=1)
		CONFIRM:C162("Do you really want to delete this record?")
	Else 
		CONFIRM:C162("Do you really want to delete these "+String:C10($n)+" record?")
	End if 
	If (OK=1)
		CREATE SET:C116(Current form table:C627->; "saved")
		COPY SET:C600("UserSet"; "GlobSet")
		DIFFERENCE:C122("saved"; "GlobSet"; "saved")
		USE SET:C118("UserSet")
		DELETE SELECTION:C66(Current form table:C627->)
		USE SET:C118("saved")
		CLEAR SET:C117("saved")
		CLEAR SET:C117("GlobSet")
		C_TEXT:C284($RecSel)  // Command Replaced was o_C_STRING length was 10
		$RecSel:=String:C10(Records in selection:C76([Templates:86]))
		SET WINDOW TITLE:C213(MainTitle+" ["+$RecSel+"]")
		ORDER BY:C49([Templates:86]; [Templates:86]TemplateName:2)
		
	End if 
End if 