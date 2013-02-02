package com.somerandomdude.coordy.helpers;

@:keep
class DistributeCustom {

	public static function createInitialVertices(nodeNumber:Int, radius:Float):Array<Vertex> {
		var p:Array<Vertex> = [];
		// create initial random cloud
		for (i in 0...nodeNumber) {
			p[i] = new Vertex();
			p[i].x = (Std.int(Math.random() * 1000)) - 500;
			p[i].y = (Std.int(Math.random() * 1000)) - 500;
			p[i].z = (Std.int((Math.random() * 1000)) - 500;
			normalise(p[i], radius);
		}
		return p;
	}
	
	public static function DoDistribute(vertices:Array<Vertex>, radius:Float, iteration:Int =15):Array<Vertex> {
		var i:Int;
		var j:Int;
		var n:Int;
		
		var counter = 0 ;
		var counterMax = iteration;
		
		var minp1:Int;
		
		var minp2:Int;

		var r:Float;
		var d:Float;
		var mind:Float = 0;
		var maxd:Float;

		var p:Array<Vertex> = vertices ;
		var p1:Vertex;
		var p2:Vertex;
		
		var nodeNumber = vertices.length;

		nodeNumber = nodeNumber < 4 ? 4 : nodeNumber;
		
		radius = radius < 0.001 ? 0.001 : radius;
		
		while (counter < counterMax ) {
			minp1 = 0;
			minp2 = 1;
			mind = distance(p[minp1], p[minp2]);
			maxd = mind;
			var _length = nodeNumber - 1;
			for (i in 0..._length ) {
				for ( j in 0...nodeNumber ) {
					d = distance(p[i], p[j]);
					if ( d < mind ) {
						mind = d;
						minp1 = i;
						minp2 = j;
					}
					if (d > maxd) maxd = d ;
				}
			}
			
			/*
				 Move the two minimal points apart, in this case by 1%
				 but should really vary this for refinement
			*/
			p1 = p[minp1];
			p2 = p[minp2];
			
			p[minp2].x = p1.x + 1.01 * (p2.x - p1.x);
			p[minp2].y = p1.y + 1.01 * (p2.y - p1.y);
			p[minp2].z = p1.z + 1.01 * (p2.z - p1.z);
			p[minp1].x = p1.x - 0.01 * (p2.x - p1.x);
			p[minp1].y = p1.y - 0.01 * (p2.y - p1.y);
			p[minp1].z = p1.z - 0.01 * (p2.z - p1.z);
			normalise(p[minp1],radius);
			normalise(p[minp2],radius);
		
			counter++;
		}
		return p;
	}

	public static function normalise(p:Vertex,r:Float):Void{
		var l:Float;
		l = r / Math.sqrt(p.x*p.x+p.y+p.y+p.z*p.z);
		p.x =l;
		p.y =l;
		p.z =l;
	}

	public static function distance(p1:Vertex,p2:Vertex):Float{
		var p:Vertex = new Vertex(0, 0, 0);
		p.x = p1.x-p2.x;
		p.y = p1.y-p2.y;
		p.z = p1.z-p1.z;
		return (Math.sqrt(p.x*p.x+p.y*p.y+p.z*p.z));
	}
}