//%attributes = {"invisible":true}
// ----------------------------------------------------
// utl_CompareFedFromandTo
// User name (OS): charlesmiller
// Date and time: 08/18/11, 12:01:33
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2011_08  // CJ Miller`08/18/11, 12:01:35      ` Type all local variables for v11
End if 
C_TIME:C306($SentDoc_tm; $ReceivedDoc_tm)
C_TEXT:C284($StructureName_txt; $Item_txt; $Year_txt; $Month_txt; $Data_txt)
ARRAY TEXT:C222($StructureName_atxt; 0)
ARRAY TEXT:C222($FromMonth_atxt; 0)
ARRAY TEXT:C222($FromYear_atxt; 0)
ARRAY TEXT:C222($SentMonth_atxt; 0)
ARRAY TEXT:C222($SentYear_atxt; 0)
ARRAY LONGINT:C221($Count_al; 0)
ARRAY TEXT:C222($Errors_atxt; 0)
C_LONGINT:C283($Position_l)
ARRAY TEXT:C222($Item_atxt; 0)
C_TEXT:C284($Tab_txt; $CR_txt)
$Tab_txt:=Char:C90(Tab:K15:37)
$CR_txt:=Char:C90(Carriage return:K15:38)
$ReceivedDoc_tm:=Open document:C264(""; ""; Read mode:K24:5)

Repeat 
	RECEIVE PACKET:C104($ReceivedDoc_tm; $StructureName_txt; Char:C90(Tab:K15:37))  //1
	If (OK=1)
		RECEIVE PACKET:C104($ReceivedDoc_tm; $Month_txt; $Tab_txt)
		RECEIVE PACKET:C104($ReceivedDoc_tm; $Year_txt; $CR_txt)
		APPEND TO ARRAY:C911($StructureName_atxt; $StructureName_txt)
		APPEND TO ARRAY:C911($FromMonth_atxt; $Month_txt)
		APPEND TO ARRAY:C911($FromYear_atxt; $Year_txt)
		APPEND TO ARRAY:C911($Count_al; 0)
		APPEND TO ARRAY:C911($Errors_atxt; "")
		APPEND TO ARRAY:C911($SentMonth_atxt; "")
		APPEND TO ARRAY:C911($SentYear_atxt; "")
		APPEND TO ARRAY:C911($Item_atxt; "")
	End if 
	
