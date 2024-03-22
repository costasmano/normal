//Method: "SelectResources".Button1
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 11/27/18, 16:53:31
	// ----------------------------------------------------
	//Created : 
	Mods_2018_11
	Mods_2020_05  //Test to see if blob needs to be compressed
End if 
//
C_BLOB:C604($File_blb)
SET BLOB SIZE:C606($File_blb; 0)
SET BLOB SIZE:C606($ResourceFile_blb; 0)

C_LONGINT:C283($Start_L; $Row_l; $Compressed_L)
$Start_L:=1
Repeat 
	$Row_l:=Find in array:C230(v_1_004_ab; True:C214; $Start_L)
	$Start_L:=$Row_l+1
	If ($Row_l>0)
		$File_blb:=Server_ReturnResourceFile(LBGeneric_atxt{$Row_l})
		If (BLOB size:C605($File_blb)>0)
			VARIABLE TO BLOB:C532(LBGeneric_atxt{$Row_l}; $ResourceFile_blb; *)
			VARIABLE TO BLOB:C532($File_blb; $ResourceFile_blb; *)
			
		End if 
	End if 
Until ($Row_l<0)
C_LONGINT:C283($Size_L)
$Size_L:=BLOB size:C605($ResourceFile_blb)

COMPRESS BLOB:C534($ResourceFile_blb)
BLOB PROPERTIES:C536($ResourceFile_blb; $Compressed_L)
If ($Compressed_L#Is not compressed:K22:11)
	If (BLOB size:C605($ResourceFile_blb)>=$Size_L)
		
		EXPAND BLOB:C535($ResourceFile_blb)
		
	End if 
End if 
START TRANSACTION:C239
CREATE RECORD:C68([Activity Log:59])
Inc_Sequence("Activity Log"; ->[Activity Log:59]RefID:28)  //Get the next sequence
[Activity Log:59]Activity Type:3:="TRS"
[Activity Log:59]dDate:5:=Current date:C33(*)
[Activity Log:59]tTime:6:=Current time:C178(*)
[Activity Log:59]User Name:4:=Current user:C182
[Activity Log:59]Status:9:=-1  //transfer to every one
[Activity Log:59]Source:2:=<>Source
[Activity Log:59]Data:10:=$ResourceFile_blb
[Activity Log:59]Transfer:12:=<>transfer
[Activity Log:59]Destination:1:=<>DEstination
SAVE RECORD:C53([Activity Log:59])
VALIDATE TRANSACTION:C240


ACCEPT:C269

//End SelectResources.Button1