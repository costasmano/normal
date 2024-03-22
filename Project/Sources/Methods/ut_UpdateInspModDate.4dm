//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 05/19/10, 15:31:43
	// ----------------------------------------------------
	// Method: ut_UpdateInspModDate
	// Description
	//  ` update the mod date on inspection records loaded from a text file
	//  ` Done to force the update of inspection CUs from 4D to the pontis DB.
	//  ` The imput text file should contain a list of bridges and date with zero CU counts
	//  ` as shown below.
	
	//  `BRKEY           INSPKEY INSPDATE                                               ElemCount   
	//  `--------------- ------- ------------------------------------------------------ ----------- 
	//A0200128RMHDNBI YYST    2008-02-27 00:00:00.000                                0
	//
	//the sql script that generates this report is :
	//  `SELECT     BRKEY, INSPKEY, INSPDATE,
	//  `                          (SELECT     COUNT(*)
	//  `                            FROM          dbo.eleminsp
	//  `                            WHERE      dbo.eleminsp.inspkey = dbo.inspevnt.inspkey AND dbo.eleminsp.brkey = dbo.inspevnt.brkey) AS ElemCount
	//  `FROM         dbo.INSPEVNT
	//  `WHERE     ((SELECT     COUNT(*)
	//  `                         FROM         dbo.eleminsp
	//  `                         WHERE     dbo.eleminsp.inspkey = dbo.inspevnt.inspkey AND dbo.eleminsp.brkey = dbo.inspevnt.brkey) = 0)
	//
	//  `Stored in [Parameters] table under sp_PontisGet0CUInsp
	
	// Parameters
	// ----------------------------------------------------
	
	Mods_2010_05
	Mods_2011_06  // CJ Miller`06/14/11, 13:25:05      ` Type all local variables for v11
End if 
If (Current user:C182="Designer")
	C_TIME:C306($Doc_t)
	C_TEXT:C284($Tab_txt; $CR_txt; $ITEM8_txt; $INSPDATEYr_TXT; $INSPDATEMo_TXT; $INSPDATEDD_TXT; $BIN_txt; $Line_txt)
	C_DATE:C307($InspDate_d)
	$Tab_txt:=Char:C90(Tab:K15:37)
	$CR_txt:=Char:C90(Carriage return:K15:38)
	
	$Doc_t:=Open document:C264("")
	If (OK=1)
		START TRANSACTION:C239
		C_LONGINT:C283($TotalBINs_L; $UniqInsp_L; $UniqInspSucces_L)
		$TotalBINs_L:=0
		$UniqInsp_L:=0
		$UniqInspSucces_L:=0
		Repeat 
			RECEIVE PACKET:C104($Doc_t; $Line_txt; $CR_txt)
			If (Character code:C91(Substring:C12($Line_txt; 1; 1))=10)
				$Line_txt:=Substring:C12($Line_txt; 2)
			End if 
			
			If ($Line_txt#"")
				$ITEM8_txt:=Substring:C12($Line_txt; 1; 15)
				$BIN_txt:=Substring:C12($ITEM8_txt; 7; 3)
				$INSPDATEYr_TXT:=Substring:C12($Line_txt; 25; 4)
				$INSPDATEMo_TXT:=Substring:C12($Line_txt; 30; 2)
				$INSPDATEDD_TXT:=Substring:C12($Line_txt; 33; 2)
				QUERY:C277([Inspections:27]; [Inspections:27]BIN:1=$BIN_txt)
				If (Records in selection:C76([Inspections:27])>0)
					$TotalBINs_L:=$TotalBINs_L+1
					$InspDate_d:=Date:C102($INSPDATEMo_TXT+"/"+$INSPDATEDD_TXT+"/"+$INSPDATEYr_TXT)
					QUERY SELECTION:C341([Inspections:27]; [Inspections:27]Insp Date:78=$InspDate_d)
					Case of 
						: (Records in selection:C76([Inspections:27])=0)
						: (Records in selection:C76([Inspections:27])=1)
							$UniqInsp_L:=$UniqInsp_L+1
							
							If (ut_LoadRecordInteractive(->[Inspections:27]))
								[Inspections:27]DateModified:137:=Current date:C33(*)
								SAVE RECORD:C53([Inspections:27])
								$UniqInspSucces_L:=$UniqInspSucces_L+1
							Else 
								ALERT:C41("Cannot load inspection record for BIN "+$BIN_txt+" dated "+String:C10($InspDate_d))
							End if 
						: (Records in selection:C76([Inspections:27])=2)
							QUERY SELECTION:C341([Inspections:27]; [Inspections:27]Insp Type:6="RT@")
							If (Records in selection:C76([Inspections:27])=1)
								$UniqInsp_L:=$UniqInsp_L+1
								If (ut_LoadRecordInteractive(->[Inspections:27]))
									[Inspections:27]DateModified:137:=Current date:C33(*)
									SAVE RECORD:C53([Inspections:27])
									$UniqInspSucces_L:=$UniqInspSucces_L+1
								Else 
									ALERT:C41("Cannot load inspection record for BIN "+$BIN_txt+" dated "+String:C10($InspDate_d))
								End if 
							End if 
							
					End case 
					
				End if 
			End if 
			UNLOAD RECORD:C212([Inspections:27])
		Until (OK=0)
		
		CLOSE DOCUMENT:C267($Doc_t)
		C_TEXT:C284($Msg_txt)
		$Msg_txt:="Found "+String:C10($TotalBINs_L)+" Bins, a total of "+String:C10($UniqInsp_L)+" unique inspections, updated  "+String:C10($UniqInspSucces_L)
		$Msg_txt:=$Msg_txt+".  Commit changes or cancel?"
		CONFIRM:C162($Msg_txt; "Commit"; "Cancel")
		If (OK=1)
			VALIDATE TRANSACTION:C240
		Else 
			CANCEL TRANSACTION:C241
		End if 
		
	End if 
End if 