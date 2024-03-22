//%attributes = {"invisible":true}
//Method: ut_GetChildTables
//Description
//  ` Add to arrays information about the children of a table starting from a Key field ptr

// Parameters
// $1 : $ParentFld_ptr 
// $2 : $ChildTableNames_ptr
// $3 : $ChildTablePtrs_ptr
// $4 : $ChildTableLinkFlds_ptr
// $5 : $ChildTableParTblLinks_ptr
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 11/05/12, 11:21:41
	// ----------------------------------------------------
	//Created : 
	Mods_2012_11
End if 
//
C_POINTER:C301($1; $ParentFld_ptr)
$ParentFld_ptr:=$1
C_POINTER:C301($2; $ChildTableNames_ptr)
$ChildTableNames_ptr:=$2
C_POINTER:C301($3; $ChildTablePtrs_ptr)
$ChildTablePtrs_ptr:=$3
C_POINTER:C301($4; $ChildTableLinkFlds_ptr)
$ChildTableLinkFlds_ptr:=$4
C_POINTER:C301($5; $ChildTableParTblLinks_ptr)
$ChildTableParTblLinks_ptr:=$5

C_LONGINT:C283($parTbl_L; $parFld_L; $numTbls_L; $tblLoop_L; $fldLoop_L; $numFlds_L; $myparTbl_L; $myparFld_L; $mychoiseFld_L; $FldType_L; $FldLen_L)
C_BOOLEAN:C305($autoone_b; $automany_b; $IamChild_b; $index_b; $unique_b; $invis_b; $alreadyChild_b)
C_TEXT:C284($TableName_txt)
$parTbl_L:=Table:C252($ParentFld_ptr)
$parFld_L:=Field:C253($ParentFld_ptr)
$numTbls_L:=Get last table number:C254
C_LONGINT:C283($topTBL_L)
$topTBL_L:=Table:C252($ChildTablePtrs_ptr->{1})
ARRAY LONGINT:C221($TableNums_aL; 0)
ARRAY TEXT:C222($TableNames_atxt; 0)
GET TABLE TITLES:C803($TableNames_atxt; $TableNums_aL)  //get the UI table names and numbers
For ($tblLoop_L; 1; $numTbls_L)
	
	If ((Find in array:C230($TableNums_aL; $tblLoop_L)>0) | User in group:C338(<>CurrentUser_Name; "Design Access Group"))  //if the table is part of the UI
		If ($tblLoop_L#$parTbl_L)
			$numFlds_L:=Get last field number:C255($tblLoop_L)
			$IamChild_b:=False:C215
			$alreadyChild_b:=False:C215
			If ($topTBL_L#$parTbl_L)
				//I am searching in children of a child - Find if this table is related to the Top table
				For ($fldLoop_L; 1; $numFlds_L)
					GET RELATION PROPERTIES:C686($tblLoop_L; $fldLoop_L; $myparTbl_L; $myparFld_L; $mychoiseFld_L; $autoone_b; $automany_b)
					
					If ($myparTbl_L=$topTBL_L)
						//this table is already a child of the Top table - skip
						$alreadyChild_b:=True:C214
					End if 
					
				End for 
				
			End if 
			If (Not:C34($alreadyChild_b))
				
				For ($fldLoop_L; 1; $numFlds_L)
					
					GET RELATION PROPERTIES:C686($tblLoop_L; $fldLoop_L; $myparTbl_L; $myparFld_L; $mychoiseFld_L; $autoone_b; $automany_b)
					
					If (($myparTbl_L=$parTbl_L) & ($myparFld_L=$parFld_L))
						$TableName_txt:=Table name:C256($tblLoop_L)
						
						If (Find in array:C230($TableNums_aL; $tblLoop_L)>0)
							$TableName_txt:=$TableNames_atxt{Find in array:C230($TableNums_aL; $tblLoop_L)}
						End if 
						
						If ($parTbl_L=1)
							APPEND TO ARRAY:C911($ChildTableNames_ptr->; $TableName_txt)
						Else 
							APPEND TO ARRAY:C911($ChildTableNames_ptr->; " - "+$TableName_txt)
						End if 
						
						APPEND TO ARRAY:C911($ChildTablePtrs_ptr->; Table:C252($tblLoop_L))
						APPEND TO ARRAY:C911($ChildTableLinkFlds_ptr->; Field:C253($tblLoop_L; $fldLoop_L))
						C_LONGINT:C283($prevPar_L)
						$prevPar_L:=Find in array:C230($ChildTablePtrs_ptr->; Table:C252($myparTbl_L))
						If ($prevPar_L>1)  //One is supposed to be the MASTER table
							APPEND TO ARRAY:C911($ChildTableParTblLinks_ptr->; $prevPar_L)
						Else 
							APPEND TO ARRAY:C911($ChildTableParTblLinks_ptr->; 0)
						End if 
						$IamChild_b:=True:C214
					End if 
					
				End for 
				
				If ($IamChild_b)
					C_LONGINT:C283($Mykey_L)
					$Mykey_L:=0
					For ($fldLoop_L; 1; $numFlds_L)
						GET FIELD PROPERTIES:C258($tblLoop_L; $fldLoop_L; $FldType_L; $FldLen_L; $index_b; $unique_b; $invis_b)
						If ($unique_b)
							$Mykey_L:=$fldLoop_L
						End if 
					End for 
					
					If ($Mykey_L>0)
						ut_GetChildTables(Field:C253($tblLoop_L; $Mykey_L); $2; $3; $4; $5)
					End if 
					
				End if 
				
			End if 
			
		End if 
		
	End if 
	
End for 
//End ut_GetChildTables