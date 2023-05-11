# freeciv-testmatic
Several scripts for doing (a lot) of random tests / rerunning / counting errors ...

## Random generator : 
The script ```find_error.sh``` will 
  - create a random parameter file
  - and optionally (run the server and log everything for later analysis).
```
$ ./random_tests.sh -h

  Without arguments, this script will 
	- generate a .srv file with random parameters 
	- create a directory, copy the script and run it (no human, only AI)
	- if convert (ImageMagick) is installed, will convert .ppm to .png,
		 and make an animated gif with maps

  It tries many settings, not all, and not all possibilities, values may be extreme

  Usage : ./random_tests.sh [-option1=val1] [file1] [file2] ...

  options : 
    -h* | --h* : help = print the current message

    -img=N
	if N > 0, will generate mapimages each N turns  (default 10)
	if N == 0, do not generate map images

    -run=N
	if N != 0, do run the server script inside a created dir (default) 
	if N == 0, do not run freeciv-serv

    -server=My/Favourite/Server  (default freeciv-server)

  args :
	file1 file2 ...
	Other arguments on the command line will be considered as filenames that will be include
	in our generated file, after all random parameters.
	Order of files is important when they contain the same parameters, the last will overwrite the previous
	The files must be 'clean' :
		# comment lines are allowed
		'set parameter value' alone on a line, with NO leading spaces, no double spaces, no comment after.

   
```
examples :
``` 
   ./random_test.sh  
   will create a random parameter file, go in a directory and run the freeciv server with it.
   
   ./random_tests.sh -img=0 -server=/Big/FC31/bin/freeciv-server small.serv 12_turns.serv spacerace.serv
   will create random parameter, then load the other parameter files
```   

## Loop of N random tests
``` 
$ ./loop_random_tests.sh -h
 Usage : ./loop_random_tests.sh -n=Number_of_runs [-img=Number] [-server=/my/best/freeciv-server] [paramfile1 paramfile2 ...]
  will run random_tests.sh -n=... times, see random_test.sh -h for help about other options
``` 

