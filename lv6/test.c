#include <stdlib.h>
#include <sys/types.h>
#include <unistd.h>
int main(int argc, char* argv[], char* env[]){
	setenv("PATH","/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/tmp/lv6",1);
	execve("/toddler2_level7_teaching1",argv,env);
}
