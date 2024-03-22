//%attributes = {"invisible":true}
If (False:C215)
	// G_SortTable_new
	// Sort a tables field names in alphabetical order
	
	//Will Sort all field names for all tables
	
	// Modified by: costasmanousakis-(Designer)-(1/31/2006 14:25:25)
	Mods_2006_CM03
	Mods_PRJ_BPGM
	// Modified by: costasmanousakis-(Designer)-(10/12/10 09:09:19)
	Mods_2010_10
	//  `Added the * param at the end of the SET FIELD TITLES and SET TABLE TITLES so that they appear
	//  `sorted in the formula editors also. Check if table is deleted ie. starts with "(" .
	// Modified by: Costas Manousakis-(Designer)-(6/19/12 16:38:42)
	Mods_2012_06
	//  `remove ending _x(xxx) from fields where xxxx indicates the data type (ex _r, _s, _txt)
	// Modified by: Costas Manousakis-(Designer)-(7/6/12 16:35:40)
	Mods_2012_07
	//  `When removing the ending _x(xxx) from the field names verify that the field type matches the name extension
	// Modified by: Costas Manousakis-(Designer)-(12/16/12 20:05:12)
	Mods_2012_12
	//  `Caught case where a field is undefined.  Field must be  removed from arrays
	// Modified by: Costas Manousakis-(Designer)-(8/7/14 14:00:46)
	Mods_2014_08
	//  `Initialize arrays $asFieldNames and $aiFieldNums for each table;
	//  `added search to avoid duplicate field names by adding 0 -9 at the end of the field name
	// Modified by: Costas Manousakis-(Designer)-(2/26/15 )
	Mods_2015_02
	//  `added check if the friendly fieldname is longer than 31 chars, start removing spaces from the end until ok
	// Modified by: Costas Manousakis-(Designer)-(5/8/15 15:42:41)
	Mods_2015_05
	//  `treat fields for tables LSS_@ and DCM_@ same as the PRJ_@
	// Modified by: Costas Manousakis-(Designer)-(11/6/15 17:35:09)
	Mods_2015_11
	//  `treat fields for tables NTI_@ same as the PRJ_@
	// Modified by: Costas Manousakis-(Administrator)-(4/1/20 09:49:44)
	Mods_2020_04
	//  `stop placing the list of tables and fields in the pasteboard
	// Modified by: Costas Manousakis-(Designer)-(2023-04-28 10:42:32)
	Mods_2023_04
	//  `Added SNBI_@ tables to the list of getting same treatment as PRJ_@ tables
End if 
C_BOOLEAN:C305($ReturnBlob)
$ReturnBlob:=False:C215
Case of 
	: (Count parameters:C259=0)
	: ($1="1")  //special case to save values to a blob
		C_BLOB:C604($0; $Return_blb)
		SET BLOB SIZE:C606($Return_blb; 0)
		C_LONGINT:C283($OffSet_l)
		$OffSet_l:=0
		$ReturnBlob:=True:C214
	Else 
End case 

