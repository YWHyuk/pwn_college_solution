extern int read(int fd, char *buffer, int count);
void myread(){
	char buffer;
	for (int i =0; i < 1024;i++){
		read(3, &buffer, 1);
	}
	return;
}
