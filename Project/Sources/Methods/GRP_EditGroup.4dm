//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 09/20/10, 23:33:47
	// ----------------------------------------------------
	// Method: GRP_EditGroup
	// Description
	//  ` Edit an existing Group of Personnel. Designed to open a group for editing
	//  ` without allowing changing the group name.
	// 
	// Parameters
	// $1 : $GrpName_txt
	// $2 : $AllowGrpNameEdit_B
	// ----------------------------------------------------
	
	Mods_2010_09
End if 
C_TEXT:C284($1; $GrpName_txt)
$GrpName_txt:=$1
C_BOOLEAN:C305(GRP_NotAllowGrpNmEdit_b)
GRP_NotAllowGrpNmEdit_b:=True:C214
If (Count parameters:C259>1)
	C_BOOLEAN:C305($2)
	GRP_AllowGrpNmEdit_b:=$2
End if 
QUERY:C277([PERS_Groups:109]; [PERS_Groups:109]PERS_GroupName_s:2=$GrpName_txt)
If (Records in selection:C76([PERS_Groups:109])>0)
	
	READ WRITE:C146([PERS_Groups:109])
	READ WRITE:C146([PERS_GroupMembers:110])
	If (ut_LoadRecordInteractive(->[PERS_Groups:109]))
		C_LONGINT:C283($Ww_L; $Wh_L)
		FORM GET PROPERTIES:C674([PERS_Groups:109]; "Input"; $Ww_L; $Wh_L)
		NewWindow($Ww_L; $Wh_L; 6; Plain window:K34:13; "Edit Group")
		FORM SET INPUT:C55([PERS_Groups:109]; "Input")
		MODIFY RECORD:C57([PERS_Groups:109])
		UNLOAD RECORD:C212([PERS_Groups:109])
		CLOSE WINDOW:C154
	Else 
		ALERT:C41("Could not Edit Group Record <"+$GrpName_txt+"> !!")
	End if 
	
Else 
	ALERT:C41("No Personnel Group named <"+$GrpName_txt+"> Found!")
End if 
GRP_NotAllowGrpNmEdit_b:=False:C215