#include <stdio.h>
#include <stdlib.h>
#include <sys/ipc.h>
#include <sys/shm.h>

#include "helper.h"

/**
 * Attach to shared memory and return pointer to Question structure.
 * Fails, if smth wrong.
 */
struct Question *get_shm_block_question(int shmflg)
{
	key_t key;
	int shmid;

	struct Question *question;

	/* make the key */
	if ((key = ftok(SHM_QUESTIONS_FILE, 'C')) == -1) {
		perror("ftok");
		printf("Did you create %s ?\n", SHM_QUESTIONS_FILE);
		exit(1);
	}

	/* connect to (and possibly create) the segment */
	if ((shmid = shmget(key, sizeof(Question_entry), shmflg )) == -1) {
		perror("shmget");
		exit(1);
	}

	question = shmat(shmid, (void *)0, 0);
	if (question == (void *)(-1)) {
		perror("shmat");
		exit(1);
	}

	return question;
}

/**
 * Detach from shared memory block. pointed by @shmaddr
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
