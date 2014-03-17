/**
 *
 */
package com.bitthinker;



public class Polynome
{

	private double[] coefficients;


	public Polynome() {}
	
	/**
	 * Construct a Polynome from coefficients
	 * @param incoeffs
	 */
	public Polynome(double[] incoeffs)
	{
		this.setCoefficents(trimZeroElementsInArrayFromLeft(incoeffs));
	}
	
	
	/* getters */ 
	
	public double[] getCoefficents()
	{
		return  coefficients;
	}
	public double getCoefficentAt(int i)
	{
		return this.coefficients[i];
	}

	
	/* setters */
	
	public void setCoefficents(double[] array)
	{
		this.coefficients=array;
	}
	public void setCoefficentAt(int i, double d)
	{
		this.coefficients[i]=d;
	}

	


	/* helping dividing */

	public Polynome[] devideByArraied(Polynome other)
	{
	
		if (isPolynomeIsZero(other))
			return null;
	
		// detects Polynome's powers
		int n = this.getPolynomePower();
		int m = other.getPolynomePower();
	
		if (n < m)
			return new Polynome[] {
					new Polynome(new double[]{0}),
					new Polynome(this.getCoefficents())
			};


		double[] tempCoeffs = this.coefficients;
	
		// long division
		double[] resultingCoefficents = new double[n - m + 1];
		for (int i = 0; i <= n-m; i++)
		{
			resultingCoefficents[i] = tempCoeffs[i] / other.getCoefficentAt(0);
			for (int j = 0; j < m+1; j++)
				tempCoeffs[j+i] -= resultingCoefficents[i] * other.getCoefficentAt(j);
		}
	
		double[] restCoeffs = trimZeroElementsInArrayFromLeft(tempCoeffs);

		return new Polynome[] { 
				new Polynome(resultingCoefficents),
				new Polynome(restCoeffs)
				};
	}

	
	/* actual dividing */
	public Polynome devideBy(Polynome poly)
	{
		Polynome[] resultingPolynomes = this.devideByArraied(poly);

		if (null != resultingPolynomes) 
		{
			this.coefficients = resultingPolynomes[0].coefficients;
			return resultingPolynomes[1];
		}
		else
			return null;
	}


	/* helpers */

	public int getPolynomePower()
	{
		return this.coefficients.length - 1;
	}

	private static boolean isPolynomeIsZero(Polynome polynome)
	{
		for(int i=0; i < polynome.getCoefficents().length; i++)
			if(polynome.getCoefficentAt(i) != 0)
				return false;

		return true;
	}
	
	private static double[] trimZeroElementsInArrayFromLeft(double[] inputArray)
	{
		int posNotNullElement=0;
	
		while ( posNotNullElement < inputArray.length-1 && 0 == inputArray[posNotNullElement] )
			posNotNullElement++;
	
		double[] result = new double[inputArray.length - posNotNullElement];
	
		for (int i = 0; i < result.length; i++, posNotNullElement++)
			result[i]=inputArray[posNotNullElement];

		return result;
	}

	
	
	@Override
	public String toString()
	{
		StringBuilder sb = new StringBuilder();
		for (int i = 0; i< this.coefficients.length-1 ; i++)
			sb.append("" + coefficients[i] + "*x^" + (this.coefficients.length-i-1) + " + ");

		sb.append("" + coefficients[this.coefficients.length-1] );
		return sb.toString();
	}
}

