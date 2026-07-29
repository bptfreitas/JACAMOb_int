#include <jni.h>

#include <PingPong.h>

#include <iostream>

#include <unistd.h>
#include <fcntl.h>
#include <sys/stat.h>
#include <sys/wait.h>

extern "C"
JNIEXPORT void JNICALL Java_Agent_CheckForInterrupts
  (JNIEnv *env, jobject obj)
{
    static int counter = 0;
    // Find the exception class
    jclass excClass = env->FindClass("Agent$ExternalInterruptException");
    if (excClass == nullptr) {
        // ClassNotFoundException is already pending.
        return;
    }

    counter ++ ;

    if ( counter == 10 ){

    // Throw the exception with a message
        env->ThrowNew(
            excClass,
            "This exception came from native code.");

    }
    
    // Nothing else should be done after throwing.
}
