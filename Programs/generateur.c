#include<stdlib.h>
#include<stdio.h>
#include<string.h>
#include<time.h>
#include<assert.h>

#define WORDLEN 5
#define INT_MAX 1000000


typedef struct
{
	char source[WORDLEN];
	char destination[WORDLEN];
	double frequence;
} Paire;


void dictionnaireInit(Paire** dico, int nbMots);
void dictionnaireTestament(Paire* dico);
void dictionnaireAffichage(const Paire* dico, int nbMots);
void motSuivant(char* mot);



int main(int argc, char** argv)
{
	char distribution[10];
	int nbMots, nbPhrases, lgPhrases;
	Paire* dico;
	FILE* source;
	FILE* destination;
	float bruit,freqtot,aleaf;
	int i,j,k;

	assert(argc == 6);
	assert((!strcmp(argv[2],"zipf"))||(!strcmp(argv[2],"uniform"))||(!strcmp(argv[2],"zipfplateau")));
	strcpy(distribution,argv[2]);
	nbMots = atoi(argv[1]);
	nbPhrases = atoi(argv[3]);
	lgPhrases = atoi(argv[4]);
	bruit = atof(argv[5]);
	srand(time(NULL));

	dictionnaireInit(&dico,nbMots);
	freqtot = 0;
	source = fopen("source.txt","w");
	destination = fopen("destination.txt","w");

	if (!strcmp(distribution, "zipf"))
	{
		for(i=0;i<nbMots;i++)
		{
			dico[i].frequence = ((double)nbMots)/((double)(i+1));
			freqtot += ((double)nbMots)/((double)(i+1));
		}
		for(i=0;i<nbMots;i++)
		{
			dico[i].frequence /= freqtot;
		}
	}

	else if (!strcmp(distribution, "zipfplateau"))
	{
		for(i=0;i<(nbMots/5);i++)
		{
			dico[i].frequence = 0.8/((float)(nbMots/5));
		}
		for(i=(nbMots/5);i<nbMots;i++)
		{
			dico[i].frequence = 0.2/((float)(nbMots-(nbMots/5)));
		}
	}

	else if (!strcmp(distribution, "uniform"))
	{
		for(i=0;i<nbMots;i++)
		{
			dico[i].frequence = 1./((double)nbMots);
		}
	}

	dictionnaireAffichage(dico,nbMots);

	for(i=0;i<nbPhrases;i++)
	{
		for(j=0;j<lgPhrases;j++)
		{
			aleaf = ((float)(rand()%INT_MAX))/((float)INT_MAX);
			freqtot = 0.;
			k = -1;
			while(freqtot<aleaf)
			{
				k++;
				freqtot += ((float)dico[k].frequence);
			}
			fprintf(source,"%s ",dico[k].source);
			aleaf = ((float)(rand()%INT_MAX))/((float)INT_MAX);
			if(aleaf<=bruit)
			{
				aleaf = ((float)(rand()%INT_MAX))/((float)INT_MAX);
				freqtot = 0.;
				k = -1;
				while(freqtot<aleaf)
				{
					k++;
					freqtot += ((float)dico[k].frequence);
				}
			}
			fprintf(destination,"%s ",dico[k].destination);
		}
		fprintf(source,"\n");
		fprintf(destination,"\n");
	}

	dictionnaireTestament(dico);
	fclose(source);
	fclose(destination);

	return EXIT_SUCCESS;
}



void dictionnaireInit(Paire** dico, int nbMots)
{
	int i;
	char source[WORDLEN];
	char destination[WORDLEN];
	for(i=0;i<WORDLEN-1;i++)
	{ source[i] = 'a'; destination[i] = 'a'; }
	source[WORDLEN-1] = '\0'; destination[WORDLEN-1] = '\0';
	destination[0] = 'n';
	*dico = (Paire*) malloc (nbMots*sizeof(Paire));
	for(i=0;i<nbMots;i++)
	{
		strcpy((*dico)[i].source,source);
		strcpy((*dico)[i].destination,destination);
		(*dico)[i].frequence = 0;
		motSuivant(source); motSuivant(destination);
	}
}


void dictionnaireTestament(Paire* dico)
{
	free(dico);
}


void dictionnaireAffichage(const Paire* dico, int nbMots)
{
	int i;
	FILE* f;
	f = fopen("dictionnaire.txt","w");
	for(i=0;i<nbMots-1;i++)
	{
		fprintf(f,"%s\t%s\t%f\n",dico[i].source,dico[i].destination,dico[i].frequence);
	}
	fprintf(f,"%s\t%s\t%f",dico[nbMots-1].source,dico[nbMots-1].destination,dico[nbMots-1].frequence);
	fclose(f);
}


void motSuivant(char* mot)
{
	int i;
	int done;
	done = 0;
	for(i=WORDLEN-2;((i>=0)&&(!done));i--)
	{
		mot[i]++;
		if(mot[i]>'z')
		{ mot[i] = 'a'; }
		else
		{ done = 1; }
	}
}



