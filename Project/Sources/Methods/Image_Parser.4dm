//%attributes = {"invisible":true}
//Method: Image_Parser
//Description
//
// Parameters 
// $1 : Task 
//  // "" use picture in pasteboard
//  // IMG_partsList
//  // IMG_partExtract
// $2 : $vp_imagePtr picture var
// $3 : $vp_partTypeArrayPtr Text array
// $4 : $vp_partOffsetPtr LongInt array
// $5 : $vp_partSizePtr LongInt array
// $6 : $vt_type 
// $7 : $vp_partBlobPtr Is BLOB
// $8 : $P_return_b  : return result into pointer (true/false if pointer to boolean var or 0/1 if pointer to number var )

// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 02/27/17, 17:10:20
	// ----------------------------------------------------
	//Created : 
	Mods_2017_02
	
	//
	// Methode IMAGE_Parser
	// idea, realisation and source by Bruno LEGAY
	// http//forums.4d.fr/Post/DE/17329223/1/17329529/
	// written by Ortwin ZILLGEN
	// http://forums.4d.fr/User/EN/1073620/1/0/0/
	//----------------------------------------------------
	
	
	C_TEXT:C284(Image_Parser; $1)
	C_POINTER:C301(Image_Parser; $2)
	C_POINTER:C301(Image_Parser; $3)
	C_POINTER:C301(Image_Parser; $4)
	C_POINTER:C301(Image_Parser; $5)
	C_TEXT:C284(Image_Parser; $6)
	C_POINTER:C301(Image_Parser; $7)
	C_POINTER:C301(Image_Parser; $8)
	
End if 
C_PICTURE:C286($vi_image)
C_LONGINT:C283($i)
C_BLOB:C604($vx_blob)
C_BOOLEAN:C305($return_b; $vb_ok)
C_TEXT:C284($1; $what)
C_POINTER:C301($2; $vp_imagePtr)
C_POINTER:C301($3; $vp_partTypeArrayPtr)
C_POINTER:C301($4; $vp_partOffsetPtr)
C_POINTER:C301($5; $vp_partSizePtr)
C_TEXT:C284($6; $vt_type)
C_POINTER:C301($7; $vp_partBlobPtr)
C_POINTER:C301($P_return_b; $8)


If (Count parameters:C259=0)
	$what:=""
Else 
	$what:=$1
	If (Count parameters:C259>=5)
		$vp_imagePtr:=$2
		$vp_partTypeArrayPtr:=$3
		$vp_partOffsetPtr:=$4
		$vp_partSizePtr:=$5
	End if 
	If (Count parameters:C259>=7)
		$vt_type:=$6
		$vp_partBlobPtr:=$7
	End if 
	If (Count parameters:C259>=8)
		$P_return_b:=$8
	End if 
	
End if 

