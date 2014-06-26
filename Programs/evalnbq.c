#include<stdlib.h>
#include<stdio.h>
#include<assert.h>

#define MAXN 7

int compteMots(FILE* f)
{
	int nbMots;
	char c;
	nbMots = 0;

	do
	{
		if(feof(f))
		{ return -1; }
		fscanf(f,"%c",&c);
		if (c == ' ')
		{ nbMots ++; }
	} while (c != '\t');

	return nbMots+1;
}

void finirLigne(FILE* f)
{
	char c;

	if (!feof(f))
	{
		do
		{
			fscanf(f,"%c",&c);
		}while(c != '\n');
	}
}




int main(int argc, char** argv)
{
	FILE* fic;
	int alignements[MAXN][MAXN];
	int somme;
	int nb1, nb2;
	int i, j;

	assert(argc == 2);

	fic = fopen(argv[1],"r");

	for(i=0;i<MAXN;i++)
	{
		for(j=0;j<MAXN;j++)
		{
			alignements[i][j] = 0;
		}
	}

	while (!feof(fic))
	{
		nb1 = compteMots(fic);
		nb2 = compteMots(fic);
		finirLigne(fic);
		alignements[nb1-1][nb2-1]++;
	}
	somme = 0;
	for(i=0;i<MAXN;i++)
	{
		for(j=0;j<MAXN;j++)
		{
			printf("%d\t%d\t%d\n",i+1,j+1,alignements[i][j]);
			somme += alignements[i][j];
		}
	}

	fclose(fic);

	return 0;
}


