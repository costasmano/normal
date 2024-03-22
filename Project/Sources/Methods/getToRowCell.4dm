//%attributes = {"invisible":true}
//Method: getToRowCell
//Description
// retrieve data from an xml spreadsheet in a file at a row, column, starting from a row, column.
// return the text value in the parameter passed as a pointer
// Parameters
// $0 : $Error_b
// $1 : $xmldoc_t (doc reference - time)
// $2 : $Rownum_L
// $3 : $CellNum_L (cell number in row, or, column number)
// $4 : $currRowPtr : pointer to var with current row number - gets updated
// $5 : $CurrCellPtr : pointer to var with current cell/col number - gets updated
// $6 : $TextValuePtr : pointer to text var to receive the value
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 08/17/17, 11:42:36
	// ----------------------------------------------------
	//Created : 
	Mods_2017_08
	
	C_BOOLEAN:C305(getToRowCell; $0)
	C_TIME:C306(getToRowCell; $1)
	C_LONGINT:C283(getToRowCell; $2; $3)
	C_POINTER:C301(getToRowCell; $4; $5; $6)
	
End if 
//
C_BOOLEAN:C305($0; $Error_b)
C_TIME:C306($1; $xmldoc_t)
C_LONGINT:C283($2; $3; $RowNum_L; $CellNum_L; $CurrRow_L; $currCell_L; $RowCount_L; $colCount_L)
C_TEXT:C284($CellVal_txt; $fontVal_txt)
C_POINTER:C301($4; $5; $6)
$xmldoc_t:=$1
$RowNum_L:=$2
$CellNum_L:=$3
$CurrRow_L:=$4->
$currCell_L:=$5->
$CellVal_txt:=""
ARRAY TEXT:C222($elmAttrs_atxt; 0)
ARRAY TEXT:C222($elmtAttrVals_atxt; 0)
C_TEXT:C284($elmtname_txt; $elmPref_txt; $StructNum_txt)
C_LONGINT:C283($SAXevt_L)
C_BOOLEAN:C305($importErr_b)
$RowCount_L:=$CurrRow_L
$colCount_L:=$currCell_L

C_BOOLEAN:C305($Error_b)
$Error_b:=False:C215

If ($CurrRow_L<$RowNum_L)
	//flip through rows
	$RowCount_L:=$CurrRow_L
	Repeat 
		$SAXevt_L:=SAX Get XML node:C860($xmldoc_t)
		Case of 
			: (OK=0)
				//some error
			: ($SAXevt_L=XML start element:K45:10)
				SAX GET XML ELEMENT:C876($xmldoc_t; $elmtname_txt; $elmPref_txt; $elmAttrs_atxt; $elmtAttrVals_atxt)
				Case of 
					: ($elmtname_txt="Row")
						If (Find in array:C230($elmAttrs_atxt; "ss:Index")>0)
							$RowCount_L:=Num:C11($elmtAttrVals_atxt{Find in array:C230($elmAttrs_atxt; "ss:Index")})
						Else 
							$RowCount_L:=$RowCount_L+1
						End if 
				End case 
				
		End case 
	Until (($RowCount_L=$RowNum_L) | ($SAXevt_L=XML end document:K45:15) | (OK=0))
	
	//clear cell
	$currCell_L:=0
End if 
$Error_b:=(($SAXevt_L=XML end document:K45:15) | (OK=0) | $Error_b)

