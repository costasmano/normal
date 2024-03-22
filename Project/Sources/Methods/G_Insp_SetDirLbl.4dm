//%attributes = {"invisible":true}
If (False:C215)
	//G_Insp_SetDirLbl 
	//Set Labels for location of Wt posting and clearance signs based on orientation.
	
	Mods_2004_CM11
	
End if 

C_BOOLEAN:C305($1; $Orientation)
$Orientation:=$1
C_TEXT:C284(vsNorthEast; vsSouthWest; vsNESideWlk; vsSWSideWlk; vsNESideWlkCurb; vsSWSideWlkCurb)  // Command Replaced was o_C_STRING length was 2
C_TEXT:C284($vsBoundOnOff)  // Command Replaced was o_C_STRING length was 1
If (f_Insp_Revision1([Inspections:27]Insp Date:78))
	$vsBoundOnOff:=""
Else 
	$vsBoundOnOff:="B"
End if 

If ($Orientation)
	vsNorthEast:="N"+$vsBoundOnOff
	vsSouthWest:="S"+$vsBoundOnOff
	vsNESideWlk:="E"+$vsBoundOnOff
	vsSWSideWlk:="W"+$vsBoundOnOff
	vsNESideWlkCurb:="E"
	vsSWSideWlkCurb:="W"
Else 
	vsNorthEast:="E"+$vsBoundOnOff
	vsSouthWest:="W"+$vsBoundOnOff
	vsNESideWlk:="N"+$vsBoundOnOff
	vsSWSideWlk:="S"+$vsBoundOnOff
	vsNESideWlkCurb:="N"
	vsSWSideWlkCurb:="S"
End if 