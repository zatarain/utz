# Test runner
In order to ease the test running for developers and also continuous integration tools we need to design a tool to run test cases via command line interface.

We will use shell scripting tools but trying to keep POSIX compliance as long as possible to avoid portability issues. This means, if we need to create any shell script, that script must be runnable in bash but also in dash and bourne shell.

Following sections aim to define a design for this tool in order to be able to test an application with utz. The application could be an executable or even a library. However, is more generic do it for an excecutable.

## Inputs and configuration
The tool will need following inputs:
* Test implementation files (*.tpp) where the function `void test();` is implemented.
* Configuration via Testfile which is described in following section.
* The source or object files from the application under test to generate a shared library.

### Test implementation files
Test cases will be implemented in a *.tpp files containing an implementation for the main test function:
```C++
void utz::test();
```

That function is basically the entry point for the test cases as `int main(int, const char**)` is for an executable application.

We should be able to run:
* a single test in a tpp file
* a set of tests defined in sever tpp files
* all the tests of the application under test

### Aplication under test
The tool will need the recipe to build the application under test from source files to generate a shared library instead of an executable but with exactly the same parameters and flags as the application under test is built.

We also should be able to provide only the object files to avoid compile twice. If the application under test is actually a library already, we don't need this as we will see in next subsection.

### Testfile and set up
A Testfile is not another thing than a Makefile with some special targets. So, basically is a recipe to:
1. set the environment variables
2. define the compiler flags and parameters
3. define the linker flags and parameters.
4. build an application under test shared library from either sources or objects.
5. compile the tests cases from the tpp files.

With this, we will define an structure for our Testfile.

#### Variable section
In order to perform this we can use the varibale define section in our Testfile to achive steps 1 to 3. For example:
```Makefile
UTZ_LINKER_FLAGS:= -shared --wrapper main
UTZ_EXTERNAL_DEPENDENCIES_LIBS:= -l dependency1 ... -l dependencyN
UTZ_EXTERNAL_PATH_LIBS:= -L /path/to/mylibdir
```

#### Target `library-under-test`
To achieve the step 4, we will define a target called `library-under-test` to specify the recipe to build a shared library either from the source or object files. As we said before, if the application under test is actually a library under test, we don't need another recipe to build the shared library, since it is already. Then, we can just use in this target the actual build pipeline/target to make it. For example:
```Makefile
library-under-test:
	make [paramethers-and-flags] application
```

So, if this is not the case, it would be a good idea to have in our application build pipeline a way to generate only the object files (*.o), this means compile without linking. In this way, we can specify only the linking process in this Testfile target. For example:
```Makefile
library-under-test:
	ld ${UTZ_LINKER_FLAGS} *.o -o libundertest.so \
		${UTZ_EXTERNAL_PATH_LIBS} \
		${UTZ_EXTERNAL_DEPENDENCIES_LIBS}
```

Otherwise, this target should specify all the steps to build from source code.

## Expected behaviour and outputs
The tool should generate a report to the standard output with all executed the test cases counting all those which failed, passed and skipped ones.

Also, is required to generate a report with the coverage of the testing against the application under test. This should be in the standard output or even more depending of the scope of coverage tool we use.
