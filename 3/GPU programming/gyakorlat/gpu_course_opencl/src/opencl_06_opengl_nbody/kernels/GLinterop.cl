/**
 * This kernel calculates the gravitational forces between a system of particles
 * to simulate their motion over time.
 *
 * @param velocities      (in/out) Global buffer of particle velocities (vec2).
 * @param positions       (in/out) Global buffer of particle positions (vec2). This is shared with an OpenGL VBO.
 * @param masses          (in)     Global buffer of particle masses (float).
 * @param deltaTime       (in)     The time step for the simulation frame.
 */
__kernel void update(
  __global float2* velocities,
  __global float2* positions,
  __global const float* masses,
  const float deltaTime)
{
  // A physically-motivated gravitational constant.
  const float G = 0.0001f;

  // A small factor to prevent forces from becoming infinite during close encounters, improving stability.
  const float softeningFactor = 0.001f;

  const int particleIndex = get_global_id(0);
  const int numParticles = get_global_size(0);

  // Read current particle's state from global memory.
  float2 currentPosition = positions[particleIndex];
  float  currentMass = masses[particleIndex];

  // 1. Calculate Total Acceleration 
  // This step computes the net gravitational force on the current particle
  // by summing the forces from all other particles (F = G * m1 * m2 / (d^2 + e^2)).
  float2 totalAcceleration = (float2)(0.0f, 0.0f);
  for (int i = 0; i < numParticles; ++i)
  {
    // A particle does not exert force on itself.
    if (i == particleIndex) continue;

    // Vector pointing from the current particle to the other particle.
    float2 vectorToOther = positions[i] - currentPosition;

    // Calculate squared distance. Add the softening factor to the denominator
    // to prevent division by zero and stabilize the simulation when particles get very close.
    // This is known as "gravitational softening".
    float distanceSquared = dot(vectorToOther, vectorToOther) + softeningFactor;

    // Calculate the force magnitude using Newton's law of universal gravitation.
    // The inverse cube of the distance is used here as a performance optimization.
    float invDistCube = 1.0f / (distanceSquared * sqrt(distanceSquared));
    float forceMagnitude = (G * masses[i]) * invDistCube;

    // Accumulate acceleration (a = F/m, but currentMass cancels out, so a = G*m_other/d^2).
    totalAcceleration += vectorToOther * forceMagnitude;
  }

  // 2. Update State using Velocity Verlet Integration 
  // This is a more stable numerical integration method than the basic Euler method.
  // It conserves energy better over long periods, leading to more realistic orbits.
  // p_new = p_old + v_old * dt + 0.5 * a_old * dt^2
  // v_new = v_old + 0.5 * (a_old + a_new) * dt
  // For this single-pass kernel, we simplify to a Leapfrog variant:

  // Read old velocity.
  float2 oldVelocity = velocities[particleIndex];

  // "Leapfrog" Kick: Update velocity using the calculated acceleration.
  float2 newVelocity = oldVelocity + totalAcceleration * deltaTime;

  // "Leapfrog" Drift: Update position using the *newly calculated* velocity.
  currentPosition += newVelocity * deltaTime;

  // Write the updated state back to global memory.
  velocities[particleIndex] = newVelocity;
  positions[particleIndex] = currentPosition;
}
