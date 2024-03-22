//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 01/09/08, 10:04:56
	// ----------------------------------------------------
	// Method: ut_ClipBoardSearch
	// Description
	// Search a table by a field from text stuff in the clipboard
	// 
	// Parameters
	// $1 : $Table_Ptr
	// $2 : $Field_ptr
	// ----------------------------------------------------
	
	Mods_2007_CM_5401
	// Modified by: costasmanousakis-(Designer)-(5/31/11 14:02:11)
	Mods_2011_05
	//  `Added a call to new function ut_String2AlphaNumOnly which strips non-AlphaNum PLUS
	//  `chars from the search string (Ascii 32-126)   to avoid problems in the v11 transition
	//  `Apparently v11 gets some extra characters from the clipboard especially coming from excel.
	// ` Run the search only if the search string is non-blank.
	
End if 
C_POINTER:C301($1; $Table_Ptr; $2; $Field_ptr)
$Table_Ptr:=$1
$Field_ptr:=$2
C_LONGINT:C283($CrPos; $txtClipL; $InfoLen)
$txtClipL:=Pasteboard data size:C400("TEXT")
Case of 
	: ($txtClipL<=0)
	Else 
		C_TEXT:C284($ClipTextCopy; $SearchTxt; $DelimChar)
		C_LONGINT:C283($BlobChunk_L; $Offset_L; $Remainder_L; $BlobRemainder_L; $Done_p; $LastDone_p; $FieldType_L)
		C_BLOB:C604($ClipBlob_x)
		GET PASTEBOARD DATA:C401("TEXT"; $ClipBlob_x)
		$BlobChunk_L:=24576
		GET FIELD PROPERTIES:C258($Field_ptr; $FieldType_L)
		$ClipTextCopy:=BLOB to text:C555($ClipBlob_x; Mac text without length:K22:10; $Offset_L; $BlobChunk_L)
		$BlobRemainder_L:=$txtClipL-$Offset_L
		$DelimChar:=Char:C90(13)
		If (Position:C15(Char:C90(9); $ClipTextCopy)>0)
			$DelimChar:=Char:C90(9)
		End if 
		$CrPos:=Position:C15($DelimChar; $ClipTextCopy)
		If (($CrPos<=0) & (Length:C16($ClipTextCopy)>0))
			$CrPos:=Length:C16($ClipTextCopy)+1
		End if 
		$InfoLen:=0
		If ($txtClipL>2048)
			<>ProgressPID:=StartProgress("ClipBoardSearch"; "button"; "Clipboard Search Progress"; "% Clipboard remaining")
			UpdateProgress(0; 100)
			$LastDone_p:=0
		Else 
			SHORT_MESSAGE("Searching from clipboard...")
		End if 
		CREATE EMPTY SET:C140($Table_Ptr->; "CLIPTOTALFOUNDRECS")
		While ($CrPos>0)
			If ($CrPos>1)
				$SearchTxt:=Substring:C12($ClipTextCopy; 1; ($CrPos-1))
				$SearchTxt:=Replace string:C233($SearchTxt; "-"; "")
				$SearchTxt:=ut_String2AlphaNumOnly($SearchTxt; "ALPHANUMPLUS")
				If ($SearchTxt#"")
					If ($InfoLen=0)
						$InfoLen:=Length:C16($SearchTxt)
					End if 
					SET QUERY DESTINATION:C396(Into set:K19:2; "CLIPFOUNDRECS")
					Case of 
						: (($FieldType_L=Is integer:K8:5) | ($FieldType_L=Is longint:K8:6) | ($FieldType_L=Is real:K8:4))
							QUERY:C277($Table_Ptr->; $Field_ptr->=Num:C11($SearchTxt))
						: ($FieldType_L=Is date:K8:7)
							QUERY:C277($Table_Ptr->; $Field_ptr->=Date:C102($SearchTxt))
						: ($FieldType_L=Is alpha field:K8:1)
							QUERY:C277($Table_Ptr->; $Field_ptr->=$SearchTxt)
					End case 
					SET QUERY DESTINATION:C396(Into current selection:K19:1)
					UNION:C120("CLIPTOTALFOUNDRECS"; "CLIPFOUNDRECS"; "CLIPTOTALFOUNDRECS")
					CLEAR SET:C117("CLIPFOUNDRECS")
					
				End if 
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
				$Done_p:=100-Trunc:C95((100*($Remainder_L/$txtClipL)); 0)
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
		$SearchTxt:=""
		SET BLOB SIZE:C606($ClipBlob_x; 0)
		If ($txtClipL>2048)
			POST OUTSIDE CALL:C329(<>ProgressPID)
		Else 
			CLOSE WINDOW:C154
		End if 
		If (Not:C34(<>Abort))
			ALERT:C41("Found "+String:C10(Records in set:C195("CLIPTOTALFOUNDRECS"))+" records in table "+Table name:C256($Table_Ptr))
			USE SET:C118("CLIPTOTALFOUNDRECS")
		End if 
		CLEAR SET:C117("CLIPTOTALFOUNDRECS")
		CLEAR SET:C117("CLIPFOUNDRECS")
		
End case 