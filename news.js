
function closeDiv() {
		document.getElementById('floatLayer').style.left = "-1000";
		return false;
	}

var how_many_ads = 1;
var now = new Date()
var sec = now.getSeconds()
var ad = sec % how_many_ads;
ad +=1;
if (ad==1) {
url="NOME DO SITE";
banner="600x300.jpg"
}

	window.onerror = null;
	var topMargin = 170;
	var slideTime = 3000;
	var ns6 = (!document.all && document.getElementById);
	var ie4 = (document.all);
	var ns4 = (document.layers);

	function layerObject(id,left) {
		if (ns6) {
			this.obj = document.getElementById(id).style;
			this.obj.left = left;
			return this.obj;
			}
		else if(ie4) {
			this.obj = document.all[id].style;
			this.obj.left = left;
			return this.obj;
			}
		else if(ns4) {
			this.obj = document.layers[id];
			this.obj.left = left;
			return this.obj;
			}
		}

	function layerSetup() {
		floatLyr = new layerObject('floatLayer', pageWidth * .20);
		window.setInterval("main()", 10)
		}

	function floatObject() {
		if (ns4 || ns6) {
			findHt = window.innerHeight;
		} else if(ie4) {
			findHt = document.body.clientHeight;
		   }
		}

	function main() {
		if (ns4) {
			this.currentY = document.layers["floatLayer"].top;
			this.scrollTop = window.pageYOffset;
			mainTrigger();
			}
		else if(ns6) {
			this.currentY = parseInt(document.getElementById('floatLayer').style.top);
			this.scrollTop = scrollY;
			mainTrigger();
		} else if(ie4) {
			this.currentY = floatLayer.style.pixelTop;
			this.scrollTop = document.body.scrollTop;
			mainTrigger();
		   }
		}

	function mainTrigger() {
		var newTargetY = this.scrollTop + this.topMargin;
		if ( this.currentY != newTargetY ) {
			if ( newTargetY != this.targetY ) {
				this.targetY = newTargetY;
				floatStart();
			}
			animator();
			}
		}

	function floatStart() {
		var now = new Date();
		this.A = this.targetY - this.currentY;
		this.B = Math.PI / ( 2 * this.slideTime );
		this.C = now.getTime();
		if (Math.abs(this.A) > this.findHt) {
			this.D = this.A > 0 ? this.targetY - this.findHt : this.targetY + this.findHt;
			this.A = this.A > 0 ? this.findHt : -this.findHt;
			}
		else {
			this.D = this.currentY;
		   }
		}

	function animator() {
		var now = new Date();
		var newY = this.A * Math.sin( this.B * ( now.getTime() - this.C ) ) + this.D;
		newY = Math.round(newY);
		if (( this.A > 0 && newY > this.currentY ) || ( this.A < 0 && newY < this.currentY )) {
		if ( ie4 )document.all.floatLayer.style.pixelTop = newY;
		if ( ns4 )document.layers["floatLayer"].top = newY;
		if ( ns6 )document.getElementById('floatLayer').style.top = newY + "px";
		   }
		}

	function start() {
		if(ns6||ns4) {
			pageWidth = innerWidth;
			pageHeight = innerHeight;
			layerSetup();
			floatObject();
			}
		else if(ie4) {
			pageWidth = document.body.clientWidth;
			pageHeight = document.body.clientHeight;
			layerSetup();
			floatObject();
		   }
		}
document.write('<DIV id=floatLayer style="position: absolute; width: 30; height: 30; z-index: 30; left: 250; top: 30; visibility: visible; border: 0px none #000000">');
document.write('<table border="0" cellspacing="0" cellpadding="0" bordercolor="#FFFFFF">');
document.write('<tr><td border="0" align="center" bgcolor="#ffffff" colspan="4">');
document.write('<a onClick=closeDiv() href=' + url + ' target=_blank "\return false\">');
document.write('<img src=' + banner + ' ')
document.write('border=0></a></td></tr>');
document.write('<tr><td border="0" align="right" colspan="4"><input type="submit" name="fechar" value="FECHAR" onClick="return closeDiv()" style="font-family: Verdana; font-weight: bold; font-size:10px;  color: #FFFFFF; background-color: #000000; border: 1px solid #fffff;"></td></tr>');
document.write('</table></DIV>');
start();