Case of 
	: ($what="")
		GET PICTURE FROM PASTEBOARD:C522($vi_image)
		ARRAY TEXT:C222($tt_containerPartTypeList; 0)
		ARRAY LONGINT:C221($tl_offset; 0)
		ARRAY LONGINT:C221($tl_size; 0)
		Image_Parser("IMG_partsList"; ->$vi_image; ->$tt_containerPartTypeList; ->$tl_offset; ->$tl_size)
		C_TEXT:C284($Folder_t)
		$Folder_t:=Select folder:C670("Pick folder for the exports")
		For ($i; 1; Size of array:C274($tt_containerPartTypeList))
			SET BLOB SIZE:C606($vx_blob; 0)
			Image_Parser("IMG_partExtract"; ->$vi_image; ->$tt_containerPartTypeList; ->$tl_offset; ->$tl_size; $tt_containerPartTypeList{$i}; ->$vx_blob; ->$vb_ok)
			If ($vb_ok)
				BLOB TO DOCUMENT:C526($Folder_t+"screenshot_"+$tt_containerPartTypeList{$i}; $vx_blob)
			End if 
			SET BLOB SIZE:C606($vx_blob; 0)
		End for 
		ARRAY TEXT:C222($tt_containerPartTypeList; 0)
		ARRAY LONGINT:C221($tl_offset; 0)
		ARRAY LONGINT:C221($tl_size; 0)
		
	: ($what="IMG_partsList")
		
		$vb_ok:=False:C215
		If (Count parameters:C259>3)
			
			ASSERT:C1129(Type:C295($vp_imagePtr->)=Is picture:K8:10)
			ASSERT:C1129(Type:C295($vp_partTypeArrayPtr->)=Text array:K8:16)
			ASSERT:C1129(Type:C295($vp_partOffsetPtr->)=LongInt array:K8:19)
			ASSERT:C1129(Type:C295($vp_partSizePtr->)=LongInt array:K8:19)
			
			C_BLOB:C604($vx_blob)
			SET BLOB SIZE:C606($vx_blob; 0)
			
			ARRAY TEXT:C222($tt_containerPartTypeList; 0)
			ARRAY LONGINT:C221($tl_offset; 0)
			ARRAY LONGINT:C221($tl_size; 0)
			
			C_LONGINT:C283($vl_blobToVarOffset)
			
			If (False:C215)
				VARIABLE TO BLOB:C532($vp_imagePtr->; $vx_blob)
				$vl_blobToVarOffset:=0x0009  //eg"52 56 4C 42 0A E1 28 02 00"
			Else 
				If (Picture size:C356($vp_imagePtr->)>0)
					PICTURE TO BLOB:C692($vp_imagePtr->; $vx_blob; ".4PCT")  //get 4D raw format(same as VARIABLE TO BLOB without the 9 extra byte headers)
				End if 
				$vl_blobToVarOffset:=0x0000
			End if 
			
			If (BLOB size:C605($vx_blob)>=0x001C)
				C_LONGINT:C283($vl_offset; $vl_formatVersion; $vl_nbParts; $vl_payloadSize)
				
				
				//==============================================
				//4D picture format header
				//==============================================
				If (True:C214)
					//offset 0x00, size 0x1C(28bytes):
					//54 43 50 34 08 00 00 00 05 00 00 00 9F 27 02 00 3E 00 00 00 48 00 00 00 00 00 00
					//guess:
					//54 43 50 34="TCP4"=>looks like a signature'4PCT' in reverse(signature+byte order infos?)
					//08 00 00 00=little endian longintformat version?
					//05 00 00 00=little endian longintnumber of parts?
					//9F 27 02 00=little endian longintpayload size(0002 27 9F)starting at the first payload byte
					//3E 00 00 00=little endian longintcontainer type list size(starting after this block)
					//48 00 00 00=little endian longintmetadata size
					//00 00 00 00=???
					$vl_offset:=0x0000+$vl_blobToVarOffset
					
					C_LONGINT:C283($vl_signature)
					$vl_signature:=BLOB to longint:C551($vx_blob; PC byte ordering:K22:3; $vl_offset)
					Case of 
						: ($vl_signature=0x34504354)  ////'4PCT'(byteswap of'TCP4' 0x54435034)
							ASSERT:C1129($vl_offset=($vl_blobToVarOffset+0x0004))  //0x04/4
							$vl_formatVersion:=BLOB to longint:C551($vx_blob; PC byte ordering:K22:3; $vl_offset)
							ASSERT:C1129($vl_formatVersion=8; "unknown format version : "+String:C10($vl_formatVersion))
							$vb_ok:=($vl_formatVersion=8)
						Else 
							ASSERT:C1129(False:C215; "unexpected signature "+String:C10($vl_signature; "&x"))
					End case 
					
					If ($vb_ok)
						Case of 
							: ($vl_formatVersion=8)
								
								ASSERT:C1129($vl_offset=($vl_blobToVarOffset+0x0008))  //0x08/8
								$vl_nbParts:=BLOB to longint:C551($vx_blob; PC byte ordering:K22:3; $vl_offset)
								ASSERT:C1129($vl_nbParts>0; "no parts : "+String:C10($vl_nbParts)+", at offset "+String:C10($vl_offset; "&x"))
								
								ASSERT:C1129($vl_offset=($vl_blobToVarOffset+0x000C))  //0x0C/12
								$vl_payloadSize:=BLOB to longint:C551($vx_blob; PC byte ordering:K22:3; $vl_offset)
								ASSERT:C1129($vl_payloadSize>0; "empty paylod size : "+String:C10($vl_payloadSize)+", at offset "+String:C10($vl_offset; "&x"))
								
								//get the container information size in bytes at offset 0x09
								//which starts à offset 0x10
								//$vl_offset:=(0x0010)+$vl_blobToVarOffset
								ASSERT:C1129($vl_offset=($vl_blobToVarOffset+0x0010))  //0x10/16
								C_LONGINT:C283($vl_containerListSize)
								$vl_containerListSize:=BLOB to longint:C551($vx_blob; PC byte ordering:K22:3; $vl_offset)
								ASSERT:C1129($vl_containerListSize>0; "empty container list size : "+String:C10($vl_containerListSize)+", at offset "+String:C10($vl_offset; "&x"))
								
								//offset 0x14, size 0x8(8bytes):
								//48 00 00 00 00 00 00 00
								//guess:
								//48 00 00 00=>72(metadata size?)
								//00 00 00 00=>???
								ASSERT:C1129($vl_offset=($vl_blobToVarOffset+0x0014))  //0x14/20
								C_LONGINT:C283($vl_metadataSize)
								$vl_metadataSize:=BLOB to longint:C551($vx_blob; PC byte ordering:K22:3; $vl_offset)  //0x48=>72
								ASSERT:C1129($vl_metadataSize>0; "empty metadata size : "+String:C10($vl_metadataSize)+", at offset "+String:C10($vl_offset; "&x"))
								
						End case 
					End if 
				End if 
				
				
				//==============================================
				//get the list of part types
				//==============================================
				If ($vb_ok)
					Case of 
						: ($vl_formatVersion=8)
							
							//offset 0x1C, variable size$vl_containerListSize
							//size of string+string in UTF-16LE""
							//FC FF FF FF 2E 00 67 00 69 00 66 00=>".gif"
							//FC FF FF FF 2E 00 6A 00 70 00 67 00=>".jpg"
							//FB FF FF FF 2E 00 70 00 69 00 63 00 74 00=>".pict"
							//FC FF FF FF 2E 00 70 00 6E 00 67 00=>".png"
							//FC FF FF FF 2E 00 74 00 69 00 66 00=>".tif"
							
							//copy the bloc which contains the part types
							C_BLOB:C604($vx_containerList)
							COPY BLOB:C558($vx_blob; $vx_containerList; 0x001C+$vl_blobToVarOffset; 0; $vl_containerListSize)
							ASSERT:C1129(BLOB size:C605($vx_containerList)=$vl_containerListSize)
							
							ARRAY TEXT:C222($tt_containerPartTypeList; 0)
							
							C_LONGINT:C283($vl_containerListOffset)
							$vl_containerListOffset:=0x0000  //start at the begining of that container list block
							Repeat 
								
								C_LONGINT:C283($vl_containerListOffset)
								ASSERT:C1129($vl_containerListOffset<(BLOB size:C605($vx_containerList)-4); "blob size : "+String:C10(BLOB size:C605($vx_containerList))+", offset : "+String:C10($vl_containerListOffset))
								$vl_partSize:=BLOB to longint:C551($vx_containerList; PC byte ordering:K22:3; $vl_containerListOffset)
								//$vl_partSize:=((($vl_partSize ^|0xFFFFFFFF)+1)<<1)//Ones' complement x 2stange
								$vl_partSize:=(-$vl_partSize)*2  //Ones' complement<=>-value
								
								C_BLOB:C604($vx_containerPartType)
								SET BLOB SIZE:C606($vx_containerPartType; 0)
								COPY BLOB:C558($vx_containerList; $vx_containerPartType; $vl_containerListOffset; 0; $vl_partSize)
								$vl_containerListOffset:=$vl_containerListOffset+$vl_partSize
								
								APPEND TO ARRAY:C911($tt_containerPartTypeList; Convert to text:C1012($vx_containerPartType; "UTF-16LE"))
							Until ($vl_containerListOffset>=BLOB size:C605($vx_containerList))
					End case 
				End if 
				
				//==============================================
				//read the metadata(???)todo:
				//==============================================
				If ($vb_ok)
					Case of 
						: ($vl_formatVersion=8)
							//offset 0x1C+$vl_containerListSize, variable size$vl_metadataSize
							//47 41 42 56 01 00 00 00 01 04 00 00 00 1A 00 00 00 05 66 72 43 6F 6C 06 66 72 4C
							//"GABV frCol frLine frSplit vers "
							
							//guess:
							//47 41 42 56=>"GABV"metadata signature?
							//01 00 00 00=>longint1 version???
							//01=>octet1??? byte order?
							//04 00 00 00=>longint4 metadata number of properties(pascal strings)
							//1A 00 00 00=>longint26 metadata data size
							//05=>octet5???(size of coming string)
							//66 72 43 6F 6C=>"frCol"
							//06=>octet6???(size of coming string)
							//66 72 4C 69 6E 65=>"frLine"
							//07=>octet7???(size of coming string)
							//66 72 53 70 6C 69 74=>"frSplit"
							//04=>octet4???(size of coming string)
							//76 65 72 73=>"vers"
							//get the part"types"
							
							//guess0x1A/26 bytes(metadata data size)
							//00 0C 00 00 00 04 00 01 00 00 00 04 00 01 00 00 00 04 00 00 00 00 00 04 00 01 00
							//00 0C//0xC=>12???
							//00 00 00 04 00 01//1"frCol"?
							//00 00 00 04 00 01//1"frLine"?
							//00 00 00 04 00 00//0"frSplit"?
							//00 00 00 04 00 01//1"vers"?
							
							//guess0x03/3 bytes(padding to make multiple of 4 metadata size)
							//00 00 00
					End case 
					
				End if 
				
				//==============================================
				//get the address and size of each part
				//==============================================
				If ($vb_ok)
					Case of 
						: ($vl_formatVersion=8)
							//offset 0x1C+$vl_containerListSize+$vl_metadataSize, size0x20/32bytes x number of parts(?)
							//each address block has a 0x18 unknown data
							//followed by 2 little endian longints which are the part data offset and the part
							//the offset is an absolute offset(from 0x00)of the 4PCT" blob
							//32 bytes00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 42 01 00
							//32 bytes00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 42 13 00
							//32 bytes00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 87 58 00
							//32 bytes00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 5F 36 01
							//32 bytes00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 AF 4B 01
							
							//gif0x00000142('GIF89'
							//jpg0x00001342(0xFF 0xD8 0xFF 0xE0 0x00 0x10'JFIF'
							//pict0x00005887(pict format starts with the size of the data)
							//PNG0x0001365F('PNG',13,10,26,10")
							//tiff0x00014BAF('MM')
							
							
							C_LONGINT:C283($vl_partOffset; $vl_partSize)
							$vl_offset:=0x001C+$vl_containerListSize+$vl_metadataSize+$vl_blobToVarOffset
							
							For ($i; 1; Size of array:C274($tt_containerPartTypeList))
								$vl_offset:=$vl_offset+0x0018  //0x1B/24 relative offset in the addres table block
								
								$vl_partOffset:=BLOB to longint:C551($vx_blob; PC byte ordering:K22:3; $vl_offset)
								$vl_partSize:=BLOB to longint:C551($vx_blob; PC byte ordering:K22:3; $vl_offset)
								
								APPEND TO ARRAY:C911($tl_offset; $vl_partOffset)
								APPEND TO ARRAY:C911($tl_size; $vl_partSize)
							End for 
					End case 
				End if 
				
				//==============================================
				//container payload data(all the image data)
				//==============================================
				If ($vb_ok)
					//offset 0x1C+$vl_containerListSize+$vl_metadataSize+(0x20x$vl_nbParts), size$vl_payloadSize
					
				End if 
				
				
			End if 
			
			COPY ARRAY:C226($tt_containerPartTypeList; $vp_partTypeArrayPtr->)
			COPY ARRAY:C226($tl_offset; $vp_partOffsetPtr->)
			COPY ARRAY:C226($tl_size; $vp_partSizePtr->)
			
			ARRAY TEXT:C222($tt_containerPartTypeList; 0)
			ARRAY LONGINT:C221($tl_offset; 0)
			ARRAY LONGINT:C221($tl_size; 0)
			
			SET BLOB SIZE:C606($vx_blob; 0)
		End if 
		$return_b:=$vb_ok
		
	: ($what="IMG_partExtract")
		
		
		$vb_ok:=False:C215
		If (Count parameters:C259>5)
			ASSERT:C1129(Type:C295($vp_imagePtr->)=Is picture:K8:10)
			ASSERT:C1129(Type:C295($vp_partTypeArrayPtr->)=Text array:K8:16)
			ASSERT:C1129(Type:C295($vp_partOffsetPtr->)=LongInt array:K8:19)
			ASSERT:C1129(Type:C295($vp_partSizePtr->)=LongInt array:K8:19)
			ASSERT:C1129(Type:C295($vp_partBlobPtr->)=Is BLOB:K8:12)
			
			C_BLOB:C604($vx_blob)
			SET BLOB SIZE:C606($vx_blob; 0)
			
			C_LONGINT:C283($vl_blobToVarOffset)
			
			If (False:C215)
				VARIABLE TO BLOB:C532($vp_imagePtr->; $vx_blob)
				$vl_blobToVarOffset:=0x0009  //eg"52 56 4C 42 0A E1 28 02 00"
			Else 
				PICTURE TO BLOB:C692($vp_imagePtr->; $vx_blob; ".4PCT")  //get 4D raw format(same as VARIABLE TO BLOB without the 9 extra byte headers)
				$vl_blobToVarOffset:=0x0000
			End if 
			
			If (Length:C16($vt_type)>0)
				C_LONGINT:C283($vl_partIndex)
				$vl_partIndex:=Find in array:C230($vp_partTypeArrayPtr->; $vt_type)
				If ($vl_partIndex>0)
					$vb_ok:=(ok=1)
					
					C_LONGINT:C283($vl_partOffset; $vl_partSize)
					$vl_partOffset:=$vp_partOffsetPtr->{$vl_partIndex}
					$vl_partSize:=$vp_partSizePtr->{$vl_partIndex}
					
					C_BLOB:C604($vx_partBlob)
					SET BLOB SIZE:C606($vx_partBlob; $vl_partSize; 0x0000)
					
					COPY BLOB:C558($vx_blob; $vx_partBlob; $vl_partOffset+$vl_blobToVarOffset; 0; $vl_partSize)
					
					$vp_partBlobPtr->:=$vx_partBlob
					
					SET BLOB SIZE:C606($vx_partBlob; 0)
				End if 
				
			End if 
			SET BLOB SIZE:C606($vx_blob; 0)
			
		End if 
		$return_b:=$vb_ok
		
End case 


Case of 
	: (Is nil pointer:C315($P_return_b))
	: (Type:C295($P_return_b->)=Is boolean:K8:9)
		$P_return_b->:=$return_b
	: (Type:C295($P_return_b->)=Is longint:K8:6)
		$P_return_b->:=Num:C11($return_b)
	Else 
		// other conversions
End case 

//***** Ende der Methode IMAGE_Parser*****`End ImageParser