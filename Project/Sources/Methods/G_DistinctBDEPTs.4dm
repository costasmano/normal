//%attributes = {"invisible":true}
ARRAY TEXT:C222($asBDEPTs; 0)  //Command Replaced was o_ARRAY string length was 6
DISTINCT VALUES:C339([Bridge MHD NBIS:1]BDEPT:1; $asBDEPTS)
ALERT:C41("There are "+String:C10(Size of array:C274($asBDEPTs))+"Bridge Numbers in the current selection")