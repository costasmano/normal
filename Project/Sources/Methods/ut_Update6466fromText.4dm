//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 07/06/11, 16:25:20
	// ----------------------------------------------------
	// Method: ut_Update6466fromText
	// Description
	//  ` Update items 63,64,65,66 in the [BridgeMHDNBISArchive] table from a text file
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2011_07
End if 

If (User in group:C338(Current user:C182; "Design Access Group"))
	C_TIME:C306($Doc)
	ALERT:C41("Select a text document that has BIN, I63, I64. I65, i66 tab delimited")
	$Doc:=Open document:C264(""; ""; Read mode:K24:5)
	If (OK=1)
		C_TEXT:C284($Reason_txt; $ArchDate_txt)
		$Reason_txt:="NBI Tape 2011"
		C_TEXT:C284($Line_txt; $BIn1; $i63; $i64; $i65; $i66)
		C_REAL:C285($i64_r; $i66_r)
		C_TEXT:C284($msg)
		C_BOOLEAN:C305($saveToDB_b)
		CONFIRM:C162("Save changes to Archive Bridge table?"; "Save"; "NoSave")
		$saveToDB_b:=(OK=1)
		If ($saveToDB_b)
			ALERT:C41("Changes to the Archive Bridge Mhd nbis table will not be logged!!!")
		End if 
		
		RECEIVE PACKET:C104($Doc; $Line_txt; Char:C90(13))
		Repeat 
			If (Substring:C12($Line_txt; 1; 1)=Char:C90(10))
				$Line_txt:=Substring:C12($Line_txt; 2)
			End if 
			If (Length:C16($Line_txt)>0)
				ARRAY TEXT:C222($values_atxt; 0)
				ut_TextToArray($Line_txt; ->$values_atxt; Char:C90(9))
				If (Size of array:C274($values_atxt)>4)
					
					$Bin1:=$values_atxt{1}
					$i63:=$values_atxt{2}
					$i64:=$values_atxt{3}
					$i65:=$values_atxt{4}
					$i66:=$values_atxt{5}
					$i64_r:=Num:C11($i64)
					$i66_r:=Num:C11($i66)
					
					If ($Bin1#"BIN")
						QUERY:C277([BridgeMHDNBISArchive:139]; [BridgeMHDNBISArchive:139]BIN:3=$Bin1)
						QUERY SELECTION:C341([BridgeMHDNBISArchive:139]; [BridgeMHDNBISArchive:139]ArchiveReason_s:223=$Reason_txt)
						If (Records in selection:C76([BridgeMHDNBISArchive:139])=1)
							If (ut_LoadRecordInteractive(->[BridgeMHDNBISArchive:139]))
								$msg:=$msg+[BridgeMHDNBISArchive:139]BIN:3
								If ($i63#[BridgeMHDNBISArchive:139]Item 63:196)
									$msg:=$msg+" 63 "+[BridgeMHDNBISArchive:139]Item 63:196+"->"+$i63
									[BridgeMHDNBISArchive:139]Item 63:196:=$i63
								End if 
								If ($i64_r#[BridgeMHDNBISArchive:139]Item64:136)
									$msg:=$msg+" 64 "+String:C10([BridgeMHDNBISArchive:139]Item64:136)+"->"+$i64
									[BridgeMHDNBISArchive:139]Item64:136:=$i64_r
								End if 
								If ($i65#[BridgeMHDNBISArchive:139]Item 65:197)
									$msg:=$msg+" 65 "+[BridgeMHDNBISArchive:139]Item 65:197+"->"+$i65
									[BridgeMHDNBISArchive:139]Item 65:197:=$i65
								End if 
								If ($i66_r#[BridgeMHDNBISArchive:139]Item66:138)
									$msg:=$msg+" 66 "+String:C10([BridgeMHDNBISArchive:139]Item66:138)+"->"+$i66
									[BridgeMHDNBISArchive:139]Item66:138:=$i66_r
								End if 
								$msg:=$msg+Char:C90(13)
								If ($saveToDB_b)
									SAVE RECORD:C53([BridgeMHDNBISArchive:139])
								End if 
								
							Else 
								
							End if 
						Else 
							ALERT:C41("Incorrect number of bridge records found ! :"+String:C10(Records in selection:C76([BridgeMHDNBISArchive:139])))
						End if 
						
					End if 
					
					
				End if 
				
			End if 
			
			RECEIVE PACKET:C104($Doc; $Line_txt; Char:C90(13))
		Until (Ok=0)
		SET TEXT TO PASTEBOARD:C523($msg)
		ALERT:C41("Change Report saved on clipboard!")
		CLOSE DOCUMENT:C267($Doc)
	End if 
End if 
