//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 08/26/11, 13:24:27
//----------------------------------------------------
//Method: ut_SetNBISSecondaryIndex
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	//Ugrade to v11
	//Modified by: Charles Miller (8/26/11 13:24:28)
End if 
READ ONLY:C145(*)

READ WRITE:C146([NBIS Secondary:3])
READ WRITE:C146([NBISSecondaryArchive:140])

C_BOOLEAN:C305($Complete_b; $UpdateComplete_b)
$Complete_b:=False:C215
ALL RECORDS:C47([NBIS Secondary:3])
C_LONGINT:C283($Loop_l)
ARRAY LONGINT:C221($RecordNumbers_al; 0)
FIRST RECORD:C50([NBIS Secondary:3])
C_TEXT:C284($Item5Query_txt)

Repeat 
	For ($Loop_l; 1; Records in selection:C76([NBIS Secondary:3]))
		If (ut_LoadRecord(->[NBIS Secondary:3]; 3))
			If ([NBIS Secondary:3]NBISSecondaryKey_l:39=0)
				Inc_Sequence("[NBIS Secondary]"; ->[NBIS Secondary:3]NBISSecondaryKey_l:39)
				SAVE RECORD:C53([NBIS Secondary:3])
			End if 
			QUERY:C277([NBISSecondaryArchive:140]; [NBISSecondaryArchive:140]BIN:1=[NBIS Secondary:3]BIN:1)
			$Item5Query_txt:=Substring:C12([NBIS Secondary:3]Item5:4; 1; 1)+"@"
			
			QUERY SELECTION:C341([NBISSecondaryArchive:140]; [NBISSecondaryArchive:140]Item5:4=$Item5Query_txt)
			QUERY SELECTION:C341([NBISSecondaryArchive:140]; [NBISSecondaryArchive:140]NBISSecondaryKey_l:41=0)
			$UpdateComplete_b:=False:C215
			Repeat 
				APPLY TO SELECTION:C70([NBISSecondaryArchive:140]; [NBISSecondaryArchive:140]NBISSecondaryKey_l:41:=[NBIS Secondary:3]NBISSecondaryKey_l:39)
				If (Records in set:C195("LockedSet")=0)
					$UpdateComplete_b:=True:C214
				Else 
					USE SET:C118("LockedSet")
				End if 
				
			Until ($UpdateComplete_b)
			
			NEXT RECORD:C51([NBIS Secondary:3])
		Else 
			APPEND TO ARRAY:C911($RecordNumbers_al; Record number:C243([NBIS Secondary:3]))
			
		End if 
	End for 
	If (Size of array:C274($RecordNumbers_al)=0)
		$Complete_b:=True:C214
	Else 
		CREATE SELECTION FROM ARRAY:C640([NBIS Secondary:3]; $RecordNumbers_al)
	End if 
	
Until ($Complete_b)

//End ut_SetNBISSecondaryIndex

