//%attributes = {"invisible":true}
//Method: Temp_CheckPersonnel
//Description
// Check the cross ref between external server or dist server and Boston
// verifies if the records on first server match records on second server
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 02/28/17, 11:59:55
	// ----------------------------------------------------
	//Created : 
	Mods_2017_02
End if 
//
If (User in group:C338(Current user:C182; "Design Access Group"))
	
	//connect to ext/dist server first
	ALERT:C41("Connect to server you want to check Personnel table")
	
	SQL LOGIN:C817(""; ""; ""; *)
	//retriieve data from personnel table
	ARRAY LONGINT:C221($ExtPersIDs_aL; 0)
	ARRAY LONGINT:C221($Ext4DUIDs_aL; 0)
	ARRAY TEXT:C222($ExtFNames_atxt; 0)
	ARRAY TEXT:C222($ExtLNames_atxt; 0)
	ARRAY TEXT:C222($ExtCompany_atxt; 0)
	C_TIME:C306($ReportFile_t)
	C_TEXT:C284($ReportFile_txt)
	C_BLOB:C604($ReportBlob_x)
	C_TEXT:C284($Line_txt)
	C_LONGINT:C283($loop_L)
	
	Begin SQL
		select
		[Personnel].[Person ID] ,
		[Personnel].[First Name] ,
		[Personnel].[Last Name] ,
		[Personnel].[Employer] ,
		[Personnel].[UserID_4D] 
		from [Personnel]
		into 
		:$ExtPersIDs_aL ,
		:$ExtFNames_atxt ,
		:$ExtLNames_atxt ,
		:$ExtCompany_atxt ,
		:$Ext4DUIDs_aL
		;
		
	End SQL
	
	//retrieve data from FileIDRes table
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
	
	
	If (False:C215)
		//this is just for testing
		Begin SQL
			select
			[FileIDRes Table].[Destination ID] ,
			[FileIDRes Table].[Local ID] ,
			[FileIDRes Table].[Destination]
			from [FileIDRes Table]
			Where 
			[FileIDRes Table].[File Number] = :$TableNum_L
			into
			:$ExtRefIDs_atxt ,
			:$BostonRefIDs_atxt ,
			:$DestRef_atxt
			;
		End SQL
		
		SQL LOGOUT:C872
		$ReportFile_t:=Create document:C266("")
		$ReportFile_txt:=Document
		CLOSE DOCUMENT:C267($ReportFile_t)
		SET BLOB SIZE:C606($ReportBlob_x; 0)
		For ($loop_L; 1; Size of array:C274($ExtRefIDs_aL))
			$Line_txt:=String:C10($ExtRefIDs_aL{$loop_L})+Char:C90(Tab:K15:37)
			$Line_txt:=$Line_txt+String:C10($BostonRefIDs_aL{$loop_L})+Char:C90(Tab:K15:37)
			$Line_txt:=$Line_txt+$DestRef_atxt{$loop_L}+Char:C90(Carriage return:K15:38)
			TEXT TO BLOB:C554($Line_txt; $ReportBlob_x; Mac text without length:K22:10; *)
		End for 
		
		BLOB TO DOCUMENT:C526($ReportFile_txt; $ReportBlob_x)
		
		SET BLOB SIZE:C606($ReportBlob_x; 0)
		
		SHOW ON DISK:C922($ReportFile_txt)
		
	End if 
	
	
	//connect to Boston next
	ARRAY LONGINT:C221($BosPersIDs_aL; 0)
	ARRAY LONGINT:C221($BoS4DUIDs_aL; 0)
	ARRAY TEXT:C222($BosFNames_atxt; 0)
	ARRAY TEXT:C222($BosLNames_atxt; 0)
	ARRAY TEXT:C222($BosCompany_atxt; 0)
	
	ALERT:C41("Connect to server you want to check Personnel table against")
	
	SQL LOGIN:C817(""; ""; ""; *)
	
	Begin SQL
		select
		[Personnel].[Person ID] ,
		[Personnel].[First Name] ,
		[Personnel].[Last Name] ,
		[Personnel].[Employer] ,
		[Personnel].[UserID_4D] 
		from [Personnel]
		into 
		:$BosPersIDs_aL ,
		:$BosFNames_atxt ,
		:$BosLNames_atxt ,
		:$BosCompany_atxt ,
		:$BoS4DUIDs_aL
		;
		
	End SQL
	
	SQL LOGOUT:C872
	
	C_LONGINT:C283($loop_L)
	C_LONGINT:C283($BostonRefID_L; $Indx_L)
	ARRAY LONGINT:C221($ErrorExtIDs_aL; 0)
	ARRAY LONGINT:C221($ErrorBosIDs_aL; 0)
	ARRAY TEXT:C222($ErrorExt_Name_atxt; 0)
	ARRAY TEXT:C222($ErrorExt_ErrType_atxt; 0)
	C_BOOLEAN:C305($datamatch_b)
	C_TEXT:C284($msg_txt)
	For ($loop_L; 1; Size of array:C274($ExtPersIDs_aL))
		$indx_L:=Find in array:C230($ExtRefIDs_aL; $ExtPersIDs_aL{$loop_L})
		
		If ($indx_L>0)
			$BostonRefID_L:=$BostonRefIDs_aL{$indx_L}
		Else 
			$BostonRefID_L:=$ExtPersIDs_aL{$loop_L}
		End if 
		
		$indx_L:=Find in array:C230($BosPersIDs_aL; $BostonRefID_L)
		$datamatch_b:=True:C214
		If ($indx_L>0)
			
			Case of 
				: ($ExtFNames_atxt{$loop_L}#$BosFNames_atxt{$indx_L})
					$datamatch_b:=False:C215
				: ($ExtLNames_atxt{$loop_L}#$BosLNames_atxt{$indx_L})
					$datamatch_b:=False:C215
				: ($ExtCompany_atxt{$loop_L}#$BosCompany_atxt{$indx_L})
					$datamatch_b:=False:C215
				: ($Ext4DUIDs_aL{$loop_L}#$BoS4DUIDs_aL{$indx_L})
					$datamatch_b:=False:C215
			End case 
			
			If (Not:C34($datamatch_b))
				APPEND TO ARRAY:C911($ErrorExtIDs_aL; $ExtPersIDs_aL{$loop_L})
				APPEND TO ARRAY:C911($ErrorBosIDs_aL; $BostonRefID_L)
				APPEND TO ARRAY:C911($ErrorExt_ErrType_atxt; "Data not matching!")
				$msg_txt:=$ExtFNames_atxt{$loop_L}+" "+$ExtLNames_atxt{$loop_L}+" "+$ExtCompany_atxt{$loop_L}+" "+String:C10($Ext4DUIDs_aL{$loop_L})+" # "
				$msg_txt:=$msg_txt+$BosFNames_atxt{$indx_L}+" "+$BosLNames_atxt{$indx_L}+" "+$BosCompany_atxt{$indx_L}+" "+String:C10($BoS4DUIDs_aL{$indx_L})
				APPEND TO ARRAY:C911($ErrorExt_Name_atxt; $msg_txt)
				
			End if 
			
		Else 
			//no match!!!
			APPEND TO ARRAY:C911($ErrorExtIDs_aL; $ExtPersIDs_aL{$loop_L})
			APPEND TO ARRAY:C911($ErrorBosIDs_aL; 0)
			APPEND TO ARRAY:C911($ErrorExt_ErrType_atxt; "No Match")
			APPEND TO ARRAY:C911($ErrorExt_Name_atxt; $ExtFNames_atxt{$loop_L}+" "+$ExtLNames_atxt{$loop_L}+" "+$ExtCompany_atxt{$loop_L})
		End if 
		
		
	End for 
	If (Size of array:C274($ErrorExtIDs_aL)>0)
		ALERT:C41("create a text file for report data")
		$ReportFile_t:=Create document:C266("")
		$ReportFile_txt:=Document
		CLOSE DOCUMENT:C267($ReportFile_t)
		SET BLOB SIZE:C606($ReportBlob_x; 0)
		For ($loop_L; 1; Size of array:C274($ErrorExtIDs_aL))
			$Line_txt:=String:C10($ErrorExtIDs_aL{$loop_L})+Char:C90(Tab:K15:37)
			$Line_txt:=$Line_txt+String:C10($ErrorBosIDs_aL{$loop_L})+Char:C90(Tab:K15:37)
			$Line_txt:=$Line_txt+$ErrorExt_ErrType_atxt{$loop_L}+Char:C90(Tab:K15:37)
			$Line_txt:=$Line_txt+$ErrorExt_Name_atxt{$loop_L}+Char:C90(Carriage return:K15:38)
			TEXT TO BLOB:C554($Line_txt; $ReportBlob_x; Mac text without length:K22:10; *)
		End for 
		
		BLOB TO DOCUMENT:C526($ReportFile_txt; $ReportBlob_x)
		
		SET BLOB SIZE:C606($ReportBlob_x; 0)
		
		SHOW ON DISK:C922($ReportFile_txt)
		
	Else 
		ALERT:C41("No Errors found!")
	End if 
	//End Temp_CheckPersonnel
End if 