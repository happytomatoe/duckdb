cd my_test
rm -f *.f.heap
cd data
rm -f *.db
# MALLOC_CONF=prof_leak:true,lg_prof_sample:0,prof_final:true \
# MALLOC_CONF="prof:true,lg_prof_sample:1,prof_accum:false,prof_prefix:jeprof.out" \
# LD_PRELOAD=/usr/lib/x86_64-linux-gnu/libjemalloc.so.2 time ../build/release/duckdb -c ".read q.sql"
#rm -f *.f.heap
cd ..
#MALLOC_CONF=prof_leak:true,lg_prof_sample:0,prof_final:true \
#LD_PRELOAD=/usr/lib/x86_64-linux-gnu/libjemalloc.so.2
#LD_PRELOAD=/usr/lib/x86_64-linux-gnu/libpthread.so.0
#perf record -g -F 99 -a --

#MALLOC_CONF=prof:true,lg_prof_interval:30,lg_prof_sample:21,prof_prefix:/tmp/jeprof/jeprof \
#LD_PRELOAD=/usr/lib/x86_64-linux-gnu/libjemalloc.so.2 valgrind --tool=cachegrind -- ../build/release/duckdb duck.db -c ".read q.sql"
#LD_PRELOAD=libtcmalloc.so.4  time ../build/release/duckdb -c ".read q.sql"
#perf record -e branch-misses:pp  -- ../build/release/duckdb -c ".read q.sql"
#perf record -e "mem-loads"  -- ../build/release/duckdb -c ".read q.sql"
#chmod 777 perf.data
#perf script -i perf.data | ../FlameGraph/stackcollapse-perf.pl > coll.out
#../FlameGraph/flamegraph.pl coll.out > flamegraph.svg
#chown babkamen flamegraph.svg
cd data
mv *.f.heap ../
#mv gmon.out ../
tput bel

# perf script |  gprof2dot -f perf >graph.txt && xdot graph.txt


perf record -a build/release/duckdb duck.db -c ".read query.txt"  > log.txt 2>&1