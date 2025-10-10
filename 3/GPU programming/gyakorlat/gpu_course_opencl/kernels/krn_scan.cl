__kernel void naive_scan(
  __global int* input,
  __global int* output,
  const int offset)
{
  int id = get_global_id(0);
  int left = /*TODO*/;
  int right = left + offset;
  output[right] = /*TODO*/;
}

__kernel void downSweep(
  __global int* data,
  const int offset)
{
  int id = get_global_id(0);
  __global int* left = data + /*TODO*/;
  __global int* right = left + offset;
  /*TODO*/
}

__kernel void upSweep(
  __global int* data,
  const int offset)
{
  int id = get_global_id(0);
  __global int* left = data + /*TODO*/;
  __global int* right = left + offset;
  /*TODO*/
}