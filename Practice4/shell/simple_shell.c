#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/wait.h>
#include <unistd.h>

#define MAX_LEN 100 /* The maximum length command */

int main(void) {
    char *args[MAX_LEN / 2 + 1]; /* command line arguments */
    int should_run = 1;          /* flag to determine when to exit program */
    int background = 0;

    while (should_run) {
        printf("my_shell> ");
        fflush(stdout);


      /**
     * 표준입출력으로부터 문자열을 입력 받은 후:
     * (1) fork()를 통해 자식 프로세스를 생성
     * (2) 자식 프로세스가 execvp()를 호출하도록 할 것
     * (3) 만약 입력받은 문자에 &가 포함되어 있으면,
     *     부모 프로세스는 wait() 호출x
     */
	  // (1) receive strings by user
	    fgets(args, MAX_LEN/2, stdin);

	  // divide received strings by "\n"
	    char *tok_p;
	    p = strtok(args, "\n");
	    while(){

            if(p == NULL){// if strings is empty, go to last loop inside while
	  	        goto restart;
		    }
		    else{
				// terminate program if string is same as "exit"
				if(strcmp(args[0], "exit") == 0 || strcmp(args[0], "exit") == 0){
				    break;
				}
				else if()
		    }
	    }

        restart:
    }
    return 0;
}
