//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): administrator
//Date and time: 05/19/16, 13:15:02
//----------------------------------------------------
//Method: CNV_Error
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2015_10  // 
	//Modified by: administrator (5/19/16 13:15:33)
	
End if 
ARRAY LONGINT:C221($SQLErrorNumbers_al; 0)
ARRAY TEXT:C222($SQL_InternalCodes_atxt; 0)
ARRAY TEXT:C222($SQL_InternalDescriptions_atxt; 0)

C_LONGINT:C283($loop_l)
GET LAST ERROR STACK:C1015($SQLErrorNumbers_al; $SQL_InternalCodes_atxt; $SQL_InternalDescriptions_atxt)
// $Doc_tm:=Append document(CNV_ProcessDocument_txt)
SEND PACKET:C103(CNV_Doc_tm; String:C10(CurrentLoop_L)+Char:C90(Carriage return:K15:38))
//SEND PACKET(CNV_Doc_tm;String(CNV_RecordNumber_aL{CurrentLoop_L})+"process errors are"+Char(Carriage return ))
For ($loop_l; 1; Size of array:C274($SQL_InternalDescriptions_atxt))
	SEND PACKET:C103(CNV_Doc_tm; $SQL_InternalDescriptions_atxt{$loop_l}+Char:C90(Carriage return:K15:38))
	
End for 
//CLOSE DOCUMENT($Doc_tm)
4DError_b:=True:C214
//End CNV_Error

