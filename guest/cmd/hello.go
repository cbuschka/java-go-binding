package main

import (
	"fmt"
	"os"
)

// #include <jni.h>
import "C"

//export Java_Hello_print
func Java_Hello_print(*C.JNIEnv, C.jobject) {
	_, _ = fmt.Fprintf(os.Stderr, "Hello from Guest!\n")
}

func main() {}
