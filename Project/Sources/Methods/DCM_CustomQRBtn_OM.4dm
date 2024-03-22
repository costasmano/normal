//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 06/01/10, 12:02:52
	// ----------------------------------------------------
	// Method: DCM_CustomQRBtn_OM
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2010_05
	Mods_2011_06  // CJ Miller`06/14/11, 13:25:05      ` Type all local variables for v11
	Mods_2011_12  //Fix quick report problem where changing to related many table will not print data from original one table
	//modified by Charkes Miller 12/13/11, 14:32:17    
	//  Move code to 2004
End if 


Case of 
	: (Form event code:C388=On Load:K2:1)
		Case of 
			: (<>CurrentUser_Name="Designer")
				OBJECT SET VISIBLE:C603(CustomQR_btn; True:C214)
			: (GRP_4DUIDinGroup(<>CurrentUser_UID; "CM_CustomQRAccess")=1)
				OBJECT SET VISIBLE:C603(CustomQR_btn; True:C214)
			Else 
				OBJECT SET VISIBLE:C603(CustomQR_btn; False:C215)
		End case 
		
	: (Form event code:C388=On Clicked:K2:4)
		C_BOOLEAN:C305($QueryOpt_b)
		C_LONGINT:C283($i; $numList_L)
		$numList_L:=8
		ARRAY TEXT:C222(TablePickList_atxt; 1)
		ARRAY POINTER:C280($TblPtr_aptr; 1)
		ARRAY POINTER:C280($TbllinkFldPtr_aptr; 1)
		ARRAY LONGINT:C221($ParTblLink_aL; 1)
		$i:=1
		$TblPtr_aptr{$i}:=(->[DCM_Contracts:136])
		TablePickList_atxt{$i}:=Table name:C256($TblPtr_aptr{$i})
		$TbllinkFldPtr_aptr{$i}:=(->[DCM_Contracts:136])
		
		$i:=$i+1
		INSERT IN ARRAY:C227(TablePickList_atxt; $i)
		INSERT IN ARRAY:C227($TblPtr_aptr; $i)
		INSERT IN ARRAY:C227($TbllinkFldPtr_aptr; $i)
		INSERT IN ARRAY:C227($ParTblLink_aL; $i)
		$TblPtr_aptr{$i}:=(->[DCM_WorkOrders:137])
		TablePickList_atxt{$i}:=Table name:C256($TblPtr_aptr{$i})
		$TbllinkFldPtr_aptr{$i}:=(->[DCM_WorkOrders:137]ContractNo:1)
		
		$i:=$i+1
		INSERT IN ARRAY:C227(TablePickList_atxt; $i)
		INSERT IN ARRAY:C227($TblPtr_aptr; $i)
		INSERT IN ARRAY:C227($TbllinkFldPtr_aptr; $i)
		INSERT IN ARRAY:C227($ParTblLink_aL; $i)
		$TblPtr_aptr{$i}:=(->[DCM_Project:138])
		TablePickList_atxt{$i}:=Table name:C256($TblPtr_aptr{$i})
		$TbllinkFldPtr_aptr{$i}:=(->[DCM_Project:138]AssignID:13)
		$ParTblLink_aL{$i}:=Find in array:C230($TblPtr_aptr; (->[DCM_WorkOrders:137]))  //linked to table 2 in the list
		
		C_LONGINT:C283($picked_L)
		$picked_L:=G_PickFromList(->TablePickList_atxt; "Select Master Table for the Quick Report")
		If (OK=1)
			COPY NAMED SELECTION:C331([DCM_Contracts:136]; "PREQRSELECTION")
			
			If ($picked_L=1)
				$QueryOpt_b:=False:C215
			Else 
				$QueryOpt_b:=True:C214
				If ($ParTblLink_aL{$picked_L}>0)
					RELATE MANY SELECTION:C340($TbllinkFldPtr_aptr{$ParTblLink_aL{$picked_L}}->)
				End if 
				RELATE MANY SELECTION:C340($TbllinkFldPtr_aptr{$picked_L}->)
			End if 
			C_TEXT:C284($Setname_txt)
			C_LONGINT:C283($Size_l; $TableNumber_l)
			$TableNumber_l:=Table:C252($TblPtr_aptr{$picked_L})
			
			$Setname_txt:="◊"+Substring:C12(Table name:C256($TableNumber_l); 1; 25)+"_"+String:C10(Current process:C322)
			CREATE SET:C116($TblPtr_aptr{$picked_L}->; $Setname_txt)
			
			C_BLOB:C604($Blob_blb)
			SET BLOB SIZE:C606($Blob_blb; 0)
			VARIABLE TO BLOB:C532($Setname_txt; $Blob_blb; *)
			VARIABLE TO BLOB:C532($QueryOpt_b; $Blob_blb; *)
			VARIABLE TO BLOB:C532($TableNumber_l; $Blob_blb; *)
			
			$Size_l:=New process:C317("ut_QRProcess"; 0; "Quick Report"; $Blob_blb)
			
			//QR REPORT($TblPtr_aptr{$picked_L}->;Char(1);True;True;$QueryOpt_b;*)
			USE NAMED SELECTION:C332("PREQRSELECTION")
			CLEAR NAMED SELECTION:C333("PREQRSELECTION")
		End if 
End case 