If (($currCell_L<$CellNum_L) & Not:C34($Error_b))
	$colCount_L:=$currCell_L
	//flip cells
	Repeat 
		$SAXevt_L:=SAX Get XML node:C860($xmldoc_t)
		Case of 
			: (OK=0)
				//some error
			: ($SAXevt_L=XML start element:K45:10)
				SAX GET XML ELEMENT:C876($xmldoc_t; $elmtname_txt; $elmPref_txt; $elmAttrs_atxt; $elmtAttrVals_atxt)
				
				Case of 
					: ($elmtname_txt="Row")
						//started new row
						$RowCount_L:=$RowCount_L+1
						$colCount_L:=0
					: ($elmtname_txt="Cell")
						If (Find in array:C230($elmAttrs_atxt; "ss:Index")>0)
							$colCount_L:=Num:C11($elmtAttrVals_atxt{Find in array:C230($elmAttrs_atxt; "ss:Index")})
						Else 
							$colCount_L:=$colCount_L+1
						End if 
						If (Find in array:C230($elmAttrs_atxt; "ss:MergeAcross")>0)
							$colCount_L:=$colCount_L+Num:C11($elmtAttrVals_atxt{Find in array:C230($elmAttrs_atxt; "ss:MergeAcross")})
							
						End if 
				End case 
				
		End case 
		
	Until (($colCount_L>=$CellNum_L) | ($SAXevt_L=XML end document:K45:15) | (OK=0))
	
End if 

$Error_b:=(($SAXevt_L=XML end document:K45:15) | (OK=0) | $Error_b)

//go to the <data> of the cell
If (Not:C34($Error_b))
	C_BOOLEAN:C305($gotdata_b)
	$gotdata_b:=False:C215
	Repeat 
		$SAXevt_L:=SAX Get XML node:C860($xmldoc_t)
		
		Case of 
			: (OK=0)
				//some error
			: ($SAXevt_L=XML start element:K45:10)
				SAX GET XML ELEMENT:C876($xmldoc_t; $elmtname_txt; $elmPref_txt; $elmAttrs_atxt; $elmtAttrVals_atxt)
				ARRAY TEXT:C222($levels_atxt; 0)
				APPEND TO ARRAY:C911($levels_atxt; "Data")
				Case of 
					: ($elmtname_txt="Data")
						//next node is data - it could be split into fonts....
						$SAXevt_L:=SAX Get XML node:C860($xmldoc_t)
						If ($SAXevt_L=XML DATA:K45:12)
							SAX GET XML ELEMENT VALUE:C877($xmldoc_t; $CellVal_txt)
							$gotdata_b:=True:C214
						Else 
							
							//now what???
							//append two font data
							//loop getting font until end of data
							$CellVal_txt:=""
							Repeat 
								Case of 
									: (OK=0)
									: ($SAXevt_L=XML start element:K45:10)
										SAX GET XML ELEMENT:C876($xmldoc_t; $elmtname_txt; $elmPref_txt; $elmAttrs_atxt; $elmtAttrVals_atxt)
										APPEND TO ARRAY:C911($levels_atxt; $elmtname_txt)
										If ($elmtname_txt="Font")
											$SAXevt_L:=SAX Get XML node:C860($xmldoc_t)
											
											If ($SAXevt_L=XML DATA:K45:12)
												SAX GET XML ELEMENT VALUE:C877($xmldoc_t; $fontVal_txt)
												$CellVal_txt:=$CellVal_txt+$fontVal_txt
											End if 
											
										End if 
									: ($SAXevt_L=XML end element:K45:11)
										DELETE FROM ARRAY:C228($levels_atxt; Size of array:C274($levels_atxt); 1)
								End case 
								$SAXevt_L:=SAX Get XML node:C860($xmldoc_t)
								
							Until ((Size of array:C274($levels_atxt)=0) | ($SAXevt_L=XML end document:K45:15) | (OK=0))
							$gotdata_b:=True:C214
							
						End if 
				End case 
				
				
		End case 
		
	Until (($gotdata_b) | ($SAXevt_L=XML end document:K45:15) | (OK=0))
	
End if 
$Error_b:=(($SAXevt_L=XML end document:K45:15) | (OK=0) | $Error_b)
If (Not:C34($Error_b))
	$4->:=$RowCount_L
	$5->:=$colCount_L
	$6->:=$CellVal_txt
End if 
ASSERT:C1129(($SAXevt_L=XML end document:K45:15) | (OK=0) | $Error_b; "What happened?")
$0:=$Error_b
//End getToRowCell