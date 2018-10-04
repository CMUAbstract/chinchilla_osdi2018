static inline void bounded_inc(unsigned *count_ptr)
{
  unsigned count = *count_ptr;
  if (count < ~0) { // would we overflow?
    *count_ptr = count + 1;
  } else {
    while (1); // halt
  }
}

// TODO: is it worth to (somehow) make this a two-argument function
//       to improve performance?
void __edbprof_pathprof__inc_pathcount(unsigned **path_counts,
                                       unsigned task_idx, unsigned path_idx)
{
  bounded_inc(&path_counts[task_idx][path_idx]);
}