SET CURSOR:C469(0)
SET CURSOR:C469(4)
C_LONGINT:C283($tsize; $i; $nTables; $j; $k; $fldType_L; $fldLen_L)
$nTables:=Get last table number:C254
ARRAY TEXT:C222($asTableName; 0)  //Command Replaced was o_ARRAY string length was 31
ARRAY INTEGER:C220($aiTableNumber; 0)
C_BOOLEAN:C305($authUserConsRtg; $authUserConsInsp; $bShowTable)
$authUserConsRtg:=(User in group:C338(Current user:C182; "Conslt Rating - ReadOnly") | User in group:C338(Current user:C182; "Conslt Rating - ReadWrite"))
$authUserConsInsp:=$authUserConsRtg  //they are both the same.
C_TEXT:C284($msg)
$msg:=""
For ($i; 1; $nTables)
	
	$bShowTable:=True:C214
	Case of 
		: (Not:C34(Is table number valid:C999($i)))
			$bShowTable:=False:C215
		: (Table name:C256($i)="Conslt Rating Cost")
			$bShowTable:=$authUserConsRtg | $ReturnBlob
		: (Table name:C256($i)="Cons Inspection Cost")
			$bShowTable:=$authUserConsInsp | $ReturnBlob
		: (Table name:C256($i)="(@")  //Deleted Table
			$bShowTable:=False:C215
			
	End case 
	
	If ($bShowTable)
		$j:=$j+1
		INSERT IN ARRAY:C227($asTableName; $j; 1)
		INSERT IN ARRAY:C227($aiTableNumber; $j; 1)
		$msg:=$msg+Table name:C256($i)+Char:C90(Carriage return:K15:38)
		$asTableName{$j}:=Table name:C256($i)  // Get the name of the table
		$aiTableNumber{$j}:=$i  // Store the actual table number  		
		C_BOOLEAN:C305($PRJTypeTable_b)
		$PRJTypeTable_b:=((Table name:C256($i)="PRJ_@") | \
			(Table name:C256($i)="LSS_@") | \
			(Table name:C256($i)="DCM_@") | \
			(Table name:C256($i)="SNBI_@") | \
			(Table name:C256($i)="NTI_@"))  //if it is a PRJ_@ table
		$tsize:=Get last field number:C255($i)
		C_TEXT:C284($FieldName_s)  // Command Replaced was o_C_STRING length was 40
		ARRAY TEXT:C222($asFieldNames; 0)  //Command Replaced was o_ARRAY string length was 31
		ARRAY INTEGER:C220($aiFieldNums; 0)
		
		//Sort only tables with more than 10 fields
		If (($tsize>10) | ($ReturnBlob))
			ARRAY TEXT:C222($asFieldNames; $tsize)  //Command Replaced was o_ARRAY string length was 31
			ARRAY INTEGER:C220($aiFieldNums; $tsize)
			For ($k; 1; $tsize)
				If (Is field number valid:C1000($i; $k))
					GET FIELD PROPERTIES:C258($i; $k; $fldType_L; $fldLen_L)
					$aiFieldNums{$k}:=$k
					$asFieldNames{$k}:=""
					If ($fldType_L=Is undefined:K8:13)
						//Undefined field for some reason!!!!!!
					Else 
						$FieldName_s:=Field name:C257($i; $k)
						If ($PRJTypeTable_b)
							If ((Length:C16($FieldName_s)-Position:C15("_"; $FieldName_s))>2)
								$FieldName_s:=Substring:C12($FieldName_s; (Position:C15("_"; $FieldName_s)+1))
								If (Substring:C12($FieldName_s; (Length:C16($FieldName_s)-1); 1)="_")
									$FieldName_s:=Substring:C12($FieldName_s; 1; (Length:C16($FieldName_s)-2))
								End if 
								
							Else 
								$FieldName_s:=Substring:C12($FieldName_s; 1; (Position:C15("_"; $FieldName_s)-1))
								
							End if 
							
						End if 
						
						Case of 
							: ($FieldName_s="@_R")  //real
								
								If (Type:C295(Field:C253($i; $k)->)=Is real:K8:4)
									$FieldName_s:=Substring:C12($FieldName_s; 1; (Length:C16($FieldName_s)-2))
								End if 
							: ($FieldName_s="@_L")  //longint
								If (Type:C295(Field:C253($i; $k)->)=Is longint:K8:6)
									$FieldName_s:=Substring:C12($FieldName_s; 1; (Length:C16($FieldName_s)-2))
								End if 
							: ($FieldName_s="@_D")  //date
								If (Type:C295(Field:C253($i; $k)->)=Is date:K8:7)
									$FieldName_s:=Substring:C12($FieldName_s; 1; (Length:C16($FieldName_s)-2))
								End if 
							: ($FieldName_s="@_TXT")  //text
								If (Type:C295(Field:C253($i; $k)->)=Is text:K8:3)
									$FieldName_s:=Substring:C12($FieldName_s; 1; (Length:C16($FieldName_s)-4))
								End if 
							: ($FieldName_s="@_S")  //string
								If (Type:C295(Field:C253($i; $k)->)=Is alpha field:K8:1)
									$FieldName_s:=Substring:C12($FieldName_s; 1; (Length:C16($FieldName_s)-2))
								End if 
							: ($FieldName_s="@_I")  //integer
								If (Type:C295(Field:C253($i; $k)->)=Is integer:K8:5)
									$FieldName_s:=Substring:C12($FieldName_s; 1; (Length:C16($FieldName_s)-2))
								End if 
							: ($FieldName_s="@_T")  //time
								If (Type:C295(Field:C253($i; $k)->)=Is time:K8:8)
									$FieldName_s:=Substring:C12($FieldName_s; 1; (Length:C16($FieldName_s)-2))
								End if 
							: ($FieldName_s="@_X")  //blob
								If (Type:C295(Field:C253($i; $k)->)=Is BLOB:K8:12)
									$FieldName_s:=Substring:C12($FieldName_s; 1; (Length:C16($FieldName_s)-2))
								End if 
						End case 
						
						$FieldName_s:=sFriendlyName($FieldName_s)  // Get the name of the field and make it friendly...
						$FieldName_s:=Replace string:C233($FieldName_s; "-"; "")  // remove "-"...
						If (Length:C16($FieldName_s)>31)
							C_BOOLEAN:C305($donefix_b; $cleanSpace_b)
							$donefix_b:=False:C215
							C_LONGINT:C283($fldnameLen_L; $charPos_L)
							$fldnameLen_L:=Length:C16($FieldName_s)
							Repeat 
								$cleanSpace_b:=False:C215
								
								For ($charPos_L; $fldnameLen_L; 1; -1)
									
									If (Substring:C12($FieldName_s; $charPos_L; 1)=" ")
										//found one - remove it and check again
										$FieldName_s:=Substring:C12($FieldName_s; 1; ($charPos_L-1))+Substring:C12($FieldName_s; ($charPos_L+1))
										$charPos_L:=-1
										$cleanSpace_b:=True:C214
										
									End if 
									
								End for 
								$fldnameLen_L:=Length:C16($FieldName_s)
								
								If ($fldnameLen_L<=31)
									$donefix_b:=True:C214
								Else 
									//if no more spaces found
									If (Not:C34($cleanSpace_b))
										//just get the 1st 31 chars
										$FieldName_s:=Substring:C12($FieldName_s; 1; 31)
										$donefix_b:=True:C214
									End if 
									
								End if 
								
							Until ($donefix_b)
						End if 
						If ($FieldName_s#"")
							
							C_LONGINT:C283($FldInList_L; $count_L)
							$count_L:=0
							$FldInList_L:=Find in array:C230($asFieldNames; $FieldName_s)
							
							While (($FldInList_L>0) & ($count_L<10))
								$FieldName_s:=Substring:C12($FieldName_s; 1; 30)+String:C10($count_L; "0")
								$FldInList_L:=Find in array:C230($asFieldNames; $FieldName_s)
								$count_L:=$count_L+1
								
							End while 
							
						End if 
						$asFieldNames{$k}:=$FieldName_s
						$msg:=$msg+Table name:C256($i)+Char:C90(Tab:K15:37)+$FieldName_s+Char:C90(Carriage return:K15:38)
						
					End if 
				Else 
					
					
				End if 
			End for 
			
			C_LONGINT:C283($k)
			For ($k; Size of array:C274($aiFieldNums); 1; -1)
				
				If ($asFieldNames{$k}="")  //Remove field from arrays if not Defined
					DELETE FROM ARRAY:C228($asFieldNames; $k; 1)
					DELETE FROM ARRAY:C228($aiFieldNums; $k; 1)
				End if 
			End for 
			// sort field in ascending order
			SORT ARRAY:C229($asFieldNames; $aiFieldNums; >)
			SET FIELD TITLES:C602(Table:C252($i)->; $asFieldNames; $aiFieldNums; *)
			If ($ReturnBlob)
				VARIABLE TO BLOB:C532($asFieldNames; $Return_blb; *)
				VARIABLE TO BLOB:C532($aiFieldNums; $Return_blb; *)
			End if 
			
		End if 
	End if 
	
End for 

SORT ARRAY:C229($asTableName; $aiTableNumber; >)

//SET TEXT TO PASTEBOARD($msg)

SET TABLE TITLES:C601($asTableName; $aiTableNumber; *)
SET CURSOR:C469(0)

If ($ReturnBlob)
	VARIABLE TO BLOB:C532($asTableName; $Return_blb; *)
	VARIABLE TO BLOB:C532($aiTableNumber; $Return_blb; *)
	$0:=$Return_blb
	SET BLOB SIZE:C606($Return_blb; 0)
End if 