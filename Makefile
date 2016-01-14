
all:
	nvcc hello.cu -o hello.out
	nvcc main.cu -o main.out

clean:
	rm hello.out main.out
