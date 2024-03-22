vGeoDeg_L:=Int:C8(vDMS_r)
vGeoMin_L:=Int:C8(60*(vDMS_r-vGeoDeg_L))
vGeoSec_r:=(vDMS_r*3600)-((3600*vGeoDeg_L)+(60*vGeoMin_L))
vGeoSec_r:=Round:C94(vGeoSec_r; 5)
