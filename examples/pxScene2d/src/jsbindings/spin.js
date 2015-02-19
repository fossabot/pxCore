var root = scene.root;

var url;
url = process.cwd() + "/../../images/skulls.png";
var bg = scene.createImage({url:url,xStretch:2,yStretch:2,parent:root});
bg.animateTo({r:360},60.0,scene.PX_LINEAR,scene.PX_LOOP);

url = process.cwd() + "/../../images/radial_gradient.png";
var bgShade = scene.createImage({url:url,xStretch:1,yStretch:1,parent:root});

scene.createScene({url:process.cwd()+"/hello.js",parent:root});

function updateSize(w, h) {
  //var d = Math.pow(Math.pow(w,2)+Math.pow(h,2),0.5);
  var d = Math.pow(1280*1280+1280*1280,0.5);
  bg.x = -d;
  bg.y = -d;
  bg.cx = d;
  bg.cy = d;
  bg.w = d*2;
  bg.h = d*2;
  bgShade.w = w;
  bgShade.h = h;
 }

scene.on("onResize", function(e) {console.log("fancy resize", e.w, e.h); updateSize(e.w,e.h);});
updateSize(scene.w, scene.h);