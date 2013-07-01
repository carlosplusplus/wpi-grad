#include <stdio.h>

main()
{
	float a[3][4] = {1,2,3,4,5,6,7,8,9,10,11,12};
	float b[4][2] = {20,21,22,23,24,25,26,27};
	float c[3][2];
	int	irow, icol, k;

	for( irow=0; irow<3; irow++ )
	{
		for( icol=0; icol<2; icol++ )
		{
			c[irow][icol] = 0.0;
			for( k=0; k<4; k++ )
			{
				c[irow][icol] += a[irow][k] * b[k][icol];
			}
		}
	}

	for( irow=0; irow<3; irow++ )
		printf( "%10.10f %10.10f\n", c[irow][0], c[irow][1] );
}