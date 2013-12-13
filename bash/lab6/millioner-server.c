/*
 * Description.
 **/ 

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/ipc.h>
#include <sys/shm.h>
#include <sys/sem.h>
#include <string.h>

#include <errno.h>

/* Shared memory with dynamic array inside */
// http://stackoverflow.com/questions/14558443/c-shared-memory-dynamic-array-inside-shared-struct


// dynamic array
// http://stackoverflow.com/questions/3536153/c-dynamically-growing-array
// http://happybearsoftware.com/implementing-a-dynamic-array.html
// http://forum.codecall.net/topic/51010-dynamic-arrays-using-malloc-and-realloc/

#include "helper.h"



int initsem(key_t key, int nsems);  /* key from ftok() */

int main()
{
	printf("== Server of \"You are a Millioner game\" started...== \n\n");

	/*
	struct Question *question;
	question = get_shm_block_question(IPC_CREAT | 0644);
	char *str = "Привет Привет Ghbdtn!";
	strncpy(question->question, str, QUESTION_FIELD_SIZE);
	detach_from_shm_block(question);
	*/

	/* Read questions from file */

        /*
        printf("Looking for Questions in '%s'...\n", SHM_QUESTIONS_FILE);

	FILE *fp = NULL;
	fp = fopen(SHM_QUESTIONS_FILE, "r");
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

	printf("%s\n", "Create semaphore...");

	char *sem_file = "/tmp/sm";

	key_t key;
	int semid;
	struct sembuf sb;
	sb.sem_flg = SEM_UNDO;

	if ((key = ftok(sem_file, 'J')) == -1) {
		perror("ftok");
		printf("Did you create %s ?\n", sem_file);
		exit(1);
	}

	semid = semget(key, 1, IPC_CREAT | IPC_EXCL | 0666);

	if (semid < 0) { /* sem exist */
		printf("%s\n", "Remove the semaphore, please");
		exit(1);
	}
	sb.sem_num = 0;		/* first one in set */


	/* Init semaphores */
	printf("%s\n", "Init semaphore...");
	sb.sem_op = 1;		/* this semaphore is free */
	if (semop(semid, &sb, 1) == -1) {
		perror("semop:");
		return -1;
	}

	/* block semaphore */
	sb.sem_op =  -1;		/* set to block */

	printf("Blocking sem... %d\n", sb.sem_op);
	if (semop(semid, &sb, 1) == -1) {
		perror("semop:");
		return -1;
	}
	printf("%s\n", "Blocked. Client should unlock it.");


	/* wait for connection  ********************/
	sb.sem_op =  -1;	/* block resources */

	printf("Try to block... again (wait for connections) %d\n", sb.sem_op);
	if (semop(semid, &sb, 1) == -1) {
		perror("semop:");
		return -1;
	}
	printf("%s\n", "Client Connected!");


	printf("%s\n", "dbg sleeping...");
	while(1) {}

	return 0;
}

/*
** initsem() -- more-than-inspired by W. Richard Stevens' UNIX Network
** Programming 2nd edition, volume 2, lockvsem.c, page 295.
*/

/*

wait for client, while shm_buf != '*'
если *, то клиент подсоединился,
клиент спит чуток, мы блокируем
 */
