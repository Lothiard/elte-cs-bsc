__kernel void reduce_workgroup(
    __global const int* input,
    __global int* output,
    __local int* scratch,
    const unsigned length)
{
    int lid  = get_local_id(0);
    int gid  = get_global_id(0);
    int lsize = get_local_size(0);

    // 1. Load data into local memory. Pad with zeroess that's over 'size'.
    scratch[lid] = (gid < length) ? input[gid] : 0;
    barrier(CLK_LOCAL_MEM_FENCE);

    // 2. Perform reduction in local memory
    for (int offset = lsize >> 1; offset != 0; offset >>= 1) {
        if (lid < offset) {
            scratch[lid] += scratch[lid + offset];
        }
        barrier(CLK_LOCAL_MEM_FENCE);
    }

    // 3. Write one result per work-group
    if (!lid) {
        output[get_group_id(0)] = scratch[0];
    }
}

__kernel void hybrid_reduce(
    __global const int* input,   // input array
    __global int* result,        // output: one value per work-group
    __local int* scratch,        // scratch local memory (size = local_size)
    const unsigned length)       // total number of elements
{
    const int lid = get_local_id(0);
    const int gid = get_global_id(0);
    const int gsize = get_global_size(0);

    // 1. Each thread sums its strided chunk of the input

    // 2. Store partial sum into local memory

    // 3. Parallel reduction in local memory (tree style)

    // 4. One thread per group writes result
	
}
