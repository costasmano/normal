//%attributes = {"invisible":true}
If (False:C215)
	// Modified by: costasmanousakis-(Designer)-(1/11/10 12:31:17)
	Mods_2010_01
	//  `Inactivated
	
	
	
	//GP TEMP_UpdSelList
	
	//This procedure updates the Select List.
	
	//Modified 2-10-2000 : CM
	//    Adjust logic to recognize files with records ending either in CRLF or CR.
	
	
	C_TEXT:C284($text; $path; $file)
	C_TEXT:C284($BIN; $BKey; $AASHTO)
	C_LONGINT:C283($i; $j; $k; $recs)
	C_TEXT:C284($text)
	C_BOOLEAN:C305($PrintWarn)
	
	$text:="In the following dialog box, select the tab-delimited "
	$text:=$text+"text file containing the Select List."+(2*<>sCR)
	$text:=$text+"Each record should consist of a BIN, a Bridge Key, and an AASHTO rating."
	ALERT:C41($text)
	C_TIME:C306($dImportFile; $dUpdateRpt)
	$dImportFile:=Open document:C264(""; "TEXT")
	If (OK=0)
		//I think it aborts before this, so this is unnecessary.
		ABORT:C156
	End if 
	vdImpFile:=$dImportFile
	$path:=GetPath
	
	$file:=$path+"Select List Update Report"
	$dUpdateRpt:=Create document:C266($file)
	vdUpdateRpt:=$dUpdateRpt
	$text:="Select List Update Report"+(2*<>sCR)
	SEND PACKET:C103($dUpdateRpt; $text)
	
	//TRACE
	
	ALL RECORDS:C47([Bridge MHD NBIS:1])
	SELECTION TO ARRAY:C260([Bridge MHD NBIS:1]BIN:3; $aBIN; [Bridge MHD NBIS:1]Bridge Key:2; $aBKey; [Bridge MHD NBIS:1]AASHTO:5; $aAASHTO; [Bridge MHD NBIS:1]FHWA Select:4; $aXSelect)
	ARRAY BOOLEAN:C223($aSelect; Size of array:C274($aXSelect))
	
	$i:=0
	RECEIVE PACKET:C104($dImportFile; $BIN; <>sTab)
	While (OK=1)
		// 2-10-2000 : CM  
		// Modified to account for CRLF or Just CR record delimited files
		If (Substring:C12($BIN; 1; 1)=<>sLF)
			$BIN:=Substring:C12($BIN; 2)
		End if 
		
		$i:=$i+1
		RECEIVE PACKET:C104($dImportFile; $BKey; <>sTab)
		RECEIVE PACKET:C104($dImportFile; $AASHTO; <>sCR)
		
		$j:=Find in array:C230($aBIN; $BIN)
		
		$text:=""
		$PrintWarn:=False:C215
		If ($j>0)
			$aSelect{$j}:=True:C214
			If ($BKey#$aBKey{$j})
				$text:=$text+"≠"+$aBKey{$j}
				$PrintWarn:=True:C214
			End if 
			$text:=$text+<>sTab  //This tab will help things line up properly.
			If (Abs:C99(Num:C11($AASHTO)-$aAASHTO{$j})>0.05)
				$text:=$text+$AASHTO+"≠"+String:C10(Round:C94($aAASHTO{$j}; 3))
				$PrintWarn:=True:C214
			End if 
			If ($aXSelect{$j})
				//Reset this so the only ones left are the ones that
				//have been removed from the Select List.
				$aXSelect{$j}:=False:C215
			Else 
				$text:=$text+<>sTab+"Newly Added to List."
				$PrintWarn:=True:C214
			End if 
		Else 
			$text:=$text+<>sTab+"***  Bad BIN!? ***"
			$PrintWarn:=True:C214
		End if 
		If ($PrintWarn)
			$text:=String:C10($i)+<>sTab+$BIN+<>sTab+$BKey+$text+<>sCR
			SEND PACKET:C103($dUpdateRpt; $text)
		End if 
		
		RECEIVE PACKET:C104($dImportFile; $BIN; <>sTab)
	End while 
	$recs:=$i
	
	$j:=Find in array:C230($aXSelect; True:C214)
	If ($j>0)
		$text:=<>sCR+"Bridges no longer on the Select List:"+<>sCR
		SEND PACKET:C103($dUpdateRpt; $text)
		While ($j>0)
			$text:=<>sTab+$aBIN{$j}+<>sTab+$aBKey{$j}+<>sCR
			SEND PACKET:C103($dUpdateRpt; $text)
			$j:=Find in array:C230($aXSelect; True:C214; $j+1)
		End while 
	End if 
	
	START TRANSACTION:C239
	ARRAY TO SELECTION:C261($aSelect; [Bridge MHD NBIS:1]FHWA Select:4)
	$j:=Records in set:C195("LockedSet")
	While ($j>0)
		TRACE:C157
		USE SET:C118("LockedSet")
		FIRST RECORD:C50([Bridge MHD NBIS:1])
		ARRAY BOOLEAN:C223($aLockedSel; 0)
		//  $text:=◊sCR+String($j)+" Locked Records Not Updated:"+◊sCR
		//  SEND PACKET($dUpdateRpt;$text)
		For ($i; 1; $j)
			INSERT IN ARRAY:C227($aLockedSel; $i)
			$k:=Find in array:C230($aBIN; [Bridge MHD NBIS:1]BIN:3)
			$aLockedSel{$i}:=$aSelect{$k}
			//    $text:=◊sTab+[Bridge MHD NBIS]BIN+◊sTab+[Bridge MHD NBIS]BDEPT
			//+◊sTab+String(Num($aSelect{$k});"On List;;Off List")+◊sCR
			//    SEND PACKET($dUpdateRpt;$text)
			NEXT RECORD:C51([Bridge MHD NBIS:1])
		End for 
		ARRAY TO SELECTION:C261($aLockedSel; [Bridge MHD NBIS:1]FHWA Select:4)
		$j:=Records in set:C195("LockedSet")
	End while 
	
	CONFIRM:C162("Save Select List Update?")
	If (OK=1)
		VALIDATE TRANSACTION:C240
		$text:=(2*<>sCR)+"Select List Import Completed."+<>sCR
	Else 
		CANCEL TRANSACTION:C241
		$text:=(2*<>sCR)+"Select List Import Aborted."+<>sCR
	End if 
	$text:=$text+String:C10($recs)+" records."+<>sCR
	SEND PACKET:C103($dUpdateRpt; $text)
	CLOSE DOCUMENT:C267($dUpdateRpt)
	CLOSE DOCUMENT:C267($dImportFile)
End if 
