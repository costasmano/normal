//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 08/07/08, 09:48:46
	// ----------------------------------------------------
	// Method: CM_CustomQRBtn_OM
	// Description
	//  ` Method for a Quick report button that allows a choise for the
	//  ` Master Table of the quick report
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2008_CM_5404
	// Modified by: costasmanousakis-(Designer)-(7/8/08 09:21:46)
	Mods_2008_CM_5404  // ("OTHERQUICKREPORT")
	Mods_2011_06  // CJ Miller`06/14/11, 13:25:05      ` Type all local variables for v11
	Mods_2011_12  //Fix quick report problem where changing to related many table will not print data from original one table
	//modified by Charkes Miller 12/13/11, 14:32:17    
	//  Move code to 2004
End if 
C_BOOLEAN:C305($QueryOpt_b)
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
		C_LONGINT:C283($i; $numList_L)
		$numList_L:=8
		ARRAY TEXT:C222(TablePickList_atxt; 1)
		ARRAY POINTER:C280($TblPtr_aptr; 1)
		ARRAY POINTER:C280($TbllinkFldPtr_aptr; 1)
		ARRAY LONGINT:C221($ParTblLink_aL; 1)
		$i:=1
		$TblPtr_aptr{$i}:=(->[Contract_Maintenance:97])
		TablePickList_atxt{$i}:=Table name:C256($TblPtr_aptr{$i})
		$TbllinkFldPtr_aptr{$i}:=(->[Contract_Maintenance:97])
		
		$i:=$i+1
		INSERT IN ARRAY:C227(TablePickList_atxt; $i)
		INSERT IN ARRAY:C227($TblPtr_aptr; $i)
		INSERT IN ARRAY:C227($TbllinkFldPtr_aptr; $i)
		INSERT IN ARRAY:C227($ParTblLink_aL; $i)
		$TblPtr_aptr{$i}:=(->[Contract_Assignment_Maintenance:101])
		TablePickList_atxt{$i}:=Table name:C256($TblPtr_aptr{$i})
		$TbllinkFldPtr_aptr{$i}:=(->[Contract_Assignment_Maintenance:101]ContractNo:1)
		
		$i:=$i+1
		INSERT IN ARRAY:C227(TablePickList_atxt; $i)
		INSERT IN ARRAY:C227($TblPtr_aptr; $i)
		INSERT IN ARRAY:C227($TbllinkFldPtr_aptr; $i)
		INSERT IN ARRAY:C227($ParTblLink_aL; $i)
		$TblPtr_aptr{$i}:=(->[Invoice_Maintenance:95])
		TablePickList_atxt{$i}:=Table name:C256($TblPtr_aptr{$i})
		$TbllinkFldPtr_aptr{$i}:=(->[Invoice_Maintenance:95]ContractNo:3)
		
		$i:=$i+1
		INSERT IN ARRAY:C227(TablePickList_atxt; $i)
		INSERT IN ARRAY:C227($TblPtr_aptr; $i)
		INSERT IN ARRAY:C227($TbllinkFldPtr_aptr; $i)
		INSERT IN ARRAY:C227($ParTblLink_aL; $i)
		$TblPtr_aptr{$i}:=(->[ExtendTime_Maintenance:98])
		TablePickList_atxt{$i}:=Table name:C256($TblPtr_aptr{$i})
		$TbllinkFldPtr_aptr{$i}:=(->[ExtendTime_Maintenance:98]ContractNo:1)
		$i:=$i+1
		INSERT IN ARRAY:C227(TablePickList_atxt; $i)
		INSERT IN ARRAY:C227($TblPtr_aptr; $i)
		INSERT IN ARRAY:C227($TbllinkFldPtr_aptr; $i)
		INSERT IN ARRAY:C227($ParTblLink_aL; $i)
		$TblPtr_aptr{$i}:=(->[FundTransfer_Maintenance:96])
		TablePickList_atxt{$i}:=Table name:C256($TblPtr_aptr{$i})
		$TbllinkFldPtr_aptr{$i}:=(->[FundTransfer_Maintenance:96]ContractNo:1)
		$i:=$i+1
		INSERT IN ARRAY:C227(TablePickList_atxt; $i)
		INSERT IN ARRAY:C227($TblPtr_aptr; $i)
		INSERT IN ARRAY:C227($TbllinkFldPtr_aptr; $i)
		INSERT IN ARRAY:C227($ParTblLink_aL; $i)
		$TblPtr_aptr{$i}:=(->[AddFund_Maintenance:99])
		TablePickList_atxt{$i}:=Table name:C256($TblPtr_aptr{$i})
		$TbllinkFldPtr_aptr{$i}:=(->[AddFund_Maintenance:99]ContractNo:1)
		$i:=$i+1
		INSERT IN ARRAY:C227(TablePickList_atxt; $i)
		INSERT IN ARRAY:C227($TblPtr_aptr; $i)
		INSERT IN ARRAY:C227($TbllinkFldPtr_aptr; $i)
		INSERT IN ARRAY:C227($ParTblLink_aL; $i)
		$TblPtr_aptr{$i}:=(->[Contract_Project_Maintenance:100])
		TablePickList_atxt{$i}:=Table name:C256($TblPtr_aptr{$i})
		$TbllinkFldPtr_aptr{$i}:=(->[Contract_Project_Maintenance:100]AssignID:13)
		$ParTblLink_aL{$i}:=Find in array:C230($TblPtr_aptr; (->[Contract_Assignment_Maintenance:101]))  //linked to table 2 in the list
		
		C_LONGINT:C283($picked_L)
		$picked_L:=G_PickFromList(->TablePickList_atxt; "Select Master Table for the Quick Report")
		If (OK=1)
			COPY NAMED SELECTION:C331([Contract_Maintenance:97]; "PREQRSELECTION")
			
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