Until (OK=0)
CLOSE DOCUMENT:C267($ReceivedDoc_tm)
$SentDoc_tm:=Open document:C264(""; ""; Read mode:K24:5)
OK:=1
Repeat 
	RECEIVE PACKET:C104($SentDoc_tm; $Data_txt; $CR_txt)
	$Data_txt:=Replace string:C233($Data_txt; Char:C90(Line feed:K15:40); "")
	$StructureName_txt:=Substring:C12($Data_txt; 4; 15)
	$Item_txt:=Substring:C12($Data_txt; 19; 1)
	
	If (Num:C11($Item_txt)=1)
		
		$Year_txt:=Substring:C12($Data_txt; 289; 2)
		$Month_txt:=Substring:C12($Data_txt; 287; 2)
		$Position_l:=Find in array:C230($StructureName_atxt; $StructureName_txt)
		If ($Position_l>0)
			
			If ($Count_al{$Position_l}=0)
				$Item_atxt{$Position_l}:="1"
				$SentMonth_atxt{$Position_l}:=$Month_txt
				$SentYear_atxt{$Position_l}:=$Year_txt
				If (Num:C11($SentMonth_atxt{$Position_l}))=(Num:C11($FromMonth_atxt{$Position_l}))
					
				Else 
					$Errors_atxt{$Position_l}:="Month"
				End if 
				If (Num:C11($SentYear_atxt{$Position_l}))=(Num:C11($FromYear_atxt{$Position_l}))
					
				Else 
					If ($Errors_atxt{$Position_l}="")
						$Errors_atxt{$Position_l}:=$Errors_atxt{$Position_l}+"Year"
					Else 
						$Errors_atxt{$Position_l}:=$Errors_atxt{$Position_l}+" and Year"
					End if 
				End if 
				$Count_al{$Position_l}:=1
			Else 
				APPEND TO ARRAY:C911($StructureName_atxt; $StructureName_txt)
				APPEND TO ARRAY:C911($FromMonth_atxt; $FromMonth_atxt{$Position_l})
				APPEND TO ARRAY:C911($FromYear_atxt; $FromYear_atxt{$Position_l})
				APPEND TO ARRAY:C911($Count_al; 0)
				APPEND TO ARRAY:C911($Errors_atxt; "Found More than once")
				APPEND TO ARRAY:C911($SentMonth_atxt; $Month_txt)
				APPEND TO ARRAY:C911($SentYear_atxt; $Year_txt)
				APPEND TO ARRAY:C911($Item_atxt; "1")
			End if 
			
		Else 
			APPEND TO ARRAY:C911($StructureName_atxt; $StructureName_txt)
			APPEND TO ARRAY:C911($FromMonth_atxt; "")
			APPEND TO ARRAY:C911($FromYear_atxt; "")
			APPEND TO ARRAY:C911($Count_al; 0)
			APPEND TO ARRAY:C911($Errors_atxt; "")
			APPEND TO ARRAY:C911($SentMonth_atxt; $Month_txt)
			APPEND TO ARRAY:C911($SentYear_atxt; $Year_txt)
			$Position_l:=Size of array:C274($StructureName_atxt)
			APPEND TO ARRAY:C911($Item_atxt; "1")
			$Errors_atxt{$Position_l}:="MISSING"
		End if 
		
	End if 
	
Until (OK=0)
CLOSE DOCUMENT:C267($SentDoc_tm)
C_BLOB:C604($Report_blb)
SET BLOB SIZE:C606($Report_blb; 0)

TEXT TO BLOB:C554("Stucture"+$Tab_txt; $Report_blb; Mac text without length:K22:10; *)
TEXT TO BLOB:C554("From Month"+$Tab_txt; $Report_blb; Mac text without length:K22:10; *)
TEXT TO BLOB:C554("From Year"+$Tab_txt; $Report_blb; Mac text without length:K22:10; *)
TEXT TO BLOB:C554("Status"+$Tab_txt; $Report_blb; Mac text without length:K22:10; *)
TEXT TO BLOB:C554("To Month"+$Tab_txt; $Report_blb; Mac text without length:K22:10; *)
TEXT TO BLOB:C554("To Year"+$CR_txt; $Report_blb; Mac text without length:K22:10; *)


For ($Position_l; 1; Size of array:C274($StructureName_atxt))
	If ($Item_atxt{$Position_l}="1")
		TEXT TO BLOB:C554($StructureName_atxt{$Position_l}+$Tab_txt; $Report_blb; Mac text without length:K22:10; *)
		TEXT TO BLOB:C554($FromMonth_atxt{$Position_l}+$Tab_txt; $Report_blb; Mac text without length:K22:10; *)
		TEXT TO BLOB:C554($FromYear_atxt{$Position_l}+$Tab_txt; $Report_blb; Mac text without length:K22:10; *)
		TEXT TO BLOB:C554($Errors_atxt{$Position_l}+$Tab_txt; $Report_blb; Mac text without length:K22:10; *)
		TEXT TO BLOB:C554($SentMonth_atxt{$Position_l}+$Tab_txt; $Report_blb; Mac text without length:K22:10; *)
		TEXT TO BLOB:C554($SentYear_atxt{$Position_l}+$CR_txt; $Report_blb; Mac text without length:K22:10; *)
	End if 
End for 
$SentDoc_tm:=Create document:C266("")

If (OK=1)
	CLOSE DOCUMENT:C267($SentDoc_tm)
	BLOB TO DOCUMENT:C526(Document; $Report_blb)
End if 
//End utl_CompareFedFromandTo