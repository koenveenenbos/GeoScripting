# Koen Veenenbos & Tim Jak
# Team JakVeenenbos
# 16-01-2017

feature_buffer = function(sp_feature, buf_dist){
  gBuffer(sp_feature, byid=FALSE, id=NULL, width=buf_dist, quadsegs=8, capStyle="ROUND",
          joinStyle="ROUND", mitreLimit=1.0)
}

