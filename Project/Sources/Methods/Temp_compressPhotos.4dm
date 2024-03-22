//%attributes = {"invisible":true}
C_PICTURE:C286($vpic1)
C_LONGINT:C283($vlWidth; $vlHt; $vlNPics; $i; $vlMinWidth; $vlNewSize; $vlOldSize)
C_LONGINT:C283($vlNewWidth)
C_TIME:C306(dMsgFile)
$vlMinWidth:=300
$vlNewWidth:=900
QUERY:C277([Standard Photos:36]; [Standard Photos:36]PictType:5=BMS Photo)
$vlNPics:=Records in selection:C76([Standard Photos:36])
dMsgFile:=Create document:C266("")
SEND PACKET:C103(dMSGFile; "Min Width "+String:C10($vlMinWidth)+"   New Width "+String:C10($vlNewWidth)+<>sCR+<>sLF)
FIRST RECORD:C50([Standard Photos:36])
SHORT_MESSAGE("Photo #1 of "+String:C10($vlNPics))
For ($i; 1; $vlNPics)
	PICTURE PROPERTIES:C457([Standard Photos:36]Std Photo:3; $vlWidth; $vlHt)
	MESSAGE:C88("Pic "+String:C10($i)+" of "+String:C10($vlNPics)+Char:C90(13))
	If ($vlWidth>$vlMinWidth)
		$vlOldSize:=Picture size:C356([Standard Photos:36]Std Photo:3)
		CREATE THUMBNAIL:C679([Standard Photos:36]Std Photo:3; $vpic1; $vlNewWidth; Int:C8($vlHt*($vlNewWidth/$vlWidth)); Scaled to fit:K6:2; 32)
		$vpic1:=F_CompressPic($vpic1)
		SEND PACKET:C103(dMsgFile; String:C10([Standard Photos:36]StdPhotoID:7)+<>sTAB+String:C10($vlWidth)+<>sTAB+String:C10($vlHT))
		SEND PACKET:C103(dMsgFile; <>sTAB+String:C10($vlOldSize)+<>sTAB+String:C10(Picture size:C356($vpic1))+<>sCR+<>sLF)
		If (False:C215)  //don't update pictures
			If (Picture size:C356($vpic1)<$vlOldSize)
				MESSAGE:C88("Pic "+String:C10($i)+" of "+String:C10($vlNPics)+Char:C90(13))
				[Standard Photos:36]Std Photo:3:=$vPic1
				SAVE RECORD:C53([Standard Photos:36])
				//just in case
			End if 
		End if 
		$vPic1:=$vPic1*0
	End if 
	NEXT RECORD:C51([Standard Photos:36])
End for 
CLOSE DOCUMENT:C267(dMsgFile)
CLOSE WINDOW:C154