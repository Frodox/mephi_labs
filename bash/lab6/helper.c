#include <stdio.h>
#include <stdlib.h>
#include <sys/ipc.h>
#include <sys/shm.h>
#include <sys/sem.h>
#include <string.h>

#include "helper.h"

/************************************************************************************************
 * ##### Some code related to work with shared memory #####
 ************************************************************************************************/

/**
 * Attach to shared memory (with flags @shmflg) and return pointer to Question structure.
 * Fails, if smth wrong.
 */
struct Question *get_shm_block_question(int *shmid_orig, int shmflg)
{
	if (NULL == shmid_orig) {
		printf("%s\n", "Bad arg to get_shm_block_question()");
		exit(1);
	}

	key_t key;
	int shmid;

	struct Question *question;

	/* make the key */
	if ((key = ftok(QUESTIONS_FILE, 'E')) == -1) {
		perror("ftok");
		printf("Did you create %s ?\n", QUESTIONS_FILE);
		exit(1);
	}

	/* connect to (and possibly create) the segment */
	if ((shmid = shmget(key, sizeof(Question_entry), shmflg )) == -1) {
		perror("shmget");
		exit(1);
	}
	else {
		printf("DBG: get shm_block with id: %d\n", shmid);
	}

	question = shmat(shmid, (void *)0, 0);
	if (question == (void *)(-1)) {
		perror("shmat");
		exit(1);
	}

	*shmid_orig = shmid;
	return question;
}


/**
 * Detach from shared memory block, pointed by @shmaddr
 */
void detach_from_shm_block(void *shmaddr)
{
	if (NULL == shmaddr)
		return;

	/* detach from the segment */
	if (shmdt(shmaddr) == -1) {
		perror("shmdt");
		exit(1);
	}
}

void remove_shm_block( int shmid )
{
	if (shmctl(shmid, IPC_RMID, NULL) == -1) {
		perror("shmctl");
		exit(1);
	}
}


/************************************************************************************************
 * ##### Some code related to work with semaphores #####
 ************************************************************************************************/

/**
 * Attach/Create a set (@nsem) of semaphores with flags @semflg.
 * If create, semaphores will be markes as free (1);
 * Fails, if smth wrong.
 */
int get_semaphores_set( int nsems, int semflg )
{
	if (nsems < 1) {
		printf("%s\n", "Wrong arg @nsem to get_semaphores_set()");
		exit(1);
	}

	key_t key;
	int semid;
	struct sembuf sb;

	if ((key = ftok(QUESTIONS_FILE, 'S')) == -1) {
		perror("ftok");
		printf("Did you create %s ?\n", QUESTIONS_FILE);
		exit(1);
	}

	semid = semget(key, nsems, semflg);
	if (semid < 0) { // set exists
		printf("%s\n", "Remove a set of semaphores, please");
		exit(1);
	}
	else {
		printf("DBG: attached to semaphores set with id: %d\n", semid);
	}

	// Init semaphores
	if (0 != semflg) // mean, we create them
	{
		printf("DBG: Init semaphores with 1 (free)\n");
		sb.sem_flg = 0;
		sb.sem_op = 1;

		for(sb.sem_num = 0; sb.sem_num < nsems; sb.sem_num++) { 
			if (semop(semid, &sb, 1) == -1) {
				perror("semop:");
				semctl(semid, 0, IPC_RMID); /* clean up */
				exit(1);
			}
		}
	}

	return semid;
}


void remove_semaphore_set( int semid )
{
	if (-1 == semctl(semid, 0, IPC_RMID)) {
		perror("semctl:");
		exit(1);
	}
}



void free_first_sem(int semid)
{
	if(semop(semid, &freeed_first_sem, 1) == -1) {
		perror("semop");
		exit(1);
	}
}

void block_first_sem(int semid)
{
	if(semop(semid, &blocked_first_sem, 1) == -1) {
		perror("semop");
		exit(1);
	}
}




