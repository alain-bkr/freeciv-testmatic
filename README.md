# freeciv-testmatic
Several scripts for doing (a lot) of random tests / timing / counting errors / rerun ...


## Random game generator : 
The script `random_tests.sh` will 
  - create a random parameter file
  - and run the server and log everything for later analysis

It tries many settings, not all, and not all possibilities, values may be extreme.

`Usage :
	./random_tests.sh [-opt1=val1] [-opt2=val2] [file1] [file2] ...`

  Without arguments, this script will run one random game, in its own directory
  and create a mapimg.ppm each 10 turns 

  -opt=value
	See `./random_test.sh -h` for more explainations

  file1 file2 ...

  * Other arguments on the command line will be considered as filenames that will be included
in our generated file, after all random parameters. See samples/ 
  * Order of files is important when they contain some common parameter, the last will overwrite the previous.
  * The files should be 'clean' :
 
	`# comment lines are allowed`
	
	`set parameter value` alone on a line, with NO leading spaces, no double spaces, no comment after.


examples :
``` 
   ./random_test.sh  
   will create a random parameter file, go in a directory and run the freeciv server with it.
   
   ./random_tests.sh -img=0 -server=/Big/FC31/bin/freeciv-server small.serv 12_turns.serv spacerace.serv
   will create random parameters, then append the 3 given parameter files, then run without mapimg generation.
```

## Loop of N random test games
``` 
$ ./loop_random_tests.sh -h
 Usage : ./loop_random_tests.sh -n=Number_of_runs [-img=Number] [-server=/my/best/freeciv-server] [paramfile1 paramfile2 ...]
  will run random_tests.sh -n=... times, see random_test.sh -h for help about other options
``` 

## Compute average duration of a turn for given directories.
```
$ ./turn_average_duration.sh
./turn_average_duration.sh computes average turn duration of a game, each game alone inside its own dir
Usage : ./turn_average_duration.sh DIR [DIR2] [DIR3] [DI*] ...
```
example :
```
$ ./turn_average_duration.sh loop.* ../run04_clang-15/
loop.230511-030427/Sz6-Ai016-Lm18-230511_032250.done                           4139 turns     3 s per turn
../run04_clang-15/loop.230507-100842.done/Sz1-Ai010-Lm47-230507_113829.done    1001 turns     7 s per turn
loop.230511-030425/Sz5-Ai004-Lm84-230511_061643.done                            701 turns     9 s per turn
../run04_clang-15/loop.230507-100838.done/Sz1-Ai002-Lm42-230507_135150.done    1001 turns     9 s per turn
```

