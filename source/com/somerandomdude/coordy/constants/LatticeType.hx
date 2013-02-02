package com.somerandomdude.coordy.constants;

class LatticeType{
	/**
	 * Sets layout of Lattice to that of a square/rectangular lattice (nodes are set orthogonally)
	 *
	 * @see com.somerandomdude.coordy.layouts.twodee.Lattice
	 */
	public static  inline var SQUARE:String="squareLattice";
	
	/**
	 * Sets layout of Lattice to that of a triangular/rhombic lattice lattice (nodes are set alternatingly shifted one half spacing)
	 *
	 * @see com.somerandomdude.coordy.layouts.twodee.Lattice
	 */
	public static  inline var DIAGONAL:String="diagonalLattice";
}