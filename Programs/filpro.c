#include<stdlib.h>
#include<assert.h>
#include<string.h>
#include<stdio.h>
#include<time.h>

#define LIGNES 15
#define COLONNES 20
#define DICO 400
#define DISTRIBUTION "zipf"


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


int main (int argc, char** argv)
{
	int corpus[LIGNES][COLONNES];
	int **profils;
	long int profsize, pi;
	float dico[DICO];
	float f, aleaf;
	int ok, i, j, k, l, m;

	srand(time(NULL));

	/* Initialisation du dictionnaire */
	if (!strcmp(DISTRIBUTION,"zipf"))
	{
		f = 0;
		for(i=0;i<DICO;i++)
		{
			dico[i] = ((float)DICO)/((float)(i+1));
			f += dico[i];
		}
		for(i=0;i<DICO;i++)
		{
			dico[i] /= f;
		}
	}
	else if (!strcmp(DISTRIBUTION,"uniform"))
	{
		for(i=0;i<DICO;i++)
		{
			dico[i] = 1./((float)DICO);
		}
	}
	else
	{
		assert(0);
	}

	/* Initialisation du corpus */
		for(i=0;i<LIGNES;i++)
		{
			for(j=0;j<COLONNES;j++)
			{
				aleaf = ((float)(rand()%DICO))/DICO;
				k = -1;
				f = 0;
				while(f <= aleaf)
				{
					k++;
					f += dico[k];
				}
				corpus[i][j] = k;
			}
		}

	/* Affichage du corpus */
	printf("\nCorpus :\n");
	for(i=0;i<LIGNES;i++)
	{
		for(j=0;j<COLONNES;j++)
		{
			printf("%d ", corpus[i][j]);
			k = 10;
			while(DICO > k)
			{
				if (corpus[i][j] < k)
				{
					printf(" ");
				}
				k *= 10;
			}
		}
		printf("\n");
	}
	printf("\n");

	/* Initialisation des profils */
	profsize = puis(2,LIGNES);
	profils = (int**) malloc(3*sizeof(int*));
	for(i=0;i<3;i++)
	{
		profils[i] = (int*) malloc(profsize*sizeof(int));
		for(j=0;j<profsize;j++)
		{
			profils[i][j] = 0;
		}
	}


	/* Initialisation du dico de travail */
	for(i=0;j<DICO;i++)
	{
		dico[i] = 0;
	}

	/* Calcul des profils (1) */
	for (k=0;k<DICO;k++)
	{
		pi = 0;
		for(i=0;i<LIGNES;i++)
		{
			ok = 0;
			for(j=0;j<COLONNES;j++)
			{
				if ((ok == 0) && (corpus[i][j] == k))
				{
					pi += puis(2,i);
					ok = 1;
				}
			}
		}
		assert((0<=pi) && (pi<profsize));
		profils[0][pi]++;
	}

	/* Calcul des profils (2) */
	for (k=0;k<DICO;k++)
	{
		for (l=0;l<DICO;l++)
		{
			pi = 0;
			for(i=0;i<LIGNES;i++)
			{
				ok = 0;
				for(j=0;j<COLONNES-1;j++)
				{
					if ((ok == 0) && (corpus[i][j] == k) && (corpus[i][j+1] == l))
					{
						pi += puis(2,i);
						ok = 1;
					}
				}
			}
			assert((0<=pi) && (pi<profsize));
			profils[1][pi]++;
		}
	}

	/* Calcul des profils (3) */
	for (k=0;k<DICO;k++)
	{
		for (l=0;l<DICO;l++)
		{
			for (m=0;m<DICO;m++)
			{
				pi = 0;
				for(i=0;i<LIGNES;i++)
				{
					ok = 0;
					for(j=0;j<COLONNES-2;j++)
					{
						if ((ok == 0) && (corpus[i][j] == k) && (corpus[i][j+1] == l) && (corpus[i][j+2] == m))
						{
							pi += puis(2,i);
							ok = 1;
						}
					}
				}
				assert((0<=pi) && (pi<profsize));
				profils[2][pi]++;
			}
		}
	}

	/* Affichage des profils obtenus */
	for(k=0;k<3;k++)
	{
		pi = 0;
		printf("Pour des %d-grams :\n",k+1);
		for(j=1;j<COLONNES;j++)
		{
			m = 0;
			for(i=0;i<profsize;i++)
			{
				if (profils[k][i] == j)
				{
					m++;
				}
			}
			if (m != 0)
			{
				printf("%d profils apparaissent %d fois\n", m, j);
			}
		}
		printf("\n");
	}

	return 0;
}

