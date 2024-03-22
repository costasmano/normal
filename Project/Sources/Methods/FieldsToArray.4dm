//%attributes = {"invisible":true}
If (False:C215)
	//Procedure: FieldsToArray(file ptr;array ptr;array ptr;boolean;boolean;array ptr)
	//ACI University Programming Classes
	//Generic ACI Shell Programming
	//Created By:  Jim Steinman
	//Date:  10/5/95
	
	//Legend:
	//$1 - pointer to file to copy fieldnames from.
	//$2 - pointer to array to put fieldnames into.
	//$3 - pointer to array to put pointers to fields into.
	//$4 - if true, only copy indexed fields.
	//$5 - (Optional) if true, include invisible fields
	
	//Purpose: Copies fieldnames into an array and copies field pointers into second a
	//Picture fields and subfiles are not copied.
	
	<>fGeneric:=False:C215
	<>f_Ver1x20:=False:C215
	<>fJ_Steinman:=False:C215
	
	//Modification by Tom Nee, 1/28/98.
	//$6 - (Optional) pointer to array of field types and lengths.
	// Modified by: Costas Manousakis-(Designer)-(10/16/13 10:01:53)
	Mods_2013_10
	//  `Replaced Insert in Array with Append to Array
End if 

C_POINTER:C301($1; $2; $3; $6; $pField)
C_LONGINT:C283($i; $j; $LType; $LLen; $LFileNum; $LParms; $LInvisible; $LRelatFile; $LRelatField; $LAttribute)
C_TEXT:C284($sChoiceList)  // Command Replaced was o_C_STRING length was 30
C_BOOLEAN:C305($4; $5; $fIndexed; $DoTypes; $vbUnique; $vbInvisible; $vbInvisChk)
C_TEXT:C284($Ltype_s)  // Command Replaced was o_C_STRING length was 8

//SetCursor is now Set Cursor in v6.5
//Change made on 6 02 00
//SetCursor(4)
SET CURSOR:C469(4)

$LParms:=Count parameters:C259
If ($LParms>=5)  //added this one....
	$vbInvisChk:=$5
End if 

If ($LParms=6)
	$DoTypes:=True:C214
End if 
$LFileNum:=Table:C252($1)  //Get the file number we are using

$j:=0
For ($i; 1; Get last field number:C255($1))
	
	$pField:=Field:C253(Table:C252($1); $i)  //Get a pointer to the field
	GET FIELD PROPERTIES:C258($pField; $LType; $LLen; $fIndexed; $vbUnique; $vbInvisible)
	If (($LType#Is picture:K8:10) & ($LType#Is subtable:K8:11) & ($LType#Is BLOB:K8:12))  //not a picture, Blob field or a subfile
		If ((Not:C34($4)) | (($4) & ($fIndexed)))  //If indexed or including all fields regardless of index
			
			If (Not:C34(($vbInvisible & ($LParms>=5))))  //($LInvisible=0)  `Include if not invisible or not checking
				$j:=$j+1
				//INSERT IN ARRAY($2->;$j)
				//ARRAY STRING(19;$2->;$j)
				//$2->{$j}:=Substring(sFriendlyName (Field name($pField));1;19)  `make sure we get only 19 chars
				APPEND TO ARRAY:C911($2->; Substring:C12(sFriendlyName(Field name:C257($pField)); 1; 19))
				//INSERT IN ARRAY($3->;$j)
				//ARRAY POINTER($3->;$j)
				//$3->{$j}:=$pField
				APPEND TO ARRAY:C911($3->; $pField)
				If ($DoTypes)
					//INSERT IN ARRAY($6->;$j)
					//ARRAY STRING(8;$6->;$j)
					Case of 
						: ($LType=Is alpha field:K8:1)
							$Ltype_s:="Char*"+String:C10($LLen)  //String
						: ($LType=Is real:K8:4)
							$Ltype_s:="Real"  //Real
						: ($LType=Is text:K8:3)
							$Ltype_s:="Text"  //Text
						: ($LType=Is date:K8:7)
							$Ltype_s:="Date"  //Date
						: ($LType=Is boolean:K8:9)
							$Ltype_s:="Boolean"  //Boolean
						: ($LType=Is integer:K8:5)
							$Ltype_s:="Integer"  //Integer
						: ($LType=Is longint:K8:6)
							$Ltype_s:="Long Int"  //Long Integer
						: ($LType=Is time:K8:8)
							$Ltype_s:="Time"  //Time
						Else 
							$Ltype_s:="?"
					End case 
					APPEND TO ARRAY:C911($6->; $Ltype_s)
				End if 
			End if 
			
		End if 
	End if 
	
End for 
//SetCursor is now Set Cursor in v6.5
//Change made on 6 02 00
//SetCursor(0)
SET CURSOR:C469(0)
//CLOSE WINDOW
//End of procedure 