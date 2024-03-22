//%attributes = {"invisible":true}
//Method: LSS_FillTeamMembers
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 10/18/18, 11:18:58
	// ----------------------------------------------------
	//Created : 
	Mods_2018_10
End if 
//
C_TEXT:C284($Key_txt)
ARRAY LONGINT:C221($Keys_aL; 0)
$Key_txt:=[LSS_Inspection:164]LSS_InspectionId_s:1

Begin SQL
	select [LSS_TeamMembers].[LSS_TeamMemberId_L]
	from 
	[LSS_TeamMembers]
	where [LSS_TeamMembers].[LSS_InspectionId_s] = :$Key_txt
	into :$Keys_aL
	
End SQL
C_TEXT:C284($LSS_TeamMembers_txt)
LSS_TeamMembers_txt:=""
C_LONGINT:C283($Loop_L; $Key_L)
For ($Loop_L; 1; Size of array:C274($Keys_aL))
	$Key_L:=$Keys_aL{$Loop_L}
	$LSS_TeamMembers_txt:=""
	
	Begin SQL
		select CONCAT(CONCAT([Personnel].[First Name],' '),[Personnel].[Last Name])
		FROM [Personnel]
		where [Personnel].[Person ID] = :$Key_L
		into :$LSS_TeamMembers_txt;
		
	End SQL
	
	
	If ($Loop_L=1)
		LSS_TeamMembers_txt:=LSS_TeamMembers_txt+$LSS_TeamMembers_txt
	Else 
		LSS_TeamMembers_txt:=LSS_TeamMembers_txt+", "+$LSS_TeamMembers_txt
	End if 
	
End for 


//End LSS_FillTeamMembers