/***********************************************************************************
 * ##### General helpers // S E R V E R #####
 ***********************************************************************************/
void init_questions( struct Question *arr[], int *question_count )
{
	// dynamic array
	// http://stackoverflow.com/questions/3536153/c-dynamically-growing-array
	// http://happybearsoftware.com/implementing-a-dynamic-array.html
	// http://forum.codecall.net/topic/51010-dynamic-arrays-using-malloc-and-realloc/

	if (NULL == arr) {
		printf("%s\n", "Bad arg to init_queston");
		exit(1);
	}


	arr[0] = malloc(sizeof(Question_entry));
	strcpy((arr[0])->question, "Как звали главного героя в повести Н.В. Гоголя \"Шинель\"?");
	strcpy((arr[0])->a, "Значительное лицо");
	strcpy((arr[0])->b, "Варух");
	strcpy((arr[0])->c, "Акакий       ");
	strcpy((arr[0])->d, "Трифилий");
	(arr[0])->answer = 'c';


	arr[1] = malloc(sizeof(Question_entry));
	strcpy((arr[1])->question, "Одним из направлений какой религиозной философии является учение дзен?");
	strcpy((arr[1])->a, "Даосизм");
	strcpy((arr[1])->b, "Индуизм");
	strcpy((arr[1])->c, "Иудаизм");
	strcpy((arr[1])->d, "Буддизм");
	(arr[1])->answer = 'd';


	arr[2] = malloc(sizeof(Question_entry));
	strcpy((arr[2])->question, "Как называется традиционная народная русская забава \"Взятие снежного...\"?");
	strcpy((arr[2])->a, "Мужика");
	strcpy((arr[2])->b, "Городка");
	strcpy((arr[2])->c, "Снеговика");
	strcpy((arr[2])->d, "Не было такой игры");
	(arr[2])->answer = 'b';

	arr[3] = malloc(sizeof(Question_entry));
	strcpy((arr[3])->question, "Что в дореволюционной России означала поговорка \"Идти под ёлку\"?");
	strcpy((arr[3])->a, "Идти под ёлку");
	strcpy((arr[3])->b, "Идти домой");
	strcpy((arr[3])->c, "Идти в кабак  ");
	strcpy((arr[3])->d, "Пойти проспаться");
	(arr[3])->answer = 'c';


	arr[4] = malloc(sizeof(Question_entry));
	strcpy((arr[4])->question, "Как звали невесту Эдмона Дантеса, будущего графа Монте-Кристо?");
	strcpy((arr[4])->a, "Вольво");
	strcpy((arr[4])->b, "Мерседес");
	strcpy((arr[4])->c, "Лада   ");
	strcpy((arr[4])->d, "Опель");
	(arr[4])->answer = 'b';


	*question_count = 5;
}



void print_question(struct Question *question)
{
	if (NULL == question) {
		printf("%s\n", "WTF, Bro. Sendinf NULL into print_question()");
		exit(1);
	}
	printf("\n");
	printf(">: %s\n", question->question);
	printf("a: %s\t", question->a);
	printf("b: %s\n", question->b);
	printf("c: %s\t", question->c);
	printf("d: %s\n", question->d);
}



        /*
	// Read questions from file
        printf("Looking for Questions in '%s'...\n", QUESTIONS_FILE);

	FILE *fp = NULL;
	fp = fopen(QUESTIONS_FILE, "r");
	if (NULL == fp) {
		printf("ERROR: ");
		perror("fopen");
		exit(1);
	}

	char buf[ QUESTION_FIELD_SIZE ];
	char *line = NULL;

	while ( fgets(buf, sizeof(buf), fp) != NULL ) {
		line = buf;

		// skip spaces
		while ( *line != '\0' && isspace(*line) )
			line++;

		// skip comments and line with only spases
		if (strlen(line) == 0 || *line == '#')
			continue;

		printf("%s", line);
	}
	fclose(fp);
        */


