//%attributes = {"invisible":true}
If (False:C215)
	If (False:C215)
		// ----------------------------------------------------
		// User name (OS): costasmanousakis
		// User name (4D): Designer
		// Date and time: 04/11/10, 10:01:58
		// ----------------------------------------------------
		// Method: Temp_CreateArchiveBMSTable
		// Description
		//  ` creates a new table which is the archive of the bridge mhd nbis table
		//  ` adds two fields ArchiveReason (Alpha 80), DateArchived (Date), and a DummyBoolean
		// 
		// Parameters
		// ----------------------------------------------------
		
		Mods_2010_05
	End if 
	If (Current user:C182="Designer")
		ARRAY TEXT:C222($myTables_atxt; 0)
		C_LONGINT:C283($MyTables_L)
		$MyTables_L:=Get last table number:C254
		ARRAY TEXT:C222($myTables_atxt; $MyTables_L)
		C_LONGINT:C283($loop_L; $FoundBMSArch_L; $FoundBMS2ndArch_L)
		For ($loop_L; 1; Size of array:C274($myTables_atxt))
			$myTables_atxt{$loop_L}:=Table name:C256($loop_L)
		End for 
		C_BOOLEAN:C305($DoIt_b)
		$DoIt_b:=False:C215
		$FoundBMSArch_L:=Find in array:C230($myTables_atxt; "BridgeMHDNBISArchive")
		$FoundBMS2ndArch_L:=Find in array:C230($myTables_atxt; "NBISSecondaryArchive")
		C_TEXT:C284($msg_txt)
		$msg_txt:="Found table BridgeMHDNBISArchive :"+f_Boolean2String(($FoundBMSArch_L>0); "YN")+Char:C90(13)
		$msg_txt:=$msg_txt+"Found table NBISSecondaryArchive :"+f_Boolean2String(($FoundBMS2ndArch_L>0); "YN")+Char:C90(13)
		$msg_txt:=$msg_txt+"Do the copy of these tables in Structure File "+Structure file:C489+"?"
		G_MyConfirm($msg_txt)
		$DoIt_b:=(OK=1)
		If ($DoIt_b)
			C_LONGINT:C283($NumFields_L; $Loop_L; $TableNum_L; $NewTableNum_L)
			$TableNum_L:=Table:C252(->[Bridge MHD NBIS:1])
			$NumFields_L:=Get last field number:C255(->[Bridge MHD NBIS:1])
			
			ARRAY TEXT:C222($FieldNames_atxt; ($NumFields_L+3))
			ARRAY LONGINT:C221($FieldTypes_aL; ($NumFields_L+3))
			ARRAY LONGINT:C221($FieldLengths_aL; ($NumFields_L+3))
			C_TEXT:C284($FieldName_txt)
			C_LONGINT:C283($Fldtype_L; $FieldLen_L)
			For ($Loop_L; 1; $NumFields_L)
				$FieldName_txt:=Field name:C257($TableNum_L; $Loop_L)
				GET FIELD PROPERTIES:C258($TableNum_L; $Loop_L; $Fldtype_L; $FieldLen_L)
				$FieldNames_atxt{$Loop_L}:=$FieldName_txt
				$FieldTypes_aL{$Loop_L}:=$Fldtype_L
				$FieldLengths_aL{$Loop_L}:=$FieldLen_L
			End for 
			$FieldNames_atxt{$NumFields_L+1}:="ArchiveReason_s"
			$FieldTypes_aL{$NumFields_L+1}:=Is alpha field:K8:1
			$FieldLengths_aL{$NumFields_L+1}:=80
			$FieldNames_atxt{$NumFields_L+2}:="ArchiveDate_d"
			$FieldTypes_aL{$NumFields_L+2}:=Is date:K8:7
			$FieldLengths_aL{$NumFields_L+2}:=0
			$FieldNames_atxt{$NumFields_L+3}:="Dummy_b"
			$FieldTypes_aL{$NumFields_L+3}:=Is boolean:K8:9
			$FieldLengths_aL{$NumFields_L+3}:=0
			
			
			//$NewTableNum_L:=Ô11999;44Ô ("BridgeMHDNBISArchive";$FieldNames_atxt;$FieldTypes_aL;$FieldLengths_aL)
			ALERT:C41("This is not working on v17")
			
			$TableNum_L:=Table:C252(->[NBIS Secondary:3])
			$NumFields_L:=Get last field number:C255(->[NBIS Secondary:3])
			
			ARRAY TEXT:C222($FieldNames_atxt; ($NumFields_L+3))
			ARRAY LONGINT:C221($FieldTypes_aL; ($NumFields_L+3))
			ARRAY LONGINT:C221($FieldLengths_aL; ($NumFields_L+3))
			C_TEXT:C284($FieldName_txt)
			C_LONGINT:C283($Fldtype_L; $FieldLen_L)
			For ($Loop_L; 1; $NumFields_L)
				$FieldName_txt:=Field name:C257($TableNum_L; $Loop_L)
				GET FIELD PROPERTIES:C258($TableNum_L; $Loop_L; $Fldtype_L; $FieldLen_L)
				$FieldNames_atxt{$Loop_L}:=$FieldName_txt
				$FieldTypes_aL{$Loop_L}:=$Fldtype_L
				$FieldLengths_aL{$Loop_L}:=$FieldLen_L
			End for 
			$FieldNames_atxt{$NumFields_L+1}:="ArchiveReason_s"
			$FieldTypes_aL{$NumFields_L+1}:=Is alpha field:K8:1
			$FieldLengths_aL{$NumFields_L+1}:=80
			$FieldNames_atxt{$NumFields_L+2}:="ArchiveDate_d"
			$FieldTypes_aL{$NumFields_L+2}:=Is date:K8:7
			$FieldLengths_aL{$NumFields_L+2}:=0
			$FieldNames_atxt{$NumFields_L+3}:="Dummy_b"
			$FieldTypes_aL{$NumFields_L+3}:=Is boolean:K8:9
			$FieldLengths_aL{$NumFields_L+3}:=0
			
			//$NewTableNum_L:=Ô11999;44Ô ("NBISSecondaryArchive";$FieldNames_atxt;$FieldTypes_aL;$FieldLengths_aL)
			ALERT:C41("This is not working on v17")
			
		End if 
		
	End if 
End if 
