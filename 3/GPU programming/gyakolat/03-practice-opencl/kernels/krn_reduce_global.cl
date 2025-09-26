__kernel void reduce_associative(
    __global int* data,
    int offset)
{
    int gid = get_global_id(0);

    __global int* left = data + gid * (2 * offset);
    __global int* right = left + offset;

    // data[gid * (2 * offset)] += data[gid * (2 * offset) + offset]
    *left += *right;
}

__kernel void reduce_commutative(
    __global int* data,
    int _)   // used to be 'offset', this is ignored here
{
    int gid = get_global_id(0);

    __global int* left = data + gid;
    __global int* right = left + get_global_size(0);

    *left += *right;
}
