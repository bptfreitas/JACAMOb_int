#include <jni.h>

#include <iostream>

#include <unistd.h>
#include <fcntl.h>
#include <sys/stat.h>
#include <sys/wait.h>

#include <libjasonint.h>

extern "C"
JNIEXPORT void JNICALL Java_jason_asSemantics_Agent_CheckForInterrupts
  (JNIEnv *env, jobject obj)
{
    static int counter = 0;
    // Find the exception class
    jclass excClass = env->FindClass("jason/asSemantics/Agent$ExternalInterruptException");
    if (excClass == nullptr) {
        // ClassNotFoundException is already pending.
        return;
    }

    counter ++ ;

    fprintf(stdout, "\nCounter : %d", counter );

    if ( counter == 100 ){

    // Throw the exception with a message
        env->ThrowNew(
            excClass,
            "This exception came from native code.");

    }
    
    // Nothing else should be done after throwing.
}
