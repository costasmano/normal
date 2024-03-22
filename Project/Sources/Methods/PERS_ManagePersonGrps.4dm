//%attributes = {"invisible":true}
//Method: PERS_ManagePersonGrps
//Description
// manage Personnel groups that a Person belongs to
// Parameters
// $1 : PersonID (Optional)
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Created : 
	//Date and time: Apr 25, 2023, 12:25:32
	Mods_2023_04
	// ----------------------------------------------------
	
	C_LONGINT:C283(PERS_ManagePersonGrps; $1)
	
End if 
//

C_LONGINT:C283($PersonID_L)
If (Count parameters:C259>0)
	C_LONGINT:C283($1)
	$PersonID_L:=$1
Else 
	$PersonID_L:=[Personnel:42]Person ID:1
End if 

C_LONGINT:C283($loadProgress_L)
$loadProgress_L:=Progress New
Progress SET TITLE($loadProgress_L; "Getting available Personnel groups")
Progress SET PROGRESS($loadProgress_L; -1; ""; True:C214)
C_OBJECT:C1216($availgroups_o; $persongroups_o)
$availgroups_o:=ds:C1482.PERS_Groups.all().orderBy("PERS_GroupName_s asc")

C_OBJECT:C1216($persongroupmemb_o)
$persongroupmemb_o:=ds:C1482.PERS_Groups.query("PERS_GroupID_I_54_GroupID_I.PersonID_I = :1"; $PersonID_L)
If ($persongroupmemb_o.length>0)
	C_COLLECTION:C1488($persongroups_c)
	$persongroups_c:=$persongroupmemb_o.toCollection("PERS_GroupID_I")
	PERS_ExpandGroups($persongroups_c)  //get all memberships
	
	C_COLLECTION:C1488($search_c)
	$search_c:=New collection:C1472
	For each ($grp_o; $persongroups_c)
		$search_c.push($grp_o.PERS_GroupID_I)
	End for each 
	//create entity selection of groups which the user is a member of
	$persongroupmemb_o:=ds:C1482.PERS_Groups.query("PERS_GroupID_I in :1"; $search_c)
	//remove from availgrps 
	$availgroups_o:=$availgroups_o.minus($persongroupmemb_o)
	
End if 
//reset the selection from Pers_groups for the person to be only what is directly member of
$persongroups_o:=ds:C1482.PERS_Groups.query("PERS_GroupID_I_54_GroupID_I.PersonID_I = :1"; $PersonID_L).orderBy("PERS_GroupName_s asc")
C_COLLECTION:C1488($availgrps_c; $persongrps_c)
$availgrps_c:=$availgroups_o.orderBy("PERS_GroupName_s asc").toCollection("PERS_GroupName_s,PERS_GroupID_I")
$persongrps_c:=$persongroups_o.toCollection("PERS_GroupName_s,PERS_GroupID_I")

Progress QUIT($loadProgress_L)

// prepare to load the dialog
C_LONGINT:C283($dlg_L)
$dlg_L:=Open form window:C675("twolistmove_c"; Plain form window:K39:10)
C_OBJECT:C1216($datafromdlg_o)  //object that will have the resulting collections
$datafromdlg_o:=New object:C1471  //have to initialize it
DIALOG:C40("twolistmove_c"; New object:C1471("return"; $datafromdlg_o; \
"UseC"; $availgrps_c; \
"OmitC"; $persongrps_c; \
"col1"; "PERS_GroupName_s"; \
"useheader"; "Available groups"; \
"equalattr"; "PERS_GroupID_I"; \
"orderbycriteria"; "PERS_GroupName_s asc"; \
"omitheader"; "Person groups"; \
"cancelbtn"; New object:C1471("label"; "forget it")))
CLOSE WINDOW:C154($dlg_L)

If (OK=1)
	//get the resulting collection
	C_COLLECTION:C1488($new_c)
	$new_c:=$datafromdlg_o.OmitC
	
	//create a new entity selection from the new collection
	C_OBJECT:C1216($new_o; $grp_o; $add_o; $remove_o)
	C_COLLECTION:C1488($search_c)
	$search_c:=New collection:C1472
	For each ($grp_o; $new_c)
		$search_c.push($grp_o.PERS_GroupID_I)
	End for each 
	
	$new_o:=ds:C1482.PERS_Groups.query("PERS_GroupID_I IN :1"; $search_c)
	$add_o:=$new_o.minus($persongroups_o)
	$remove_o:=$persongroups_o.minus($new_o)
	
	
	If ($add_o.length>0)
		// have something to add
		For each ($grp_o; $add_o)
			CREATE RECORD:C68([PERS_GroupMembers:110])
			[PERS_GroupMembers:110]GroupID_I:1:=$grp_o.PERS_GroupID_I
			[PERS_GroupMembers:110]PersonID_I:2:=$PersonID_L
			[PERS_GroupMembers:110]PERS_GroupMembers_UUIDKey_s:3:=Generate UUID:C1066
			SAVE RECORD:C53([PERS_GroupMembers:110])
			LogNewRecord(->[PERS_Groups:109]PERS_GroupID_I:1; ->[PERS_GroupMembers:110]GroupID_I:1; ->[PERS_GroupMembers:110]PersonID_I:2; 3; ""; ->[Personnel:42]Person ID:1)
		End for each 
	End if 
	
	If ($remove_o.length>0)
		// have something to delete
		For each ($grp_o; $remove_o)
			QUERY:C277([PERS_GroupMembers:110]; [PERS_GroupMembers:110]GroupID_I:1=$grp_o.PERS_GroupID_I; *)
			QUERY:C277([PERS_GroupMembers:110];  & ; [PERS_GroupMembers:110]PersonID_I:2=$PersonID_L)
			If (Records in selection:C76([PERS_GroupMembers:110])=1)
				
				If (ut_LoadRecordInteractive(->[PERS_GroupMembers:110]))
					LogDeletion(->[PERS_Groups:109]PERS_GroupID_I:1; ->[PERS_GroupMembers:110]GroupID_I:1; ->[PERS_GroupMembers:110]PersonID_I:2; 3; ->[Personnel:42]Person ID:1)
					DELETE RECORD:C58([PERS_GroupMembers:110])
				Else 
					ALERT:C41("Member record in group "+$grp_o.PERS_GroupName_s+" could not be deleted! Try again later!")
				End if 
				
			Else 
				ALERT:C41("Member record in group "+$grp_o.PERS_GroupName_s+" not found!")
			End if 
		End for each 
	End if 
	
End if 
//End PERS_ManagePersonGrps   