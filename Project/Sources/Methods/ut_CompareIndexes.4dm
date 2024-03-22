//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): Chuck Miller
//Date and time: 02/28/17, 12:57:29
//----------------------------------------------------
//Method: ut_CompareIndexes
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	
End if 
C_TEXT:C284($IPAddress_txt)
$IPAddress_txt:=SQL_TestConnection
ut_SQLConnect("Designer"; "caesar"; $IPAddress_txt)
ARRAY LONGINT:C221($RemoteID_aL; 0)
ARRAY TEXT:C222($RemoteName_atxt; 0)
ARRAY TEXT:C222($RemoteTableName_atxt; 0)
ARRAY TEXT:C222($RemoteColumnName_atxt; 0)
CONFIRM:C162("Include UUIDS in comparison"; "Yes"; "No")
C_BOOLEAN:C305($IncludeUUIDSP_B)
$IncludeUUIDSP_B:=(OK=1)
Begin SQL
	select
	INDEX_ID,
	INDEX_NAME,
	TABLE_NAME,
	COLUMN_NAME
	from
	_USER_IND_COLUMNS
	into
	:$RemoteID_aL,
	:$RemoteName_atxt,
	:$RemoteTableName_atxt,
	:$RemoteColumnName_atxt;
	
End SQL
ARRAY TEXT:C222($RemoteCombined_atxt; 0)
ARRAY TEXT:C222($RemoteCombined_atxt; Size of array:C274($RemoteColumnName_atxt))
C_LONGINT:C283($Loop_L)
For ($Loop_L; 1; Size of array:C274($RemoteTableName_atxt))
	$RemoteCombined_atxt{$Loop_L}:=$RemoteTableName_atxt{$Loop_L}+"-"+$RemoteColumnName_atxt{$Loop_L}
End for 
SQL LOGOUT:C872
ARRAY LONGINT:C221($LocalID_aL; 0)
ARRAY TEXT:C222($LocalName_atxt; 0)
ARRAY TEXT:C222($LocalTableName_atxt; 0)
ARRAY TEXT:C222($LocalColumnName_atxt; 0)
Begin SQL
	select
	INDEX_ID,
	INDEX_NAME,
	TABLE_NAME,
	COLUMN_NAME
	from
	_USER_IND_COLUMNS
	into
	:$LocalID_aL,
	:$LocalName_atxt,
	:$LocalTableName_atxt,
	:$LocalColumnName_atxt;
	
End SQL
ARRAY TEXT:C222($LocalCombined_atxt; 0)
ARRAY TEXT:C222($LocalCombined_atxt; Size of array:C274($LocalTableName_atxt))
For ($Loop_L; 1; Size of array:C274($LocalTableName_atxt))
	$LocalCombined_atxt{$Loop_L}:=$LocalTableName_atxt{$Loop_L}+"-"+$LocalColumnName_atxt{$Loop_L}
End for 

C_LONGINT:C283($Position_L)
For ($Loop_L; Size of array:C274($LocalCombined_atxt); 1; -1)
	If (Position:C15("UUID"; $LocalCombined_atxt{$Loop_L})>0) & (Not:C34($IncludeUUIDSP_B))
		
		DELETE FROM ARRAY:C228($LocalCombined_atxt; $Loop_L; 1)
		
	Else 
		$Position_L:=Find in array:C230($RemoteCombined_atxt; $LocalCombined_atxt{$Loop_L})
		If ($Position_L>0)
			DELETE FROM ARRAY:C228($RemoteCombined_atxt; $Position_L; 1)
			DELETE FROM ARRAY:C228($LocalCombined_atxt; $Loop_L; 1)
		End if 
	End if 
End for 
C_TEXT:C284($Text_txt)
For ($Loop_L; 1; Size of array:C274($LocalCombined_atxt))
	If ($Text_txt="")
		$Text_txt:="Local"+Char:C90(Carriage return:K15:38)
		$Text_txt:=$Text_txt+$LocalCombined_atxt{$Loop_L}+Char:C90(Carriage return:K15:38)
	End if 
End for 
If (Size of array:C274($RemoteCombined_atxt)>0)
	$Text_txt:=$Text_txt+"Remote "+Char:C90(Carriage return:K15:38)
End if 
For ($Loop_L; 1; Size of array:C274($RemoteCombined_atxt))
	$Text_txt:=$Text_txt+$RemoteCombined_atxt{$Loop_L}+Char:C90(Carriage return:K15:38)
End for 
If (Length:C16($Text_txt)>0)
	C_TIME:C306($Doc_tm)
	$Doc_tm:=Create document:C266("")
	SEND PACKET:C103($Doc_tm; $Text_txt)
	CLOSE DOCUMENT:C267($Doc_tm)
Else 
	ALERT:C41("Indexes are the same")
	
End if 
//End ut_CompareIndexes

