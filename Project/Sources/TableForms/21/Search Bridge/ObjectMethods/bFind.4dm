If (False:C215)
	//Object Method: [Dialogs];"Search Bridge".bFind 
	// Modified by: costasmanousakis-(Designer)-(1/8/08 12:06:57)
	Mods_2007_CM_5401
	//  `Modified to detect the Control(win) or Command(Mac) key, in which case
	//  `we attempt to search of stuff that is in the clipboard. What is searched for
	//  `is controlled by the length of the first 'element' in the clipboard.
	//  `if len=3 then it is BIN , if len=6 then it is BDEPT.
	//  `Will handle Bdepts in form X-XX-XXX by stripping the "-", but 
	//  `anything else will not be used.
	//  `Also text in the clipboard longer than 32000 chars will be ignored.
	
	// Modified by: costasmanousakis-(Designer)-(3/6/08 15:32:17)
	Mods_2008_CM_5403
	//  `Allow coma as a separator also
	// Modified by: costasmanousakis-(Designer)-(5/31/11 11:55:07)
	Mods_2011_05
	//  `Added a call to new function ut_String2AlphaNumOnly which strips non-AlphaNum 
	//  `chars from the search string (leaves @ char) to avoid problems in the v11 transition
	//  `Apparently v11 gets some extra characters from the clipboard. Run the search only if
	//  `the search string is non-blank
	Mods_2011_06  // CJ Miller`06/20/11, 10:36:56      ` Type all local variables for v11
	// Modified by: Costas Manousakis-(Designer)-(1/24/12 12:27:33)
	Mods_2012_01
	//  `Added extra check for CR-LF combination for delimiter ; also take into account the length of the delimiter
	//  `use the substring to fill the vBIN or vBDEPT variables.   
	// Modified by: Costas Manousakis-(Designer)-(11/4/13 15:55:32)
	Mods_2013_11
	//  `Added a f_TrimStr to remove extra spaces  when parsing the pasteboard
	// Modified by: Costas Manousakis-(Designer)-(3/10/20 11:39:24)
	Mods_2020_03_bug
	//  `enabled using Item8 strings in the clipboard search - will check if strlen is 15 then extract the BIN and use that.
	// Modified by: manousakisc (7/9/2021)
	Mods_2021_07
	//  `Use method SRC_PasteboardSearch when searching from Pasteboard
End if 
C_BOOLEAN:C305($fromClipBoard_B)
If (<>PL_LPlatfrm=Windows:K25:3)
	$fromClipBoard_B:=Windows Ctrl down:C562
Else 
	$fromClipBoard_B:=Macintosh command down:C546
End if 
If ($fromClipBoard_B)
	//If (False)
	
	//C_LONGINT($CrPos;$txtClipL;$InfoLen)
	//$txtClipL:=Pasteboard data size("TEXT")
	//Case of 
	//: ($txtClipL<=0)
	//Else 
	//C_TEXT($ClipTextCopy;$SearchTxt;$DelimChar)
	//C_LONGINT($BlobChunk_L;$Offset_L;$Remainder_L;$BlobRemainder_L;$Done_p;$LastDone_p)
	//C_BLOB($ClipBlob_x)
	//GET PASTEBOARD DATA("TEXT";$ClipBlob_x)
	//$BlobChunk_L:=24576
	
	//$ClipTextCopy:=BLOB to text($ClipBlob_x;Mac text without length;$Offset_L;$BlobChunk_L)
	//$BlobRemainder_L:=$txtClipL-$Offset_L
	//$DelimChar:=Char(13)
	//Case of 
	//: (Position(Char(9);$ClipTextCopy)>0)
	//$DelimChar:=Char(9)
	//: (Position(",";$ClipTextCopy)>0)
	//$DelimChar:=","
	//: (Position((Char(13)+Char(10));$ClipTextCopy)>0)
	//$DelimChar:=(Char(13)+Char(10))
	//: (Position(Char(10);$ClipTextCopy)>0)
	//$DelimChar:=Char(10)
	
	//End case 
	//$CrPos:=Position($DelimChar;$ClipTextCopy)
	//If (($CrPos<=0) & (Length($ClipTextCopy)>0))
	//$CrPos:=Length($ClipTextCopy)+1
	//End if 
	//$InfoLen:=0
	//If ($txtClipL>2048)
	//<>ProgressPID:=StartProgress ("ClipBoardSearch";"button";"Clipboard Search Progress";"% Clipboard used")
	//UpdateProgress (0;100)
	//$LastDone_p:=0
	//Else 
	//SHORT_MESSAGE ("Searching from clipboard...")
	//End if 
	//SRC_HideLooking_b:=True
	//While ($CrPos>0)
	//If ($CrPos>1)
	//$SearchTxt:=Substring($ClipTextCopy;1;($CrPos-1))
	//$SearchTxt:=Replace string($SearchTxt;"-";"")
	//$SearchTxt:=ut_String2AlphaNumOnly ($SearchTxt)
	//$SearchTxt:=f_TrimStr ($SearchTxt;True;True)
	//If (Length($SearchTxt)>0)
	
	//If ($InfoLen=0)
	//$InfoLen:=Length($SearchTxt)
	//End if 
	//Case of 
	//: ($InfoLen=3)
	//vBIN:=Substring($SearchTxt;1;3)
	//: ($InfoLen=6)
	//vBDEPT:=Substring($SearchTxt;1;6)
	//: ($InfoLen=15)
	//vBIN:=Substring($SearchTxt;7;3)
	//End case 
	//CreateRandomSet 
	
	//End if 
	//End if 
	//$ClipTextCopy:=Substring($ClipTextCopy;($CrPos+Length($DelimChar)))
	
	//If ($Offset_L>=$txtClipL)
	//Else 
	//If (Length($ClipTextCopy)<($BlobChunk_L/2))
	//$ClipTextCopy:=$ClipTextCopy+BLOB to text($ClipBlob_x;Mac text without length;$Offset_L;$BlobChunk_L)
	//$BlobRemainder_L:=$txtClipL-$Offset_L
	//End if 
	//End if 
	//If (BLOB size($ClipBlob_x)>2048)
	//$Remainder_L:=Length($ClipTextCopy)+$BlobRemainder_L
	//$Done_p:=100-Int(100*($Remainder_L/$txtClipL))
	//If ($Done_p#$LastDone_p)
	//$LastDone_p:=$Done_p
	//If ($Done_p%2=0)
	//UpdateProgress ($Done_p;100)
	//End if 
	//End if 
	//End if 
	
	//$CrPos:=Position($DelimChar;$ClipTextCopy)
	//If (($CrPos<=0) & (Length($ClipTextCopy)>0))
	//$CrPos:=Length($ClipTextCopy)+1
	//End if 
	//If (<>Abort)
	//$CrPos:=-1
	//End if 
	
	//End while 
	
	//$ClipTextCopy:=""
	//SET BLOB SIZE($ClipBlob_x;0)
	
	//If ($txtClipL>2048)
	//CALL PROCESS(<>ProgressPID)
	//Else 
	//CLOSE WINDOW
	//End if 
	//SRC_HideLooking_b:=False
	
	//End case 
	
	//Else 
	//End if 
	SRC_PasteboardSearch
	
Else 
	CreateRandomSet
End if 