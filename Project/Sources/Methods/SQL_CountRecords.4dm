//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 12/16/10, 10:24:46
//----------------------------------------------------
//Method: SQL_CountRecords
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	//Ugrade to v11
	//Modified by: Charles Miller (12/16/10 10:24:47)
End if 
C_TEXT:C284($IPAddress_txt; $1)
$IPAddress_txt:=$1


ut_SQLConnect("Designer"; "caesar"; $IPAddress_txt)


C_LONGINT:C283($Loop_l; $LastTableNumber_l; Count_l; $LocalCount_l)
C_TEXT:C284($Report_txt; $TableName_txt)
C_POINTER:C301($Table_ptr)
$LastTableNumber_l:=Get last table number:C254
For ($Loop_l; $Loop_l; $LastTableNumber_l)
	If (Is table number valid:C999($Loop_l))
		$TableName_txt:=Table name:C256($Loop_l)
		Case of 
			: ($TableName_txt="Activity Log")
			: ($TableName_txt="Owners of Data")
			: ($TableName_txt="BridgeMHDNBISArchive")
			: ($TableName_txt="NBISSecondaryArchive")
				//: ($TableName_txt="Combined Inspections")
				//: ($TableName_txt="BMS Inspections")
			: ($TableName_txt="Cond Units")
				//: ($TableName_txt="BMS Field Trip")
				//: ($TableName_txt="Inspections")
			: ($TableName_txt="ElementsSafety")
			: ($TableName_txt="Standard Photos")
			: ($TableName_txt="InventoryPhotos")
				//: ($TableName_txt="Field Trip")
			: ($TableName_txt="Bridge MHD NBIS_Year Painted")
			: ($TableName_txt="ONSQLAthenticationErrors")
			: ($TableName_txt="InventoryPhotoInsp")
			: ($TableName_txt="Pontis_Metric_Data")
			: ($TableName_txt="Pontis_Metrics")
			: ($TableName_txt="SD_History")
			: ($TableName_txt="Dialogs")
				
			Else 
				If (False:C215)
					ARRAY LONGINT:C221($Reprocess_al; 0)
					
					If (Find in array:C230($Reprocess_al; $Loop_l)>0)
						C_POINTER:C301($Table_ptr)
						$Table_ptr:=Table:C252($Loop_l)
						ALL RECORDS:C47($Table_ptr->)
						DELETE SELECTION:C66($Table_ptr->)
					End if 
				End if 
				$Table_ptr:=Table:C252($Loop_l)
				$Report_txt:=$Report_txt+String:C10($Loop_l)+Char:C90(Tab:K15:37)
				$Report_txt:=$Report_txt+Table name:C256($Loop_l)+Char:C90(Tab:K15:37)
				$LocalCount_l:=Records in table:C83($Table_ptr->)
				$Report_txt:=$Report_txt+String:C10($LocalCount_l)+Char:C90(Tab:K15:37)
				$TableName_txt:="["+Table name:C256($Loop_l)+"]"
				SQL_txt:="SELECT Count(*) FROM "+$TableName_txt+" INTO :Count_l ;"
				
				Begin SQL
					EXECUTE IMMEDIATE :SQL_txt;
				End SQL
				$Report_txt:=$Report_txt+String:C10(Count_l)+Char:C90(Tab:K15:37)
				
				If (Count_l#$LocalCount_l)
					$Report_txt:=$Report_txt+"Record Count Does not Match"+Char:C90(Tab:K15:37)+String:C10($LocalCount_l-Count_l)
				End if 
				$Report_txt:=$Report_txt+Char:C90(Carriage return:K15:38)
		End case 
		
	End if 
End for 
C_TIME:C306($doc)
$doc:=Create document:C266("")

SEND PACKET:C103($doc; $Report_txt)

CLOSE DOCUMENT:C267($doc)
ut_SQLLogout


//End SQL_CountRecords