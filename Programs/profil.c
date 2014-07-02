#include<stdlib.h>
#include<stdio.h>

#define ITER 10
#define LEN 4


long int puis(long int x, int p)
{
	long int y;
	int i;
	y = 1;
	for(i=0;i<p;i++)
	{
		y = y*x;
	}
	return y;
}

void affcoeff(int* coef, int l)
{
	int i;
	for (i=0;i<l;i++)
	{
		printf("%d ",coef[i]);
	}
	printf("\n");
}

int somme(int n, int *coef, int** vecteurs)
{
	long int i,j,sum;
	long int PUIS;
	PUIS=puis(2,LEN);
	for(i=0;i<LEN;i++)
	{
		sum = 0;
		for(j=1;j<PUIS;j++)
		{
			sum += coef[j]*vecteurs[j][i];
		}
		if (sum != n)
		{ return 0; }
	}
	return 1;
}


void increm(int *coef, int len, int max)
{
	int ok;
	int i;
	ok = 0;
	i = len-1;

	while(ok == 0)
	{
		coef[i]++;
		if (coef[i] > max)
		{
			coef[i] = 0;
			i--;
		}
		else
		{
			ok = 1;
		}
		if (i<0)
		{
			ok = 1;
		}
	}
}

void remplirVecteurs(int** vecteurs, int n, long int total)
{
	long int i, j;
	int* vec;

	vec = (int*) malloc(n*sizeof(int));
	for(i=0;i<n;i++)
	{ vec[i] = 0; }

	for(i=0;i<total;i++)
	{
		for(j=0;j<n;j++)
		{ vecteurs[i][j] = vec[j]; }
		increm(vec, n, 1);
	}
}

int main(int argc, char** argv)
{
	int** vecteurs;
	int* coef;
	long int total;
	long int i, j;
	long int PUIS;

	PUIS = puis(2,LEN);
	coef = (int*) malloc(PUIS*sizeof(int));
	vecteurs = (int**) malloc(PUIS*sizeof(int*));
	for(i=0;i<PUIS;i++)
	{
		vecteurs[i] = (int*) malloc(LEN*sizeof(int));
	}

	remplirVecteurs(vecteurs, LEN, PUIS);

	for(i=0;i<ITER;i++)
	{
		for(j=0;j<PUIS;j++)
		{
			coef[j] = 0;
		}
		total = 0;

		for (j=0;j<puis(i+1,PUIS-1);j++)
		{
			if (somme(i, coef, vecteurs) == 1)
			{ total++; }
			increm(coef,PUIS,i);
		}

		printf("i=%ld\n%ld combinaison(s)\n\n",i,total);
	}

	return 0;
}


