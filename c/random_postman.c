#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <string.h>

#define NUMBER_OF_TEAM = 6;

int random_postman()
{
	srand(time(NULL));
	int r = rand() % 6;
}

int main() 
{
	
	
	char team[6][10] =
	{
		"Antoine",
		"Emilie",
		"Gregory",
		"Ricardo",
		"Benjamin",
		"Bertrand"
	};
	
	return printf("Le facteur est: %s\n", team[r]);
}
