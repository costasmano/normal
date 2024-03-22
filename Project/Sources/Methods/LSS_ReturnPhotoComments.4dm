//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): administrator
//Date and time: 12/04/14, 17:18:37
//----------------------------------------------------
//Method: LSS_ReturnPhotoComments
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2014_Lighting  // 
	//Modified by: administrator (12/4/14 17:18:39)
	
End if 
C_POINTER:C301($1; $2; $3)
ARRAY TEXT:C222($PhotoDescription_atxt; 0)
ARRAY TEXT:C222($PhotoType_atxt; 0)
ARRAY LONGINT:C221($PhotoSeq_aL; 0)
C_TEXT:C284($4)
C_TEXT:C284($ID_txt)
$ID_txt:=$4


Begin SQL
	select 
	[LSS_Photos].[LSS_PhotoSequence_L], 
	[LSS_Photos].[LSS_Photo_txt],
	[LSS_Photos].[LSS_PhotoType_s] 
	from
	[LSS_Photos]
	where
	[LSS_Photos].[LSS_InspectionId_s] =:$ID_txt
	into
	:$PhotoSeq_aL, 
	:$PhotoDescription_atxt,
	:$PhotoType_atxt;
End SQL
COPY ARRAY:C226($PhotoSeq_aL; $1->)
COPY ARRAY:C226($PhotoDescription_atxt; $2->)
COPY ARRAY:C226($PhotoType_atxt; $3->)

//End LSS_ReturnPhotoComments