//%attributes = {"invisible":true}

// ----------------------------------------------------
// User name (OS): administrator
// Date and time: 11/18/14, 15:00:05
// ----------------------------------------------------
// Method: LSS_CreateRoles
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($IPAddress_txt)

C_BOOLEAN:C305($LogOut_B; SQLConnectionMade_b; $Skip_b)
C_LONGINT:C283($PersGroupdID_L; Count_L; $Loop_L)

C_LONGINT:C283($Size_L; $Limit_L; $State_L; $Time_L)
C_TEXT:C284($Name_txt; $Name1_txt)

If (Count parameters:C259=1)
	C_TEXT:C284($1)
	$IPAddress_txt:=$1
End if 
If (SQLConnectionMade_b)
	$LogOut_B:=False:C215
	ARRAY LONGINT:C221($RoleID_aL; 0)
	ARRAY LONGINT:C221($PersoniD_al; 0)
	ARRAY LONGINT:C221($LigtingID_aL; 0)
	
	Begin SQL
		select [Person_Role].[RoleId], 
		[Person_Role].[PersonId], 
		[refPersontoPersonXREF].[Person ID]
		from  [Person_Role], [refPersontoPersonXREF]
		where
		[refPersontoPersonXREF].[LightingID_L] = [Person_Role].[PersonId]
		into :$RoleID_aL, :$LigtingID_aL, :$PersoniD_al
		
	End SQL
	
	ut_SQLLogout
	
	
Else 
	$IPAddress_txt:=SQL_TestConnection
	
	If ($IPAddress_txt#"")
		ut_SQLConnect("Designer"; "caesar"; $IPAddress_txt)
		$LogOut_B:=True:C214
	End if 
	ARRAY LONGINT:C221($RoleID_aL; 0)
	ARRAY LONGINT:C221($PersoniD_al; 0)
	ARRAY LONGINT:C221($LigtingID_aL; 0)
	
	Begin SQL
		select [Person_Role].[RoleId], 
		[Person_Role].[PersonId], 
		[refPersontoPersonXREF].[Person ID]
		from  [Person_Role], [refPersontoPersonXREF]
		where
		[refPersontoPersonXREF].[LightingID_L] = [Person_Role].[PersonId]
		into :$RoleID_aL, :$LigtingID_aL, :$PersoniD_al
		
	End SQL
	
End if 



Count_L:=Size of array:C274($RoleID_aL)

<>ProgressPID:=StartProgress("PERS_GroupMembers"; "Button"; "Creating Records")
UpdateProgress(1; Count_l)
For ($Loop_L; 1; Size of array:C274($RoleID_aL))
	$Skip_b:=False:C215
	If (($Loop_L%25)=0)
		UpdateProgress($Loop_L; Count_l)
	End if 
	
	Case of 
		: ($RoleID_aL{$Loop_L}=1)  //group id = 92
			$PersGroupdID_L:=92
			
		: ($RoleID_aL{$Loop_L}=2)  //group id = 93
			$PersGroupdID_L:=93
			
		: ($RoleID_aL{$Loop_L}=3)  //group id = 94
			$PersGroupdID_L:=94
			
		: ($RoleID_aL{$Loop_L}=4)  //group id = 95
			$PersGroupdID_L:=95
		Else 
			$Skip_b:=True:C214
	End case 
	If (Not:C34($Skip_b))
		QUERY:C277([PERS_GroupMembers:110]; [PERS_GroupMembers:110]PersonID_I:2=$PersoniD_al{$Loop_L}; *)
		QUERY:C277([PERS_GroupMembers:110];  & ; [PERS_GroupMembers:110]GroupID_I:1=$PersGroupdID_L)
		If (Records in selection:C76([PERS_GroupMembers:110])=0)
			CREATE RECORD:C68([PERS_GroupMembers:110])
			[PERS_GroupMembers:110]PersonID_I:2:=$PersoniD_al{$Loop_L}
			[PERS_GroupMembers:110]GroupID_I:1:=$PersGroupdID_L
			SAVE RECORD:C53([PERS_GroupMembers:110])
			UNLOAD RECORD:C212([PERS_GroupMembers:110])
		End if 
	End if 
End for 
POST OUTSIDE CALL:C329(<>ProgressPID)
PROCESS PROPERTIES:C336(<>ProgressPID; $Name_txt; $State_L; $Time_L)

Repeat 
	//IDLE
	PROCESS PROPERTIES:C336(<>ProgressPID; $Name1_txt; $State_L; $Time_L)
	
	DELAY PROCESS:C323(Current process:C322; 60)
Until ($State_L<1) | ($Name_txt#$Name1_txt)
If ($LogOut_B)
	ut_SQLLogout
Else 
	ut_SQLConnect("Designer"; "caesar"; $IPAddress_txt)
	
End if 
