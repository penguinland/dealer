#ifndef FAST_RANDINT_H
#define FAST_RANDINT_H

// Returns a random integer 0..(max-1)
// WARNING: `max` must be at least 1 and at most 52.
unsigned char fast_randint(unsigned char max);

#endif // FAST_RANDINT_H
