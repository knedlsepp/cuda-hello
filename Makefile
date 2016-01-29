
all:
	nvcc -g hello.cu -o hello.out
	nvcc -g main.cu -o main.out

clean:
	rm hello.out main.out
