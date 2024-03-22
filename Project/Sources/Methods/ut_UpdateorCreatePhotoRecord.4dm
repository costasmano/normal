//%attributes = {"invisible":true}
//Method: ut_UpdateorCreatePhotoRecord
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	
	//----------------------------------------------------
	//User name (OS): administrator
	//Date and time: 12/18/14, 16:11:37
	//----------------------------------------------------
	Mods_2014_Lighting  // 
	//Modified by: administrator (12/18/14 16:11:38)
	// Modified by: Costas Manousakis-(Designer)-(2/17/16 17:40:25)
	Mods_2016_02_bug
	//  `fixed wrong sequence in the lognewrecord was LSS_Photo should be LSS_PhotoID_s
	// Modified by: Costas Manousakis-(Designer)-(4/29/16 17:27:01)
	Mods_2016_04_bug
	//  `fixed length of var $key_s to match the id field
	Mods_2017_06_bug  ////Fix error where errors occur and tranaction not cancelled
	//Modified by: Chuck Miller (6/21/17 13:44:29)
End if 
C_BOOLEAN:C305($0)
C_TEXT:C284($1; $2; $3; 4; $Path_txt; $Type_txt; $Description_txt; $ImportHow_txt)
$ImportHow_txt:=$1
C_PICTURE:C286($Photo_pct)

$Path_txt:=$2
$Type_txt:=$3
$Description_txt:=$4

C_POINTER:C301($5; $PictVariable_ptr)
$PictVariable_ptr:=$5
$0:=True:C214
QUERY:C277([LSS_Photos:166]; [LSS_Photos:166]LSS_InspectionId_s:2=[LSS_Inspection:164]LSS_InspectionId_s:1; *)
QUERY:C277([LSS_Photos:166];  & ; [LSS_Photos:166]LSS_PhotoType_s:3=$Type_txt)
If ($ImportHow_txt="file")
	If (Test path name:C476($Path_txt)=Is a document:K24:1)
		
		C_LONGINT:C283($Key_L)
		READ PICTURE FILE:C678($Path_txt; $Photo_pct; *)
		
		If (Picture size:C356($Photo_pct)>0)
			If (OK=1)
				$PictVariable_ptr->:=$Photo_pct
				
			Else 
				$0:=False:C215
			End if 
		Else 
			$0:=False:C215
			ALERT:C41("Selected picture has not size")
		End if 
	Else 
		$0:=False:C215
		ALERT:C41("Selected item is not a file")
	End if 
Else 
	$Photo_pct:=$PictVariable_ptr->
	
End if 
C_TEXT:C284($ErrorMethodCalled_txt)
$ErrorMethodCalled_txt:=Method called on error:C704
ON ERR CALL:C155("LSS_ErrorMethod")
If (Records in selection:C76([LSS_Photos:166])=0)
	LSS_PhotoDescription_txt:=""
	C_LONGINT:C283($Sequence_L)
	C_TEXT:C284($Key_s)  // Command Replaced was o_C_STRING length was 20
	$Key_s:=[LSS_Inspection:164]LSS_InspectionId_s:1
	Begin SQL
		select max([LSS_Photos].[LSS_PhotoSequence_L])
		from [LSS_Photos]
		where [LSS_Photos].[LSS_InspectionId_s] = :$Key_s
		into :$Sequence_L
	End SQL
	CREATE RECORD:C68([LSS_Photos:166])
	Inc_Sequence("LSS_PhotoId_s"; ->$Key_L)
	
	[LSS_Photos:166]LSS_PhotoId_s:1:=String:C10($Key_L; <>KeyMask_s)
	[LSS_Photos:166]LSS_InspectionId_s:2:=[LSS_Inspection:164]LSS_InspectionId_s:1
	[LSS_Photos:166]LSS_PhotoSequence_L:6:=$Sequence_L+1
	[LSS_Photos:166]LSS_PhotoType_s:3:=$Type_txt
	
	LogNewRecord(->[LSS_Photos:166]LSS_PhotoId_s:1; ->[LSS_Photos:166]LSS_PhotoId_s:1; ->[LSS_Photos:166]LSS_PhotoId_s:1; 0; "LSS_PhotoId_s")
	
End if 
If (ut_LoadRecordInteractiveV2(->[LSS_Photos:166])=1)
	[LSS_Photos:166]LSS_Photo_txt:4:=$Description_txt
	[LSS_Photos:166]LSS_PhotoType_s:3:=$Type_txt
	PICTURE TO BLOB:C692($Photo_pct; [LSS_Photos:166]LSS_Photo_blb:5; "JPEG")
	BLOB TO PICTURE:C682([LSS_Photos:166]LSS_Photo_blb:5; $PictVariable_ptr->)
	
Else 
	ALERT:C41("Unable to load photo record, you wil have to try again later")
End if 
ON ERR CALL:C155($ErrorMethodCalled_txt)
//End ut_UpdateorCreatePhotoRecord