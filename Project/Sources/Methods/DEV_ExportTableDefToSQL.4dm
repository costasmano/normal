//%attributes = {"invisible":true}
//Method: DEV_ExportTableDefToSQL
//Description
// Export table definitions to SQL
// copied from https://discuss.4d.com/t/how-to-export-the-database-from-4th-dimension-version-2004/24174/5
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Created : 
	//Date and time: Jan 11, 2023, 16:30:39
	Mods_2023_01_bug
	// ----------------------------------------------------
	
End if 
//
C_BOOLEAN:C305($vbCreatePrimaryKey)
$vbCreatePrimaryKey:=False:C215
$vbCreatePrimaryKey:=True:C214
C_LONGINT:C283($vlCurrentField; $vlCurrentTable; $i; $vlTemp)
C_LONGINT:C283($vlType; $vlLenght)
C_LONGINT:C283($vlOneField; $vlOneTable)
C_BOOLEAN:C305($vbIndexed; $vbUniq)
ARRAY LONGINT:C221($alPrimaryKey; 0)
ARRAY LONGINT:C221($alForiegnKey; 0)
ARRAY LONGINT:C221($alUniqField; 0)
C_TEXT:C284($vs80fieldname)
C_TEXT:C284($vtSQLText; $vtTempSQL; $vtFileName)
$vtFileName:=Select document:C905(""; ".sql"; "Select output file"; File name entry:K24:17)
$vtFileName:=Document
SET CHANNEL:C77(12; $vtFileName)
For ($vlCurrentTable; 1; Get last table number:C254)
	
	If (Is table number valid:C999($vlCurrentTable))
		If (Position:C15("__"; Table name:C256($vlCurrentTable))=0)
			$vtSQLText:="CREATE TABLE "+Table name:C256($vlCurrentTable)+"  ("+Char:C90(10)+Char:C90(13)
			If (Size of array:C274($alForiegnKey)>0)
				DELETE FROM ARRAY:C228($alForiegnKey; 1; Size of array:C274($alForiegnKey))
			End if 
			If (Size of array:C274($alPrimaryKey)>0)
				DELETE FROM ARRAY:C228($alPrimaryKey; 1; Size of array:C274($alPrimaryKey))
			End if 
			If (Size of array:C274($alUniqField)>0)
				DELETE FROM ARRAY:C228($alUniqField; 1; Size of array:C274($alUniqField))
			End if 
			For ($vlCurrentField; 1; Get last field number:C255($vlCurrentTable))
				If (Is field number valid:C1000($vlCurrentTable; $vlCurrentField))
					If (Position:C15("__"; Field name:C257($vlCurrentTable; $vlCurrentField))=0) & (Field name:C257($vlCurrentTable; $vlCurrentField)#"intern")
						$vs80fieldname:=Field name:C257($vlCurrentTable; $vlCurrentField)
						If ($vlCurrentField#1)
							$vtSQLText:=$vtSQLText+","+Char:C90(10)+Char:C90(13)
						End if 
						$vs80fieldname:=$vs80fieldname+(" "*(20-Length:C16($vs80fieldname)))
						$vtSQLText:=$vtSQLText+"                      "+$vs80fieldname+"       "
						GET FIELD PROPERTIES:C258($vlCurrentTable; $vlCurrentField; $vlType; $vlLenght; $vbIndexed; $vbUniq)
						GET RELATION PROPERTIES:C686($vlCurrentTable; $vlCurrentField; $vlOneTable; $vlOneField)
						Case of 
							: ($vlType=Is alpha field:K8:1)
								$vtSQLText:=$vtSQLText+"CHAR("+String:C10($vlLenght)+")"
							: ($vlType=Is text:K8:3)
								$vtSQLText:=$vtSQLText+"LONG VARCHAR"
							: ($vlType=Is real:K8:4)
								$vtSQLText:=$vtSQLText+"REAL"
							: ($vlType=Is integer:K8:5)
								$vtSQLText:=$vtSQLText+"SMALLINT"
							: ($vlType=Is longint:K8:6)
								$vtSQLText:=$vtSQLText+"INTEGER"
							: ($vlType=Is date:K8:7)
								$vtSQLText:=$vtSQLText+"DATE"
							: ($vlType=Is time:K8:8)
								$vtSQLText:=$vtSQLText+"TIME"
							: ($vlType=Is boolean:K8:9)
								$vtSQLText:=$vtSQLText+"BIT"
							: ($vlType=Is picture:K8:10)
								$vtSQLText:=$vtSQLText+"LONG VARBINARY"
							: ($vlType=Is BLOB:K8:12)
								$vtSQLText:=$vtSQLText+"LONG VARBINARY"
						End case 
						
						If ($vbIndexed)
							INSERT IN ARRAY:C227($alPrimaryKey; Size of array:C274($alPrimaryKey)+1)
							$alPrimaryKey{Size of array:C274($alPrimaryKey)}:=$vlCurrentField
						End if 
						If ($vbUniq)
							INSERT IN ARRAY:C227($alUniqField; Size of array:C274($alUniqField)+1)
							$alUniqField{Size of array:C274($alUniqField)}:=$vlCurrentField
						End if 
						If ($vlOneTable#0)
							INSERT IN ARRAY:C227($alForiegnKey; Size of array:C274($alForiegnKey)+1)
							$alForiegnKey{Size of array:C274($alForiegnKey)}:=$vlCurrentField
						End if 
					End if 
					
				End if 
			End for 
			// add primary key 
			If ($vbCreatePrimaryKey)
				$vlTemp:=0
				$vtTempSQL:=$vtSQLText
				If (Size of array:C274($alPrimaryKey)>0)
					$vtSQLText:=$vtSQLText+","+Char:C90(10)+Char:C90(13)+"PRIMARY KEY("
					For ($i; 1; Size of array:C274($alPrimaryKey))
						If (Find in array:C230($alUniqField; $alPrimaryKey{$i})>0) | (Find in array:C230($alForiegnKey; $alPrimaryKey{$i})>0)
							$vtSQLText:=$vtSQLText+Field name:C257($vlCurrentTable; $alPrimaryKey{$i})+", "
							$vlTemp:=$vlTemp+1
						End if 
					End for 
					$vtSQLText[[Length:C16($vtSQLText)-1]]:=" "
					$vtSQLText:=$vtSQLText+")"+Char:C90(10)+Char:C90(13)
				End if 
				If ($vlTemp=0)
					$vtSQLText:=$vtTempSQL
				End if 
			End if 
			// add foriegn key  
			If (Size of array:C274($alForiegnKey)>0)
				For ($i; 1; Size of array:C274($alForiegnKey))
					$vlCurrentField:=$alForiegnKey{$i}
					GET RELATION PROPERTIES:C686($vlCurrentTable; $vlCurrentField; $vlOneTable; $vlOneField)
					$vtSQLText:=$vtSQLText+","+Char:C90(10)+Char:C90(13)
					$vtSQLText:=$vtSQLText+"FOREIGN KEY ( "+Field name:C257($vlCurrentTable; $vlCurrentField)+")  REFERENCES "+Table name:C256($vlOneTable)+" ("+Field name:C257($vlOneTable; $vlOneField)+")"
				End for 
			End if 
			$vtSQLText:=$vtSQLText+");"+Char:C90(10)+Char:C90(13)
			For ($i; 1; Size of array:C274($alPrimaryKey))
				$vtSQLText:=$vtSQLText+"CREATE "
				$vlCurrentField:=$alPrimaryKey{$i}
				If (Find in array:C230($alUniqField; $vlCurrentField)>0)
					$vtSQLText:=$vtSQLText+"UNIQUE "
				End if 
				$vtSQLText:=$vtSQLText+"INDEX   X"+Table name:C256($vlCurrentTable)+Field name:C257($vlCurrentTable; $vlCurrentField)+" ON "+Table name:C256($vlCurrentTable)+" ( "+Field name:C257($vlCurrentTable; $vlCurrentField)+" ASC  );"+Char:C90(10)+Char:C90(13)
			End for 
			SEND PACKET:C103($vtSQLText)
		End if 
		
	End if 
End for 
SET CHANNEL:C77(11)
SHOW ON DISK:C922($vtFileName)
ALERT:C41("OK")
//End DEV_ExportTableDefToSQL   