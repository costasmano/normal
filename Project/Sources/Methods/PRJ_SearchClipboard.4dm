//%attributes = {"invisible":true}
// ----------------------------------------------------
// Method: PRJ_SearchClipboard
// Description
//  ` Search [PRJ_ProjectFile] by file no from text in Clipboard
// 
// Parameters
// ----------------------------------------------------

If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 01/12/12, 11:02:51
	// First Release
	Mods_2012_01
End if 
C_LONGINT:C283($CrPos; $txtClipL; $InfoLen)
$txtClipL:=Pasteboard data size:C400("TEXT")
Case of 
	: ($txtClipL<=0)
	Else 
		C_TEXT:C284($ClipTextCopy; $SearchTxt; $DelimChar)
		C_LONGINT:C283($BlobChunk_L; $Offset_L; $Remainder_L; $BlobRemainder_L; $Done_p; $LastDone_p)
		C_LONGINT:C283($NumValsSearch_L; $NumFound_L)
		$NumValsSearch_L:=0
		$NumFound_L:=0
		C_BLOB:C604($ClipBlob_x)
		GET PASTEBOARD DATA:C401("TEXT"; $ClipBlob_x)
		$BlobChunk_L:=24576
		CREATE EMPTY SET:C140([PRJ_ProjectFile:117]; "PRJCLIPSEARCHFOUNDTOTAL")
		$ClipTextCopy:=BLOB to text:C555($ClipBlob_x; Mac text without length:K22:10; $Offset_L; $BlobChunk_L)
		$BlobRemainder_L:=$txtClipL-$Offset_L
		$DelimChar:=Char:C90(13)
		Case of 
			: (Position:C15(Char:C90(9); $ClipTextCopy)>0)
				$DelimChar:=Char:C90(9)
			: (Position:C15(","; $ClipTextCopy)>0)
				$DelimChar:=","
		End case 
		$CrPos:=Position:C15($DelimChar; $ClipTextCopy)
		If (($CrPos<=0) & (Length:C16($ClipTextCopy)>0))
			$CrPos:=Length:C16($ClipTextCopy)+1
		End if 
		$InfoLen:=0
		If ($txtClipL>2048)
			<>ProgressPID:=StartProgress("ClipBoardSearch"; "button"; "Clipboard Search Progress"; "% Clipboard used")
			UpdateProgress(0; 100)
			$LastDone_p:=0
		Else 
			SHORT_MESSAGE("Searching from clipboard...")
		End if 
		SRC_HideLooking_b:=True:C214
		While ($CrPos>0)
			If ($CrPos>1)
				$SearchTxt:=Substring:C12($ClipTextCopy; 1; ($CrPos-1))
				$SearchTxt:=Replace string:C233($SearchTxt; "-"; "")
				$SearchTxt:=ut_String2AlphaNumOnly($SearchTxt)
				SET QUERY DESTINATION:C396(Into set:K19:2; "PRJCLIPSEARCHFOUND")
				If (Length:C16($SearchTxt)>0)
					$NumValsSearch_L:=$NumValsSearch_L+1
					QUERY:C277([PRJ_ProjectFile:117]; [PRJ_ProjectFile:117]PF_FileNumber_l:3=Num:C11($SearchTxt))
					UNION:C120("PRJCLIPSEARCHFOUNDTOTAL"; "PRJCLIPSEARCHFOUND"; "PRJCLIPSEARCHFOUNDTOTAL")
				End if 
				SET QUERY DESTINATION:C396(Into current selection:K19:1)
				
			End if 
			$ClipTextCopy:=Substring:C12($ClipTextCopy; ($CrPos+1))
			
			If ($Offset_L>=$txtClipL)
			Else 
				If (Length:C16($ClipTextCopy)<($BlobChunk_L/2))
					$ClipTextCopy:=$ClipTextCopy+BLOB to text:C555($ClipBlob_x; Mac text without length:K22:10; $Offset_L; $BlobChunk_L)
					$BlobRemainder_L:=$txtClipL-$Offset_L
				End if 
			End if 
			If (BLOB size:C605($ClipBlob_x)>2048)
				$Remainder_L:=Length:C16($ClipTextCopy)+$BlobRemainder_L
				$Done_p:=100-Int:C8(100*($Remainder_L/$txtClipL))
				If ($Done_p#$LastDone_p)
					$LastDone_p:=$Done_p
					If ($Done_p%2=0)
						UpdateProgress($Done_p; 100)
					End if 
				End if 
			End if 
			
			$CrPos:=Position:C15($DelimChar; $ClipTextCopy)
			If (($CrPos<=0) & (Length:C16($ClipTextCopy)>0))
				$CrPos:=Length:C16($ClipTextCopy)+1
			End if 
			If (<>Abort)
				$CrPos:=-1
			End if 
			
		End while 
		$ClipTextCopy:=""
		SET BLOB SIZE:C606($ClipBlob_x; 0)
		
		If ($txtClipL>2048)
			POST OUTSIDE CALL:C329(<>ProgressPID)
		Else 
			CLOSE WINDOW:C154
		End if 
		SRC_HideLooking_b:=False:C215
		USE SET:C118("PRJCLIPSEARCHFOUNDTOTAL")
		
		ALERT:C41("Searched for "+String:C10($NumValsSearch_L)+" Proj File Nos ; Found "+String:C10(Records in set:C195("PRJCLIPSEARCHFOUNDTOTAL"))+" !!!")
		
		CLEAR SET:C117("PRJCLIPSEARCHFOUNDTOTAL")
		CLEAR SET:C117("PRJCLIPSEARCHFOUND")
End case 