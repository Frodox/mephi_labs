#ifndef _MILLIONER_GAME_
#define _MILLIONER_GAME_	1

#define SIZE_1K 1024
#define SIZE_2K 2048

#include <sys/ipc.h>
#include <sys/shm.h>
#include <sys/sem.h>
#include <unistd.h>

/**** S H A R E D  M E M O R Y *****/

#define QUESTIONS_FILE "questions.txt"

#define QUESTION_FIELD_SIZE SIZE_1K
#define BUFFER_BLOCK_SIZE   SIZE_1K

#define SHM_CREATE_PERMS 0644


struct Question {
	/* Question itself  */
	char question[ QUESTION_FIELD_SIZE ];
	/* possible answers */
	char a[ QUESTION_FIELD_SIZE ];
	char b[ QUESTION_FIELD_SIZE ];
	char c[ QUESTION_FIELD_SIZE ];
	char d[ QUESTION_FIELD_SIZE ];
	char answer;    /* correct one */

	/* store user answer here */
	char user_answer[ QUESTION_FIELD_SIZE ];
	/* some extra text from server (and result) */
	char server_msg[ QUESTION_FIELD_SIZE ];

	int is_user_win;
} Question_entry ;


struct Question *get_shm_block_question(int *shmid, int shmflg );


void detach_from_shm_block(void *shmaddr);
void remove_shm_block(int shmid);




/**********************************/
/****** S E M A P H O R E S *******/
/**********************************/

#define SEM_CREATE_PERMS 0666
#define SEM_IN_SET_COUNT 2

union semun {
	int val;
	struct semid_ds *buf;
	unsigned short *array;
};


// free semaphores //
static struct sembuf freeed_first_sem  = { .sem_num = 0, .sem_op = 1, .sem_flg = 0 };
//static struct sembuf free_second_sem = { .sem_num = 1, .sem_op = 1, .sem_flg = 0 };

// block semaphores //
static struct sembuf blocked_first_sem  = { .sem_num = 0, .sem_op = -1, .sem_flg = 0 };
//static struct sembuf block_second_sem = { .sem_num = 1, .sem_op = -1, .sem_flg = 0 };


int get_semaphores_set( int nsems, int semflg );

void remove_semaphore_set( int semid );


void free_first_sem(int semid);
void block_first_sem(int semid);




/****** common funcs **************/
/**
 * Read @questions_file and return pointer to array of Questions
 */
void init_questions( struct Question *arr[], int *question_count );

void print_question(struct Question *question);






#endif /* helper.h */
