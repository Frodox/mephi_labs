#include <stdio.h>
#include <stdlib.h>
#include <sys/ipc.h>
#include <sys/shm.h>
#include <sys/sem.h>

#include "helper.h"

int main()
{
/*
	printf("Greeting in \"You are a Millioner game\"!\n");
	struct Question *question;
	question = get_shm_block_question(0);

	printf("Question: %s\n", question->question);
	detach_from_shm_block(question);
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

	semid = semget(key, 1, 0 );
	if (semid < 0) { /* can't attach */
		printf("%s\n", "Cannot attach to semaphore");
		exit(1);
	}
	sb.sem_num = 0;		/* first one in set */


	/* Connect to server | release semaphore ********************/
	sb.sem_op =  1;		/* set to release */

	printf("Connecting... %d\n", sb.sem_op);
	if (semop(semid, &sb, 1) == -1) {
		perror("semop:");
		return -1;
	}
	printf("%s\n", "Connected");


        // read output from server, try to send response
        
        /* Try to send to server smth | lock semaphore ********************/
	sb.sem_op = -1;    /* block */

	printf("Sending response... %d\n", sb.sem_op);
	if (semop(semid, &sb, 1) == -1) {
		perror("semop:");
		return -1;
	}
	printf("%s\n", "Sended");


	return 0;
}

