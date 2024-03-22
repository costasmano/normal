//%attributes = {"invisible":true}
//Method: TEMP_SavePersonnelLoginInfo
//Description
//  ` save the logininfo from field [Personnel]MachineName_txt
//  ` before loading should run method Temp_CheckPersonnel to verify that the ID matching is OK
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 02/28/17, 15:41:56
	// ----------------------------------------------------
	//Created : 
	Mods_2017_02
End if 
//
C_BOOLEAN:C305($Exportdata_b)
CONFIRM:C162("Export Login info to blob, or load from blob?"; "Export"; "Load")
$Exportdata_b:=(OK=1)
C_BLOB:C604($Data_x)
C_TIME:C306($dataFile_t)
C_TEXT:C284($dataFile_txt)
ARRAY LONGINT:C221($PersIDs_aL; 0)
ARRAY TEXT:C222($Logins_atxt; 0)
C_LONGINT:C283($loop_L)

If ($Exportdata_b)
	//Export
	C_BOOLEAN:C305($external_b)
	$external_b:=False:C215
	CONFIRM:C162("Login to a server or run on current data flle?"; "Login"; "Current")
	If (OK=1)
		$external_b:=True:C214
		SQL LOGIN:C817(""; ""; ""; *)
	End if 
	Begin SQL
		select
		[Personnel].[Person ID] ,
		[Personnel].[MachineName_txt]
		from [Personnel]
		into
		:$PersIDs_aL ,
		:$Logins_atxt 
		;
	End SQL
	ARRAY TEXT:C222($ExtRefIDs_atxt; 0)
	ARRAY TEXT:C222($BostonRefIDs_atxt; 0)
	ARRAY LONGINT:C221($ExtRefIDs_aL; 0)
	ARRAY LONGINT:C221($BostonRefIDs_aL; 0)
	ARRAY TEXT:C222($DestRef_atxt; 0)
	C_LONGINT:C283($TableNum_L)
	$TableNum_L:=Table:C252(->[Personnel:42])
	Begin SQL
		select
		[FileIDRes Table].[Destination ID],
		[FileIDRes Table].[Local ID]
		from [FileIDRes Table]
		Where 
		[FileIDRes Table].[File Number] = :$TableNum_L
		and
		[FileIDRes Table].[Destination] = 'here'
		into
		:$ExtRefIDs_atxt,
		:$BostonRefIDs_atxt
		;
	End SQL
	//convert the test to number arrays
	ARRAY LONGINT:C221($ExtRefIDs_aL; Size of array:C274($ExtRefIDs_atxt))
	ARRAY LONGINT:C221($BostonRefIDs_aL; Size of array:C274($ExtRefIDs_atxt))
	For ($loop_L; 1; Size of array:C274($ExtRefIDs_atxt))
		$ExtRefIDs_aL{$loop_L}:=Num:C11($ExtRefIDs_atxt{$loop_L})
		$BostonRefIDs_aL{$loop_L}:=Num:C11($BostonRefIDs_atxt{$loop_L})
	End for 
	
	If ($external_b)
		SQL LOGOUT:C872
	End if 
	
	//create the destination array
	ARRAY LONGINT:C221($DestIDs_aL; Size of array:C274($PersIDs_aL))
	C_LONGINT:C283($indx_L)
	For ($loop_L; 1; Size of array:C274($PersIDs_aL))
		$indx_L:=Find in array:C230($ExtRefIDs_aL; $PersIDs_aL{$loop_L})
		
		If ($indx_L>0)
			$DestIDs_aL{$loop_L}:=$BostonRefIDs_aL{$indx_L}
		Else 
			$DestIDs_aL{$loop_L}:=$PersIDs_aL{$loop_L}
		End if 
		
	End for 
	//save to a blob
	
	VARIABLE TO BLOB:C532($DestIDs_aL; $Data_x; *)
	VARIABLE TO BLOB:C532($Logins_atxt; $Data_x; *)
	
	//save blob to doc
	ALERT:C41("Create document for the binary data")
	$dataFile_t:=Create document:C266("")
	$dataFile_txt:=Document
	CLOSE DOCUMENT:C267($dataFile_t)
	
	BLOB TO DOCUMENT:C526($dataFile_txt; $Data_x)
Else 
	//Load
	
	$dataFile_txt:=Select document:C905(""; ""; "Select file with data arrays"; 0)
	If (OK=1)
		$dataFile_txt:=Document
		DOCUMENT TO BLOB:C525($dataFile_txt; $Data_x)
		C_LONGINT:C283($offset_L)
		$offset_L:=0
		BLOB TO VARIABLE:C533($Data_x; $PersIDs_aL; $offset_L)
		BLOB TO VARIABLE:C533($Data_x; $Logins_atxt; $offset_L)
		
		
		Case of 
			: (Size of array:C274($PersIDs_aL)=0)
				ALERT:C41("Error! Size of array($PersIDs_aL)=0")
			: (Size of array:C274($Logins_atxt)=0)
				ALERT:C41("Error! Size of array($Logins_atxt)=0")
			: (Size of array:C274($Logins_atxt)#Size of array:C274($PersIDs_aL))
				ALERT:C41("Error! Size of array($Logins_atxt)#Size of array($PersIDs_aL)")
			Else 
				//process them - update the local data in personnel
				C_LONGINT:C283($Updated_L; $notFound_L; $NotLoaded_L; $MultiError_L)
				$Updated_L:=0
				For ($loop_L; 1; Size of array:C274($PersIDs_aL))
					QUERY:C277([Personnel:42]; [Personnel:42]Person ID:1=$PersIDs_aL{$loop_L})
					
					Case of 
						: (Records in selection:C76([Personnel:42])=0)
							//not found!
							ALERT:C41("NO Personel records found for ID "+String:C10($PersIDs_aL{$loop_L}))
							$notFound_L:=$notFound_L+1
						: (Records in selection:C76([Personnel:42])=1)
							If (ut_LoadRecordInteractive(->[Personnel:42]))
								[Personnel:42]MachineName_txt:18:=$Logins_atxt{$loop_L}
								SAVE RECORD:C53([Personnel:42])
								$Updated_L:=$Updated_L+1
							Else 
								//skip it
								ALERT:C41("Personel record Not Loaded for ID "+String:C10($PersIDs_aL{$loop_L}))
								$NotLoaded_L:=$NotLoaded_L+1
							End if 
							
						Else 
							//Multiple????
							ALERT:C41("Multiple Personel records found for ID "+String:C10($PersIDs_aL{$loop_L}))
							$MultiError_L:=$MultiError_L+1
					End case 
					
					
				End for 
				C_TEXT:C284($msg_txt)
				$msg_txt:="Read "+String:C10(Size of array:C274($PersIDs_aL))+" IDs"+Char:C90(13)
				$msg_txt:=$msg_txt+"Updated "+String:C10($Updated_L)+" local Personnel records"+Char:C90(13)
				$msg_txt:=$msg_txt+"Could not load "+String:C10($NotLoaded_L)+" local Personnel records"+Char:C90(13)
				$msg_txt:=$msg_txt+"Did not Find "+String:C10($notFound_L)+" IDs"+Char:C90(13)
				$msg_txt:=$msg_txt+"Mulitple local records for "+String:C10($MultiError_L)+" IDs"+Char:C90(13)
				ALERT:C41($msg_txt)
		End case 
		
	End if 
	
End if 
//End TEMP_SavePersonnelLoginInfo