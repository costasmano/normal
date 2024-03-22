//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 08/30/07, 10:49:54
	// ----------------------------------------------------
	// Method: ut_importAddress
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	Mods_2007_CM12_5301
	Mods_2011_06  // CJ Miller`06/14/11, 13:25:05      ` Type all local variables for v11
End if 
C_TIME:C306($Doc)
$Doc:=Open document:C264("")
If (Ok=1)
	C_TEXT:C284($TF)
	C_LONGINT:C283($tblNum_L; $NumFields_L; $i)
	$tblNum_L:=Table:C252(->[Conslt Address:77])
	$NumFields_L:=Get last field number:C255(->[Conslt Address:77])
	ARRAY POINTER:C280($Fldptrs_aptr; $NumFields_L)
	ARRAY TEXT:C222($FldNames_atxt; $NumFields_L)
	ARRAY TEXT:C222($FldValues_atxt; $NumFields_L)
	C_TEXT:C284($SQLID_txt)
	For ($i; 1; $NumFields_L)
		$Fldptrs_aptr{$i}:=Field:C253($tblNum_L; $i)
		$FldNames_atxt{$i}:=Field name:C257($tblNum_L; $i)
	End for 
	SORT ARRAY:C229($FldNames_atxt; $Fldptrs_aptr)
	C_BOOLEAN:C305($Done_b)
	$Done_b:=False:C215
	Repeat 
		RECEIVE PACKET:C104($Doc; $FldValues_atxt{1}; Char:C90(Tab:K15:37))
		If (Ok=1)
			If ($FldValues_atxt{1}="City")
			Else 
				CREATE RECORD:C68([Conslt Address:77])
				Inc_Sequence("ConsAddress"; ->[Conslt Address:77]ConsltAddressID:1)
			End if 
			
			$Fldptrs_aptr{1}->:=$FldValues_atxt{1}
			For ($i; 2; $NumFields_L)
				RECEIVE PACKET:C104($Doc; $FldValues_atxt{$i}; Char:C90(Tab:K15:37))
				If ($i<=$NumFields_L)
					RECEIVE PACKET:C104($Doc; $FldValues_atxt{$i}; Char:C90(Carriage return:K15:38))  //last
				Else 
				End if 
				If ($FldNames_atxt{$i}="ConsltAddressID")
				Else 
					Case of 
						: (Type:C295($Fldptrs_aptr{$i}->)=Is alpha field:K8:1)
							$Fldptrs_aptr{$i}->:=$FldValues_atxt{$i}
						: (Type:C295($Fldptrs_aptr{$i}->)=Is text:K8:3)
							$Fldptrs_aptr{$i}->:=$FldValues_atxt{$i}
						: (Type:C295($Fldptrs_aptr{$i}->)=Is boolean:K8:9)
							$TF:=Substring:C12($FldValues_atxt{$i}; 1; 1)
							$Fldptrs_aptr{$i}->:=(($TF="T") | ($TF="Y"))
						: (Type:C295($Fldptrs_aptr{$i}->)=Is integer:K8:5)
							$Fldptrs_aptr{$i}->:=Num:C11($FldValues_atxt{$i})
						: (Type:C295($Fldptrs_aptr{$i}->)=Is date:K8:7)
							$Fldptrs_aptr{$i}->:=Date:C102($FldValues_atxt{$i})
						: (Type:C295($Fldptrs_aptr{$i}->)=Is longint:K8:6)
							$Fldptrs_aptr{$i}->:=Num:C11($FldValues_atxt{$i})
						: (Type:C295($Fldptrs_aptr{$i}->)=Is real:K8:4)
							$Fldptrs_aptr{$i}->:=Num:C11($FldValues_atxt{$i})
						: (Type:C295($Fldptrs_aptr{$i}->)=Is time:K8:8)
							$Fldptrs_aptr{$i}->:=Time:C179($FldValues_atxt{$i})
					End case 
				End if 
				
			End for 
			RECEIVE PACKET:C104($Doc; $SQLID_txt; Char:C90(Carriage return:K15:38))  //last is the SQL vendor ID
			QUERY:C277([Conslt_Name:127]; [Conslt_Name:127]SQL_VendorID_l:3=Num:C11($SQLID_txt))
			If (Records in selection:C76([Conslt_Name:127])=1)
				[Conslt Address:77]ConsultantNameID_l:22:=[Conslt_Name:127]ConsultantNameID_l:1
			End if 
			
			If ($FldValues_atxt{1}="City")
				
			Else 
				SAVE RECORD:C53([Conslt Address:77])
				UNLOAD RECORD:C212([Conslt Address:77])
			End if 
			
		Else 
			$Done_b:=True:C214
		End if 
		
	Until ($Done_b)
	CLOSE DOCUMENT:C267($Doc)
End if 